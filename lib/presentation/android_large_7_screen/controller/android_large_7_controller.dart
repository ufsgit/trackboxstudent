import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/android_large_7_model.dart';

/// A controller class for the AndroidLarge7Screen.
///
/// This class manages the state of the AndroidLarge7Screen, including the
/// current androidLarge7ModelObj
class AndroidLarge7Controller extends GetxController {
  TextEditingController searchController = TextEditingController();

  TextEditingController timeController = TextEditingController();

  Rx<AndroidLarge7Model> androidLarge7ModelObj = AndroidLarge7Model().obs;

  @override
  void onClose() {
    super.onClose();
    searchController.dispose();
    timeController.dispose();
  }
}
