import 'package:anandhu_s_application4/http/http_request.dart';
import 'package:anandhu_s_application4/http/http_urls.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/models/exam_result_model.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/models/student_exam_result_model.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExamResultController extends GetxController {
  var examResult = <ExamResultModel>[].obs;
  var studentExamResults = <StudentExamResultModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  getExamResults(String courseId) async {
    final prefs = await SharedPreferences.getInstance();
    final String studentId = prefs.getString('breffini_student_id') ?? "0";
    await HttpRequest.httpGetRequest(
      endPoint:
          '${HttpUrls.getExamResult}?studentId=$studentId&courseId=$courseId',
    ).then((response) {
      if (response!.statusCode == 200) {
        final responseData = response.data;
        if (responseData is List<dynamic>) {
          final examResultsData = responseData;
          examResult.value = examResultsData
              .map((result) => ExamResultModel.fromJson(result))
              .toList();
        } else if (responseData is Map<String, dynamic>) {
          final examResultsData = [responseData];
          examResult.value = examResultsData
              .map((result) => ExamResultModel.fromJson(result))
              .toList();
        } else {
          throw Exception('Unexpected response data format');
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    }).catchError((error) {
      print('Error fetching data: $error');
    });

    update();
  }

  Future<void> getExamResultsByStudentId(int studentId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      await HttpRequest.httpGetRequest(
        endPoint: HttpUrls.getStudentExamResults(studentId.toString()),
      ).then((response) {
        if (response!.statusCode == 200) {
          final responseData = response.data;
          if (responseData is List<dynamic>) {
            studentExamResults.value = responseData
                .map((result) => StudentExamResultModel.fromJson(result))
                .toList();
          } else if (responseData is Map<String, dynamic>) {
            studentExamResults.value = [
              StudentExamResultModel.fromJson(responseData)
            ];
          } else {
            throw Exception('Unexpected response data format');
          }
          isLoading.value = false;
        } else {
          errorMessage.value = 'Failed to load exam results';
          isLoading.value = false;
        }
      }).catchError((error) {
        errorMessage.value = 'Error: $error';
        isLoading.value = false;
        print('Error fetching exam results: $error');
      });
    } catch (e) {
      errorMessage.value = 'Error: $e';
      isLoading.value = false;
      print('Exception in getExamResultsByStudentId: $e');
    }

    update();
  }

  Future<bool> saveExamResult({
    required int courseId,
    required int examDataId,
    required String totalMark,
    required String passMark,
    required String obtainedMark,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final String studentId = prefs.getString('breffini_student_id') ?? "0";

    try {
      final response = await HttpRequest.httpPostBodyRequest(
        endPoint: HttpUrls.saveExamResult,
        bodyData: {
          "student_id": studentId,
          "course_id": courseId,
          "course_exam_id": examDataId,
          "total_mark": totalMark,
          "pass_mark": passMark,
          "obtained_mark": obtainedMark,
        },
      );

      if (response != null && response.statusCode == 200) {
        // You might want to parse the response here if needed,
        // but for now checking 200 OK is sufficient for the boolean return.
        print("Exam saved successfully: ${response.data}");
        return true;
      } else {
        print("Failed to save exam: ${response?.statusCode}");
        return false;
      }
    } catch (e) {
      print("Error saving exam result: $e");
      return false;
    }
  }
}
