import 'dart:convert';
import 'dart:developer';
import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:anandhu_s_application4/http/http_request.dart';
import 'package:anandhu_s_application4/http/http_urls.dart';
import 'package:anandhu_s_application4/presentation/login/login_controller.dart';
import 'package:anandhu_s_application4/presentation/onboarding/course_list_model.dart';
import 'package:anandhu_s_application4/presentation/onboarding/occupation_list_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

final OnboardingController onboardingController =
    Get.put(OnboardingController());

class OnboardingController extends GetxController {
  @override
  void onReady() {
    getCourseDropdownValue(courseName: 'popular');
    getCourseDropdownValue(courseName: 'recommended');

    super.onReady();
  }

  OccupationListModel? occupationDropdownValue;
  CourseListModel? courseModelDropdownValue;

  List<OccupationListModel> occupationDropdownListValue = [];
  List<CourseListModel> courseList = [];

  // List<ValueItem<Object?>> selectedOptions = [];

  List<CourseListModel> courseListWidget = [];

  List<CourseListModel> popularCourseList = [];
  List<CourseListModel> recommendedCourseList = [];
  final LoginController loginController = Get.put(LoginController());

//for loading
  RxBool isCourseLoading = true.obs;

  getOccupationDropdownValue() async {
    await HttpRequest.httpGetRequest(endPoint: HttpUrls.getOccupations)
        .then((value) {
      if (value != null) {
        print(value.data);

        List data = value.data;
        occupationDropdownListValue =
            data.map((e) => OccupationListModel.fromJson(e)).toList();
        print(occupationDropdownListValue);
      }
    });
    update();
  }

  Future<void> getCourseDropdownValue({required String courseName}) async {
    print('coursedropdownapi///////////////');
    try {
      // Make the HTTP GET request
      final response = await HttpRequest.httpGetRequest(
        endPoint: HttpUrls.getSpecificCourseDetails,
        bodyData: {
          "course_Type": courseName,
        },
      );

      // Check if the response is not null
      if (response != null) {
        // Print the type and content of the response data for debugging
        print('Response data type: ${response.data.runtimeType}');
        print('Response data: ${response.data}');

        // Decode the response data from JSON if it is a string
        List<dynamic> data;
        if (response.data is String) {
          try {
            data = jsonDecode(response.data) as List<dynamic>;
          } catch (e) {
            print('Error parsing response data: $e');
            return;
          }
        } else {
          // If response.data is not a string, treat it as already parsed
          data = response.data as List<dynamic>;
        }

        // Update the lists based on the course type
        if (courseName == 'popular') {
          popularCourseList =
              data.map((e) => CourseListModel.fromJson(e)).toList();
          print('popular : $popularCourseList');
        } else if (courseName == 'recommended') {
          recommendedCourseList =
              data.map((e) => CourseListModel.fromJson(e)).toList();
          print('recommended : $recommendedCourseList');
        } else {
          courseList = data.map((e) => CourseListModel.fromJson(e)).toList();
          print(courseList);
        }

        // Additional debug print statements if needed
        print(courseList);
        print('recommended : $recommendedCourseList');
      }
    } catch (e) {
      print('Error during HTTP request or data processing: $e');
    } finally {
      isCourseLoading.value = false;
      update();
    }
  }

  saveOccupation() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String studentId = preferences.getString('breffini_student_id') ?? '';
    log('save occupation $studentId ============================.');
    log('save occupation iddddd ${occupationDropdownValue?.occupationId} ============================.');

    await HttpRequest.httpPostBodyRequest(bodyData: {
      "Student_ID": studentId,
      "Occupation_Id": occupationDropdownValue?.occupationId,
      "Prefferd_Course": courseListWidget.map((e) => e.courseID).toList()
    }, endPoint: HttpUrls.saveOccupation)
        .then((value) {
      if (value != null) {
        print(value.data);
        occupationDropdownValue = null;
        courseListWidget.clear();
        loginController.firstNameController.clear();
        loginController.lastNameController.clear();
        loginController.emailController.clear();
        loginController.phoneController.clear();
        loginController.genderController.clear();
        loginController.dobController.clear();
        Get.offAllNamed(AppRoutes.homePageContainerScreen);
        // Get.toNamed(AppRoutes.homePageContainerScreen);
      }
    });
    update();
  }
}
