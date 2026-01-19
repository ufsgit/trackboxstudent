import '../../../core/app_export.dart';
import '../controller/reading_test_questions_controller.dart';

/// A binding class for the ReadingTestQuestionsScreen.
///
/// This class ensures that the ReadingTestQuestionsController is created when the
/// ReadingTestQuestionsScreen is first loaded.
class ReadingTestQuestionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReadingTestQuestionsController());
  }
}
