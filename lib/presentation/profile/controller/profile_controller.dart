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

      if (response != null) {
        print('response.data  ' + response.data.toString());
        List<dynamic> data;
        if (response.data is String) {
          try {
            data = jsonDecode(response.data) as List<dynamic>;
          } catch (e) {
            print('Error parsing response data: $e');
            return;
          }
        } else if (response.data is List) {
          data = response.data;
        } else {
          throw Exception('Unexpected response data format');
        }
        print('datalocals1 ' + data.toString());

        if (data.length > 0) {
          print('datalocals ' + data[0][0].toString());
          // Update profile data
          profileData = ProfileDetailsModel.fromJson(data[0][0]);

          await preferences.setString('First_Name', profileData!.firstName);
          await preferences.setString(
              'profile_url', profileData!.profilePhotoPath);
          await preferences.setString('Live_Link', profileData!.gmeetLink);
          // Process course data
          List<dynamic> coursesData = data[1];
          List<int> allCourseIds = [];
          List<int> accessibleCourseIds = [];
          List<int> batchIds = [];

          for (var course in coursesData) {
            print(
                'Course data: $course'); // Print each course to see the structure

            int? courseId = course['Course_ID'] as int?;
            int? canAccess = course['Can_Access'] as int?;
            int? batchId = course['Batch_ID'] as int?;

            print(
                'CourseId: $courseId, CanAccess: $canAccess, BatchId: $batchId');
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

          // Update course IDs
          studentIdsss.value = allCourseIds;
          courseAccessController.enrolledCourseIds.value = accessibleCourseIds;

          // Store IDs in preferences
          await preferences.setString(
              'student_batch_ids', jsonEncode(batchIds));
          await preferences.setString(
              'student_course_ids', jsonEncode(allCourseIds));

          // Subscribe to batch topics
          await subscribeToBatchTopics(batchIds);

          print('Course IDs: $studentIdsss');
          print(
              'Stored course IDs: ${preferences.getString('student_course_ids')}');
        } else {
          print('No profile data found');
        }
      }
    } catch (e) {
      print('Error fetching student profile: $e');
    } finally {
      isLoading.value = false;
      print('calling');
      onboardingController.update();
      update(['profile_name']);
      update();
    }
  }

  Future<void> subscribeToBatchTopics(List<int> batchIds) async {
    for (int batchId in batchIds) {
      String topic = "BATCH-$batchId"; // Construct the topic string
      await FirebaseMessaging.instance.subscribeToTopic(topic);
      print('Subscribed to topic: $topic');
    }
  }

  Future<List<int>> getStoredCourseIds() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? storedIds = preferences.getString('student_course_ids');
    if (storedIds != null) {
      List<dynamic> decodedIds = jsonDecode(storedIds);
      return decodedIds.cast<int>();
    }
    return [];
  }

  saveStudentProfile(StudentProfileModel studentProfile) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String studentId = preferences.getString('breffini_student_id') ?? '';
    String newUser = preferences.getString('breffini_new_user') ?? '';

    await HttpRequest.httpPostBodyRequest(
      endPoint: HttpUrls.saveProfile,
      bodyData: studentProfile.toJson(),
    ).then((value) async {
      print('edited profile $value');

      if (value != null) {
        if (value.data[0] != null) {
          await getProfileStudent();
          update();
          Get.back();

          firstNameController.clear();
          lastNameController.clear();
          emailController.clear();
          phoneController.clear();
          genderController.clear();
          dobController.clear();
        }
      } else {
        Get.showSnackbar(GetSnackBar(
          message: 'invalid request',
          duration: Duration(milliseconds: 800),
        ));
      }
    });
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

  Future<void> fetchEffectsLicense({
    required String appId,
    required String authInfo,
  }) async {
    final dio = Dio();

    try {
      final Map<String, dynamic> queryParameters = {
        'Action': 'DescribeEffectsLicense',
        'AppId': appId,
        'AuthInfo': authInfo
      };

      // Make GET request
      final response = await dio.get(
        'https://aieffects-api.zego.im',
        queryParameters: queryParameters,
      );

      if (response.statusCode == 200) {
        print('Response data: ${response.data}');
      } else {
        print('Request failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        print('Dio error: ${e.message}');

        if (e.response != null) {
          print('Error response: ${e.response?.data}');
        }
      } else {
        print('Error occurred: $e');
      }
    }
  }
}
