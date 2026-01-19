// import 'package:anandhu_s_application4/core/app_export.dart';
// import 'package:anandhu_s_application4/core/utils/extentions.dart';
// import 'package:anandhu_s_application4/core/utils/key_center.dart';
// import 'package:anandhu_s_application4/presentation/home_page/controller/home_controller.dart';
// import 'package:anandhu_s_application4/presentation/home_page/models/home_model.dart';
// import 'package:anandhu_s_application4/presentation/home_page/models/save_student_model.dart';
// import 'package:anandhu_s_application4/presentation/profile/controller/profile_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:uuid/uuid.dart';
// // import 'package:zego_uikit_beauty_plugin/zego_uikit_beauty_plugin.dart';
// import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
//
// class VideoIndividualScreen extends StatefulWidget {
//   final int teacherId;
//   const VideoIndividualScreen({super.key, required this.teacherId});
//
//   @override
//   State<VideoIndividualScreen> createState() => _VideoIndividualScreenState();
// }
//
// class _VideoIndividualScreenState extends State<VideoIndividualScreen> {
//   var uuid = Uuid();
//   String uniqId = '';
//   final ProfileController profileController = Get.find<ProfileController>();
//   HomeController controller = Get.put(HomeController(HomeModel().obs));
//   String studentCallId="";
//
//
//   @override
//   void initState() {
//     uniqId = uuid.v1();
//     controller.saveStudentCall(SaveStudentCallModel(
//         id: 0,
//         teacherId: widget.teacherId,
//         studentId: 0,
//         callStart: DateTime.now(),
//         callEnd: '',
//         callDuration: null,
//         callType: 'Video',
//         isStudentCalled: 1,
//         liveLink: uniqId)).then((value){
//           if(!value.isNullOrEmpty()){
//             studentCallId=value;
//             setState(() {
//
//             });
//           }
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text('$uniqId'),
//       //   centerTitle: true,
//       // ),
//
//       body: SafeArea(
//         child: ZegoUIKitPrebuiltCall(
//             onDispose: () {
//               controller.stopCall(widget.teacherId.toString(),studentCallId);
//             },
//             appID: appID,
//             appSign: appSign,
//             userID: profileController.profileData!.studentId.toString(),
//             userName: profileController.profileData!.firstName,
//             callID: uniqId,
//             // plugins: [ZegoUIKitBeautyPlugin()],
//             config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
//               // ignore: deprecated_member_use
//               ..bottomMenuBarConfig = ZegoBottomMenuBarConfig(
//                 padding: EdgeInsets.symmetric(horizontal: 16),
//                 hideAutomatically: false,
//                 hideByClick: false,
//                 height: 64,
//                 margin: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
//                 backgroundColor: Colors.grey.withOpacity(.5),
//               )),
//       ),
//     );
//   }
// }
