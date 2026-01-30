// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:zego_express_engine/zego_express_engine.dart';
// import '../../core/utils/key_center.dart';
// import '../../core/utils/zego_token_utils.dart';
// import '../profile/controller/profile_controller.dart';
// import 'controller/live_class_joining_controller.dart';
// import 'widgets/bottom_bar_widget.dart';
// import 'widgets/live_data_widget.dart';
// import 'widgets/popup_menu_container.dart';
// import 'widgets/remote_user_widget.dart';
// import 'widgets/top_bar_widget.dart';

// class CustomVideoCallScreen extends StatefulWidget {
//   const CustomVideoCallScreen({super.key, required this.callID});
//   final String callID;
//   @override
//   State<CustomVideoCallScreen> createState() => _CustomVideoCallScreenState();
// }

// class _CustomVideoCallScreenState extends State<CustomVideoCallScreen> {
//   LiveClassJoiningController videoCallCtrl =
//       Get.put(LiveClassJoiningController());
//   final ProfileController profileController = Get.find<ProfileController>();
//   Widget? localView;
//   int? localViewID;
//   Widget? remoteView;
//   int? remoteViewID;
//   @override
//   void initState() {
//     startListenEvent();
//     videoCallCtrl.startTimer();
//     loginRoom();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return Scaffold(
//         backgroundColor: Colors.grey.shade700,
//         body: GetBuilder(
//             init: LiveClassJoiningController(),
//             builder: (value) {
//               return Stack(
//                 children: [
//                   //---Local User
//                   Obx(() {
//                     return videoCallCtrl.userInfoList.length == 1 &&
//                             videoCallCtrl.isVideoEnabled.value == true
//                         ? localView ?? const SizedBox.shrink()
//                         : SizedBox(
//                             width: size.width,
//                             height: size.height,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Container(
//                                   width: 163,
//                                   height: 163,
//                                   decoration: BoxDecoration(
//                                       border: Border.all(
//                                           color: Colors.white, width: 3),
//                                       image: const DecorationImage(
//                                           image: AssetImage(
//                                               "assets/images/Ellipse 32.png")),
//                                       shape: BoxShape.circle,
//                                       color: Colors.white),
//                                 ),
//                               ],
//                             ),
//                           );
//                   }),

//                   //---Top Bar
//                   TopBarWidget(size: size, videoCallCtrl: videoCallCtrl),

//                   //Videocall Live Data
//                   VideoCallLiveDataWidget(videoCallCtrl: videoCallCtrl),

//                   //Popup Menu Container
//                   Obx(() {
//                     return videoCallCtrl.onButtonPop.value == true
//                         ? PopUpMenuContainer(videoCallCtrl: videoCallCtrl)
//                         : SizedBox();
//                   }),

//                   //--Call Role Widget
//                   //!-- CallRoleWidget(),

//                   //---Remote User
//                   RemoteUserWidget(
//                       size: size,
//                       videoCallCtrl: videoCallCtrl,
//                       remoteView: remoteView),

//                   //---Bottom Button Bar
//                   BottomBarWidget(
//                     videoCallCtrl: videoCallCtrl,
//                     callID: widget.callID,
//                     localView: localView,
//                     localViewID: localViewID,
//                   )
//                 ],
//               );
//             }));
//   }

//   Future<ZegoRoomLoginResult> loginRoom() async {
//     // The value of `userID` is generated locally and must be globally unique.
//     final user = ZegoUser('${profileController.profileData?.studentId ?? ""}',
//         profileController.profileData?.firstName ?? "");

//     // The value of `roomID` is generated locally and must be globally unique.
//     final roomID = widget.callID;

//     // onRoomUserUpdate callback can be received when "isUserStatusNotify" parameter value is "true".
//     ZegoRoomConfig roomConfig = ZegoRoomConfig.defaultConfig()
//       ..isUserStatusNotify = true;

//     if (kIsWeb) {
//       // ! ** Warning: ZegoTokenUtils is only for use during testing. When your application goes live,
//       // ! ** tokens must be generated by the server side. Please do not generate tokens on the client side!
//       roomConfig.token = ZegoTokenUtils.generateToken(appID, serverSecret,
//           '${profileController.profileData?.studentId ?? ""}');
//     }
//     // log in to a room
//     // Users must log in to the same room to call each other.
//     return ZegoExpressEngine.instance
//         .loginRoom(roomID, user, config: roomConfig)
//         .then((ZegoRoomLoginResult loginRoomResult) {
//       debugPrint(
//           'loginRoom: errorCode:${loginRoomResult.errorCode}, extendedData:${loginRoomResult.extendedData}');
//       if (loginRoomResult.errorCode == 0) {
//         startPreview();
//         startPublish();
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//             content: Text('loginRoom failed: ${loginRoomResult.errorCode}')));
//       }
//       return loginRoomResult;
//     });
//   }

//   Future<ZegoRoomLogoutResult> logoutRoom() async {
//     videoCallCtrl.disconnectUser();
//     stopPreview();
//     stopPublish();
//     return ZegoExpressEngine.instance.logoutRoom(widget.callID);
//   }

