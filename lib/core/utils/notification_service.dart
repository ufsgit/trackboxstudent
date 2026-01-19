// import 'dart:async';
// import 'dart:developer';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// //-- Intialize Push Notification & Local Notification Services
// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print("Handling a background message: ${message.messageId}");
//   await NotificationService().initializePushNotification(message);
//   await NotificationService().initializeLocalNotifications();
// }

// class NotificationService {
//   final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   //--Background Notification Services

//   Future<void> initializePushNotification(RemoteMessage message) async {
//     handleMessage(message);

//     FirebaseMessaging.onMessageOpenedApp.listen(handleMessage(message));
//   }

//   static Future<void> onBackgroundMsg() async {
//     FirebaseMessaging.onBackgroundMessage(backgroundHandler);
//   }

//   static Future<void> backgroundHandler(RemoteMessage message) async {
//     log(message.toString());
//   }

//   handleMessage(RemoteMessage message) {
//     log("Handle the Background message functionalities here");
//     // if (message.data['type'] == 'chat') {
//     //   print("This is a Chat Notification");
//     // }
//   }

//   //--Local Notifications Services

//   onSelectNotification(NotificationResponse notificationResponse) async {
//     // var payloadData = jsonDecode(notificationResponse.payload ?? "");
//     // print("payload $payloadData");
//   }

//   Future<void> initializeLocalNotifications() async {
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//       const AndroidNotificationChannel channel = AndroidNotificationChannel(
//         'high_importance_channel',
//         'High Importance Notifications',
//         description: 'This channel is used for important notifications.',
//         importance: Importance.max,
//       );

//       const AndroidInitializationSettings initializationSettingsAndroid =
//           AndroidInitializationSettings('@mipmap/ic_launcher');

//       final InitializationSettings initializationSettings =
//           InitializationSettings(
//         android: initializationSettingsAndroid,
//       );

//       await flutterLocalNotificationsPlugin.initialize(
//         initializationSettings,
//         onDidReceiveNotificationResponse: onSelectNotification,
//         onDidReceiveBackgroundNotificationResponse: onSelectNotification,
//       );

