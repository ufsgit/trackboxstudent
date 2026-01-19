import 'package:anandhu_s_application4/http/http_request.dart';
import 'package:anandhu_s_application4/http/http_urls.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/models/exam_result_model.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExamResultController extends GetxController {
  var examResult = <ExamResultModel>[].obs;

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
}
