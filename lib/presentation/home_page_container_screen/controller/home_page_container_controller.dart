import 'package:anandhu_s_application4/presentation/onboarding/onboard_controller.dart';

import '../../../core/app_export.dart';
import '../../profile/controller/profile_controller.dart';
import '../models/home_page_container_model.dart';

/// A controller class for the HomePageContainerScreen.
///
/// This class manages the state of the HomePageContainerScreen, including the
/// current homePageContainerModelObj
class HomePageContainerController extends GetxController {
  final ProfileController profileController = Get.find<ProfileController>();

  // Observable model for the container
  Rx<HomePageContainerModel> homePageContainerModelObj =
      HomePageContainerModel().obs;

  // Observable for the current page route
  RxString currentPage = RxString(AppRoutes.homePage); // Default page

  // Observable for the selected index in navigation
  var selectedIndex = 0.obs;
  var mentorChildIndex = 0.obs;

  // Observable for the selected tab index
  var selectedTabIndex = 0.obs;

  // Method to temporarily set the page (e.g., for notifications)
  void setTemporaryPage(String route, {int mentorIndex = 0}) {
    currentPage.value = route;
    selectedIndex.value = getIndexForPage(route);
    mentorChildIndex.value = mentorIndex;
  }

  // Method to update the selected tab index
  void updateTabIndex(int index) {
    selectedTabIndex.value = index;
  }

  // Method to map page routes to indices
  int getIndexForPage(String page) {
    switch (page) {
      case AppRoutes.homePage:
        return 0;
      // case AppRoutes.connectMentorsPage: // Faculty - Hidden
      //   return 1;
      case AppRoutes.androidLarge5Page: // Chats
        return 1;
      case AppRoutes.profileScreen: // Profile
        return 2;
      default:
        return 0;
    }
  }

  @override
  void onReady() {
    super.onReady();
    // Perform initialization actions
    // initFn();
  }

  // Initialization function for async operations
  // Future<void> initFn() async {
  //   try {
  //     // Fetch initial data asynchronously
  //     await onboardingController.getCourseDropdownValue(courseName: '');
  //     await profileController.getProfileStudent();
  //   } catch (e) {
  //     // Handle any errors that occur during initialization
  //     print('Initialization error: $e');
  //   }
  // }
}
