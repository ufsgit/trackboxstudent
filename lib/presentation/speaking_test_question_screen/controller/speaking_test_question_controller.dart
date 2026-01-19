import '../../../core/app_export.dart';
import '../models/speaking_test_question_model.dart';

/// A controller class for the SpeakingTestQuestionScreen.
///
/// This class manages the state of the SpeakingTestQuestionScreen, including the
/// current speakingTestQuestionModelObj
class SpeakingTestQuestionController extends GetxController {
  Rx<SpeakingTestQuestionModel> speakingTestQuestionModelObj =
      SpeakingTestQuestionModel().obs;
}
