import '../../../core/app_export.dart';
import '../controller/writing_test_question_controller.dart';

/// A binding class for the WritingTestQuestionScreen.
///
/// This class ensures that the WritingTestQuestionController is created when the
/// WritingTestQuestionScreen is first loaded.
class WritingTestQuestionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WritingTestQuestionController());
  }
}
