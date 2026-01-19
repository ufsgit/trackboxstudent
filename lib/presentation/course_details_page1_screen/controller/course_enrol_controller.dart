import 'package:anandhu_s_application4/http/http_request.dart';
import 'package:anandhu_s_application4/http/http_urls.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/models/batch_day_model.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/models/enrol_model.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/models/exam_day_model.dart';

import 'package:get/get.dart';

class CourseEnrolController extends GetxController {
  var courseEnrollist = <Checkenrolcoursemodel>[].obs;
  var batchDaysList = <BatchWithDaysModel>[].obs;
  var examDayList = <ExamDayModel>[].obs;
  var selectedDay = Rx<BatchWithDaysModel?>(null);
  var selectedExamDay = Rx<ExamDayModel?>(null);
  var selectedIndex = 0.obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  void selectIndex(int index) {
    selectedIndex.value = index;
  }

  void selectDay(BatchWithDaysModel day) {
    selectedDay.value = day;
  }

  void selectExamDay(ExamDayModel days) {
    selectedExamDay.value = days;
  }

  bool isSelected(BatchWithDaysModel day) {
    return selectedDay.value == day;
  }

  bool isExamSelected(ExamDayModel day) {
    return selectedDay.value == day;
  }

  checkCourseEnrolled(String courseId) async {
    await HttpRequest.httpGetRequest(
      endPoint: '${HttpUrls.checkStudentEnrolnment}/$courseId',
    ).then((response) {
      if (response!.statusCode == 200) {
        final responseData = response.data;
        if (responseData is List<dynamic>) {
          final enrolCheck = responseData;
          courseEnrollist.value = enrolCheck
              .map((result) => Checkenrolcoursemodel.fromJson(result))
              .toList();
        } else if (responseData is Map<String, dynamic>) {
          final enrolCheck = [responseData];
          courseEnrollist.value = enrolCheck
              .map((result) => Checkenrolcoursemodel.fromJson(result))
              .toList();
        } else {
          throw Exception('Unexpected response data format');
        }
      } else {
        throw Exception('Failed to load profile data: ${response.statusCode}');
      }
    }).catchError((error) {
      print('Error fetching data: $error');
    });

    update();
  }

  Future<void> getBatchWithDays(String courseId, String moduleId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await HttpRequest.httpGetRequest(
        endPoint: '${HttpUrls.getBatchDays}/$courseId/$moduleId',
      );

      if (response == null) {
        throw Exception('No response received from server');
      }

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData is List<dynamic>) {
          batchDaysList.value = responseData
              .map((result) => BatchWithDaysModel.fromJson(result))
              .toList();
        } else if (responseData is Map<String, dynamic>) {
          batchDaysList.value = [BatchWithDaysModel.fromJson(responseData)];
        } else {
          throw Exception('Unexpected response data format');
        }
      } else {
        throw Exception('Failed to load batch days: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching batch days: $error');
      errorMessage.value = error.toString();
      batchDaysList.clear();
    } finally {
      isLoading.value = false;
      update();
    }
  }

  getExamWithDays(String courseId, String moduleId) async {
    await HttpRequest.httpGetRequest(
      endPoint: '${HttpUrls.getExamDays}/$courseId/$moduleId',
    ).then((response) {
      if (response!.statusCode == 200) {
        final responseData = response.data;
        if (responseData is List<dynamic>) {
          final examDays = responseData;
          examDayList.value =
              examDays.map((result) => ExamDayModel.fromJson(result)).toList();
        } else if (responseData is Map<String, dynamic>) {
          final examDays = [responseData];
          examDayList.value =
              examDays.map((result) => ExamDayModel.fromJson(result)).toList();
        } else {
          throw Exception('Unexpected response data format');
        }
      } else {
        throw Exception('Failed to load profile data: ${response.statusCode}');
      }
    }).catchError((error) {
      print('Error fetching data: $error');
    });

    update();
  }
}
