import '../../../core/app_export.dart';
import '../controller/speaking_test_checking_controller.dart';

/// A binding class for the SpeakingTestCheckingScreen.
///
/// This class ensures that the SpeakingTestCheckingController is created when the
/// SpeakingTestCheckingScreen is first loaded.
class SpeakingTestCheckingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SpeakingTestCheckingController());
  }
}
