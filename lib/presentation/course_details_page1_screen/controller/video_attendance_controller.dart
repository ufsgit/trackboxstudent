import 'package:anandhu_s_application4/http/http_request.dart';
import 'package:anandhu_s_application4/http/http_urls.dart';
import 'package:anandhu_s_application4/presentation/profile/models/video_attendance_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class VideoAttendanceController extends GetxController {
  var videoAttendanceList = <VideoAttendanceModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  /// Save video attendance when watch threshold is met
  Future<bool> saveVideoAttendance({
    required int courseId,
    required int contentId,
    required String contentTitle,
    required int watchDurationSeconds,
    required int totalDurationSeconds,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final String studentId = prefs.getString('breffini_student_id') ?? "0";

    // Calculate watch percentage
    final double watchPercentage =
        (watchDurationSeconds / totalDurationSeconds) * 100;

    // Get current date
    final String date = DateFormat('yyyy-MM-dd').format(DateTime.now());

    try {
      final response = await HttpRequest.httpPostBodyRequest(
        endPoint: HttpUrls.saveVideoAttendance,
        bodyData: {
          "student_id": int.parse(studentId),
          "course_id": courseId,
          "content_id": contentId,
          "content_title": contentTitle,
          "watch_duration_seconds": watchDurationSeconds,
          "total_duration_seconds": totalDurationSeconds,
          "watch_percentage": watchPercentage,
          "date": date,
        },
      );

      if (response != null && response.statusCode == 200) {
        print("Video attendance saved successfully: ${response.data}");
        return true;
      } else {
        print("Failed to save video attendance: ${response?.statusCode}");
        return false;
      }
    } catch (e) {
      print("Error saving video attendance: $e");
      return false;
    }
  }

  /// Get video attendance for a student
  Future<void> getVideoAttendanceByStudentId(int studentId,
      {String? month, int? courseId}) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      String endPoint = HttpUrls.getVideoAttendance(studentId.toString());

      // Add query parameters if provided
      List<String> queryParams = [];
      if (month != null) {
        queryParams.add('month=$month');
      }
      if (courseId != null) {
        queryParams.add('course_id=$courseId');
      }
      if (queryParams.isNotEmpty) {
        endPoint += '?${queryParams.join('&')}';
      }

      await HttpRequest.httpGetRequest(
        endPoint: endPoint,
      ).then((response) {
        if (response!.statusCode == 200) {
          final responseData = response.data;
          if (responseData is List<dynamic>) {
            videoAttendanceList.value = responseData
                .map((item) => VideoAttendanceModel.fromJson(item))
                .toList();
          } else if (responseData is Map<String, dynamic>) {
            videoAttendanceList.value = [
              VideoAttendanceModel.fromJson(responseData)
            ];
          } else {
            throw Exception('Unexpected response data format');
          }
          isLoading.value = false;
        } else {
          errorMessage.value = 'Failed to load video attendance';
          isLoading.value = false;
        }
      }).catchError((error) {
        errorMessage.value = 'Error: $error';
        isLoading.value = false;
        print('Error fetching video attendance: $error');
      });
    } catch (e) {
      errorMessage.value = 'Error: $e';
      isLoading.value = false;
      print('Exception in getVideoAttendanceByStudentId: $e');
    }

    update();
  }

  /// Calculate watch percentage
  double calculateWatchPercentage(int watchedSeconds, int totalSeconds) {
    if (totalSeconds == 0) return 0.0;
    return (watchedSeconds / totalSeconds) * 100;
  }

  /// Check if watch percentage meets attendance threshold
  bool meetsAttendanceThreshold(double watchPercentage,
      {double threshold = 80.0}) {
    return watchPercentage >= threshold;
  }
}
