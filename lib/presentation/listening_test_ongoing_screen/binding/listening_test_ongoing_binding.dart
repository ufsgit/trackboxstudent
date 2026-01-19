import '../../../core/app_export.dart';
import '../controller/listening_test_ongoing_controller.dart';

/// A binding class for the ListeningTestOngoingScreen.
///
/// This class ensures that the ListeningTestOngoingController is created when the
/// ListeningTestOngoingScreen is first loaded.
class ListeningTestOngoingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ListeningTestOngoingController());
  }
}
