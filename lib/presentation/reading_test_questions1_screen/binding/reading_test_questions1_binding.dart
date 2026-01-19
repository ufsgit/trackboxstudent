import '../../../core/app_export.dart';
import '../controller/reading_test_questions1_controller.dart';

/// A binding class for the ReadingTestQuestions1Screen.
///
/// This class ensures that the ReadingTestQuestions1Controller is created when the
/// ReadingTestQuestions1Screen is first loaded.
class ReadingTestQuestions1Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReadingTestQuestions1Controller());
  }
}
