import '../../../core/app_export.dart';
import '../controller/course_details_page1_controller.dart';

/// A binding class for the CourseDetailsPage1Screen.
///
/// This class ensures that the CourseDetailsPage1Controller is created when the
/// CourseDetailsPage1Screen is first loaded.
class CourseDetailsPage1Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CourseModuleController());
  }
}
