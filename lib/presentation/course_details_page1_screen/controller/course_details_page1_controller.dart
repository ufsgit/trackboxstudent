import 'dart:convert';

import 'package:anandhu_s_application4/http/http_request.dart';
import 'package:anandhu_s_application4/http/http_urls.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/models/course_module_model.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/models/course_modules_model.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/models/mock_tests_module_model.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/models/recordings_model.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/models/section_by_course_model.dart';
import 'package:anandhu_s_application4/presentation/home_page/models/course_info_model.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../models/course_details_page1_model.dart';

class CourseModuleController extends GetxController {
  Rx<CourseDetailsPage1Model> courseDetailsPage1ModelObj =
      CourseDetailsPage1Model().obs;
  var courseModuleList = <CourseModuleModel>[].obs;
  var courseModulesList = <CourseModulesModel>[].obs;
  var sectionByModule = <SectionByCourseModel>[].obs;
  var recordings = <RecordingsModel>[].obs;
  var courseInfo = <CourseInfoModel>[].obs;
  var mockModules = <MockTestModuleModel>[].obs;
  RxBool isCourseLoading = false.obs;

  var contentVideoUrl =
      'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4'
          .obs;
  VideoPlayerController? videoPlayerController;
  var isExpanded = false.obs;
  void toggleExpansion() {
    isExpanded.value = !isExpanded.value;
  }

  // void getCourseModules() async {
  //   await HttpRequest.httpGetRequest(
  //     endPoint: '${HttpUrls.getCourseModules}',
  //   ).then((response) {
  //     if (response!.statusCode == 200) {
  //       final responseData = response.data;
  //       if (responseData is List<dynamic>) {
  //         final courseModule = responseData;
  //         courseModuleList.value = courseModule
  //             .map((result) => CourseModuleModel.fromJson(result))
  //             .toList();
  //       } else if (responseData is Map<String, dynamic>) {
  //         final courseModule = [responseData];
  //         courseModuleList.value = courseModule
  //             .map((result) => CourseModuleModel.fromJson(result))
  //             .toList();
  //       } else {
  //         throw Exception('Unexpected response data format');
  //       }
  //     } else {
  //       throw Exception('Failed to load  data: ${response.statusCode}');
  //     }
  //   }).catchError((error) {
  //     print('Error fetching data: $error');
  //   });

  //   update();
  // }

  void getCoursesModules({required String courseId}) async {
    await HttpRequest.httpGetRequest(
      endPoint: '${HttpUrls.getCoursesModules}/$courseId',
    ).then((response) {
      if (response!.statusCode == 200) {
        final responseData = response.data;
        if (responseData is List<dynamic>) {
          final courseModules = responseData;
          courseModulesList.value = courseModules
              .map((result) => CourseModulesModel.fromJson(result))
              .toList();
        } else if (responseData is Map<String, dynamic>) {
          final courseModules = [responseData];
          courseModulesList.value = courseModules
              .map((result) => CourseModulesModel.fromJson(result))
              .toList();
        } else {
          throw Exception('Unexpected response data format');
        }
      } else {
        throw Exception('Failed to load  data: ${response.statusCode}');
      }
    }).catchError((error) {
      print('Error fetching data: $error');
    });

    update();
  }

  void getModulesofMockTests({required String courseId}) async {
    await HttpRequest.httpGetRequest(
      endPoint: '${HttpUrls.getModulesofMockTests}/$courseId',
    ).then((response) {
      if (response!.statusCode == 200) {
        final responseData = response.data;
        if (responseData is List<dynamic>) {
          final mockModulesData = responseData;
          mockModules.value = mockModulesData
              .map((result) => MockTestModuleModel.fromJson(result))
              .toList();
        } else if (responseData is Map<String, dynamic>) {
          final mockModulesData = [responseData];
          mockModules.value = mockModulesData
              .map((result) => MockTestModuleModel.fromJson(result))
              .toList();
        } else {
          throw Exception('Unexpected response data format');
        }
      } else {
        throw Exception('Failed to load  data: ${response.statusCode}');
      }
    }).catchError((error) {
      print('Error fetching data: $error');
    });

    update();
  }

