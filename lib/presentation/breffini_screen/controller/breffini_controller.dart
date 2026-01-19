import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/breffini_model.dart';

/// A controller class for the BreffiniScreen.
///
/// This class manages the state of the BreffiniScreen, including the
/// current breffiniModelObj
class BreffiniController extends GetxController {
  TextEditingController askanythingoneController = TextEditingController();

  Rx<BreffiniModel> breffiniModelObj = BreffiniModel().obs;

  @override
  void onClose() {
    super.onClose();
    askanythingoneController.dispose();
  }
}
