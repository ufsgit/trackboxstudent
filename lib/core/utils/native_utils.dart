import 'package:flutter/services.dart';

class NativeUtils{
  static var platform = MethodChannel('methodChannel');

  static Future<void> requestBatteryOptimization() async {

    try {
      await platform.invokeMethod('requestBatteryOptimization');
    } on PlatformException catch (e) {
      print("Failed to request battery optimization: '${e.message}'.");
    }
  }
  static Future<void> requestFullScreenIntentPermission() async {

    try {
      await platform.invokeMethod('requestFullScreenIntentPermission');
    } on PlatformException catch (e) {
      print("Failed to request battery optimization: '${e.message}'.");
    }
  }
  static Future<void> initFirebaseCleanup() async {

    try {
      await platform.invokeMethod('initFirebaseCleanup');
    } on PlatformException catch (e) {
      print("Failed to request initFirebaseCleanup: '${e.message}'.");
    }
  }
  static Future<void> wakeLock() async {

    try {
      await platform.invokeMethod('wakeScreen');
    } on PlatformException catch (e) {
      print("Failed to request wake screen: '${e.message}'.");
    }
  }

}