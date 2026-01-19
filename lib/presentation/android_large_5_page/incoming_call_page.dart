import 'dart:async';

import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:anandhu_s_application4/core/colors_res.dart';
import 'package:anandhu_s_application4/core/utils/common_utils.dart';
import 'package:anandhu_s_application4/core/utils/date_time_utils.dart';
import 'package:anandhu_s_application4/core/utils/extentions.dart';
import 'package:anandhu_s_application4/core/utils/firebase_utils.dart';
import 'package:anandhu_s_application4/core/utils/key_center.dart';
import 'package:anandhu_s_application4/http/http_urls.dart';
import 'package:anandhu_s_application4/http/socket_io.dart';
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
import 'package:zego_express_engine/zego_express_engine.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
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
            // FirebaseUtils.checkForRecentCallWithSameTeacher(
            //         widget.teacherId.toString())
            //     .then((value) async {
            //   if (value) {
            //     // await ZegoUIKitPrebuiltCallController().hangUp(context);
            //     ScaffoldMessenger.of(context).showSnackBar(
            //       SnackBar(
            //           content: Text(
            //               "Cant place new call. While you are in another call")),
            //     );
            //     homeController.updateCallStatusFailed(widget.callId);
            //     if (Get.currentRoute == "/IncomingCallPage") {
            //       safeBack();
            //     }
            //   } else {
            //     // if (Get.currentRoute == "/IncomingCallPage") {
            //     await FirebaseUtils.saveCall(widget.teacherId.toString(),
            //         widget.teacherName, widget.callId, callModel);
            //     FirebaseUtils.listeningToCurrentCall(
            //       widget.teacherId.toString(),
            //       widget.callId,

            //     );

            //     callandChatController.currentCallModel.value = CurrentCallModel(
            //         callerId: widget.teacherId.toString(),
            //         callId: (widget.callId),
            //         callerName: widget.teacherName,
            //         isVideo: widget.video,
            //         profileImg: widget.profileImageUrl,
            //         liveLink: widget.liveLink,
            //         type: "new_call");
            //   }
            // });
          }
        });
      } else {
        FirebaseUtils.checkIfCallExists(
                widget.teacherId.toString(), widget.callId)
            .then((value) async {
          if (!value) {
            callandChatController.currentCallModel.value = CurrentCallModel();
            // await ZegoUIKitPrebuiltCallController().hangUp(context);
            // ZegoUIKit.instance.uninit();
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
    // if(null!=animationController && animationController!.isDismissed){
    //   animationController?.dispose();
    // }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PopScope(
          canPop: true,
          onPopInvokedWithResult: (bool didPop, callBack) async {
            if (didPop) {
            } else {
              if (!ZegoUIKitPrebuiltCallController().minimize.minimize(
                    context,
                    rootNavigator: true,
                  )) {
                safeBack(canPop: false);

                // return;
              }
            }

            /// not support end by return button
          },
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              ZegoUIKitPrebuiltCall(
                onDispose: () async {
                  // if (ZegoUIKitPrebuiltCallController().minimize.isMinimizing) {
                  //   // if (!ZegoUIKitPrebuiltCallController().minimize.minimize(
                  //   //       context,
                  //   //       rootNavigator: true,
                  //   //     )) {
                  //   //   showCallNotification(context);
                  //   //   // return;
                  //   // }
                  // } else {
                  //   SchedulerBinding.instance.addPostFrameCallback((_) async {
                  //     callandChatController.audioCallFormatedTime.value =
                  //         "00:00";
                  //     callandChatController.stopTimer();
                  //      await liveClassController.stopCall(
                  //         widget.teacherId.toString(), widget.studentCallId);
                  //   });
                  // }

                  //
                  // Get.back();
                },
                appID: appID,
                appSign: appSign,
                userID: PrefUtils().getStudentId().toString(),
                userName: PrefUtils().getStudentName(),
                callID: widget.liveLink,
                config: widget.video == true
                    ? ZegoUIKitPrebuiltCallConfig.groupVideoCall()
                    : ZegoUIKitPrebuiltCallConfig.groupVoiceCall()
                  ..bottomMenuBar = ZegoCallBottomMenuBarConfig(
                    // padding: EdgeInsets.symmetric(horizontal: 16),
                    hideAutomatically: false,
                    height: 64,
                    margin: EdgeInsets.symmetric(
                      horizontal: 3,
                      vertical: 32,
                    ),
                    backgroundColor: Colors.grey.withOpacity(.5),
                    buttons: [
                      // ZegoCallMenuBarButtonName.toggleScreenSharingButton,
                      if (widget.video)
                        ZegoCallMenuBarButtonName.switchCameraButton,
                      if (widget.video)
                        ZegoCallMenuBarButtonName.toggleCameraButton,

                      ZegoCallMenuBarButtonName.switchAudioOutputButton,
                      ZegoCallMenuBarButtonName.toggleMicrophoneButton,
                      ZegoCallMenuBarButtonName.hangUpButton,
                    ],
                  )
                  ..foreground = Align(
                    alignment: Alignment.topCenter,
                    child: Obx(() => Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(top: 40),
                          // width: 150,
                          height: 150,
                          // color: Color(0xff4A4B4D),
                          alignment: Alignment.topCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.teacherName,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      callandChatController
                                                  .audioCallFormatedTime
                                                  .value ==
                                              "00:00"
                                          ? "Connecting"
                                          : callandChatController
                                              .audioCallFormatedTime.value,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                  )
                  ..layout = ZegoLayout.gallery(
                    showScreenSharingFullscreenModeToggleButtonRules:
                        ZegoShowFullscreenModeToggleButtonRules.alwaysShow,
                    showNewScreenSharingViewInFullscreenMode: true,

                    // margin: EdgeInsets.all(50)
                  )
                  ..topMenuBar.isVisible = true
                  ..topMenuBar = ZegoCallTopMenuBarConfig(
                    hideAutomatically: false,
                    height: 50,
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.all(0),
                    style: ZegoCallMenuBarStyle.light,
                  )
                  ..topMenuBar.buttons = [
                    ZegoCallMenuBarButtonName.minimizingButton,
                    // ZegoCallMenuBarButtonName.showMemberListButton,
                  ]
                  ..audioVideoView = ZegoCallAudioVideoViewConfig(
                    useVideoViewAspectFill: true,
                  )
                  ..duration = ZegoCallDurationConfig(
                      isVisible: false,
                      onDurationUpdate: (Duration duration) async {
                        if (callandChatController.enteredUserList.length == 0 &&
                            duration.inSeconds == 35) {
                          // to disconnect call ringing after 35 second

                          // animationController?.dispose();
                          ZegoUIKit.instance.uninit();
                          await callandChatController.disconnectCall(
                              true,
                              false,
                              widget.teacherId.toString(),
                              widget.callId);
                          await FlutterCallkitIncoming.endCall(widget.callId);

                          // await cancelNotification();
                          if (Get.currentRoute == "/IncomingCallPage") {
                            safeBack();
                          }
                        }
                        // print(duration.inSeconds.toString()+"////////////////////////////////////");
                        // showCallNotification(context,duration.inSeconds);

                        // print(duration.toString()+"dddddddddddddddddd");
                      })
                  ..avatarBuilder = (BuildContext context, Size size,
                      ZegoUIKitUser? user, Map extraInfo) {
                    return user != null
                        ? CachedNetworkImage(
                            height: size.height,
                            width: size.width,
                            imageUrl: user.id == widget.teacherId.toString()
                                ? widget.profileImageUrl
                                        .contains(HttpUrls.imgBaseUrl)
                                    ? widget.profileImageUrl
                                    : HttpUrls.imgBaseUrl +
                                        widget.profileImageUrl
                                : HttpUrls.imgBaseUrl +
                                    PrefUtils().getProfileUrl(),
                            imageBuilder: (context, imageProvider) => Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                        value: downloadProgress.progress),
                            errorWidget: (context, url, error) => const Center(
                                  child: Icon(
                                    Icons.image_not_supported_outlined,
                                    color: ColorResources.colorBlue100,
                                    size: 40,
                                  ),
                                ))
                        // Container(
                        //         decoration: BoxDecoration(
                        //           shape: BoxShape.circle,
                        //           image: DecorationImage(fit: BoxFit.cover,
                        //             image: NetworkImage(
                        //               user.id==widget.teacherId.toString()?
                        //               widget.profileImageUrl
                        //                       .contains(HttpUrls.imgBaseUrl)
                        //                   ? widget.profileImageUrl
                        //                   : HttpUrls.imgBaseUrl +
                        //                       widget.profileImageUrl:HttpUrls.imgBaseUrl +PrefUtils().getProfileUrl(),
                        //             ),
                        //           ),
                        //         ),
                        //       )
                        : const SizedBox();
                  },
                events: ZegoUIKitPrebuiltCallEvents(
                    onError: (error) {
                      // if(kDebugMode) {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     SnackBar(content: Text(error.message)),
                      //   );
                      // }
                    },
                    room: ZegoCallRoomEvents(
                      onStateChanged: (ZegoUIKitRoomState roomState) {
                        if (roomState == ZegoRoomState.Disconnected) {
                          print(
                              'Room disconnected, possibly due to network issues');
                          // Handle disconnection
                        }
                      },
                    ),
                    user: ZegoCallUserEvents(
                      onEnter: (ZegoUIKitUser user) {
                        if (user.id.toString() == widget.teacherId.toString()) {
                          callandChatController.startTimer();
                          // if(null!=animationController && animationController!.isDismissed){
                          //   animationController?.dispose();
                          // }
                          callandChatController.enteredUserList.add(user.id);

                          // showCallNotification(context);
                        }
                        setState(() {});
                      },
                      onLeave: (ZegoUIKitUser user) {
                        callandChatController.enteredUserList.remove(user.id);
                        setState(() {});
                      },
                    ),
                    onCallEnd: (
                      ZegoCallEndEvent event,
                      VoidCallback defaultAction,
                    ) async {
                      // ZegoUIKit.instance.uninit();

                      defaultAction.call();
                      await callandChatController.disconnectCall(true, false,
                          widget.teacherId.toString(), widget.callId);
                      await FlutterCallkitIncoming.endCall(widget.callId);

                      // await cancelNotification();
                      if (Get.currentRoute == "/IncomingCallPage") {
                        safeBack();
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDot(double scale) {
    return Transform.scale(
      scale: scale,
      child: Container(
        width: 5,
        height: 5,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  // Future<bool> _onWillPop() async {
  //   return (await showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text(
  //           'Exit Call',
  //           style: TextStyle(
  //               fontSize: 16,
  //               fontWeight: FontWeight.w700,
  //               color: const Color(0xff283B52)),
  //         ),
  //         content: Text(
  //           'Are you sure you want to exit the call?',
  //           style: TextStyle(fontSize: 15, color: const Color(0xff283B52)),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             onPressed: () async {
  //               await controller.stopLive(widget.teacherId.toString());
  //               Get.back();
  //               // Get.back();
  //             },
  //             child: Text(
  //               'Yes',
  //               style: TextStyle(
  //                   fontSize: 14,
  //                   fontWeight: FontWeight.w700,
  //                   color: const Color(0xff283B52)),
  //             ),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               Get.back();
  //             },
  //             child: Text(
  //               'No',
  //               style: TextStyle(
  //                   fontSize: 14,
  //                   fontWeight: FontWeight.w700,
  //                   color: const Color(0xff283B52)),
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   )) ??
  //       false;
  // }
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
