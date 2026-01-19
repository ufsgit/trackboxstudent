// import 'dart:async';
// import 'dart:developer';
// import 'package:anandhu_s_application4/presentation/home_page/controller/check_permission.dart';
// import 'package:anandhu_s_application4/presentation/home_page/controller/home_controller.dart';
// import 'package:anandhu_s_application4/presentation/home_page/models/home_model.dart';
// import 'package:anandhu_s_application4/presentation/home_page/models/save_student_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:uuid/uuid.dart';
// import 'package:zego_express_engine/zego_express_engine.dart';
//
// class CustomLivePage extends StatefulWidget {
//   final String? roomId;
//   final String? teacherId;
//   final String? teacherName;
//   final String? studentName;
//   final String? profileURL;
//   final bool outgoingCall;
//   const CustomLivePage(
//       {super.key,
//       this.teacherName,
//       this.studentName,
//       this.roomId,
//       this.profileURL,
//       this.teacherId,
//       this.outgoingCall = false});
//
//   @override
//   State<CustomLivePage> createState() => _CustomLivePageState();
// }
//
// class _CustomLivePageState extends State<CustomLivePage> {
//   HomeController controller = Get.put(HomeController(HomeModel().obs));
//
//   String? studentId;
//
//   Widget? localView;
//   Widget? remoteView;
//   Timer? timer;
//   int callDuartionStartingTime = 0;
//
//   int? localViewID;
//   int? remoteViewID;
//
//   String _roomId = '';
//   bool isCameraOn = false;
//   bool isAudioON = false;
//
//   int onlineUserCount = 0;
// //Create room Id
//   String getRoomId() {
//     if (widget.roomId == null) {
//       ///creating a meeting
//       final id = Uuid().v4();
//       print(id);
//       return id;
//     } else {
//       ///Joining a meeting
//       return widget.roomId!;
//     }
//   }
//
//   getStudentId() async {
//     final prefs = await SharedPreferences.getInstance();
//     studentId = prefs.getString('breffini_student_id') ?? "0";
//     print('Student ID $studentId');
//   }
//
//   void startListenEvent(String teacherId) {
//     // Callback for updates on the status of other users in the room.
//     // Users can only receive callbacks when the isUserStatusNotify property of ZegoRoomConfig is set to `true` when logging in to the room (loginRoom).
//     ZegoExpressEngine.onRoomUserUpdate =
//         (roomID, updateType, List<ZegoUser> userList) {
//       print('rfger $updateType');
//       if (updateType == ZegoUpdateType.Delete) {
//         logoutRoom(teacherId).then((value) {
//           Navigator.pop(context);
//         });
//       }
//       debugPrint(
//           'onRoomUserUpdate: roomID: $roomID, updateType: ${updateType.name}, userList: ${userList.map((e) => e.userID)}');
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
//   }
//
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
//
//   Future<void> stopPlayStream(String streamID) async {
//     ZegoExpressEngine.instance.stopPlayingStream(streamID);
//     if (remoteViewID != null) {
//       ZegoExpressEngine.instance.destroyCanvasView(remoteViewID!);
//       setState(() {
//         remoteViewID = null;
//         remoteView = null;
//       });
//     }
//   }
//
//   ///log in and log out
//   Future<ZegoRoomLoginResult> loginRoom(String userID, String userNm) async {
//     // The value of `userID` is generated locally and must be globally unique.
//     await getStudentId();
//     // ZegoExpressEngine.onRemoteCameraStateUpdate = (userID, state) {
//     //   if (state == ZegoRemoteDeviceState.Disable) {
//     //     print('User $userID has turned on their camera');
//     //   } else if (state != ZegoRemoteDeviceState.Mute) {
//     //     print('User $userID has turned off their camera');
//     //   }
//     // };
//     _roomId = getRoomId();
//     if (widget.outgoingCall) {
//       // API CALL
//       controller.saveStudentCall(
//         SaveStudentCallModel(
//           id: 0,
//           teacherId: int.parse(widget.teacherId!),
//           studentId: int.parse(studentId!),
//           callStart: DateTime.now(),
//           callEnd: '',
//           callDuration: null,
//           // callType: widget.isIndividualVideoCall ? 'Video' : 'Audio',
//           callType: 'Audio',
//           isStudentCalled: 1,
//           liveLink: _roomId,
//         ),
//       );
//     }
//
//     final user = ZegoUser(studentId!, userNm);
//     ZegoExpressEngine.instance.setAudioRouteToSpeaker(true);
//     ZegoExpressEngine.instance.muteMicrophone(false);
//
//     print('<<<<<<<<<<<_room ID 2 $_roomId>>>>>>>>>>>');
//
//     // The value of `roomID` is generated locally and must be globally unique.
//
//     // onRoomUserUpdate callback can be received when "isUserStatusNotify" parameter value is "true".
//     ZegoRoomConfig roomConfig = ZegoRoomConfig.defaultConfig()
//       ..isUserStatusNotify = true;
//     ZegoExpressEngine.onRoomOnlineUserCountUpdate = (String roomID, int count) {
//       // Update your state with the new count
//       setState(() {
//         onlineUserCount = count;
//       });
//       // if (count == 2) {
//       //   startTimer();
//       // }
//       log('message$count');
//     };
//     // log in to a room
//     // Users must log in to the same room to call each other.
//     ZegoExpressEngine.onDebugError =
//         (int errorCode, String funcName, String info) {
//       print('on Debug Error in $funcName: $info');
//       // Handle errors here, such as by showing an alert to the user
//     };
//     ZegoExpressEngine.onFatalError = (int errorCode) {
//       print('on fatal Error in : $errorCode');
//       // Handle errors here, such as by showing an alert to the user
//     };
//     ZegoExpressEngine.onNetworkSpeedTestError = (int errorCode, t) {
//       print('on netw Error in : $errorCode , type $t');
//       // Handle errors here, such as by showing an alert to the user
//     };
//     return ZegoExpressEngine.instance
//         .loginRoom(_roomId, user, config: roomConfig)
//         .then((ZegoRoomLoginResult loginRoomResult) {
//       debugPrint(
//           'loginRoom: errorCode:${loginRoomResult.errorCode}, extendedData:${loginRoomResult.extendedData}');
//       if (loginRoomResult.errorCode == 0) {
//         // startPreview();
//         startPublish();
//       } else {
//         log('loginRoom failed: ${loginRoomResult.errorCode}');
//       }
//       return loginRoomResult;
//     });
//   }
//
//   Future<ZegoRoomLogoutResult> logoutRoom(String teacherId) async {
//     await controller.stopLive(teacherId);
//     stopPreview();
//     stopPublish();
//     return ZegoExpressEngine.instance.logoutRoom(_roomId);
//   }
//
//   ///Start and stop preview
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
//
//   Future<void> stopPreview() async {
//     ZegoExpressEngine.instance.stopPreview();
//     if (localViewID != null) {
//       await ZegoExpressEngine.instance.destroyCanvasView(localViewID!);
//       setState(() {
//         localViewID = null;
//         localView = null;
//       });
//     }
//   }
//
//   ///Start publish and stop publish
//   Future<void> startPublish() async {
//     // After calling the `loginRoom` method, call this method to publish streams.
//     // The StreamID must be unique in the room.
//     String streamID = "Call_Id_${studentId}";
//     return ZegoExpressEngine.instance.startPublishingStream(streamID);
//   }
//
//   Future<void> stopPublish() async {
//     return ZegoExpressEngine.instance.stopPublishingStream();
//   }
//
//   void stopListenEvent() {
//     ZegoExpressEngine.onRoomUserUpdate = null;
//     ZegoExpressEngine.onRoomStreamUpdate = null;
//     ZegoExpressEngine.onRoomStateUpdate = null;
//     ZegoExpressEngine.onPublisherStateUpdate = null;
//   }
//
//   @override
//   void initState() {
//     startTimer();
//     checkPermission();
//     startListenEvent(widget.teacherId.toString());
//     loginRoom(studentId ?? '', widget.teacherName!);
//     super.initState();
//   }
//
//   void startTimer() {
//     // if (onlineUserCount == 2) {
//     timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
//       setState(() => callDuartionStartingTime++);
//     });
//     // }
//   }
//
//   String formatDuration(int seconds) {
//     final int minutes = seconds ~/ 60;
//     final int remainingSeconds = seconds % 60;
//     return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     stopListenEvent();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       // appBar: AppBar(title: const Text("Call Page")),
//
//       body: Stack(
//         children: [
//           localView ?? Container(),
//           Align(
//             child: Container(
//                 width: 100,
//                 height: 40,
//                 child: remoteView ?? Container(color: Colors.transparent)),
//           ),
//           Align(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   width: 163,
//                   height: 163,
//                   decoration: BoxDecoration(
//                       boxShadow: [
//                         BoxShadow(color: Colors.black26, blurRadius: 10),
//                       ],
//                       border: Border.all(color: Colors.white, width: 3),
//                       image: DecorationImage(
//                         fit: BoxFit.contain,
//                         image: widget.profileURL != null
//                             ? NetworkImage(widget.profileURL!)
//                             : const AssetImage("assets/images/Ellipse 32.png"),
//                       ),
//                       shape: BoxShape.circle,
//                       color: Colors.white),
//                 ),
//                 SizedBox(height: 20),
//                 Text(
//                   widget.studentName ?? '',
//                   style: GoogleFonts.plusJakartaSans(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 // if (onlineUserCount != 2)
//                 //   Text('calling')
//                 // else
//                 Text(formatDuration(callDuartionStartingTime))
//               ],
//             ),
//           ),
//           Positioned(
//             bottom: MediaQuery.of(context).size.height / 20,
//             left: 0,
//             right: 0,
//             child: Container(
//               margin: EdgeInsets.all(10),
//               padding: EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 boxShadow: [
//                   BoxShadow(
//                     blurRadius: 10,
//                     color: Colors.black26,
//                   ),
//                 ],
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               width: MediaQuery.of(context).size.width / 3,
//               // height: MediaQuery.of(context).size.width / 3,
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       // InkWell(
//                       //   onTap: () async {
//                       //     if (isCameraOn) {
//                       //       await ZegoExpressEngine.instance
//                       //           .enableCamera(false)
//                       //           .then((v) {
//                       //         stopPreview();
//                       //         setState(() => isCameraOn = false);
//                       //       });
//                       //     } else {
//                       //       await ZegoExpressEngine.instance
//                       //           .enableCamera(true)
//                       //           .then((v) {
//                       //         startPreview();
//                       //         setState(() => isCameraOn = true);
//                       //       });
//                       //     }
//                       //   },
//                       //   child: CircleAvatar(
//                       //     child: Icon(Icons.camera),
//                       //   ),
//                       // ),
//                       GestureDetector(
//                         onTap: () {
//                           if (isAudioON) {
//                             ZegoExpressEngine.instance
//                                 .mutePublishStreamVideo(true);
//                             // ZegoExpressEngine.instance
//                             //     .mutePublishStreamAudio(true);
//
//                             setState(() => isAudioON = false);
//                           } else {
//                             ZegoExpressEngine.instance
//                                 .mutePublishStreamVideo(false);
//                             // ZegoExpressEngine.instance
//                             //     .mutePublishStreamAudio(false);
//
//                             setState(() => isAudioON = true);
//                           }
//                         },
//                         child: Container(
//                           padding: const EdgeInsets.all(15),
//                           height: 56,
//                           width: 56,
//                           decoration: BoxDecoration(
//                               // borderRadius: BorderRadius.circular(24),
//                               shape: BoxShape.circle,
//                               border: Border.all(color: Colors.black26),
//                               color: isAudioON
//                                   ? Colors.white
//                                   : Colors.grey.shade800),
//                           child: SvgPicture.asset(
//                               "assets/images/MicrophoneSlash.svg",
//                               color: isAudioON ? Colors.blue : Colors.white),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         fixedSize: Size(MediaQuery.sizeOf(context).width, 50),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                         backgroundColor: Colors.red),
//                     onPressed: () {
//                       logoutRoom(widget.teacherId!).then((value) {
//                         Navigator.pop(context);
//                       });
//                     },
//                     child: SvgPicture.asset('assets/images/phone_hang_up.svg'),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
