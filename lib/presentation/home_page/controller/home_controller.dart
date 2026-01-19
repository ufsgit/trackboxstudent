import 'dart:convert';
import 'dart:developer';
import 'package:anandhu_s_application4/presentation/login/login_controller.dart';
import 'package:anandhu_s_application4/core/utils/common_utils.dart';
import 'package:anandhu_s_application4/presentation/home_page/models/save_student_model.dart';
import 'package:anandhu_s_application4/presentation/home_page/models/teacher_model.dart';
import 'package:anandhu_s_application4/presentation/home_page/models/time_slot_model.dart';
import 'package:anandhu_s_application4/presentation/profile/controller/profile_controller.dart';
import 'package:anandhu_s_application4/presentation/splash_screen/splashscreen.dart';
import 'package:anandhu_s_application4/presentation/splash_screen/splashscreen1.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hypersdkflutter/hypersdkflutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/app_export.dart';
import '../../../http/http_request.dart';
import '../../../http/http_urls.dart';
import '../../course_details_page1_screen/models/course_review_model.dart';
import '../../course_details_page_screen/models/course_content_model.dart';
import '../../course_details_page_screen/models/course_details_page_model.dart';
import '../../onboarding/onboard_controller.dart';
import '../models/home_model.dart';

/// A controller class for the HomePage.
///
/// This class manages the state of the HomePage, including the
/// current homeModelObj
class HomeController extends GetxController {
  HomeController(this.homeModelObj);

  ProfileController profileController = Get.put(ProfileController());

  Rx<HomeModel> homeModelObj;
//  VideoPlayerController controller=VideoPlayerController.networkUrl(Uri.parse(
//         'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),

//         )
//       ..initialize().then((_) {
//         // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.

//       });

  CourseDetailsListModel? courseDetails;
  List<CourseReviewModel> courseReviewList = [];
  var isUserLogin = false.obs;
  List<CourseDetailsContentListModel> courseDetailsContent = [];
  var teacherList = <TeacherModel>[].obs;
  var hodList = <TeacherModel>[].obs;
  var timeSlotList = <TimeSlotModel>[].obs;
  RxInt selectedIndex = 0.obs;
  RxString title = ''.obs;
  RxString selectedCourseCategory = ''.obs;
  String videoURL = '';
  String seletctedAudio = '';
  String seletctedPdfUrl = '';

  @override
  void onReady() {
    print('onready fn ');

    super.onReady();
  }

  setTitle(String selectedTitle) {
    title.value = selectedTitle;
  }

  getSelectedCourseCategory(String selectedCategory) {
    selectedCourseCategory.value = selectedCategory;
  }

  initFn() async {
    await onboardingController.getCourseDropdownValue(courseName: '');
    await profileController.getProfileStudent();
    final studentName = await PrefUtils().getStudentName();
    log("////////name$studentName");
    log("////////name$studentName");
    if (studentName.isEmpty || studentName == '' || studentName == 'NA') {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String id = prefs.getString('breffini_student_id') ?? 'Unknown';
      Get.defaultDialog(
          title: "Profile Error",
          middleText:
              "Failed to load Profile Name.\nStudent ID: $id\nName: $studentName",
          textConfirm: "Retry",
          onConfirm: () {
            Get.back();
            initFn();
          },
          textCancel: "Logout",
          onCancel: () {
            Get.find<LoginController>().logout();
          });
      return;
    }
  }

  // getHomeCourseData()async{

  // }

  // getCourseReview({required int courseId}) async {
  //   await HttpRequest.httpGetRequest(
  //       endPoint: '${HttpUrls.getCourseReviews}',
  //       bodyData: {
  //         "courseId": courseId,
  //       }).then((value) {
  //     if (value != null) {
  //       List data = value.data;

  //       courseReviewList =
  //           data.map((e) => CourseReviewModel.fromJson(e)).toList();
  //     }
  //   });
  // }

  // Future<void> getCourseDetailsData({
  //   required int courseId,
  // }) async {
  //   try {
  //     // Fetch data from the API
  //     final response = await HttpRequest.httpGetRequest(
  //       endPoint: '${HttpUrls.getCourseDetails}/$courseId',
  //     );

  //     if (response != null) {
  //       // Log the raw response for debugging
  //       log('Raw course details data: ${response.data}');

  //       // Handle and parse the response data
  //       List<dynamic> data;
  //       if (response.data is String) {
  //         try {
  //           data = jsonDecode(response.data) as List<dynamic>;
  //         } catch (e) {
  //           throw Exception('Error parsing JSON response: $e');
  //         }
  //       } else if (response.data is List) {
  //         data = response.data as List<dynamic>;
  //       } else {
  //         throw Exception(
  //             'Unexpected response data format: ${response.data.runtimeType}');
  //       }

  //       log('Parsed course details data: $data');

