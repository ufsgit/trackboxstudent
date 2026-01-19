import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/listening_test_ongoing_model.dart';

/// A controller class for the ListeningTestOngoingScreen.
///
/// This class manages the state of the ListeningTestOngoingScreen, including the
/// current listeningTestOngoingModelObj
class ListeningTestOngoingController extends GetxController {
  TextEditingController answerInputController = TextEditingController();

  Rx<ListeningTestOngoingModel> listeningTestOngoingModelObj =
      ListeningTestOngoingModel().obs;

  Rx<String> questionRadioGroup = "".obs;

  @override
  void onClose() {
    super.onClose();
    answerInputController.dispose();
  }
}
