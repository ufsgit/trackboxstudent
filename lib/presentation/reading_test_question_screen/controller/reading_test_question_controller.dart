import '../../../core/app_export.dart';
import '../models/reading_test_question_model.dart';

/// A controller class for the ReadingTestQuestionScreen.
///
/// This class manages the state of the ReadingTestQuestionScreen, including the
/// current readingTestQuestionModelObj
class ReadingTestQuestionController extends GetxController {
  Rx<ReadingTestQuestionModel> readingTestQuestionModelObj =
      ReadingTestQuestionModel().obs;
}
