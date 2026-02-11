import 'dart:developer';
import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../presentation/home_page_container_screen/home_page_container_screen.dart';

class PushNotificationHelper {
  static String fcmToken = "";

  // ---------------- INITIALIZE ---------------- //

  static Future<void> initialize() async {
    await AwesomeNotifications().initialize(
      'resource://drawable/res_app_icon',
      [
        NotificationChannel(
          channelKey: 'chat_channel',
          channelName: 'Chat notifications',
          channelDescription: 'Notification channel for chat messages',
          importance: NotificationImportance.Max,
          enableVibration: true,
          enableLights: true,
        ),
      ],
    );

    AwesomeNotifications().setListeners(
      onActionReceivedMethod: (ReceivedAction action) async {
        _handleNotificationNavigation(action.payload);
      },
    );

    if (Platform.isIOS) {
      await FirebaseMessaging.instance.requestPermission();
    }

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await _getDeviceToken();

    FirebaseMessaging.instance
        .getInitialMessage()
        .then(_handleNotificationClick);

    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationClick);
  }

  // ---------------- DEVICE TOKEN ---------------- //

  static Future<void> _getDeviceToken() async {
    fcmToken = await FirebaseMessaging.instance.getToken() ?? '';
    log("FCM Token: $fcmToken");
  }

  // ---------------- FOREGROUND ---------------- //

  static Future<void> _handleForegroundMessage(RemoteMessage message) async {
    final payload =
        message.data.map((key, value) => MapEntry(key, value.toString()));

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch ~/ 100,
        channelKey: 'chat_channel',
        title: message.notification?.title ?? "New Message",
        body: message.notification?.body ?? "",
        payload: payload,
      ),
    );
  }

  // ---------------- BACKGROUND ---------------- //

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    final payload =
        message.data.map((key, value) => MapEntry(key, value.toString()));

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch ~/ 100,
        channelKey: 'chat_channel',
        title: message.notification?.title ?? "New Message",
        body: message.notification?.body ?? "",
        payload: payload,
      ),
    );
  }

  // ---------------- CLICK HANDLER ---------------- //

  static void _handleNotificationClick(RemoteMessage? message) {
    if (message == null) return;

    _handleNotificationNavigation(
      message.data.map((key, value) => MapEntry(key, value.toString())),
    );
  }

  static void _handleNotificationNavigation(Map<String, String?>? payload) {
    if (payload == null) return;

    Get.to(() => HomePageContainerScreen());
  }
}
