import '../../../core/app_export.dart';
import '../controller/frame_1000005261_controller.dart';

/// A binding class for the Frame1000005261Screen.
///
/// This class ensures that the Frame1000005261Controller is created when the
/// Frame1000005261Screen is first loaded.
class Frame1000005261Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Frame1000005261Controller());
  }
}
