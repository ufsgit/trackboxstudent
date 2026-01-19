import '../../../core/app_export.dart';
import '../controller/frame_1000004952_controller.dart';

/// A binding class for the Frame1000004952Screen.
///
/// This class ensures that the Frame1000004952Controller is created when the
/// Frame1000004952Screen is first loaded.
class Frame1000004952Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Frame1000004952Controller());
  }
}
