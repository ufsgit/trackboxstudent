import 'package:anandhu_s_application4/http/http_request.dart';
import 'package:anandhu_s_application4/http/http_urls.dart';
import 'package:anandhu_s_application4/presentation/profile/models/video_attendance_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VideoAttendanceController extends GetxController {
  var videoAttendanceList = <VideoAttendanceModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  /// Save video attendance when watch threshold is met
  /// Backend only requires Student_ID, Course_ID, Content_ID
  Future<bool> saveVideoAttendance({
    required int courseId,
    required int contentId,
    required String contentTitle, // Not sent to backend, just for logging
    required int watchDurationSeconds, // Not sent to backend
    required int totalDurationSeconds, // Not sent to backend
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final String studentId = prefs.getString('breffini_student_id') ?? "0";

    // Calculate watch percentage for logging
    final double watchPercentage =
        (watchDurationSeconds / totalDurationSeconds) * 100;

    print(
        "Saving video attendance: Student=$studentId, Course=$courseId, Content=$contentId, Watch=${watchPercentage.toStringAsFixed(1)}%");

    try {
      final response = await HttpRequest.httpPostBodyRequest(
        endPoint: HttpUrls.saveVideoAttendance,
        bodyData: {
          "Student_ID": int.parse(studentId),
          "Course_ID": courseId,
          "Content_ID": contentId,
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
        if (response != null && response.statusCode == 200) {
          final responseData = response.data;

          // Handle two possible response formats:
          // 1. Array format: [ {...}, {...} ]
          // 2. Success wrapper format: { success: true, rows: [{...}] }

          List<dynamic> dataList = [];

          if (responseData is List<dynamic>) {
            // Format 1: Direct array
            dataList = responseData;
          } else if (responseData is Map<String, dynamic>) {
            // Format 2: Success wrapper
            if (responseData['success'] == true &&
                responseData['rows'] is List) {
              dataList = responseData['rows'];
            } else {
              throw Exception('Unexpected response format');
            }
          } else {
            throw Exception('Unexpected response data format');
          }

          videoAttendanceList.value = dataList
              .map((item) => VideoAttendanceModel.fromJson(item))
              .toList();

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
