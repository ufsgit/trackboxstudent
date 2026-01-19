import '../../../core/app_export.dart';
import '../controller/playing_course_controller.dart';

/// A binding class for the PlayingCourseScreen.
///
/// This class ensures that the PlayingCourseController is created when the
/// PlayingCourseScreen is first loaded.
class PlayingCourseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PlayingCourseController());
  }
}
