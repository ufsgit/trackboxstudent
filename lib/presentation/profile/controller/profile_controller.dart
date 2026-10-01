import 'dart:convert';

import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:anandhu_s_application4/presentation/breff_screen/breff_screen.dart';
import 'package:anandhu_s_application4/presentation/explore_courses/controller/course_access_controller.dart';
import 'package:anandhu_s_application4/presentation/login/model/student_profile_model.dart';
import 'package:anandhu_s_application4/presentation/onboarding/onboard_controller.dart';
import 'package:anandhu_s_application4/presentation/profile/model/student_details_model.dart';
import 'package:anandhu_s_application4/presentation/splash_screen/splashscreen1.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../http/http_request.dart';
import '../../../http/http_urls.dart';

class ProfileController extends GetxController {
  CourseAccessController courseAccessController =
      Get.put(CourseAccessController());

  List<String> profileTileTextList = [
    'Account & Security',
    'Attendance report'
  ];

  RxBool isLoading = true.obs;
  ProfileDetailsModel? profileData;
  var studentIdsss = [].obs;

  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController feedbackController = TextEditingController();
  TextEditingController gmeetController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  // TextEditingController profileMobileNumberController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  Future<void> getProfileStudent() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String studentId = preferences.getString('breffini_student_id') ?? '';

      final response = await HttpRequest.httpGetRequest(
        endPoint: "${HttpUrls.getStudent}/$studentId?is_Student=1",
      );

      if (response != null && response.data != null) {
        if (kDebugMode) {
          print('getProfileStudent response: ${response.data}');
        }
        List<dynamic> data = [];
        if (response.data is String) {
          try {
            var decoded = jsonDecode(response.data);
            if (decoded is List) {
              data = decoded;
            } else if (decoded is Map) {
              data = [decoded];
            }
          } catch (e) {
            print('Error parsing response data: $e');
            return;
          }
        } else if (response.data is List) {
          data = response.data;
        } else if (response.data is Map) {
          data = [response.data];
        }

        if (data.isNotEmpty) {
          Map<String, dynamic>? studentMap;
          if (data[0] is List && (data[0] as List).isNotEmpty && (data[0] as List)[0] is Map) {
            studentMap = Map<String, dynamic>.from((data[0] as List)[0]);
          } else if (data[0] is Map) {
            studentMap = Map<String, dynamic>.from(data[0]);
          }

          if (studentMap != null) {
            profileData = ProfileDetailsModel.fromJson(studentMap);
            await preferences.setString('First_Name', profileData!.firstName);
            await preferences.setString('profile_url', profileData!.profilePhotoPath);
            await preferences.setString('Live_Link', profileData!.gmeetLink);
          }

          // Process course data safely
          List<dynamic> coursesData = [];
          if (data.length > 1 && data[1] is List) {
            coursesData = data[1];
          }

          List<int> allCourseIds = [];
          List<int> accessibleCourseIds = [];
          List<int> batchIds = [];

          for (var course in coursesData) {
            if (course is Map) {
              int? courseId = course['Course_ID'] as int?;
              int? canAccess = course['Can_Access'] as int?;
              int? batchId = course['Batch_ID'] as int?;

              if (courseId != null) {
                allCourseIds.add(courseId);
                if (canAccess == 1) {
                  accessibleCourseIds.add(courseId);
                }
              }

              if (batchId != null) {
                batchIds.add(batchId);
              }
            }
          }

          studentIdsss.value = allCourseIds;
          courseAccessController.enrolledCourseIds.value = accessibleCourseIds;

          await preferences.setString('student_batch_ids', jsonEncode(batchIds));
          await preferences.setString('student_course_ids', jsonEncode(allCourseIds));

          if (batchIds.isNotEmpty) {
            await subscribeToBatchTopics(batchIds);
          }
        }
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('Error fetching student profile: $e\n$stackTrace');
      }
    } finally {
      isLoading.value = false;
      onboardingController.update();
      update(['profile_name']);
      update();
    }
  }

  Future<void> subscribeToBatchTopics(List<int> batchIds) async {
    try {
      for (int batchId in batchIds) {
        String topic = "BATCH-$batchId";
        await FirebaseMessaging.instance.subscribeToTopic(topic);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error subscribing to batch topics: $e');
      }
    }
  }

  Future<List<int>> getStoredCourseIds() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? storedIds = preferences.getString('student_course_ids');
    if (storedIds != null) {
      try {
        List<dynamic> decodedIds = jsonDecode(storedIds);
        return decodedIds.cast<int>();
      } catch (_) {}
    }
    return [];
  }

  Future<bool> saveStudentProfile(StudentProfileModel studentProfile) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      final String token = preferences.getString('breffini_token') ?? "";

      if (kDebugMode) {
        print('=== PROFILE SAVE STARTED ===');
        print('Request URL: ${HttpUrls.baseUrl}${HttpUrls.saveProfile}');
        print('REQUEST METHOD: POST');
        print('REQUEST BODY: ${jsonEncode(studentProfile.toJson())}');
        print('AUTH TOKEN PRESENT: ${token.isNotEmpty ? "YES" : "NO"}');
      }

      final response = await HttpRequest.httpPostBodyRequest(
        endPoint: HttpUrls.saveProfile,
        bodyData: studentProfile.toJson(),
      );

      if (kDebugMode) {
        print('Response status: ${response?.statusCode}');
        print('Response body: ${response?.data}');
      }

      if (response != null && (response.statusCode == 200 || response.statusCode == 201)) {
        var data = response.data;
        bool isSuccess = false;

        if (data is Map) {
          if (data['status'] == false || data['status'] == 0 || data['error'] != null) {
            isSuccess = false;
          } else {
            isSuccess = true;
          }
        } else if (data is List) {
          isSuccess = data.isNotEmpty;
        } else if (data is String) {
          try {
            var decoded = jsonDecode(data);
            if (decoded is Map && (decoded['status'] == false || decoded['error'] != null)) {
              isSuccess = false;
            } else if (decoded is List) {
              isSuccess = decoded.isNotEmpty;
            } else {
              isSuccess = true;
            }
          } catch (_) {
            isSuccess = true;
          }
        } else {
          isSuccess = true;
        }

        if (isSuccess) {
          if (kDebugMode) {
            print('=== PROFILE SAVE COMPLETED: SUCCESS ===');
          }
          await getProfileStudent();
          update();
          return true;
        } else {
          if (kDebugMode) {
            print('=== PROFILE SAVE COMPLETED: FAILED (Response status check failed) ===');
          }
          return false;
        }
      } else {
        if (kDebugMode) {
          print('=== PROFILE SAVE COMPLETED: FAILED (Response null or status error) ===');
        }
        return false;
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('=== PROFILE SAVE ERROR: $e ===\n$stackTrace');
      }
      return false;
    }
  }

  submitFeedBack({required String feedBack}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String studentId = preferences.getString('breffini_student_id') ?? '';

    await HttpRequest.httpPostBodyRequest(
      endPoint: HttpUrls.submitFeedBack,
      bodyData: {
        "Review_Id": 0,
        'studentId': studentId,
        "comments": feedBack,
      },
    ).then((value) async {
      print('Feedback:$value');

      if (value != null) {
        print(value);
      } else {
        Get.showSnackbar(GetSnackBar(
          message: 'invalid request',
          duration: Duration(milliseconds: 800),
        ));
      }
    });
  }

  // Zego license fetching logic removed
}
