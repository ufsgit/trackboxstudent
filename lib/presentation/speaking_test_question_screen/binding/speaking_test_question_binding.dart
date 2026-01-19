import '../../../core/app_export.dart';
import '../controller/speaking_test_question_controller.dart';

/// A binding class for the SpeakingTestQuestionScreen.
///
/// This class ensures that the SpeakingTestQuestionController is created when the
/// SpeakingTestQuestionScreen is first loaded.
class SpeakingTestQuestionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SpeakingTestQuestionController());
  }
}
