import '../../../core/app_export.dart';
import '../controller/frame_1000004940_controller.dart';

/// A binding class for the Frame1000004940Screen.
///
/// This class ensures that the Frame1000004940Controller is created when the
/// Frame1000004940Screen is first loaded.
class Frame1000004940Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Frame1000004940Controller());
  }
}
