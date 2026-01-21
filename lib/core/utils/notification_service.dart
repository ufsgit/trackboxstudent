import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:anandhu_s_application4/core/utils/firebase_utils.dart';
import 'package:anandhu_s_application4/firebase_options.dart';
import 'package:anandhu_s_application4/http/socket_io.dart';
import 'package:anandhu_s_application4/presentation/android_large_5_page/controller/call_chat_controller.dart';
import 'package:anandhu_s_application4/presentation/home_page_container_screen/home_page_container_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_callkit_incoming_yoer/entities/android_params.dart';
import 'package:flutter_callkit_incoming_yoer/entities/call_kit_params.dart';
import 'package:flutter_callkit_incoming_yoer/entities/ios_params.dart';
import 'package:flutter_callkit_incoming_yoer/entities/notification_params.dart';
import 'package:flutter_callkit_incoming_yoer/flutter_callkit_incoming.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

// Top-level function for background tapped notification
@pragma('vm:entry-point')
@pragma('vm:entry-point')
void notificationTapBackground(
    NotificationResponse notificationResponse) async {
  // handle action
  log('notificationTapBackground: ${notificationResponse.payload}');
  if (notificationResponse.actionId == NotificationService.replyActionId &&
      notificationResponse.input != null) {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);
    }

    // Duplicate logic from _handleReply to ensure it works in background isolate
    String input = notificationResponse.input!;
    String? payload = notificationResponse.payload;

    log("Background Reply Input: $input");
    if (payload != null) {
      try {
        Map<String, dynamic> data = jsonDecode(payload);
        log("Sending background reply for payload: $data");

        String? teacherId = data['teacherId']?.toString() ??
            data['id']?.toString() ??
            data['senderId']?.toString();

        if (teacherId == null) {
          log("Error: teacherId not found in payload");
          return;
        }

        final prefs = await SharedPreferences.getInstance();
        final String studentId = prefs.getString('breffini_student_id') ?? "0";

        final messageData = {
          "studentId": studentId,
          "userId": teacherId,
          "chatMessage": input,
          "sentTime": DateTime.now().toUtc().toIso8601String(),
          "isStudent": true,
          "filePath": "",
          "fileSize": 0.0,
          "thumbUrl": "",
          "senderName": prefs.getString('student_name') ?? "Student",
        };

        String path = 'chats/$teacherId/students/$studentId/messages';
        await FirebaseFirestore.instance.collection(path).add(messageData);
        log("Background Reply sent to Firestore at $path");
      } catch (e) {
        log("Error handling background reply: $e");
      }
    }
  }
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
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
  } else if (type == "new_message" || type == "chat") {
    // Handle background/terminated chat messages (data-only)
    // Initialize strictly for background (channels logic)
    await NotificationService().initializeForBackground();
    await NotificationService().showLocalNotification(message);
  }

  return;
}

