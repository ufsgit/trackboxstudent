import '../../../core/app_export.dart';
import '../controller/course_details_page_controller.dart';

/// A binding class for the CourseDetailsPageScreen.
///
/// This class ensures that the CourseDetailsPageController is created when the
/// CourseDetailsPageScreen is first loaded.
class CourseDetailsPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CourseDetailsPageController());
  }
}
