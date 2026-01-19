import '../../../core/app_export.dart';
import '../models/reading_test_questions_model.dart';

/// A controller class for the ReadingTestQuestionsScreen.
///
/// This class manages the state of the ReadingTestQuestionsScreen, including the
/// current readingTestQuestionsModelObj
class ReadingTestQuestionsController extends GetxController {
  Rx<ReadingTestQuestionsModel> readingTestQuestionsModelObj =
      ReadingTestQuestionsModel().obs;
}
