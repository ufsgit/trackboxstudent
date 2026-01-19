import '../../../core/app_export.dart';
import '../controller/frame_1000004938_controller.dart';

/// A binding class for the Frame1000004938Screen.
///
/// This class ensures that the Frame1000004938Controller is created when the
/// Frame1000004938Screen is first loaded.
class Frame1000004938Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Frame1000004938Controller());
  }
}
