import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/android_large_4_model.dart';

/// A controller class for the AndroidLarge4Screen.
///
/// This class manages the state of the AndroidLarge4Screen, including the
/// current androidLarge4ModelObj
class AndroidLarge4Controller extends GetxController {
  TextEditingController messageController = TextEditingController();

  Rx<AndroidLarge4Model> androidLarge4ModelObj = AndroidLarge4Model().obs;

  @override
  void onClose() {
    super.onClose();
    messageController.dispose();
  }
}
