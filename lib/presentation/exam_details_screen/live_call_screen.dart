// import 'package:anandhu_s_application4/core/app_export.dart';
// import 'package:anandhu_s_application4/core/utils/key_center.dart';
// import 'package:anandhu_s_application4/presentation/android_large_5_page/controller/call_chat_controller.dart';
// import 'package:anandhu_s_application4/presentation/android_large_5_page/models/current_call_model.dart';
// import 'package:anandhu_s_application4/presentation/exam_details_screen/controller/live_class_joining_controller.dart';
// import 'package:anandhu_s_application4/presentation/exam_details_screen/models/live_class_joining_model.dart';
// import 'package:anandhu_s_application4/presentation/my_courses_page/controller/live_class_controller.dart';
// import 'package:anandhu_s_application4/presentation/profile/controller/profile_controller.dart';
// import 'package:anandhu_s_application4/widgets/animated_container_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_callkit_incoming_yoer/flutter_callkit_incoming.dart';
// // import 'package:zego_uikit_beauty_plugin/zego_uikit_beauty_plugin.dart';
// import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
// import 'package:flutter/scheduler.dart' as scheduler;
// // import 'package:zego_effects_plugin/zego_effects_plugin.dart';

// class LiveCallScreen extends StatefulWidget {
//   final String liveLink;
//   final int callId;
//   final String teacherId, teacherName, profileImageUrl;
//   LiveCallScreen(
//       {super.key,
//       required this.liveLink,
//       required this.callId,
//       required this.teacherId,
//       required this.teacherName,
//       this.profileImageUrl = ""});

//   @override
//   State<LiveCallScreen> createState() => _LiveCallScreenState();
// }

// class _LiveCallScreenState extends State<LiveCallScreen> {
//   final ProfileController profileController = Get.find<ProfileController>();
//   LiveClassController liveController = Get.put(LiveClassController());
//   LiveClassJoiningController liveJoiningController =
//       Get.put(LiveClassJoiningController());
//   CallandChatController callandChatController =
//       Get.put(CallandChatController());
//   int studentLiveClassId = 0;
//   String currentUserId = '';
//   @override
//   void initState() {
//     super.initState();
//     currentUserId = widget.teacherId;
//     scheduler.SchedulerBinding.instance.addPostFrameCallback((_) {
//       FlutterCallkitIncoming.endCall(widget.callId.toString());

//       // setStudentClassStatus(true);
//       callandChatController.startStudentLiveClass(
//           firstCall: false,
//           endTime: null,
//           liveClassId:
//               liveController.liveNowCourseList[0].liveClassID.toString(),
//           startTime: DateTime.now());
//       callandChatController.currentCallModel.value = CurrentCallModel(
//           callerId: widget.teacherId.toString(),
//           callId: (widget.callId.toString()),
//           callerName: widget.teacherName,
//           isVideo: true,
//           profileImg: widget.profileImageUrl,
//           liveLink: widget.liveLink,
//           type: "new_live");
//     });

//     // liveController.currentCallId.value = widget.callId;
//   }

//   // setStudentClassStatus(bool isJoin) async {
//   //   studentLiveClassId = await liveController.saveStudentLiveData(
//   //       widget.callId, isJoin ? 0 : studentLiveClassId);
//   //   if (mounted) setState(() {});
//   // }

//   @override
//   Widget build(BuildContext context) {
//     // final config = ZegoUIKitPrebuiltCallConfig.groupVideoCall();
//     // config.bottomMenuBar.buttons = [
//     //   ZegoCallMenuBarButtonName.beautyEffectButton,
//     //   ...config.bottomMenuBar.buttons,
//     // ];