//       print('Got a message whilst in the foreground!');
//       if (message.notification != null) {
//         print('Notification Title: ${message.notification?.title}');
//         print('Notification Body: ${message.notification?.body}');
//         await flutterLocalNotificationsPlugin.show(
//           message.hashCode,
//           message.notification?.title,
//           message.notification?.body,
//           NotificationDetails(
//             android: AndroidNotificationDetails(
//               channel.id,
//               channel.name,
//               channelDescription: channel.description,
//               icon: "@mipmap/ic_launcher",
//               importance: Importance.max,
//               priority: Priority.max,
//               playSound: true,
//             ),
//           ),
//         );
//       }
//     });
//   }
// }

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:anandhu_s_application4/core/utils/extentions.dart';
import 'package:anandhu_s_application4/core/utils/firebase_utils.dart';
import 'package:anandhu_s_application4/core/utils/notification_controller.dart';
import 'package:anandhu_s_application4/firebase_options.dart';
import 'package:anandhu_s_application4/http/http_urls.dart';
import 'package:anandhu_s_application4/http/socket_io.dart';
import 'package:anandhu_s_application4/presentation/android_large_5_page/controller/call_chat_controller.dart';
import 'package:anandhu_s_application4/presentation/android_large_5_page/models/ongoing_call_model.dart';
import 'package:anandhu_s_application4/presentation/chat_screen/controller/chat_firebase_controller.dart';
import 'package:anandhu_s_application4/presentation/my_courses_page/controller/live_class_controller.dart';
import 'package:anandhu_s_application4/routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_callkit_incoming_yoer/entities/android_params.dart';
import 'package:flutter_callkit_incoming_yoer/entities/call_event.dart';
import 'package:flutter_callkit_incoming_yoer/entities/call_kit_params.dart';
import 'package:flutter_callkit_incoming_yoer/entities/ios_params.dart';
import 'package:flutter_callkit_incoming_yoer/entities/notification_params.dart';
import 'package:flutter_callkit_incoming_yoer/flutter_callkit_incoming.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../../presentation/android_large_5_page/incoming_call_page.dart';
import '../../presentation/home_page_container_screen/home_page_container_screen.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  
  // print("Handling a background message: ${message.messageId}");
  // await NotificationService().initializeLocalNotifications();
  //
  // await NotificationService().initializePushNotification(message);
  // await NotificationService().initializeLocalNotifications();
  //
  // await NotificationService().initializePushNotification(message);

  // to handle call notification dismiss when call disconnect from staff side
  var payload = message.data;

  String type = payload.containsKey("type") ? payload['type'] : "";

  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    PrefUtils().init();
    print("Firebase initialized successfully");
  } else {
    print("Firebase is already initialized");
  }

  if (type == "new_call" || type == "new_live") {
    String callId = message.data.containsKey("id") ? message.data['id'] : "";
    FirebaseUtils.listenCalls();

    if (message.data.containsKey('timestamp') && type == "new_call") {
      // Parse the send time from the notification payload as UTC
      DateTime sendTime = DateTime.parse(message.data['timestamp']).toUtc();
      DateTime arrivalTime = DateTime.now().toUtc();

      int delayInSeconds = arrivalTime.difference(sendTime).inSeconds;

      if (delayInSeconds <= 50) {
        Get.put(CallandChatController()).listenIncomingCallNotification();

        // _showNotification(message);
      } else {
        // FirebaseUtils.deleteCall(callId);
      }
    } else {
      if (type == "new_live") {
        handleNotification(message);
      }
      // _showNotification(message);
    }
  }

  return;
  // String type = message.data.containsKey("type")
  //     ? message.data['type']
  //     : "";
  // if(type=="new_live" || type=="new_call") {
  //
  //   Get.put(ChatFireBaseController()).updateLog(
  //       (type == "new_live" ? "Live call " : " Call arrived") + " in bg",
  //       jsonString);
  //   if(type=="new_call") {
  //     try {
  //       await ChatSocket.initSocket();
  //
  //       // ChatSocket().listenCurrentCall((status, callId) {
  //       //   if (status) {
  //       //     FlutterCallkitIncoming.endAllCalls();
  //       //   }
  //       // });
  //     } catch (_) {
  //       Get.put(ChatFireBaseController()).updateLog(
  //           "Message arrived in bg :error ", _.toString());
  //     }
  //   }
  //   return;
  //   handleNotification(message);

  // }
}

@pragma(
    'vm:entry-point') // The @pragma('vm:entry-point') annotation in Flutter/Dart is used to mark a function or class as an entry point, ensuring that it is not removed during tree shaking or code stripping
Future<void> showCallkitIncoming(
    String callId,
    String callerName,
    String profileUrl,
    String callType,
    Map<String, dynamic> data,
    bool isMissedCall,
    {String sessionType = "Call"}) async {
  String avatarUrl = Platform.isAndroid
      ? 'file:///android_asset/flutter_assets/assets/images/logo.jpg'
      : "";

  final params = CallKitParams(
    id: callId,
    nameCaller: callerName + (sessionType == "Live" ? " (Live Class)" : ""),
    appName: 'Breffni',
    avatar: avatarUrl,
    // avatar: !profileUrl.isNullOrEmpty() && profileUrl.startsWith("http")?
    // profileUrl:HttpUrls.imgBaseUrl+profileUrl,,// duplicate dialog when image size is big
    handle: '0123456789',
    type: callType == "Video" ? 1 : 0,
    duration: 30000,
    textAccept: 'Accept',
    textDecline: 'Decline',

    missedCallNotification: NotificationParams(
      showNotification: true,
      isShowCallback: false,
      subtitle: sessionType == "Live" ? "Live Missed Call" : 'Missed call',
      callbackText: '',
    ),
    extra: data,
    headers: <String, dynamic>{'apiKey': 'Abc@123!', 'platform': 'flutter'},
    android: const AndroidParams(
      isCustomNotification: true,
      isCustomSmallExNotification: true,
      isShowFullLockedScreen: true,
      isShowLogo: false,
      incomingCallNotificationChannelName: "high_importance_channel",
      ringtonePath: 'system_ringtone_default',
      backgroundColor: '#0955fa',
      backgroundUrl: 'assets/images/track_box_logo.png',
      actionColor: '#4CAF50',
      textColor: '#ffffff',
    ),
    ios: const IOSParams(
      iconName: 'CallKitLogo',
      handleType: '',
      supportsVideo: true,
      maximumCallGroups: 2,
      maximumCallsPerCallGroup: 1,
      audioSessionMode: 'default',
      audioSessionActive: true,
      audioSessionPreferredSampleRate: 44100.0,
      audioSessionPreferredIOBufferDuration: 0.005,
      supportsDTMF: true,
      supportsHolding: true,
      supportsGrouping: false,
      supportsUngrouping: false,
      ringtonePath: 'system_ringtone_default',
    ),
  );
  if (isMissedCall) {
    await FlutterCallkitIncoming.showMissCallNotification(params);
  } else {
    await FlutterCallkitIncoming.showCallkitIncoming(params);
  }
}

