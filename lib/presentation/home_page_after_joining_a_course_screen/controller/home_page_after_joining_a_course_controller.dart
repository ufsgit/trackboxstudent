import '../../../core/app_export.dart';
import '../models/home_page_after_joining_a_course_model.dart';

/// A controller class for the HomePageAfterJoiningACourseScreen.
///
/// This class manages the state of the HomePageAfterJoiningACourseScreen, including the
/// current homePageAfterJoiningACourseModelObj
class HomePageAfterJoiningACourseController extends GetxController {
  Rx<HomePageAfterJoiningACourseModel> homePageAfterJoiningACourseModelObj =
      HomePageAfterJoiningACourseModel().obs;

  // @override
  // void onReady() {
  //   Future.delayed(const Duration(milliseconds: 3000), () {
  //     Get.offNamed(
  //       AppRoutes.breffScreen,
  //     );
  //   });
  // }
}
