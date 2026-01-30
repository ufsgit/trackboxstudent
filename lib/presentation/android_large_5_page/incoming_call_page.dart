import 'dart:async';

import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:anandhu_s_application4/core/colors_res.dart';
import 'package:anandhu_s_application4/core/utils/common_utils.dart';
import 'package:anandhu_s_application4/core/utils/date_time_utils.dart';
import 'package:anandhu_s_application4/core/utils/extentions.dart';
import 'package:anandhu_s_application4/core/utils/firebase_utils.dart';
import 'package:anandhu_s_application4/core/utils/key_center.dart';
import 'package:anandhu_s_application4/http/http_urls.dart';
// import 'package:anandhu_s_application4/http/socket_io.dart';
import 'package:anandhu_s_application4/main.dart';
import 'package:anandhu_s_application4/presentation/android_large_5_page/controller/call_chat_controller.dart';
import 'package:anandhu_s_application4/presentation/android_large_5_page/models/current_call_model.dart';
import 'package:anandhu_s_application4/presentation/home_page/controller/home_controller.dart';
import 'package:anandhu_s_application4/presentation/home_page/models/home_model.dart';
import 'package:anandhu_s_application4/presentation/home_page/models/save_student_model.dart';
import 'package:anandhu_s_application4/presentation/my_courses_page/controller/live_class_controller.dart';
import 'package:anandhu_s_application4/presentation/profile/controller/profile_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_callkit_incoming_yoer/flutter_callkit_incoming.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/scheduler.dart' as scheduler;

class IncomingCallPage extends StatefulWidget {
  String liveLink;
  String callId;
  int teacherId;
  String profileImageUrl;
  bool video;
  String teacherName;

  // final bool isIncomingCall;

  IncomingCallPage({
    super.key,
    required this.liveLink,
    required this.teacherId,
    required this.callId,
    required this.video,
    // required this.isIncomingCall,
    required this.profileImageUrl,
    required this.teacherName,
  });

  @override
  State<IncomingCallPage> createState() => _IncomingCallPageState();
}

class _IncomingCallPageState extends State<IncomingCallPage>
    with SingleTickerProviderStateMixin {
  _IncomingCallPageState();
  final ProfileController profileController = Get.find<ProfileController>();
  final CallandChatController callandChatController =
      Get.put(CallandChatController());

  LiveClassController liveController = Get.put(LiveClassController());
  HomeController homeController = Get.put(HomeController(HomeModel().obs));
  var uuid = Uuid();
  // AnimationController? animationController;
  // late Animation<double> _animation;
  String busyMessage = "";

  @override
  void initState() {
    super.initState();
    if (!widget.profileImageUrl.isNullOrEmpty() &&
        !widget.profileImageUrl.startsWith("http")) {
      widget.profileImageUrl = HttpUrls.imgBaseUrl + widget.profileImageUrl;
    }
    scheduler.SchedulerBinding.instance.addPostFrameCallback((_) async {
      await FlutterCallkitIncoming.endCall(widget.callId);

      if (widget.callId.isNullOrEmpty()) {
        widget.liveLink = uuid.v1();
        setState(() {});

        SaveStudentCallModel callModel = SaveStudentCallModel(
          id: 0,
          teacherId: widget.teacherId,
          studentId: 0,
          callStart: DateTime.now(),
          callEnd: '',
          callDuration: null,
          callType: widget.video ? "Video" : "Audio",
          isStudentCalled: 1,
          liveLink: widget.liveLink,
          studentName: PrefUtils().getStudentName(),
          profileUrl: PrefUtils().getProfileUrl(),
        );
        homeController.saveStudentCall(callModel).then((value) async {
          if (!value.isNullOrEmpty()) {
            widget.callId = value;
            await FirebaseUtils.saveCall(widget.teacherId.toString(),
                widget.teacherName, widget.callId, callModel);
            FirebaseUtils.listeningToCurrentCall(
              widget.teacherId.toString(),
              widget.callId,
            );

            callandChatController.currentCallModel.value = CurrentCallModel(
                callerId: widget.teacherId.toString(),
                callId: (widget.callId),
                callerName: widget.teacherName,
                isVideo: widget.video,
                profileImg: widget.profileImageUrl,
                liveLink: widget.liveLink,
                type: "new_call");
          }
        });
      } else {
        FirebaseUtils.checkIfCallExists(
                widget.teacherId.toString(), widget.callId)
            .then((value) async {
          if (!value) {
            callandChatController.currentCallModel.value = CurrentCallModel();

            await callandChatController.disconnectCall(
                true, false, widget.teacherId.toString(), widget.callId);
            if (Get.currentRoute == "/IncomingCallPage") {
              safeBack();
            }
          } else {
            FirebaseUtils.listeningToCurrentCall(
              widget.teacherId.toString(),
              widget.callId,
            );

            FirebaseUtils.updateCallStatus(
                widget.teacherId.toString(), FirebaseUtils.callAccepted);
            homeController.updateCallStatusAccept(widget.callId);

            callandChatController.currentCallModel.value = CurrentCallModel(
                callerId: widget.teacherId.toString(),
                callId: (widget.callId),
                callerName: widget.teacherName,
                isVideo: widget.video,
                profileImg: widget.profileImageUrl,
                liveLink: widget.liveLink,
                type: "new_call");
          }
        });
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Video Call Features are currently disabled.",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  callandChatController.disconnectCall(true, false,
                      widget.teacherId.toString(), widget.callId ?? "");
                  Get.back();
                },
                child: Text("Close Call"),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> checkUserAvailability() async {
    busyMessage = await homeController
            .checkCallAvailability(widget.teacherId.toString()) ??
        "";

    if (!busyMessage.isNullOrEmpty()) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        safeBack();
        Get.showSnackbar(GetSnackBar(
          message: busyMessage,
          duration: Duration(milliseconds: 3000),
        ));
      });
    }
    setState(() {});
    return busyMessage.isNullOrEmpty();
  }
}
