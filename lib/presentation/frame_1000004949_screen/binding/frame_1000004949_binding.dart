import '../../../core/app_export.dart';
import '../controller/frame_1000004949_controller.dart';

/// A binding class for the Frame1000004949Screen.
///
/// This class ensures that the Frame1000004949Controller is created when the
/// Frame1000004949Screen is first loaded.
class Frame1000004949Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Frame1000004949Controller());
  }
}