  void getSectionByCourse({required String courseId}) async {
    await HttpRequest.httpGetRequest(
      endPoint: '${HttpUrls.getSecttionsByCourse}/$courseId',
    ).then((response) {
      if (response!.statusCode == 200) {
        final responseData = response.data;
        if (responseData is List<dynamic>) {
          final section = responseData;
          sectionByModule.value = section
              .map((result) => SectionByCourseModel.fromJson(result))
              .toList();
        } else if (responseData is Map<String, dynamic>) {
          final section = [responseData];
          sectionByModule.value = section
              .map((result) => SectionByCourseModel.fromJson(result))
              .toList();
        } else {
          throw Exception('Unexpected response data format');
        }
      } else {
        throw Exception('Failed to load  data: ${response.statusCode}');
      }
    }).catchError((error) {
      print('Error fetching data: $error');
    });

    update();
  }

  getRecordings({required String courseId}) async {
    await HttpRequest.httpGetRequest(
      endPoint: '${HttpUrls.getRecordings}/$courseId',
    ).then((response) {
      if (response!.statusCode == 200) {
        final responseData = response.data;
        if (responseData is List<dynamic>) {
          final recordingsData = responseData;
          recordings.value = recordingsData
              .map((result) => RecordingsModel.fromJson(result))
              .toList();
        } else if (responseData is Map<String, dynamic>) {
          final recordingsData = [responseData];
          recordings.value = recordingsData
              .map((result) => RecordingsModel.fromJson(result))
              .toList();
        } else {
          throw Exception('Unexpected response data format');
        }
      } else {
        throw Exception('Failed to load  data: ${response.statusCode}');
      }
    }).catchError((error) {
      print('Error fetching data: $error');
    });

    update();
  }

  Future<void> getCourseInfo({required int courseId}) async {
    try {
      isCourseLoading.value = true;

      final response = await HttpRequest.httpGetRequest(
          endPoint: '${HttpUrls.getCourseInfo}/$courseId', showLoader: true);

      if (response?.statusCode == 200) {
        final responseData = response?.data;

        print('Response data type: ${responseData.runtimeType}');
        print('Raw response data: $responseData');

        if (responseData == null) {
          throw Exception('Response data is null');
        }

        if (responseData is String) {
          if (responseData.trim().isEmpty) {
            throw Exception('Response data is an empty string');
          }
          try {
            final jsonData = json.decode(responseData);
            if (jsonData is List<dynamic>) {
              courseInfo.value = jsonData
                  .map((result) => CourseInfoModel.fromJson(result))
                  .toList();
            } else if (jsonData is Map<String, dynamic>) {
              courseInfo.value = [CourseInfoModel.fromJson(jsonData)];
            } else {
              throw Exception(
                  'Unexpected JSON structure: ${jsonData.runtimeType}');
            }
          } catch (e) {
            print('Error parsing JSON: $e');
            throw Exception('Invalid JSON format: $e');
          }
        } else if (responseData is List<dynamic>) {
          courseInfo.value = responseData
              .map((result) => CourseInfoModel.fromJson(result))
              .toList();
        } else if (responseData is Map<String, dynamic>) {
          courseInfo.value = [CourseInfoModel.fromJson(responseData)];
        } else {
          throw Exception(
              'Unexpected response data type: ${responseData.runtimeType}');
        }
      } else {
        print('Failed to load data: ${response?.statusCode}');
        print('Response body: ${response?.data}');
        throw Exception('Failed to load data: ${response?.statusCode}');
      }
    } catch (error) {
      print('Error fetching or processing data: $error');
      // Optionally, you can set courseInfo to a default value or clear it
      // courseInfo.value = [];
      rethrow;
    } finally {
      isCourseLoading.value = false;

      update();
    }
  }
}
