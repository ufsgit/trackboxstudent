import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../android_large_5_page/android_large_5_page.dart';
import '../home_page/home_page.dart';
import '../my_courses_page/my_courses_page.dart';
import 'controller/frame_1000004962_controller.dart'; // ignore_for_file: must_be_immutable

class Frame1000004962Screen extends GetWidget<Frame1000004962Controller> {
  const Frame1000004962Screen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: Container(
          width: SizeUtils.width,
          height: SizeUtils.height,
          padding: EdgeInsets.only(bottom: 64.v),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                ImageConstant.imgGroup767,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: SizedBox(
            height: 686.v,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 429.v,
                    width: double.maxFinite,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgRectangle713,
                          height: 429.v,
                          width: 360.h,
                          alignment: Alignment.center,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 220.v,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment(0.53, 0.76),
                                end: Alignment(0.53, 0.1),
                                colors: [
                                  appTheme.black900,
                                  appTheme.black900.withOpacity(0)
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    height: 401.v,
                    width: double.maxFinite,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgRectangle712,
                          height: 401.v,
                          width: 360.h,
                          alignment: Alignment.center,
                        ),
                        _buildNavigationRow()
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 28.h),
          child: _buildBottomBar(),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildNavigationRow() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: EdgeInsets.fromLTRB(16.h, 26.v, 16.h, 326.v),
        padding: EdgeInsets.all(1.h),
        decoration: AppDecoration.outlineBluegray501.copyWith(
          borderRadius: BorderRadiusStyle.circleBorder18,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgArrowLeftWhiteA700,
              height: 24.adaptSize,
              width: 24.adaptSize,
              radius: BorderRadius.circular(
                12.h,
              ),
              margin: EdgeInsets.symmetric(vertical: 11.v),
              onTap: () {
                onTapImgArrowleftone();
              },
            ),
            Spacer(
              flex: 56,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 7.v),
              child: Column(
                children: [
                  Text(
                    "lbl_arathy_krishnan".tr,
                    style: CustomTextStyles.labelLargeWhiteA700,
                  ),
                  SizedBox(height: 2.v),
                  Text(
                    "lbl_1_05".tr,
                    style: CustomTextStyles.labelMediumWhiteA700,
                  )
                ],
              ),
            ),
            Spacer(
              flex: 43,
            ),
            CustomImageView(
              imagePath: ImageConstant.imgPhoneWhiteA700,
              height: 46.adaptSize,
              width: 46.adaptSize,
              radius: BorderRadius.circular(
                15.h,
              ),
              onTap: () {
                onTapImgPhoneone();
              },
            )
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildBottomBar() {
    return CustomBottomBar(
      onChanged: (BottomBarEnum type) {
        Get.toNamed(getCurrentRoute(type), id: 1);
      },
    );
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return AppRoutes.homePage;
      case BottomBarEnum.Mycourses:
        return AppRoutes.myCoursesPage;
      case BottomBarEnum.Mentors:
        return AppRoutes.androidLarge5Page;
      case BottomBarEnum.Profile:
        return "/";
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.homePage:
        return HomePage();
      case AppRoutes.myCoursesPage:
        return MyCoursesPage();
      case AppRoutes.androidLarge5Page:
        return AndroidLarge5Screen(
          isNotificationClick: false,
        );
      default:
        return DefaultWidget();
    }
  }

  /// Navigates to the previous screen.
  onTapImgArrowleftone() {
    Get.back();
  }

  /// Navigates to the androidLarge4Screen when the action is triggered.
  onTapImgPhoneone() {
    Get.toNamed(
      AppRoutes.chatScreen,
    );
  }
}