//   void startListenEvent() {
//     // Callback for updates on the status of other users in the room.
//     // Users can only receive callbacks when the isUserStatusNotify property of ZegoRoomConfig is set to `true` when logging in to the room (loginRoom).
//     ZegoExpressEngine.onRoomUserUpdate =
//         (roomID, updateType, List<ZegoUser> userList) {
//       debugPrint(
//           'onRoomUserUpdate: roomID: $roomID, updateType: ${updateType.name}, userList: ${userList.map((e) => e.userID)}, userList:$userList');
//       for (int i = 0; i < userList.length; i++) {
//         if (updateType.name == "Add") {
//           videoCallCtrl.getUserList(true, userList, i, context);
//         } else {
//           videoCallCtrl.getUserList(false, userList, i, context);
//         }
//       }
//     };

//     ZegoExpressEngine.onRoomOnlineUserCountUpdate = (roomID, count) {
//       videoCallCtrl.getUserCount(count);

//       debugPrint(
//           'onRoomUserUpdate: roomID: $roomID, UserCount: ${videoCallCtrl.userCount.value}');
//     };

//     ZegoExpressEngine.onRemoteMicStateUpdate = (streamID, state) {
//       debugPrint(
//           'onRemoteMicStateUpdate: streamID: $streamID, updateType: $state');
//     };

//     // Callback for updates on the status of the streams in the room.
//     ZegoExpressEngine.onRoomStreamUpdate =
//         (roomID, updateType, List<ZegoStream> streamList, extendedData) {
//       debugPrint(
//           'onRoomStreamUpdate: roomID: $roomID, updateType: $updateType, streamList: ${streamList.map((e) => e.streamID)}, extendedData: $extendedData');
//       if (updateType == ZegoUpdateType.Add) {
//         for (final stream in streamList) {
//           startPlayStream(stream.streamID);
//         }
//       } else {
//         for (final stream in streamList) {
//           stopPlayStream(stream.streamID);
//         }
//       }
//     };

//     // Callback for updates on the current user's room connection status.
//     ZegoExpressEngine.onRoomStateUpdate =
//         (roomID, state, errorCode, extendedData) {
//       debugPrint(
//           'onRoomStateUpdate: roomID: $roomID, state: ${state.name}, errorCode: $errorCode, extendedData: $extendedData');
//     };

//     // Callback for updates on the current user's stream publishing changes.
//     ZegoExpressEngine.onPublisherStateUpdate =
//         (streamID, state, errorCode, extendedData) {
//       debugPrint(
//           'onPublisherStateUpdate: streamID: $streamID, state: ${state.name}, errorCode: $errorCode, extendedData: $extendedData');
//     };

//     ZegoExpressEngine.onRoomExtraInfoUpdate = (roomID, roomExtraInfoList) {
//       videoCallCtrl.getRoomExtraInfo(roomExtraInfoList);
//       debugPrint(
//           'onRoomExtraInfoUpdate: streamID: $roomID, roomExtraInfoList:  $roomExtraInfoList');
//     };

//     ZegoExpressEngine.onRemoteCameraStateUpdate = (streamID, state) {
//       debugPrint(
//           'onPublisherStateUpdate: streamID: $streamID, state: ${state.name}');
//     };

//     ZegoExpressEngine.onRemoteMicStateUpdate = (streamID, state) {
//       debugPrint(
//           'onPublisherStateUpdate: streamID: $streamID, state: ${state.name}');
//     };
//   }

//   Future<void> startPreview() async {
//     await ZegoExpressEngine.instance.createCanvasView((viewID) {
//       localViewID = viewID;
//       ZegoCanvas previewCanvas =
//           ZegoCanvas(viewID, viewMode: ZegoViewMode.AspectFill);
//       ZegoExpressEngine.instance.startPreview(canvas: previewCanvas);
//     }).then((canvasViewWidget) {
//       setState(() => localView = canvasViewWidget);
//     });
//   }

//   Future<void> stopPreview() async {
//     ZegoExpressEngine.instance.stopPreview();
//     if (localViewID != null) {
//       await ZegoExpressEngine.instance.destroyCanvasView(localViewID!);
//       if (mounted) {
//         setState(() {
//           localViewID = null;
//           localView = null;
//         });
//       }
//     }
//   }

//   Future<void> startPublish() async {
//     // After calling the `loginRoom` method, call this method to publish streams.
//     // The StreamID must be unique in the room.

//     String streamID =
//         '"Stream_ID_${widget.callID}_${DateTime.now().millisecondsSinceEpoch}';
//     return ZegoExpressEngine.instance.startPublishingStream(streamID);
//   }

//   Future<void> stopPublish() async {
//     return ZegoExpressEngine.instance.stopPublishingStream();
//   }

//   Future<void> startPlayStream(String streamID) async {
//     // Start to play streams. Set the view for rendering the remote streams.
//     await ZegoExpressEngine.instance.createCanvasView((viewID) {
//       remoteViewID = viewID;
//       ZegoCanvas canvas = ZegoCanvas(viewID, viewMode: ZegoViewMode.AspectFill);
//       ZegoExpressEngine.instance.startPlayingStream(streamID, canvas: canvas);
//     }).then((canvasViewWidget) {
//       setState(() => remoteView = canvasViewWidget);
//     });
//   }

//   Future<void> stopPlayStream(String streamID) async {
//     ZegoExpressEngine.instance.stopPlayingStream(streamID);
//     if (remoteViewID != null) {
//       ZegoExpressEngine.instance.destroyCanvasView(remoteViewID!);
//       if (mounted) {
//         setState(() {
//           remoteViewID = null;
//           remoteView = null;
//         });
//       }
//     }
//   }
// }
