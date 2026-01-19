import 'package:flutter/material.dart';
import '../../../core/app_export.dart';

/// A controller class for the BreffScreen.
///
/// This class manages the state of the BreffScreen, including the
/// current breffModelObj
class BreffController extends GetxController {
  TextEditingController askanythingoneController = TextEditingController();

  // Rx<BreffModel> breffModelObj = BreffModel().obs;
  RxInt selectedIndex = 0.obs;
  RxBool isLoginButton = false.obs;
  RxBool isLogin = false.obs;

  @override
  void onReady() {
    var data = Get.parameters;
    selectedIndex.value = int.parse(data['index'] ?? '1');
    isLoginButton.value = bool.tryParse(data['isLogin'].toString()) ?? false;
    print(data);
    super.onInit();
  }
}
