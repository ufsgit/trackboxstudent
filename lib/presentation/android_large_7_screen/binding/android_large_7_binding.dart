import '../../../core/app_export.dart';
import '../controller/android_large_7_controller.dart';

/// A binding class for the AndroidLarge7Screen.
///
/// This class ensures that the AndroidLarge7Controller is created when the
/// AndroidLarge7Screen is first loaded.
class AndroidLarge7Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AndroidLarge7Controller());
  }
}
