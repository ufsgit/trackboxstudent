import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:anandhu_s_application4/presentation/exam_details_screen/models/live_class_joining_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:zego_express_engine/zego_express_engine.dart';
// import '../../../core/utils/zego_sdk_user.dart';
import '../../../http/http_request.dart';
import '../../../http/http_urls.dart';
import '../../profile/controller/profile_controller.dart';

class LiveClassJoiningController extends GetxController {
  ValueNotifier<dynamic> publisherState = ValueNotifier<dynamic>(null);
  // ZegoSDKUser? currentUser;
  // List<ZegoSDKUser> userDataList = [];

  Future<void> connectUser(String id, String name, {String? token}) async {
    // currentUser = ZegoSDKUser(userID: id, userName: name);
  }

  Future<void> disconnectUser() async {
    // currentUser = null;
  }

  Future<bool> requestPermission() async {
    debugPrint("requestPermission...");
    try {
      PermissionStatus microphoneStatus = await Permission.microphone.request();
      if (microphoneStatus != PermissionStatus.granted) {
        debugPrint('Error: Microphone permission not granted!!!');
        return false;
      }
    } on Exception catch (error) {
      debugPrint("[ERROR], request microphone permission exception, $error");
    }

    try {
      PermissionStatus cameraStatus = await Permission.camera.request();
      if (cameraStatus != PermissionStatus.granted) {
        debugPrint('Error: Camera permission not granted!!!');
        return false;
      }
    } on Exception catch (error) {
      debugPrint("[ERROR], request camera permission exception, $error");
    }

    return true;
  }

  Future<void> updateStreamExtraInfo(bool micStatus, bool camStatus) async {
    // if (kIsWeb && (publisherState.value != ZegoPublisherState.Publishing)) {
    //   return;
    // }

    final ProfileController profileController = Get.find<ProfileController>();
    final extraInfo = jsonEncode({
      'mic': micStatus ? 'on' : 'off',
      'cam': camStatus ? 'on' : 'off',
      "userID": profileController.profileData?.studentId ?? "",
      "userName": profileController.profileData?.firstName ?? "",
    });
    // await ZegoExpressEngine.instance.setStreamExtraInfo(extraInfo);
    for (int index = 0; index < userInfoList.length; index++) {
      if (userInfoList[index]["userID"] ==
          profileController.profileData!.studentId) {
        userInfoList[index]["videoStatus"] = camStatus;
        userInfoList[index]['audioStatus'] = micStatus;
        log(userInfoList.toString());
      }
    }

    print('Extract Info: $extraInfo');
  }

  var userInfoList = [].obs;
  var isListener = true.obs;
  var userCount = 0.obs;
  var isAudioEnabled = true.obs;
  var isVideoEnabled = true.obs;

  var qnaMode = false.obs;
  void turnCameraOn(bool isOn, context) {
    // ZegoExpressEngine.instance.enableCamera(isOn);
    isVideoEnabled.value = isOn;
    updateStreamExtraInfo(isAudioEnabled.value, isVideoEnabled.value);
  }

  void turnMicrophoneOn(bool isOn, context) {
    // ZegoExpressEngine.instance.mutePublishStreamAudio(isOn);
    isAudioEnabled.value = isOn;
    updateStreamExtraInfo(isAudioEnabled.value, isVideoEnabled.value);
  }

  getUserCount(int count) {
    userCount.value = count;
  }

  var userStatus = false.obs;
  List<dynamic> usersList = [];
  getUserList(bool status, List<dynamic> userList, int index, context) {
    userStatus.value = status;
    usersList = userList;
    if (userStatus.value == true) {
      // if (userInfoList
      //         .indexWhere((item) => item['userID'] == userList[index].userID) ==
      //     -1) {
      //   userInfoList.add({
      //     "userID": userList[index].userID,
      //     "userName": userList[index].userName,
      //     "videoStatus": isVideoEnabled.value,
      //     "audioStatus": isAudioEnabled.value,
      //   });
      // }
    } else {
      userInfoList.removeAt(index);
    }
    log('User List: ${userInfoList.toString()}');
  }

  List extraInfoList = [];
  getRoomExtraInfo(List roomExtraInfoList) {
    extraInfoList = roomExtraInfoList;
  }

  var onButtonPop = false.obs;
  popUpMenuButton(bool isOn) {
    onButtonPop.value = isOn;
  }

  var frontCamEnabled = true.obs;
  switchCamera(bool isOn) {
    // ZegoExpressEngine.instance.useFrontCamera(isOn);
    frontCamEnabled.value = isOn;
    popUpMenuButton(false);
  }

  viewLiveDetails() {
    popUpMenuButton(false);
  }

  String getInitials(String userName) {
    List<String> names = userName.split(" ");
    String initials = "";
    int numWords = 2;

    if (numWords < names.length) {
      numWords = names.length;
    }
    for (var i = 0; i < numWords; i++) {
      initials += names[i][0];
    }
    return initials;
  }

  Timer? timer;
  var start = 0.obs; // Set initial duration in seconds
  var formattedTime = '00:00'.obs;

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      start.value++;
      formattedTime.value = formatTime(start.value);
    });
  }

  String formatTime(int seconds) {
    int minutes = (seconds / 60).floor();
    int secs = seconds % 60;
    return '${padZero(minutes)}:${padZero(secs)}';
  }

  String padZero(int number) {
    log('${number.toString().padLeft(2, '0')}');
    return number.toString().padLeft(2, '0');
  }
}