//     return Scaffold(
//       body: SafeArea(
//           child: ZegoUIKitPrebuiltCall(
//               appID: appID,
//               appSign: appSign,
//               userID: PrefUtils().getStudentId().toString(),
//               userName: PrefUtils().getStudentName(),
//               callID: widget.liveLink,
//               events: ZegoUIKitPrebuiltCallEvents(
//                   user: ZegoCallUserEvents(
//                     onEnter: (ZegoUIKitUser user) {
//                       if (user.id == PrefUtils().getStudentId().toString()) {
//                         // callandChatController.startTimer();
//                       }
//                       // Handle when user enters the call
//                       print('User ${user.name} has entered the call');
//                       // Add any custom behavior like updating UI or showing notification
//                     },
//                     onLeave: (ZegoUIKitUser user) async {
//                       // Handle when user leaves the call
//                       if (user.id == widget.teacherId) {
//                         //case when teacher end live and need everyone left from call
//                         // await ZegoUIKitPrebuiltCallController().hangUp(context);
//                       }
//                       print('User ${user.name} has left the call');
//                       // Add any custom behavior like updating UI or showing notification
//                     },
//                   ),
//                   onCallEnd: (
//                     ZegoCallEndEvent event,
//                     VoidCallback defaultAction,
//                   ) {
//                     print('////////////////hangup triggered');
//                     debugPrint('onCallEnd, do whatever you want');

//                     //when add ZegoUIKitPrebuiltCallController().hangUp(context); in onleave its already calling  defaultAction.call()
//                     // .so here if ts local hangup call  defaultAction.call().
//                     if (event.reason == ZegoCallEndReason.localHangUp) {
//                       defaultAction.call();

//                       callandChatController.startStudentLiveClass(
//                           firstCall: true,
//                           endTime: DateTime.now(),
//                           liveClassId: liveController
//                               .liveNowCourseList[0].liveClassID
//                               .toString(),
//                           startTime: callandChatController.classStartTime);
//                     }
//                     // setStudentClassStatus(true);
//                     callandChatController.currentCallModel.value =
//                         CurrentCallModel();
//                   }),
//               config: ZegoUIKitPrebuiltCallConfig.groupVideoCall()
//                 ..topMenuBar.isVisible = true
//                 ..topMenuBar = ZegoCallTopMenuBarConfig(
//                   hideAutomatically: false,
//                   height: 50,
//                   margin: EdgeInsets.only(top: 10),
//                   padding: EdgeInsets.all(0),
//                   style: ZegoCallMenuBarStyle.light,
//                 )
//                 ..topMenuBar.buttons = [
//                   ZegoCallMenuBarButtonName.minimizingButton,
//                   ZegoCallMenuBarButtonName.showMemberListButton,
//                 ]
//                 ..layout = ZegoLayout.gallery(
//                   showScreenSharingFullscreenModeToggleButtonRules:
//                       ZegoShowFullscreenModeToggleButtonRules.alwaysShow,
//                   showNewScreenSharingViewInFullscreenMode: true,
//                 )
//                 ..bottomMenuBar = ZegoCallBottomMenuBarConfig(
//                   padding: EdgeInsets.symmetric(horizontal: 16),
//                   height: 64,
//                   margin: EdgeInsets.symmetric(horizontal: 3, vertical: 32),
//                   backgroundColor: Colors.grey.withOpacity(.5),
//                   buttons: [
//                     ZegoCallMenuBarButtonName.switchCameraButton,
//                     ZegoCallMenuBarButtonName.toggleCameraButton,
//                     ZegoCallMenuBarButtonName.switchAudioOutputButton,
//                     ZegoCallMenuBarButtonName.toggleMicrophoneButton,
//                     ZegoCallMenuBarButtonName.hangUpButton,
//                   ],
//                 )
//                 ..audioVideoView = ZegoCallAudioVideoViewConfig(
//                     useVideoViewAspectFill: true,
//                     foregroundBuilder: (BuildContext context, Size size,
//                         ZegoUIKitUser? user, Map extraInfo) {
//                       if (user != null && user.id == currentUserId) {
//                         return ValueListenableBuilder(
//                           valueListenable:
//                               ZegoUIKit().getCameraStateNotifier(user.id),
//                           builder: (context, isCameraOn, child) {
//                             return isCameraOn ? const SizedBox() : child!;
//                           },
//                           child: const AnimatedPhoneCallContainer(),
//                         );
//                       }
//                       return const SizedBox();
//                     }))),
//     );
//   }
// }
