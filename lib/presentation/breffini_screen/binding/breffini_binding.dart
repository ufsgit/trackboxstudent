import '../../../core/app_export.dart';
import '../controller/breffini_controller.dart';

/// A binding class for the BreffiniScreen.
///
/// This class ensures that the BreffiniController is created when the
/// BreffiniScreen is first loaded.
class BreffiniBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BreffiniController());
  }
}
