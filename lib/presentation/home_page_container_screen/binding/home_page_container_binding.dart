import '../../../core/app_export.dart';
import '../controller/home_page_container_controller.dart';
import '../../profile/controller/profile_controller.dart';

/// A binding class for the HomePageContainerScreen.
///
/// This class ensures that the HomePageContainerController is created when the
/// HomePageContainerScreen is first loaded.
class HomePageContainerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController());
    Get.lazyPut(() => HomePageContainerController());
  }
}
