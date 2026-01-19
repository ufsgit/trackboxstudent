import '../../../core/app_export.dart';
import '../controller/breff_controller.dart';

/// A binding class for the BreffScreen.
///
/// This class ensures that the BreffController is created when the
/// BreffScreen is first loaded.
class BreffBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BreffController());
  }
}
