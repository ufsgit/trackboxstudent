import '../../../core/app_export.dart';
import '../models/reading_test_passage_model.dart';

/// A controller class for the ReadingTestPassageScreen.
///
/// This class manages the state of the ReadingTestPassageScreen, including the
/// current readingTestPassageModelObj
class ReadingTestPassageController extends GetxController {
  Rx<ReadingTestPassageModel> readingTestPassageModelObj =
      ReadingTestPassageModel().obs;
}
