import '../../../core/app_export.dart';
import '../controller/android_large_4_controller.dart';

/// A binding class for the AndroidLarge4Screen.
///
/// This class ensures that the AndroidLarge4Controller is created when the
/// AndroidLarge4Screen is first loaded.
class AndroidLarge4Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AndroidLarge4Controller());
  }
}
