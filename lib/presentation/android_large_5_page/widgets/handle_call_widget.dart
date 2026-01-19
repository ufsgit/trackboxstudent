import 'package:anandhu_s_application4/core/utils/extentions.dart';
import 'package:anandhu_s_application4/core/utils/firebase_utils.dart';
import 'package:anandhu_s_application4/core/utils/pref_utils.dart';
import 'package:anandhu_s_application4/http/loader.dart';
import 'package:anandhu_s_application4/presentation/android_large_5_page/controller/call_chat_controller.dart';
import 'package:anandhu_s_application4/presentation/android_large_5_page/models/current_call_model.dart';
import 'package:anandhu_s_application4/presentation/home_page/controller/home_controller.dart';
import 'package:anandhu_s_application4/presentation/home_page/models/save_student_model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_callkit_incoming_yoer/flutter_callkit_incoming.dart';

Future<void> handleTeacherCall({
  required String teacherId,
  required String teacherName,
  required String callId,
  required bool isVideo,
  required String profileImageUrl,
  required String liveLink,
  required HomeController homeController,
  required CallandChatController callandChatController,
  required Function safeBack,
  bool isIncomingCall = false,
}) async {
  try {
    Loader.showLoader();

    await FlutterCallkitIncoming.endCall(callId);

    if (callId.isNullOrEmpty()) {
      await handleNewTeacherCall(
        teacherId: teacherId,
        teacherName: teacherName,
        isVideo: isVideo,
        profileImageUrl: profileImageUrl,
        liveLink: liveLink,
        homeController: homeController,
        callandChatController: callandChatController,
        safeBack: safeBack,
        isIncomingCall: isIncomingCall,
      );
    } else {
      await handleExistingTeacherCall(
        teacherId: teacherId,
        teacherName: teacherName,
        callId: callId,
        isVideo: isVideo,
        profileImageUrl: profileImageUrl,
        liveLink: liveLink,
        homeController: homeController,
        callandChatController: callandChatController,
        safeBack: safeBack,
      );
    }

    Loader.stopLoader();
  } catch (e) {
    Loader.stopLoader();
    debugPrint('Error in handleTeacherCall: $e');
    rethrow;
  }
}

Future<void> handleNewTeacherCall({
  required String teacherId,
  required String teacherName,
  required bool isVideo,
  required String profileImageUrl,
  required String liveLink,
  required HomeController homeController,
  required CallandChatController callandChatController,
  required Function safeBack,
  bool isIncomingCall = false,
}) async {
  try {
    Loader.showLoader();

    String updatedLiveLink =
        isIncomingCall ? liveLink : PrefUtils().getGmeetLink();
    String? newCallId;
    SaveStudentCallModel? callModel;

    if (!isIncomingCall) {
      callModel = SaveStudentCallModel(
        id: 0,
        teacherId: int.parse(teacherId),
        studentId: 0,
        callStart: DateTime.now(),
        callEnd: '',
        callDuration: null,
        callType: isVideo ? "Video" : "Audio",
        isStudentCalled: 1,
        liveLink: updatedLiveLink,
        studentName: PrefUtils().getStudentName(),
        profileUrl: PrefUtils().getProfileUrl(),
      );

      newCallId = await homeController.saveStudentCall(callModel);
    }

    if (!newCallId.isNullOrEmpty()) {
      bool hasRecentCall =
          await FirebaseUtils.checkForRecentCallWithSameTeacher(teacherId);
      if (!isIncomingCall && callModel != null) {
        await FirebaseUtils.saveCall(
          teacherId,
          teacherName,
          newCallId ?? '',
          callModel,
        );
        FirebaseUtils.listeningToCurrentCall(teacherId, newCallId ?? '');
      }

      callandChatController.currentCallModel.value = CurrentCallModel(
        callerId: teacherId,
        callId: newCallId,
        callerName: teacherName,
        isVideo: isVideo,
        profileImg: profileImageUrl,
        liveLink: updatedLiveLink,
        type: "new_call",
      );
    }

    Loader.stopLoader();
  } catch (e) {
    Loader.stopLoader();
    debugPrint('Error in handleNewTeacherCall: $e');
    rethrow;
  }
}

Future<void> handleExistingTeacherCall({
  required String teacherId,
  required String teacherName,
  required String callId,
  required bool isVideo,
  required String profileImageUrl,
  required String liveLink,
  required HomeController homeController,
  required CallandChatController callandChatController,
  required Function safeBack,
}) async {
  try {
    Loader.showLoader();

    bool callExists = await FirebaseUtils.checkIfCallExists(teacherId, callId);

    if (!callExists) {
      callandChatController.currentCallModel.value = CurrentCallModel();
      await callandChatController.disconnectCall(
          true, false, teacherId, callId);

      if (Get.currentRoute == "/IncomingCallPage") {
        safeBack();
      }
    } else {
      FirebaseUtils.listeningToCurrentCall(teacherId, callId);
      FirebaseUtils.updateCallStatus(teacherId, FirebaseUtils.callAccepted);
      await homeController.updateCallStatusAccept(callId);

      callandChatController.currentCallModel.value = CurrentCallModel(
        callerId: teacherId,
        callId: callId,
        callerName: teacherName,
        isVideo: isVideo,
        profileImg: profileImageUrl,
        liveLink: liveLink,
        type: "new_call",
      );
    }

    Loader.stopLoader();
  } catch (e) {
    Loader.stopLoader();
    debugPrint('Error in handleExistingTeacherCall: $e');
    rethrow;
  }
}
