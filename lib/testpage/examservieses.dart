import 'package:dio/dio.dart';
import '../http/http_urls.dart';
import 'exam_modal.dart';
import 'quastions_modal.dart';

class ExamService {
  late final Dio _dio;

  ExamService(String token) {
    _dio = Dio(
      BaseOptions(
        baseUrl: HttpUrls.baseUrl,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );
  }

  Future<List<ExamModel>> fetchExamsByCourse(String courseId) async {
    try {
      final res = await _dio.get(
        HttpUrls.getStudentExamsByCourse(courseId),
      );

      if (res.statusCode == 200 && res.data['status'] == true) {
        return (res.data['data'] as List)
            .map((e) => ExamModel.fromJson(e))
            .toList();
      }
      return [];
    } catch (_) {
      return [];
    }
  }

  Future<List<QuestionModel>> fetchQuestionsByCourseExam(
      int courseExamId) async {
    try {
      final res = await _dio.get(
        HttpUrls.getStudentQuestionsByCourseExam(
          courseExamId.toString(),
        ),
      );

      if (res.statusCode == 200 && res.data['status'] == true) {
        return (res.data['data'] as List)
            .map((e) => QuestionModel.fromJson(e))
            .toList();
      }
      return [];
    } catch (_) {
      return [];
    }
  }

  Future<Map<String, List<ExamModel>>> fetchExamsGroupedByCourse(
      String studentId) async {
    try {
      final res = await _dio.get(
        HttpUrls.getMyCourseDetails(studentId),
      );

      final courses = res.data is List ? res.data : res.data['data'];

      Map<String, List<ExamModel>> result = {};

      for (var c in courses) {
        final exams = await fetchExamsByCourse(c['Course_ID'].toString());
        result[c['Course_Name']] = exams;
      }

      return result;
    } catch (_) {
      return {};
    }
  }
}