  //       // Validate and process the data
  //       if (data.isNotEmpty) {
  //         // Ensure the data structure matches expectations
  //         if (data.length > 0 && data[0] is List && data[0].isNotEmpty) {
  //           courseDetails = CourseDetailsListModel.fromMap(data[0][0]);
  //         } else {
  //           throw Exception('Unexpected data format for course details');
  //         }

  //         if (data.length > 1 && data[1] is List) {
  //           final courseDetailsContentList = data[1];
  //           courseDetailsContent = courseDetailsContentList
  //               .map((e) => CourseDetailsContentListModel.fromMap(e))
  //               .toList();
  //         } else {
  //           throw Exception(
  //               'Unexpected data format for course details content');
  //         }

  //         // Optionally call another function if needed
  //         getCourseTimeSlot(courseId);

  //         print(courseDetailsContent);
  //       } else {
  //         throw Exception('Response data is empty');
  //       }
  //     } else {
  //       throw Exception('Response is null');
  //     }
  //   } catch (e) {
  //     // Handle any errors that occur during data processing
  //     print('Error fetching course details: $e');
  //   }
  // }
  Future<bool> startPayment(HyperSDK hyperSDK, double amount,
      hyperSDKCallbackHandler(MethodCall methodCall)) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String studentId = preferences.getString('breffini_student_id') ?? '';

    var requestBody = {
      "amount": amount,
      "studentId": studentId,
      // block:end:updateOrderID
    };
    var response = await HttpRequest.httpPostBodyRequest(
        bodyData: requestBody, endPoint: HttpUrls.initiateJuspayPayment);

