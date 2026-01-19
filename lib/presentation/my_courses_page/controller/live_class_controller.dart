import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:anandhu_s_application4/http/http_request.dart';
import 'package:anandhu_s_application4/http/http_urls.dart';
import 'package:anandhu_s_application4/http/socket_io.dart';
import 'package:anandhu_s_application4/presentation/my_courses_page/models/live_class_model.dart';
import 'package:get/get.dart';

class LiveClassController extends GetxController {
  RxList<LiveClassModel> liveNowCourseList = <LiveClassModel>[].obs;

  bool isLiveNow = false;

  // checkCourseLiveByID(int courseId, int batchId) async {
  //   await HttpRequest.httpGetRequest(
  //     endPoint: '${HttpUrls.
  //
  //     checkMyCourseLiveNow}$courseId/$batchId',
  //   ).then((value) {
  //     if (value != null) {
  //       List data = value.data;
  //       print('my live course details $value');
  //       liveNowCourseList.value =
  //           data.map((e) => LiveClassModel.fromJson(e)).toList();
  //       // liveNowCourseList.value = data;
  //     }
  //   });
  //   update();
  // }
  checkCourseLiveByID(int courseId, int batchId) {
    try {
      // isLoading.value = true;

      ChatSocket.emitLiveClass(courseId, batchId);

      ChatSocket.listenOngoingLiveClass();
    } catch (error) {
    } finally {}
  }

  Future<int> saveStudentLiveData(
      int liveClassId, int studentLiveClassId) async {
    Map<String, dynamic> body = Map<String, dynamic>();
    int studentLiveClassId = 0;
    if (studentLiveClassId > 0) {
      //caLL exit
      body = {
        "StudentLiveClass_ID": studentLiveClassId,
        "End_Time": DateTime.now().toString(),
      };
    } else {
      body = {
        //call join
        "StudentLiveClass_ID": 0,
        "Student_ID": PrefUtils().getStudentId(),
        "LiveClass_ID": liveClassId,
        "Start_Time": DateTime.now().toString(),
        "Attendance_Duration": 60
      };
    }

    var value = await HttpRequest.httpPostBodyRequest(
      bodyData: body,
      endPoint: HttpUrls.saveStudentLiveData,
    );
    if (value != null) {
      if (value.data[0] != null) {
        studentLiveClassId = value.data[0]['StudentLiveClass_ID'];
        // Get.showSnackbar(GetSnackBar(
        //   message: 'Account deleted successfully',
        //   duration: Duration(milliseconds: 3000),
        // ));
      }
    } else {
      // Get.showSnackbar(GetSnackBar(
      //   message: 'Cant delete your account',
      //   duration: Duration(milliseconds: 800),
      // ));
    }
    return studentLiveClassId;
  }

  @override
  void onClose() {
    super.onClose();
    print('live controller closed');
    liveNowCourseList.clear();
  }
}
