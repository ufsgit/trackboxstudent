import 'dart:developer';
import 'package:anandhu_s_application4/http/http_request.dart';
import 'package:anandhu_s_application4/http/http_urls.dart';
import 'package:anandhu_s_application4/presentation/profile/models/video_attendance_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VideoAttendanceController extends GetxController {
  var videoAttendanceList = <VideoAttendanceModel>[].obs;
  var _allAttendanceList = <VideoAttendanceModel>[];  // full unfiltered cache
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
      final body = {
        "Student_ID": int.parse(studentId),
        "Course_ID": courseId,
        "Content_ID": contentId,
      };

      print("📤 Request Body for Save Attendance: $body");

      final response = await HttpRequest.httpPostBodyRequest(
        endPoint: HttpUrls.saveVideoAttendance,
        bodyData: body,
      );

      if (response != null && response.statusCode == 200) {
        print("✅ Video attendance saved successfully!");
        print("📥 Response Data video attendance: ${response.data}");
        return true;
      } else {
        print("❌ Failed to save video attendance: ${response?.statusCode}");
        print("📥 Error Response Body: ${response?.data}");
        return false;
      }
    } catch (e) {
      print("Error saving video attendance: $e");
      return false;
    }
  }

  /// Filter the displayed list by year + month (client-side)
  /// watchedDate is stored as a String (ISO 8601), so we parse it first.
  void filterByMonth(int year, int month) {
    videoAttendanceList.value = _allAttendanceList.where((item) {
      final rawDate = item.watchedDate;
      if (rawDate == null) return false;
      final date = DateTime.tryParse(rawDate);
      if (date == null) return false;
      return date.year == year && date.month == month;
    }).toList();
    print('📅 Filtered attendance: ${videoAttendanceList.length} records '
        'for $year-${month.toString().padLeft(2, '0')}');
    update();
  }

  /// Get video attendance for a student
  Future<void> getVideoAttendanceByStudentId(int studentId,
      {String? month, int? courseId}) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      String endPoint = "${HttpUrls.getVideoAttendance}/$studentId";

      List<String> queryParams = [];
      if (month != null) {
        queryParams.add('Month=$month');
      }
      if (courseId != null) {
        queryParams.add('Course_ID=$courseId');
      }
      if (queryParams.isNotEmpty) {
        endPoint += '?${queryParams.join('&')}';
      }

      log('Fetching attendance from: $endPoint');
      await HttpRequest.httpGetRequest(
        endPoint: endPoint,
      ).then((response) {
        if (response != null && response.statusCode == 200) {
          final responseData = response.data;
          log('Attendance data received: $responseData');

          // Handle two possible response formats:
          // 1. Array format: [ {...}, {...} ]
          // 2. Success wrapper format: { success: true, rows: [{...}] }

          List<dynamic> dataList = [];

          if (responseData is List<dynamic>) {
            // Handle double-nested list [[{...}]]
            if (responseData.isNotEmpty && responseData[0] is List) {
              dataList = responseData[0];
            } else {
              dataList = responseData;
            }
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

          try {
            videoAttendanceList.value = dataList
                .map((item) => VideoAttendanceModel.fromJson(item))
                .toList();
            // Cache the full list for client-side filtering
            _allAttendanceList = List.from(videoAttendanceList);

            print("📜 Fetched Attendance Records (total: ${videoAttendanceList.length}):");
            for (var record in videoAttendanceList) {
              print(
                  "- ID: ${record.videoAttendanceId}, Content: ${record.contentName}, Date: ${record.watchedDate}, Status: ${record.status}");
            }
            log('Attendance list mapped successfully: ${videoAttendanceList.length} items');
          } catch (e) {
            print("❌ Error mapping attendance data: $e");
            log('Error mapping attendance data: $e');
            errorMessage.value = 'Data format error: $e';
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
