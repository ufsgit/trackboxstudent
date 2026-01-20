import 'package:dio/dio.dart';
import '../http/http_urls.dart';
import '../testpage/exam_modal.dart';
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

  /// Fetch exams by course ID
  Future<List<ExamModel>> fetchExamsByCourse(String courseId) async {
    try {
      final response = await _dio.get(
        HttpUrls.getStudentExamsByCourse(courseId),
      );

      if (response.statusCode == 200 &&
          response.data is Map &&
          response.data['status'] == true) {
        final List data = response.data['data'] ?? [];
        return data.map((e) => ExamModel.fromJson(e)).toList();
      }
      return [];
    } catch (_) {
      return [];
    }
  }

  /// Fetch questions by courseExamId (INT → STRING)
  Future<List<QuestionModel>> fetchQuestionsByCourseExam(
      int courseExamId) async {
    try {
      final response = await _dio.get(
        HttpUrls.getStudentQuestionsByCourseExam(
          courseExamId.toString(), // ✅ convert here
        ),
      );

      if (response.statusCode == 200 &&
          response.data is Map &&
          response.data['status'] == true) {
        final List data = response.data['data'] ?? [];
        return data.map((e) => QuestionModel.fromJson(e)).toList();
      }
      return [];
    } catch (_) {
      return [];
    }
  }

  /// Fetch exams grouped by course
  Future<Map<String, List<ExamModel>>> fetchExamsGroupedByCourse(
      String studentId) async {
    try {
      final response = await _dio.get(HttpUrls.getMyCourseDetails(studentId));

      List courseData = [];

      if (response.statusCode == 200) {
        if (response.data is List) {
          courseData = response.data;
        } else if (response.data is Map && response.data['status'] == true) {
          courseData = response.data['data'] ?? [];
        }
      }

      Map<String, List<ExamModel>> groupedExams = {};

      for (var course in courseData) {
        final String courseId = course['Course_ID'].toString();
        final String courseName = course['Course_Name'] ?? 'Unknown Course';

        final exams = await fetchExamsByCourse(courseId);
        groupedExams[courseName] = exams;
      }

      return groupedExams;
    } catch (_) {
      return {};
    }
  }
}