    if (response?.statusCode == 200) {
      Map<String, dynamic> jsonResponse = response?.data;

      // block:start:openPaymentPage
      hyperSDK.openPaymentPage(
          jsonResponse['sdk_payload'], hyperSDKCallbackHandler);
      return true;
      // block:end:openPaymentPage
    } else {
      return false;
      // throw Exception(
      //     'API call failed with status code ${response?.statusCode}');
    }
  }

  Future<bool> enrollNowApi(
      {required int courseId,
      required String totalPrice,
      required int slotId,
      required BuildContext context,
      required String txnId,
      required String paymentMethod}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String studentId = preferences.getString('breffini_student_id') ?? '';
    var response = await HttpRequest.httpPostBodyRequest(
      endPoint: '${HttpUrls.enrollCourse}',
      showLoader: true,
      bodyData: {
        "Student_ID": studentId,
        "Course_ID": courseId,
        "Enrollment_Date": DateFormat('yyyy-MM-dd').format(
          DateTime.now(),
        ),
        "Expiry_Date": null,
        "Price": totalPrice,
        "Payment_Date": DateFormat('yyyy-MM-dd').format(
          DateTime.now(),
        ),
        "Payment_Status": "Paid",
        "LastAccessed_Content_ID": 789,
        "Transaction_Id": txnId,
        "Delete_Status": 0,
        "Payment_Method": paymentMethod,
        "Slot_Id": 0
      },
    );
    if (response != null) {
      return true;
      // Get.toNamed(AppRoutes.homePageContainerScreen);
    } else {
      return false;
      // Get.back();
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text('Already enrolled')));
      // print(value!.statusCode);
    }
  }

  Future<String> saveStudentCall(
      SaveStudentCallModel saveStudentCallModel) async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // log('<<<<<<<Post Request ${saveStudentCallModel.liveLink}>>>>>>>');
    String studentId = PrefUtils().getStudentId();
    var response = await HttpRequest.httpPostBodyRequest(
      endPoint: '${HttpUrls.saveStudentCall}',
      showLoader: true,
      dismissible: false,
      bodyData: {
        "id": 0,
        "teacher_id": saveStudentCallModel.teacherId,
        "student_id": studentId,
        "call_start": DateTime.now().toString(),
        "call_end": saveStudentCallModel.callEnd,
        "call_duration": null,
        "call_type": saveStudentCallModel.callType,
        "Is_Student_Called": saveStudentCallModel.isStudentCalled,
        "Live_Link": saveStudentCallModel.liveLink,
        "is_call_rejected": false,
      },
    );
    if (response != null) {
      // preferences.setString('id', value.data[0]['id'].toString());
      // print('success');
      // log('course details data of the save student call $value');

      return response.data[0]['id'].toString();
      // Get.toNamed(AppRoutes.homePageContainerScreen);
    } else {
      return "";
    }
  }

  Future<void> updateCallStatusAccept(String callId) async {
    var response = await HttpRequest.httpGetRequest(
      endPoint: HttpUrls.Update_Call_Status_Accept + callId,
    );
    if (response != null) {
      // return response.data['id'].toString();
    } else {
      // return "";
    }
  }

  Future<void> updateCallStatusFailed(String callId) async {
    var response = await HttpRequest.httpGetRequest(
      endPoint: HttpUrls.Update_Call_Status_Failed + callId,
    );
    if (response != null) {
      // return response.data['id'].toString();
    } else {
      // return "";
    }
  }

  Future<String?> checkCallAvailability(String userId) async {
    var response = await HttpRequest.httpGetRequest(
      endPoint: HttpUrls.checkCallAvailability +
          "/?user_Id=" +
          userId +
          "&is_Student_Calling=1",
    );

    if (response!.statusCode == 200) {
      if (response.data is List<dynamic>) {
        bool isBusy = response.data[0]["is_busy"] == 1;
        return isBusy ? response.data[0]["message"] : "";
      }
    }
    return null;
  }

  //
  // stopIncomingCall({required String liveId,required String teacherId}) async {
  //   // DateTime now = DateTime.now();
  //
  //   Map<String, dynamic> jsonData = {
  //     "id": liveId,
  //     "teacher_id": teacherId,
  //     "student_id": PrefUtils().getStudentId(),
  //     "call_start": null,
  //     "call_end": DateTime.now().toString(),
  //     "call_duration": 0,
  //     "call_type": null,
  //     "Is_Student_Called": 1,
  //     "Live_Link": null
  //   };
  //   await HttpRequest.httpPostBodyRequest(
  //     bodyData: jsonData,
  //     endPoint: HttpUrls.saveStudentCall,
  //   ).then((response) {
  //     if (response != null) {
  //       print(response);
  //       print("Successful");
  //     } else {
  //       print(response);
  //       print("Not Successful");
  //     }
  //   });
  //
  //   update();
  // }

  getTeacherList() async {
    print('hdgfhrf ');
    try {
      final response = await HttpRequest.httpGetRequest(
        endPoint: '${HttpUrls.getAvailableMentors}',
      );

      if (response!.statusCode == 200) {
        // Log the raw response data
        print('Raw response data: ${response.data}');

        // Determine the structure of the response
        if (response.data is List<dynamic>) {
          final responseData = response.data as List<dynamic>;

          // Check each item in the list
          for (var item in responseData) {
            print('Item type: ${item.runtimeType}');
            print('Item data: $item');
          }

          // If responseData is a List<List<dynamic>>, handle accordingly
          if (responseData.isNotEmpty && responseData.first is List<dynamic>) {
            final nestedList = responseData.first as List<dynamic>;

            // Log the nested list's structure
            for (var nestedItem in nestedList) {
              print('Nested item type: ${nestedItem.runtimeType}');
              print('Nested item data: $nestedItem');
            }

            // Map the nested list to TeacherModel
            final teacherDataList = nestedList.map((item) {
              if (item is Map<String, dynamic>) {
                return TeacherModel.fromJson(item);
              } else {
                throw Exception(
                    'Unexpected nested item type: ${item.runtimeType}');
              }
            }).toList();

            teacherList.value = teacherDataList;

            print(teacherDataList);
            print('Teacher details loaded successfully');
          } else {
            throw Exception(
                'Unexpected response format: List does not contain nested lists');
          }
        } else {
          throw Exception(
              'Unexpected response format: ${response.data.runtimeType}');
        }
      } else {
        throw Exception('Failed to load teacher data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }

    update();
  }

  getHodList() async {
    try {
      final response = await HttpRequest.httpGetRequest(
        endPoint: '${HttpUrls.getHod}',
      );

      if (response!.statusCode == 200) {
        print('Raw response data: ${response.data}');
        if (response.data is List<dynamic>) {
          final responseData = response.data as List<dynamic>;
          for (var item in responseData) {
            print('Item type: ${item.runtimeType}');
            print('Item data: $item');
          }
          if (responseData.isNotEmpty && responseData.first is List<dynamic>) {
            final nestedList = responseData.first as List<dynamic>;
            for (var nestedItem in nestedList) {
              print('Nested item type: ${nestedItem.runtimeType}');
              print('Nested item data: $nestedItem');
            }
            final hodDataList = nestedList.map((item) {
              if (item is Map<String, dynamic>) {
                return TeacherModel.fromJson(item);
              } else {
                throw Exception(
                    'Unexpected nested item type: ${item.runtimeType}');
              }
            }).toList();

            hodList.value = hodDataList;

            print(hodDataList);
            print('Teacher details loaded successfully');
          } else {
            throw Exception(
                'Unexpected response format: List does not contain nested lists');
          }
        } else {
          throw Exception(
              'Unexpected response format: ${response.data.runtimeType}');
        }
      } else {
        throw Exception('Failed to load teacher data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }

    update();
  }

  getCourseTimeSlot(int courseID) async {
    await HttpRequest.httpGetRequest(
      endPoint: '${HttpUrls.getCourseTimeSlots(courseID)}',
    ).then((response) {
      if (response!.statusCode == 200) {
        final List<dynamic> slotList = response.data[0];
        timeSlotList.value =
            slotList.map((result) => TimeSlotModel.fromJson(result)).toList();
        log(slotList.toString());
        print('Time Slot loaded successfully');
      } else {
        throw Exception(
            'Failed to load time slot data: ${response.statusCode}');
      }
    });
    update();
  }
}
