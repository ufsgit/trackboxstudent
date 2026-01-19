import '../../../core/app_export.dart';
import '../controller/frame_1000004939_controller.dart';

/// A binding class for the Frame1000004939Screen.
///
/// This class ensures that the Frame1000004939Controller is created when the
/// Frame1000004939Screen is first loaded.
class Frame1000004939Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Frame1000004939Controller());
  }
}
