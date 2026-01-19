import '../../../core/app_export.dart';
import '../controller/reading_test_question_controller.dart';

/// A binding class for the ReadingTestQuestionScreen.
///
/// This class ensures that the ReadingTestQuestionController is created when the
/// ReadingTestQuestionScreen is first loaded.
class ReadingTestQuestionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReadingTestQuestionController());
  }
}
