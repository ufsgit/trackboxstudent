import '../../../core/app_export.dart';
import '../models/android_large_5_model.dart';

/// A controller class for the AndroidLarge5Page.
///
/// This class manages the state of the AndroidLarge5Page, including the
/// current androidLarge5ModelObj
class AndroidLarge5Controller extends GetxController {
  AndroidLarge5Controller(this.androidLarge5ModelObj);

  Rx<AndroidLarge5Model> androidLarge5ModelObj;

  @override
  void onClose() {
    super.onClose();
  }
}
