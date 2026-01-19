import '../../../core/app_export.dart';
import '../models/writing_test_question_model.dart';

/// A controller class for the WritingTestQuestionScreen.
///
/// This class manages the state of the WritingTestQuestionScreen, including the
/// current writingTestQuestionModelObj
class WritingTestQuestionController extends GetxController {
  Rx<WritingTestQuestionModel> writingTestQuestionModelObj =
      WritingTestQuestionModel().obs;
}