handleNotification(RemoteMessage message) async {
  if (message.data.isNotEmpty) {
    // Convert message.data from Map<String, dynamic> to Map<String, String?>
    final Map<String, String?> payload =
        message.data.map((key, value) => MapEntry(key, value.toString()));

    // Determine the channel key based on the payload
    String channelKey = ""; // Default channel

    if (payload['type'] == 'new_call') {
      channelKey = 'call_channel'; // Use the call channel
    } else if (payload['type'] == 'new_live') {
      channelKey = 'live_channel'; // Use the call channel
    } else
    // if (payload['type'] == 'new_message')
    {
      channelKey = 'message_channel'; // Use the message channel
    }
    String liveLink =
        message.data.containsKey("Live_Link") ? message.data['Live_Link'] : "";
    int id = message.data.containsKey("id")
        ? int.parse(message.data['id'])
        : message.hashCode;

    String profileImgUrl = message.data.containsKey("Profile_Photo_Img")
        ? message.data['Profile_Photo_Img']
        : "";
    String callId = message.data.containsKey("id") ? message.data['id'] : "";
    String callerName = message.data.containsKey("Caller_Name")
        ? message.data['Caller_Name']
        : "";
    String callType =
        message.data.containsKey("call_type") ? message.data['call_type'] : "";

    // if(channelKey == "call_channel"){
    //   if(Get.currentRoute!="/IncomingCallPage") { // hide already started cales
    //
    //     //checking notification call id is current call id in server.(to handle delayed notification showing call screen)
    //     List<OnGoingCallsModel> callList =
    //     await Get.find<CallandChatController>().getOngoingCallsApi(callId);
    //
    //     if (callList.isNotEmpty && callList[0].id.toString() == callId) {
    //       if (!callId.isNullOrEmpty()) {
    //         // to handle duplicate notification
    //         var calls = await FlutterCallkitIncoming.activeCalls();
    //         if (calls is List && calls.isNotEmpty && calls.isNotEmpty) {
    //           if (!calls.any((value) => value["id"].toString() == callId)) {
    //             showCallkitIncoming(
    //                 callId, callerName, profileImgUrl, callType,
    //                 message.data);
    //             return; // to hide default notification
    //
    //           }
    //         } else {
    //           showCallkitIncoming(
    //               callId, callerName, profileImgUrl, callType, message.data);
    //           return; // to hide default notification
    //
    //         }
    //       }
    //     } else {
    //       // remove all calls when no current call at server
    //       await FlutterCallkitIncoming.endAllCalls();
    //     }
    //   }
    //
    // }else
    if (channelKey == "live_channel") {
      String callerName = message.data.containsKey("Teacher_Name")
          ? message.data['Teacher_Name']
          : "";
      bool isLiveStart =
          (message.data.containsKey("status") ? message.data['status'] : "0") ==
              "0";

      if (isLiveStart && Get.currentRoute != "/VideoScreen") {
        showCallkitIncoming(
            callId, callerName, profileImgUrl, "Video", message.data, false,
            sessionType: "Live");
      }
      // handling missed live class (case when teacher start live class and end live
      // ...if user side is ring ing call then hide call ringing)
      if (!isLiveStart) {
        String callId =
            message.data.containsKey("id") ? message.data['id'] : "";
        await FlutterCallkitIncoming.endCall(callId);
      }
    }

    // } else{
    //
    //   // AwesomeNotifications().createNotification(
    //   //   actionButtons: channelKey == "call_channel" ? [
    //   //     NotificationActionButton(
    //   //         key: 'reject_btn', label: 'Reject', color: Colors.red),
    //   //     NotificationActionButton(
    //   //         key: 'accept_btn', label: 'Accept', color: Colors.green),
    //   //   ] : [],
    //   //   content: NotificationContent(
    //   //     id: id,
    //   //     channelKey: channelKey,
    //   //     title: message.notification?.title,
    //   //     body: message.notification?.body,
    //   //     payload: payload,
    //   //     largeIcon: HttpUrls.imgBaseUrl + profileImgUrl,
    //   //     roundedLargeIcon: true,wakeUpScreen: true,
    //   //
    //   //   ),
    //   // );
    // }
    //
    // if(Get.currentRoute=="/IncomingCallPage" && channelKey == "call_channel" ) {
    //   // AwesomeNotifications().cancel(id);
    // }
  }
}
// class NotificationService {
//   final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
//
//   //-- Initialize Awesome Notifications
//   Future<void> initializePushNotification(RemoteMessage message) async {
//     // Handle incoming messages
//     if (message.data.isNotEmpty) {
//       handleNotification(message);
//
//     }
//     // Setup background message handling
//     FirebaseMessaging.onMessageOpenedApp.listen((message) {
//       if (message.data.isNotEmpty) {
//         handleNotification(message);
//
//       }
//     });
//   }
//   //
//   // static Future<void> backgroundHandler(RemoteMessage message) async {
//   //   log("Handling a background message: ${message.toString()}");
//   //   // Handle background notification
//   // }
//
//
//
//   //-- Local Notifications Services
//
//   Future<void> initLocalNotification() async{
//
//   }
//
//   Future<void> initializeLocalNotifications() async {
//     // AwesomeNotifications().initialize(
//     //   'resource://drawable/res_app_icon',
//     //   [
//     //     NotificationChannel(
//     //       channelKey: 'message_channel',
//     //       channelName: 'Message notifications',
//     //       channelDescription: 'Notification channel for new messages',
//     //       defaultColor: Colors.teal,
//     //       importance: NotificationImportance.High,
//     //       channelShowBadge: true,
//     //     ),
//     //     NotificationChannel(
//     //       channelKey: 'call_channel',
//     //       channelName: 'Call notifications',
//     //       channelDescription: 'Notification channel for new calls',
//     //       defaultColor: Colors.red,
//     //       importance: NotificationImportance.High,
//     //       channelShowBadge: true,
//     //       soundSource: 'resource://raw/call_sound',
//     //     ),
//     //   ],
//     // );
//     //
//     // AwesomeNotifications().setListeners(
//     //   onActionReceivedMethod: (ReceivedAction receivedAction) {
//     //     return NotificationController.onActionReceivedMethod(receivedAction);
//     //   },
//     //   onNotificationCreatedMethod: (ReceivedNotification receivedNotification) {
//     //     return NotificationController.onNotificationCreatedMethod(
//     //         receivedNotification);
//     //   },
//     //   onNotificationDisplayedMethod:
//     //       (ReceivedNotification receivedNotification) {
//     //     return NotificationController.onNotificationDisplayedMethod(
//     //         receivedNotification);
//     //   },
//     //   onDismissActionReceivedMethod: (ReceivedAction receivedAction) {
//     //     return NotificationController.onDismissActionReceivedMethod(
//     //         receivedAction);
//     //   },
//     // );
//
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//       handleNotification(message);
//
//     });
//     FirebaseMessaging.instance.getInitialMessage().then((message) {
//       if(null!=message) {
//         handleNotification(message);
//       }
//
//     });
//   }
//
//   //
//   // Future<void> onSelectNotification(
//   //     NotificationResponse notificationResponse) async {
//   //   // Handle the notification response
//   //   log("Notification clicked with payload: ${notificationResponse.payload}");
//   //   // You can navigate or perform actions based on the payload
//   // }
// }
