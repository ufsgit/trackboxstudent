import '../../../core/app_export.dart';
import '../controller/reading_test_passage_controller.dart';

/// A binding class for the ReadingTestPassageScreen.
///
/// This class ensures that the ReadingTestPassageController is created when the
/// ReadingTestPassageScreen is first loaded.
class ReadingTestPassageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReadingTestPassageController());
  }
}
