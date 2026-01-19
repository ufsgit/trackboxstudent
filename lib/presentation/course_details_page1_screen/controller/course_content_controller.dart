import 'dart:developer';
import 'dart:io';

import 'package:anandhu_s_application4/data/models/home/course_content_by_module_model.dart';
import 'package:anandhu_s_application4/http/http_request.dart';
import 'package:anandhu_s_application4/http/http_urls.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/models/course_content_model.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/models/course_library_content_model.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CourseContentController extends GetxController {
  var courseContent = CourseContentByModuleModel().obs;
  var courseContentMock = <CourseContentByModuleModel>[].obs;
  var courseLibraryList = <CourseContentLibraryModelElement>[].obs;
  RxBool isLoading = false.obs;
  Future<void> getCourseContent({
    required String courseId,
    required String moduleId,
    required String sectionId,
    required String dayId,
    required bool value,
  }) async {
    try {
      final response = await HttpRequest.httpGetRequest(
        endPoint:
            '${HttpUrls.getCourseContentByDay}?Course_Id=$courseId&Module_ID=$moduleId&Section_ID=$sectionId&Day_Id=$dayId&isLibrary=$value',
      );

      log('Received response: ${response?.data}');
      log('Status code: ${response?.statusCode}');

      if (response != null && response.statusCode == 200) {
        final responseData = response.data;

        // Check if 'contents' key exists
        if (responseData['contents'] != null) {
          final contents = responseData['contents'];

          // Check if contents is a list or a string
          if (contents is List) {
            courseContent.value =
                CourseContentByModuleModel.fromJson(responseData);
            log('Course content: $courseContent');
          } else if (contents is String) {
            // Handle the string case
            log('Received string content: $contents');
            // You can decide how to handle the string, e.g., store it as a message
            courseContent.value = CourseContentByModuleModel(
              // Assuming you want to store the string in some way
              message: contents,
            );
          } else {
            throw Exception(
                'Expected a List or String but received: ${contents.runtimeType}');
          }
        } else {
          throw Exception('No contents found in response data.');
        }
      } else {
        throw Exception(
            'Failed to load course content data: ${response?.statusCode}');
      }
    } catch (error) {
      log('Error fetching data: $error');
    }
  }

  Future<List<CourseContentByModuleModel>?> getMockContents({
    required String courseId,
    required String moduleId,
    required String sectionId,
    required String dayId,
    required bool isLibrary,
  }) async {
    final endPoint =
        '${HttpUrls.getCourseContentByDay}?Course_Id=$courseId&Module_ID=$moduleId&Section_ID=$sectionId&Day_Id=$dayId&isLibrary=$isLibrary';

    try {
      final response = await HttpRequest.httpGetRequest(endPoint: endPoint);

      log('Status code: ${response?.statusCode}');
      log('Response data: ${response?.data}');

      if (response?.statusCode == 200 && response?.data != null) {
        final responseData = response!.data;

        if (responseData is Map<String, dynamic>) {
          if (responseData['contents'] == null) {
            log('Contents is null, returning empty list');
            return [];
          } else if (responseData['contents'] is List) {
            final List<dynamic> contentsData = responseData['contents'];
            courseContentMock.value = contentsData
                .map((content) => CourseContentByModuleModel.fromJson(content))
                .toList();
          } else {
            log('Contents is not null or a list: ${responseData['contents']}');
            return [];
          }
        } else {
          throw FormatException('Invalid response format: expected a Map');
        }
      } else {
        throw HttpException(
            'Failed to load course content. Status code: ${response?.statusCode}');
      }
    } catch (e) {
      log('Error fetching data: $e');
      rethrow; // Rethrow the error for the caller to handle
    }
    return null;
  }

  void getCourseContentLibrary(String courseId) async {
    final prefs = await SharedPreferences.getInstance();
    final String studentId = prefs.getString('breffini_student_id') ?? "0";
    try {
      final response = await HttpRequest.httpGetRequest(
        endPoint: '${HttpUrls.courseContentLibrary}/$studentId/$courseId',
      );

      if (response != null && response.statusCode == 200) {
        final responseData = response.data;

        if (responseData is List) {
          // Debug print to inspect the structure of the response
          print('Response Data: $responseData');

          // Flatten and convert each item in the list
          courseLibraryList.value = _flattenTypeChange(responseData);
        } else {
          throw Exception(
              'Expected a List<dynamic> but received: ${responseData.runtimeType}');
        }
      } else {
        throw Exception(
            'Failed to load course content data: ${response?.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  List<GetCourseContentModelElement> _flattenAndConvert(List<dynamic> data) {
    List<GetCourseContentModelElement> result = [];

    for (var item in data) {
      if (item is Map<String, dynamic>) {
        result.add(GetCourseContentModelElement.fromJson(item));
      } else if (item is List) {
        result.addAll(
            _flattenAndConvert(item)); // Recursive flattening for nested lists
      } else {
        throw Exception('Unexpected item type in list: ${item.runtimeType}');
      }
    }

    return result;
  }

  List<CourseContentLibraryModelElement> _flattenTypeChange(
      List<dynamic> data) {
    List<CourseContentLibraryModelElement> result = [];

    for (var item in data) {
      if (item is Map<String, dynamic>) {
        result.add(CourseContentLibraryModelElement.fromJson(item));
      } else if (item is List) {
        result.addAll(
            _flattenTypeChange(item)); // Recursive flattening for nested lists
      } else {
        throw Exception('Unexpected item type in list: ${item.runtimeType}');
      }
    }

    return result;
  }

  Future<void> updatelastaccess(String contentId, String courseId) async {
    final prefs = await SharedPreferences.getInstance();
    final String studentId = prefs.getString('breffini_student_id') ?? "0";
    await HttpRequest.httpPostBodyRequest(bodyData: {
      "studentId": studentId,
      "courseId": courseId,
      "contentId": contentId
    }, endPoint: HttpUrls.Update_LastAccessed_Content)
        .then((value) {
      if (value != null) {
        print(value.data);
      }
    });
    update();
  }
}
