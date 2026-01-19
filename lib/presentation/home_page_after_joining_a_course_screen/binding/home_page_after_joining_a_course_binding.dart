import '../../../core/app_export.dart';
import '../controller/home_page_after_joining_a_course_controller.dart';

/// A binding class for the HomePageAfterJoiningACourseScreen.
///
/// This class ensures that the HomePageAfterJoiningACourseController is created when the
/// HomePageAfterJoiningACourseScreen is first loaded.
class HomePageAfterJoiningACourseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomePageAfterJoiningACourseController());
  }
}
