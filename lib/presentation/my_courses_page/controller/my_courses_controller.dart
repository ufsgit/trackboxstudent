import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/app_export.dart';
import '../../../http/http_request.dart';
import '../../../http/http_urls.dart';
import '../models/my_courses_details_model.dart';
import '../models/my_courses_model.dart';

/// A controller class for the MyCoursesPage.
///
/// This class manages the state of the MyCoursesPage, including the
/// current myCoursesModelObj
class MyCoursesController extends GetxController {
  MyCoursesController(this.myCoursesModelObj);

  // @override
  // void onReady() {
  //   getMyCourses() ;

  //   super.onReady();
  // }
  // @override
  // void onInit() {
  //    getMyCourses() ;
  //   super.onInit();
  // }

  TextEditingController searchController = TextEditingController();

  Rx<MyCoursesModel> myCoursesModelObj;
  RxList<MyCourseDetailsModel> myCourseList = <MyCourseDetailsModel>[].obs;
  // List<MyCourseDetailsModel> myCourseList = [];

  List<MyCourseDetailsModel> myCourseSearchList = [];

  bool isSearchEmpty = false;

  getMyCourses() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String studentId = preferences.getString('breffini_student_id') ?? '';
    await HttpRequest.httpGetRequest(
      endPoint: HttpUrls.getMyCourseDetails(studentId),
    ).then((value) {
      if (value != null) {
        List data = value.data;
        print('my course details $value');

        myCourseList.value =
            data.map((e) => MyCourseDetailsModel.fromJson(e)).toList();
      }
    });
    update();
  }

  void searchCourses(String query) {
    if (query.isEmpty) {
      myCourseSearchList.clear();
      isSearchEmpty = false;
    } else {
      myCourseSearchList = myCourseList
          .where((course) =>
              course.courseName.toLowerCase().contains(query.toLowerCase()))
          .toList();
      isSearchEmpty = myCourseSearchList.isEmpty;
    }
    update();
  }

  getSearchedMyCourses() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String studentId = preferences.getString('breffini_student_id') ?? '';
    await HttpRequest.httpGetRequest(
      endPoint:
          '${HttpUrls.getMyCourseDetails(studentId)}${HttpUrls.getMyCourseSearchByName}${searchController.text}',
    ).then((value) {
      if (value != null) {
        List data = value.data;
        print('my course searched details $value');
        if (data.isEmpty) {
          isSearchEmpty = true;
        } else {
          isSearchEmpty = false;
        }
        myCourseSearchList =
            data.map((e) => MyCourseDetailsModel.fromJson(e)).toList();
      }
    });

    update();
  }

  @override
  void onClose() {
    super.onClose();
    searchController.dispose();
    myCourseSearchList.clear();
  }
}
