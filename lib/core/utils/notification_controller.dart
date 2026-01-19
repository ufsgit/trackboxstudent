// // import 'package:anandhu_s_application4/core/app_export.dart';
// // import 'package:anandhu_s_application4/presentation/android_large_5_page/android_large_5_page.dart';
// // import 'package:awesome_notifications/awesome_notifications.dart';
//
// // import '../../presentation/home_page_container_screen/controller/home_page_container_controller.dart';
//
// // class NotificationController {
// //   /// Use this method to detect when a new notification or a schedule is created
// //   @pragma("vm:entry-point")
// //   static Future<void> onNotificationCreatedMethod(
// //       ReceivedNotification receivedNotification) async {
// //     // Your code goes here
// //   }
//
// //   /// Use this method to detect every time that a new notification is displayed
// //   @pragma("vm:entry-point")
// //   static Future<void> onNotificationDisplayedMethod(
// //       ReceivedNotification receivedNotification) async {
// //     // Your code goes here
// //   }
//
// //   /// Use this method to detect if the user dismissed a notification
// //   @pragma("vm:entry-point")
// //   static Future<void> onDismissActionReceivedMethod(
// //       ReceivedAction receivedAction) async {
// //     // Your code goes here
// //   }
//
// //   /// Use this method to detect when the user taps on a notification or action button
// //   @pragma("vm:entry-point")
// //   static Future<void> onActionReceivedMethod(
// //       ReceivedAction receivedAction) async {
// //     String? payloadType = receivedAction.payload?['type'];
// //     switch (payloadType) {
// //       case 'new_call':
// //         if (Get.currentRoute != "/Widget") {
// //           //danger may be chance for app close
// //           Get.back();
// //         }
// //         var ss = Get.currentRoute;
//
// //         final HomePageContainerController controller =
// //             Get.find<HomePageContainerController>();
// //         controller.setTemporaryPage(AppRoutes.androidLarge5Page,
// //             mentorIndex: 1);
//
// //         // print('notification initiated');
// //         // // navigatorKey.currentState?.pushNamed(AppRoutes.homeContainer,
// //         // //     arguments: {'showSpecialPage': true, 'selectedTabIndex': 1});
// //         // Get.to(
// //         //     () => AndroidLarge5Page(
// //         //           initialTabIndex: 1,
// //         //           isNotificationClick: true,
// //         //         ),
// //         //     arguments: {'showSpecialPage': true, 'selectedTabIndex': 1});
// //         print('notification clicked');
// //         break;
// //       case 'new_message':
// //         print('notification initiated');
// //         // navigatorKey.currentState
// //         //     ?.pushNamed(AppRoutes.homeContainer, arguments: {
// //         //   'showSpecialPage': true,
// //         // });
// //         // Get.toNamed(AppRoutes.homeContainer,
// //         //     arguments: {'showSpecialPage': true});
// //         final HomePageContainerController controller =
// //             Get.find<HomePageContainerController>();
// //         controller.setTemporaryPage(AppRoutes.androidLarge5Page,
// //             mentorIndex: 0);
// //         // Get.to(
// //         //     () => AndroidLarge5Page(
// //         //           initialTabIndex: 0,
// //         //           isNotificationClick: true,
// //         //         ),
// //         //     arguments: {'showSpecialPage': true});
// //         // print('notification clicked');
// //         break;
// //       default:
// //         Get.toNamed(AppRoutes.homePage);
// //         break;
// //     }
// //   }
// // }
//
// import 'package:anandhu_s_application4/core/app_export.dart';
// import 'package:anandhu_s_application4/core/utils/extentions.dart';
// import 'package:anandhu_s_application4/presentation/android_large_5_page/android_large_5_page.dart';
// import 'package:anandhu_s_application4/presentation/android_large_5_page/controller/call_chat_controller.dart';
// import 'package:anandhu_s_application4/presentation/android_large_5_page/incoming_call_page.dart';
// import 'package:anandhu_s_application4/presentation/home_page/controller/home_controller.dart';
// import 'package:anandhu_s_application4/presentation/home_page/models/home_model.dart';
// import 'package:awesome_notifications/awesome_notifications.dart';
//
// import '../../presentation/home_page_container_screen/controller/home_page_container_controller.dart';
//
// class NotificationController {
//   /// Use this method to detect when a new notification or a schedule is created
//   @pragma("vm:entry-point")
//   static Future<void> onNotificationCreatedMethod(
//       ReceivedNotification receivedNotification) async {
//     // Your code goes here
//   }
//   static Future<void> clearAllNotifications() async {
//     await AwesomeNotifications().cancelAll();
//   }
//
//   /// Use this method to detect every time that a new notification is displayed
//   @pragma("vm:entry-point")
//   static Future<void> onNotificationDisplayedMethod(
//       ReceivedNotification receivedNotification) async {
//     // Your code goes here
//   }
//
//   /// Use this method to detect if the user dismissed a notification
//   @pragma("vm:entry-point")
//   static Future<void> onDismissActionReceivedMethod(
//       ReceivedAction receivedAction) async {
//     // Your code goes here
//   }
//
//   @pragma("vm:entry-point")
//   static Future<void> onActionReceivedMethod(
//       ReceivedAction receivedAction) async {
//     String? payloadType = receivedAction.payload?['type'];
//     switch (payloadType) {
//       case 'new_call':
//         if (Get.currentRoute != "/Widget") {
//           //danger may be chance for app close
//           Get.back();
//         }
//         if (receivedAction.buttonKeyPressed == 'reject_btn') {
//           String liveLink=receivedAction.payload!['Live_Link']??'';
//           if(!liveLink.isNullOrEmpty()) {
//             String callId=receivedAction.payload!['id']??'';
//             // String callType=receivedAction.payload!['call_type']??'';
//             int callerId=int.parse(receivedAction.payload!['sender_id']??"0");
//
//             Get.put(CallandChatController()).stopCall(callerId.toString(), callId,isRejectCall: true);
//
//           }
//         } else if (receivedAction.buttonKeyPressed == 'accept_btn') {
//
//           String liveLink=receivedAction.payload!['Live_Link']??'';
//           if(!liveLink.isNullOrEmpty()) {
//             String callId=receivedAction.payload!['id']??'';
//             String callType=receivedAction.payload!['call_type']??'';
//             int callerId=int.parse(receivedAction.payload!['sender_id']??"0");
//             String profileImgUrl=receivedAction.payload!.containsKey("Profile_Photo_Img")?receivedAction.payload!['Profile_Photo_Img']??"":"";
//             String callerName=receivedAction.payload!.containsKey("Caller_Name")?receivedAction.payload!['Caller_Name']??"":"";
//
//             Get.to(() =>
//                 IncomingCallPage(
//                   liveLink: liveLink,
//                   callId: callId,
//                   video: callType == 'Video',
//                   teacherId: callerId,
//                   // isIncomingCall: true,
//                   profileImageUrl: profileImgUrl,
//                   teacherName: callerName,
//                 ));
//           }
//         }else {
//           var ss = Get.currentRoute;
//           final HomePageContainerController controller =
//           Get.find<HomePageContainerController>();
//           controller.setTemporaryPage(AppRoutes.androidLarge5Page,
//               mentorIndex: 1);
//           print('notification clicked');
//         }
//         break;
//       case 'new_message':
//         print('notification initiated');
//         final HomePageContainerController controller =
//             Get.find<HomePageContainerController>();
//         controller.setTemporaryPage(AppRoutes.androidLarge5Page,
//             mentorIndex: 0);
//         break;
//       case 'new_live':
//         print('new live notification received');
//         final HomePageContainerController controller =
//             Get.find<HomePageContainerController>();
//         controller.setTemporaryPage(AppRoutes.myCoursesPage);
//         break;
//       default:
//         Get.toNamed(AppRoutes.homePage);
//         break;
//     }
//   }
// }