@pragma('vm:entry-point')
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
    } else {
      channelKey = 'message_channel'; // Use the message channel
    }

    String callId = message.data.containsKey("id") ? message.data['id'] : "";
    // String callerName = message.data.containsKey("Caller_Name")
    //     ? message.data['Caller_Name']
    //     : "";

    // String profileImgUrl = message.data.containsKey("Profile_Photo_Img")
    //     ? message.data['Profile_Photo_Img']
    //     : "";

    if (channelKey == "live_channel") {
      String callerName = message.data.containsKey("Teacher_Name")
          ? message.data['Teacher_Name']
          : "";
      bool isLiveStart =
          (message.data.containsKey("status") ? message.data['status'] : "0") ==
              "0";
      // To avoid duplicate declaration error if we reused profileImgUrl from above
      String profileImgUrl = message.data.containsKey("Profile_Photo_Img")
          ? message.data['Profile_Photo_Img']
          : "";

      if (isLiveStart && Get.currentRoute != "/VideoScreen") {
        showCallkitIncoming(
            callId, callerName, profileImgUrl, "Video", message.data, false,
            sessionType: "Live");
      }

      if (!isLiveStart) {
        String callId =
            message.data.containsKey("id") ? message.data['id'] : "";
        await FlutterCallkitIncoming.endCall(callId);
      }
    }
  }
}

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() {
    return _instance;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Channel details - Versioned to force update on Android
  static const String defaultChannelId = 'default_channel_v1';
  static const String messageChannelId = 'message_channel_v2';
  static const String callChannelId = 'call_channel_v2';

  // Action IDs
  static const String replyActionId = 'REPLY_ACTION';

  Future<void> initialize() async {
    await _requestPermission();
    await _initializeLocalNotifications();
    _configureForegroundOptions();
    _listenToForegroundMessages();
    _setupInteractedMessage();
  }

  Future<void> _requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    log('User granted permission: ${settings.authorizationStatus}');
  }

  Future<void> _initializeLocalNotifications() async {
    // Android initialization
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS initialization
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        log('Notification clicked with payload: ${response.payload}');

        // Handle Direct Reply Input
        if (response.actionId == replyActionId && response.input != null) {
          _handleReply(response.payload, response.input!);
        }

        _handleNotificationTap(response.payload);
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );

    // Create Channels
    await _createNotificationChannels();
  }

  Future<void> _createNotificationChannels() async {
    final androidImplementation =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    if (androidImplementation == null) return;

    // 1. Default Channel (High Importance, Default Sound)
    const AndroidNotificationChannel defaultChannel =
        AndroidNotificationChannel(
      defaultChannelId,
      'General Notifications',
      description: 'General app notifications',
      importance: Importance.max,
      playSound: true,
    );

    // 2. Message Channel (Custom Sound if available, else default)
    // Assuming 'message_notification.mp3' exists in res/raw
    const AndroidNotificationChannel messageChannel =
        AndroidNotificationChannel(
      messageChannelId,
      'Message Notifications',
      description: 'Notifications for new chat messages',
      importance: Importance.max,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('message_notification'),
    );

    // 3. Call Channel (Custom Sound)
    // Assuming 'call_sound.mp3' exists in res/raw
    const AndroidNotificationChannel callChannel = AndroidNotificationChannel(
      callChannelId,
      'Call Notifications',
      description: 'Incoming call notifications',
      importance: Importance.max,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('call_sound'),
    );

    await androidImplementation.createNotificationChannel(defaultChannel);
    await androidImplementation.createNotificationChannel(messageChannel);
    await androidImplementation.createNotificationChannel(callChannel);
  }

  void _configureForegroundOptions() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void _listenToForegroundMessages() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Got a message whilst in the foreground!');
      log('Message data: ${message.data}');

      String? type = message.data['type'];

      if (type == 'new_call' || type == 'new_live') {
        // Use the existing handleNotification for calls/live which uses CallKit
        handleNotification(message);
      } else if (message.notification != null) {
        log('Message also contained a notification: ${message.notification}');
        showLocalNotification(message);
      } else {
        // If it's a data-only message but we want to show a notification
        // trigger it manually based on 'type'.
        // Assuming 'type' identifies the kind of message
        if (message.data.containsKey('title') ||
            message.data.containsKey('body')) {
          showLocalNotification(message);
        } else if (type == 'new_message' || type == 'chat') {
          // Construct a notification if payload is just data
          // You might need to extract title/body from data if it's there
          // For now, relies on message.notification being present or constructing one
          showLocalNotification(message);
        }
      }
    });
  }

  void _handleReply(String? payload, String input) async {
    log("Direct Reply Input: $input");
    if (payload != null) {
      try {
        Map<String, dynamic> data = jsonDecode(payload);
        log("Sending reply for payload: $data");

        // 1. Get IDs from payload and Prefs
        String? teacherId = data['teacherId']?.toString() ??
            data['id']?.toString() ??
            data['senderId']?.toString();

        if (teacherId == null) {
          log("Error: teacherId not found in payload");
          return;
        }

        final prefs = await SharedPreferences.getInstance();
        final String studentId = prefs.getString('breffini_student_id') ?? "0";

        // 2. Construct Message
        // Note: matching structure from ChatFireBaseController
        final messageData = {
          "studentId": studentId,
          "userId": teacherId, // Assuming userId maps to teacherId in the model
          "chatMessage": input,
          "sentTime": DateTime.now()
              .toUtc()
              .toIso8601String(), // Store as ISO string or Timestamp? Model uses DateTime.
          // Firestore naturally handles DateTime or Timestamp.
          // Controller uses message.toMap(). Let's replicate simple map.
          "isStudent": true,
          "filePath": "",
          "fileSize": 0.0,
          "thumbUrl": "",
          "senderName": prefs.getString('student_name') ??
              "Student", // PrefUtils().getStudentName() logic
        };

        // 3. Write to Firestore
        // Path: 'chats/$teacherId/students/$studentId/messages'
        String path = 'chats/$teacherId/students/$studentId/messages';
        await FirebaseFirestore.instance.collection(path).add(messageData);
        log("Reply sent to Firestore at $path");
      } catch (e) {
        log("Error handling reply: $e");
      }
    }
  }

  Future<void> initializeForBackground() async {
    await _initializeLocalNotifications();
  }

  Future<String> _downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  Future<void> showLocalNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;

    // Fallback for data-only messages that resemble notifications
    String title = notification?.title ??
        message.data['title'] ??
        message.data['Caller_Name'] ??
        'New Message';
    String body = notification?.body ??
        message.data['body'] ??
        message.data['message'] ??
        'You have a new message';

    await showNotification(
      title: title,
      body: body,
      data: message.data,
    );
  }

  Future<void> showNotification({
    required String title,
    required String body,
    required Map<String, dynamic> data,
  }) async {
    // Don't show if empty
    if (title.isEmpty && body.isEmpty) return;

    // Use a hashcode or unique ID
    int id = data.hashCode;
    if (data.containsKey('id')) {
      try {
        id = int.parse(data['id'].toString());
      } catch (e) {}
    } else if (data.containsKey('messageId')) {
      try {
        id = int.parse(data['messageId'].toString());
      } catch (e) {}
    }

    String type = data['type'] ?? '';
    // Allow 'new message' from socket to trigger this
    if (data.containsKey('teacherId')) type = 'new_message';

    String channelIdToUse = defaultChannelId;
    String channelNameToUse = 'General Notifications';
    AndroidNotificationSound? soundToUse;
    StyleInformation? styleInformation;

    // Actions List
    List<AndroidNotificationAction>? actions;

    if (type == 'new_message' || type == 'chat') {
      channelIdToUse = messageChannelId;
      channelNameToUse = 'Message Notifications';
      soundToUse =
          const RawResourceAndroidNotificationSound('message_notification');

      // Use MessagingStyle for chat
      // 1. Define the Sender
      Person? sender;

      // Try to get profile image
      String? profileUrl = data['Profile_Photo_Img'] ??
          data['sender_avatar'] ??
          data['thumbUrl'];

      if (profileUrl != null && profileUrl.isNotEmpty) {
        try {
          final String largeIconPath =
              await _downloadAndSaveFile(profileUrl, 'largeIcon');
          sender = Person(
            name: title,
            key: data['senderId']?.toString() ??
                data['teacherId']?.toString() ??
                data['id']?.toString() ??
                "0",
            icon: BitmapFilePathAndroidIcon(largeIconPath),
          );
        } catch (e) {
          log('Error downloading avatar: $e');
        }
      }

      // Fallback if download failed
      sender ??= Person(
        name: title,
        key: data['senderId']?.toString() ??
            data['teacherId']?.toString() ??
            data['id']?.toString() ??
            "0",
      );

      // 2. Define the Message
      final DateTime timestamp =
          DateTime.now(); // Or parse from data['timestamp']
      final Message chatMessage = Message(
        body,
        timestamp,
        sender,
      );

      // 3. Create Style
      styleInformation = MessagingStyleInformation(
        sender,
        groupConversation: false,
        messages: [chatMessage],
      );

      // Add Direct Reply Action
      actions = [
        const AndroidNotificationAction(
          replyActionId,
          'Reply',
          inputs: <AndroidNotificationActionInput>[
            AndroidNotificationActionInput(
              label: 'Type a message...',
            ),
          ],
        ),
      ];
    } else if (type == 'new_call') {
      channelIdToUse = callChannelId;
      channelNameToUse = 'Call Notifications';
      soundToUse = const RawResourceAndroidNotificationSound('call_sound');
    }

    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channelIdToUse,
          channelNameToUse, // Use the correct name for the channel
          channelDescription: 'Notification',
          importance: Importance.max,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
          playSound: true,
          sound: soundToUse,
          actions: actions,
          styleInformation: styleInformation,
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      payload: jsonEncode(data),
    );
  }

  void _setupInteractedMessage() async {
    // Get any messages which caused the application to open from a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      _handleNotificationTap(jsonEncode(initialMessage.data));
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleNotificationTap(jsonEncode(message.data));
    });
  }

  void _handleNotificationTap(String? payload) {
    if (payload != null) {
      try {
        Map<String, dynamic> data = jsonDecode(payload);
        // Handle navigation based on data type
        String? type = data['type'];
        if (type == 'new_message' || type == 'chat') {
          Get.to(() => HomePageContainerScreen());
        } else if (type == 'new_call') {
          // Handle call
        }
      } catch (e) {
        log("Error parsing payload: $e");
      }
    }
  }
}
