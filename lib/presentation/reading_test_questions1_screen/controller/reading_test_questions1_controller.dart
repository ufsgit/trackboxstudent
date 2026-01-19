import '../../../core/app_export.dart';
import '../models/reading_test_questions1_model.dart';

/// A controller class for the ReadingTestQuestions1Screen.
///
/// This class manages the state of the ReadingTestQuestions1Screen, including the
/// current readingTestQuestions1ModelObj
class ReadingTestQuestions1Controller extends GetxController {
  Rx<ReadingTestQuestions1Model> readingTestQuestions1ModelObj =
      ReadingTestQuestions1Model().obs;

  Rx<String> radioGroup = "".obs;

  Rx<String> radioGroup1 = "".obs;

  Rx<String> radioGroup2 = "".obs;

  Rx<String> radioGroup3 = "".obs;
}
