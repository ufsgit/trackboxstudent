// // import 'dart:developer';
// // import 'dart:io';
// // import 'package:anandhu_s_application4/core/app_export.dart';
// // import 'package:anandhu_s_application4/presentation/android_large_7_screen/android_large_7_screen.dart';
// // import 'package:anandhu_s_application4/presentation/home_page/home_page.dart';
// // import 'package:anandhu_s_application4/presentation/home_page_container_screen/home_page_container_screen.dart';
// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:firebase_messaging/firebase_messaging.dart';
// // import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// // import 'package:get/get.dart';
//
// // class PushNotificationHelper {
// //   static String fcmToken = "";
//
// //   static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// //       FlutterLocalNotificationsPlugin();
//
// //   static Future<void> initialized() async {
// //     await Firebase.initializeApp();
// //     if (Platform.isAndroid) {
// //       NotificationHelper.initialized();
// //     } else if (Platform.isIOS) {
// //       FirebaseMessaging.instance.requestPermission();
// //     }
//
// //     FirebaseMessaging.onBackgroundMessage(backgroundHandler);
//
// //     getDeviceTokenToSendNotifications();
//
// //     FirebaseMessaging.instance.getInitialMessage().then((message) {
// //       if (message != null) {
// //         NotificationHelper.displayNotification(message);
// //         _handleNotificationClick(message);
// //       }
// //     });
//
// //     FirebaseMessaging.onMessage.listen((message) async {
// //       if (message.notification != null) {
// //         await flutterLocalNotificationsPlugin.show(
// //           message.hashCode,
// //           message.notification?.title,
// //           message.notification?.body,
// //           NotificationDetails(
// //             android: AndroidNotificationDetails(
// //               'Breffini', // Use a unique channel ID
// //               "Breffini academy", // Channel name
// //               channelDescription: 'Channel description',
// //               icon: '@mipmap/ic_launcher',
// //               importance: Importance.max,
// //               priority: Priority.max,
// //               playSound: true,
// //             ),
// //           ),
// //           payload: message.data['type'], // Use payload here for data
// //         );
// //         log('Notification data: ${message.data}');
// //       }
// //     });
//
// //     FirebaseMessaging.onMessageOpenedApp.listen((message) {
// //       if (message.notification != null) {
// //         _handleNotificationClick(message);
// //       }
// //     });
// //   }
//
// //   static Future<void> getDeviceTokenToSendNotifications() async {
// //     fcmToken = await FirebaseMessaging.instance.getToken() ?? '';
// //     print('Device token: $fcmToken');
// //   }
//
// //   static void _handleNotificationClick(RemoteMessage message) {
// //     if (message.data['type'] == 'new_message') {
// //       // onTapTxtPassageone();
// //       Get.to(() => HomePageContainerScreen());
// //     }
// //   }
//
// //   static void onTapTxtPassageone() {
// //     Get.toNamed(
// //       AppRoutes.androidLarge5Page,
// //     );
// //   }
// // }
//
// // class NotificationHelper {
// //   static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// //       FlutterLocalNotificationsPlugin();
//
// //   static void initialized() {
// //     const AndroidInitializationSettings androidInitializationSettings =
// //         AndroidInitializationSettings('@mipmap/ic_launcher');
// //     flutterLocalNotificationsPlugin.initialize(
// //       InitializationSettings(
// //         android: androidInitializationSettings,
// //       ),
// //       onDidReceiveNotificationResponse: (details) {
// //         _handleNotificationClick(details.payload);
// //       },
// //     );
// //   }
//
// //   static void displayNotification(RemoteMessage message) async {
// //     try {
// //       final id = DateTime.now().millisecondsSinceEpoch ~/ 100;
// //       final notificationDetails = NotificationDetails(
// //         android: AndroidNotificationDetails("Breffini", "Breffini academy",
// //             actions: [
// //               AndroidNotificationAction(
// //                   id.toString(), message.notification!.title.toString(),
// //                   showsUserInterface: true, allowGeneratedReplies: true)
// //             ],
// //             importance: Importance.max,
// //             priority: Priority.high),
// //       );
//
// //       await flutterLocalNotificationsPlugin.show(
// //         id,
// //         message.notification?.title,
// //         message.notification?.body,
// //         notificationDetails,
// //         payload: message.data['type'],
// //       );
// //       log('Firebase notification data: ${message.data}');
// //     } catch (e) {
// //       print(e);
// //     }
// //   }
//
// //   static void _handleNotificationClick(String? payload) {
// //     if (payload != null && payload == 'new_message') {
// //       // onTapTxtPassageone();
// //       int targetIndex = 2;
// //       Get.to(() => HomePageContainerScreen());
// //     }
// //   }
//
// //   static void onTapTxtPassageone() {
// //     Get.toNamed(
// //       AppRoutes.androidLarge5Page,
// //     );
// //   }
// // }
//
// // Future<void> backgroundHandler(RemoteMessage message) async {
// //   print('Background message data: ${message.data}');
// //   print('Background message title: ${message.notification?.title}');
// // }
//
// // import 'dart:developer';
// // import 'dart:io';
// // import 'dart:ui';
// // import 'package:anandhu_s_application4/core/app_export.dart';
// // import 'package:anandhu_s_application4/presentation/home_page/home_page.dart';
// // import 'package:anandhu_s_application4/presentation/home_page_container_screen/home_page_container_screen.dart';
// // import 'package:awesome_notifications/awesome_notifications.dart';
// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:firebase_messaging/firebase_messaging.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
//
// // class PushNotificationHelper {
// //   static String fcmToken = "";
//
// //   static Future<void> initialized() async {
// //     await Firebase.initializeApp();
// //     AwesomeNotifications().initialize(
// //       'resource://drawable/res_app_icon',
// //       [
// //         NotificationChannel(
// //           channelKey: 'default_channel',
// //           channelName: 'Default notifications',
// //           channelDescription: 'Notification channel for basic notifications',
// //           defaultColor: Color(0xFF9D50DD),
// //           ledColor: Colors.white,
// //         )
// //       ],
// //     );
//
// //     if (Platform.isIOS) {
// //       FirebaseMessaging.instance.requestPermission();
// //     }
//
// //     FirebaseMessaging.onBackgroundMessage(backgroundHandler);
//
// //     getDeviceTokenToSendNotifications();
//
// //     FirebaseMessaging.instance.getInitialMessage().then((message) {
// //       if (message != null) {
// //         _handleNotificationClick(message);
// //       }
// //     });
//
// //     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
// //       final Map<String, String?> payload =
// //           message.data.map((key, value) => MapEntry(key, value.toString()));
//
// //       AwesomeNotifications().createNotification(
// //         content: NotificationContent(
// //           id: message.hashCode,
// //           channelKey: 'default_channel',
// //           title: message.notification?.title,
// //           body: message.notification?.body,
// //           payload: payload,
// //         ),
// //       );
//
// //       log('Notification data: ${message.data}');
// //     });
//
// //     FirebaseMessaging.onMessageOpenedApp.listen((message) {
// //       _handleNotificationClick(message);
// //     });
// //   }
//
// //   static Future<void> getDeviceTokenToSendNotifications() async {
// //     fcmToken = await FirebaseMessaging.instance.getToken() ?? '';
// //     print('Device token: $fcmToken');
// //   }
//
// //   static void _handleNotificationClick(RemoteMessage message) {
// //     log('Handling notification click with payload: ${message.data}');
// //     if (message.data['type'] == 'new_message') {
// //       Get.to(() => HomePageContainerScreen());
// //     } else if (message.data['type'] == 'new_call') {
// //       Get.to(() => HomePageContainerScreen());
// //     }
// //   }
// // }
//
// // class NotificationHelper {
// //   static void displayNotification(RemoteMessage message) async {
// //     try {
// //       AwesomeNotifications().createNotification(
// //         content: NotificationContent(
// //           id: DateTime.now().millisecondsSinceEpoch ~/ 100,
// //           channelKey: 'default_channel',
// //           title: message.notification?.title,
// //           body: message.notification?.body,
// //           payload: message.data['type'],
// //         ),
// //       );
// //       log('Firebase notification data: ${message.data}');
// //     } catch (e) {
// //       print(e);
// //     }
// //   }
// // }
//
// // Future<void> backgroundHandler(RemoteMessage message) async {
// //   print('Background message data: ${message.data}');
// //   print('Background message title: ${message.notification?.title}');
// // }
//
// import 'dart:developer';
// import 'dart:io';
// import 'package:anandhu_s_application4/core/app_export.dart';
// import 'package:anandhu_s_application4/core/utils/extentions.dart';
// import 'package:anandhu_s_application4/presentation/home_page_container_screen/home_page_container_screen.dart';
// import 'package:anandhu_s_application4/presentation/my_courses_page/controller/live_class_controller.dart';
// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:dio/dio.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';
// import 'package:path_provider/path_provider.dart';
//
// import '../core/utils/notification_controller.dart';
// import 'http_urls.dart';
//
// // class PushNotificationHelper {
// //   static String fcmToken = "";
//
// //   static Future<void> initialized() async {
// //     await Firebase.initializeApp();
// //     AwesomeNotifications().initialize(
// //       'resource://drawable/res_app_icon',
// //       [
// //         NotificationChannel(
// //           channelKey: 'call_channel',
// //           channelName: 'Call notifications',
// //           channelDescription: 'Notification channel for incoming calls',
// //           defaultColor: Color(0xFF9D50DD),
// //           ledColor: Colors.white,
// //           importance: NotificationImportance.High,
// //           playSound: true,
// //           soundSource: 'asset://assets/sounds/call_ringtone.mp3',
// //         ),
// //         NotificationChannel(
// //           channelKey: 'message_channel',
// //           channelName: 'Message notifications',
// //           channelDescription: 'Notification channel for new messages',
// //           defaultColor: Color(0xFF9D50DD),
// //           ledColor: Colors.white,
// //           importance: NotificationImportance.Default,
// //           playSound: true,
// //           soundSource: 'asset://assets/sounds/message_notification.mp3',
// //         ),
// //       ],
// //     );
//
// //     if (Platform.isIOS) {
// //       FirebaseMessaging.instance.requestPermission();
// //     }
//
// //     FirebaseMessaging.onBackgroundMessage(backgroundHandler);
//
// //     getDeviceTokenToSendNotifications();
//
// //     FirebaseMessaging.instance.getInitialMessage().then((message) {
// //       if (message != null) {
// //         _handleNotificationClick(message);
// //       }
// //     });
//
// //     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
// //       final Map<String, String?> payload =
// //           message.data.map((key, value) => MapEntry(key, value.toString()));
//
// //       AwesomeNotifications().createNotification(
// //         content: NotificationContent(
// //           id: message.hashCode,
// //           channelKey: 'default_channel',
// //           title: message.notification?.title,
// //           body: message.notification?.body,
// //           payload: payload,
// //         ),
// //       );
//
// //       log('Notification data: ${message.data}');
// //     });
//
// //     FirebaseMessaging.onMessageOpenedApp.listen((message) {
// //       _handleNotificationClick(message);
// //     });
// //   }
//
// //   static Future<void> getDeviceTokenToSendNotifications() async {
// //     fcmToken = await FirebaseMessaging.instance.getToken() ?? '';
// //     print('Device token: $fcmToken');
// //   }
//
// //   static void _handleNotificationClick(RemoteMessage message) {
// //     if (message.data['type'] == 'new_message') {
// //       Get.to(() => HomePageContainerScreen());
// //     } else if (message.data['type'] == 'new_call') {
// //       Get.to(() => HomePageContainerScreen());
// //     }
// //   }
// // }
//
// // class NotificationHelper {
// //   static void displayNotification(RemoteMessage message) async {
// //     try {
// //       final notificationType = message.data['type'];
// //       final channelKey =
// //           notificationType == 'new_call' ? 'call_channel' : 'message_channel';
//
// //       AwesomeNotifications().createNotification(
// //         content: NotificationContent(
// //           id: DateTime.now().millisecondsSinceEpoch ~/ 100,
// //           channelKey: channelKey,
// //           title: message.notification?.title,
// //           body: message.notification?.body,
// //           payload: message.data['type'],
// //         ),
// //       );
// //       log('Firebase notification data: ${message.data}');
// //     } catch (e) {
// //       print(e);
// //     }
// //   }
// // }
//
// // Future<void> backgroundHandler(RemoteMessage message) async {
// //   // Since the app is in the background, you might need to handle the notification payload
// //   // or use additional logic to navigate if needed, when the app is resumed.
// //   print('Background message data: ${message.data}');
// //   print('Background message title: ${message.notification?.title}');
// // }
//
// class PushNotificationHelper {
//   static String fcmToken = "";
//
//   static Future<void> initialize() async {
//     await AwesomeNotifications().initialize(
//       'resource://drawable/res_app_icon',
//       [
//         NotificationChannel(
//           channelKey: 'message_channel',
//           channelName: 'Message notifications',
//           channelDescription: 'Notification channel for new messages',
//           defaultColor: Color(0xFF9D50DD),
//           ledColor: Colors.white,
//           importance: NotificationImportance.Max,enableVibration: true,//to show floating notification
//           enableLights: true,
//
//         ),
//         NotificationChannel(
//           channelKey: 'call_channel',
//           channelName: 'Call notifications',
//           channelDescription: 'Notification channel for new calls',
//           defaultColor: Color(0xFF9D50DD),
//           ledColor: Colors.white,
//           soundSource: 'resource://raw/call_sound',
//           importance: NotificationImportance.Max,enableVibration: true,
//           enableLights: true,
//
//         ),
//       ],
//     );
//     AwesomeNotifications().setListeners(
//       onActionReceivedMethod: (ReceivedAction receivedAction){
//         return NotificationController.onActionReceivedMethod( receivedAction);
//       },
//
//     );
//     // AwesomeNotifications().setListeners(
//     //
//     //   onActionReceivedMethod: (ReceivedAction receivedAction) {
//     //
//     //     if (receivedAction.buttonKeyPressed == 'READ') {
//     //       print('Read button clicked!');
//     //     } else if (receivedAction.buttonKeyPressed == 'DELETE') {
//     //       print('Delete button clicked!');
//     //     }
//     //     NotificationController.onActionReceivedMethod( receivedAction);
//     //
//     //
//     //   });
//
//     if (Platform.isIOS) {
//       await FirebaseMessaging.instance.requestPermission();
//     }
//
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//
//     await getDeviceTokenToSendNotifications();
//
//     FirebaseMessaging.instance
//         .getInitialMessage()
//         .then(_handleNotificationClick);
//
//     FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
//     FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationClick);
//   }
//
//   static Future<void> getDeviceTokenToSendNotifications() async {
//     fcmToken = await FirebaseMessaging.instance.getToken() ?? '';
//     print('Device token: $fcmToken');
//   }
//
//   static Future<void> _firebaseMessagingBackgroundHandler(
//       RemoteMessage message) async {
//     print('Handling a background message: ${message.messageId}');
//     // Add your background message handling logic here
//   }
//
//   static Future<void> _handleForegroundMessage(RemoteMessage message) async {
//     final Map<String, String?> payload =
//         message.data.map((key, value) => MapEntry(key, value.toString()));
//
//     String channelKey = 'message_channel'; // Default channel
//
//     if (message.data['type'] == 'new_call') {
//       channelKey = 'call_channel';
//     }
// //
//     if(Get.put(LiveClassController()).currentCallId!=message.data['Live_Link']) {
//
//       String profileImgUrl=message.data.containsKey("Profile_Photo_Img")?message.data['Profile_Photo_Img']:"";
//       String callerName=message.data.containsKey("Caller_Name")?message.data['Caller_Name']:"";
//       int id=message.data.containsKey("id")?int.parse(message.data['id']):message.hashCode;
//
//
//       AwesomeNotifications().createNotification(
//         actionButtons: channelKey=="call_channel"?[
//           NotificationActionButton(key: 'reject_btn', label: 'Reject',color: Colors.red),
//           NotificationActionButton(key: 'accept_btn', label: 'Accept',color: Colors.green),
//         ]:[],
//         content: NotificationContent(
//
//           id: id,
//           channelKey: channelKey,
//           title: message.notification?.title,
//           body: message.notification?.body,
//           payload: payload,
//           largeIcon: HttpUrls.imgBaseUrl+profileImgUrl,
//         ),
//       );
//     }
//
//     log('Notification data: ${message.data}');
//   }
//
//   static void _handleNotificationClick(RemoteMessage? message) {
//     if (message == null) return;
//
//     log('Handling notification click with payload: ${message.data}');
//     if (message.data['type'] == 'new_message') {
//       Get.to(() => HomePageContainerScreen());
//     } else if (message.data['type'] == 'new_call') {
//       Get.to(() => HomePageContainerScreen());
//     }
//   }
// }
