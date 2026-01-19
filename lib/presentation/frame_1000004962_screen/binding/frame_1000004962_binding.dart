import '../../../core/app_export.dart';
import '../controller/frame_1000004962_controller.dart';

/// A binding class for the Frame1000004962Screen.
///
/// This class ensures that the Frame1000004962Controller is created when the
/// Frame1000004962Screen is first loaded.
class Frame1000004962Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Frame1000004962Controller());
  }
}
