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
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
      ),
    );
  }

  /// 🔹 Fetch exams by course ID
  Future<List<ExamModel>> fetchExamsByCourse(int courseId) async {
    try {
      final response = await _dio.get(
        HttpUrls.getStudentExamsByCourse(courseId.toString()),
      );

      if (response.statusCode == 200 &&
          response.data is Map &&
          response.data['status'] == true) {
        final List list = response.data['data'] ?? [];
        return list.map((e) => ExamModel.fromJson(e)).toList();
      }

      return [];
    } catch (e) {
      return [];
    }
  }

  /// 🔹 Fetch questions by exam
  Future<List<QuestionModel>> fetchQuestionsByExam(String courseExamId) async {
    try {
      final response = await _dio.get(
        HttpUrls.getStudentQuestionsByCourseExam(courseExamId),
      );

      if (response.statusCode == 200 &&
          response.data is Map &&
          response.data['status'] == true) {
        final List data = response.data['data'] ?? [];
        return data.map((e) => QuestionModel.fromJson(e)).toList();
      }

      return [];
    } catch (e) {
      return [];
    }
  }

  /// 🔹 Fetch exams grouped by course (NO FILTERING)
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
        int courseId = course['Course_ID'];
        String courseName = course['Course_Name'] ?? 'Unknown Course';

        final exams = await fetchExamsByCourse(courseId);

        // ✅ ALWAYS ADD COURSE (even if exams empty)
        groupedExams[courseName] = exams;
      }

      return groupedExams;
    } catch (e) {
      return {};
    }
  }
}
