import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../added_to_cart_bottomsheet/added_to_cart_bottomsheet.dart';
import '../added_to_cart_bottomsheet/controller/added_to_cart_controller.dart';
import '../filter_bottom_sheet_bottomsheet/controller/filter_bottom_sheet_controller.dart';
import '../filter_bottom_sheet_bottomsheet/filter_bottom_sheet_bottomsheet.dart';
import 'controller/app_navigation_controller.dart'; // ignore_for_file: must_be_immutable

class AppNavigationScreen extends GetWidget<AppNavigationController> {
  const AppNavigationScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.whiteA700,
        body: SizedBox(
          width: 375.h,
          child: Column(
            children: [
              _buildAppNavigation(),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: AppDecoration.fillWhiteA,
                    child: Column(
                      children: [
                        _buildScreenTitle(
                          screenTitle: "msg_home_page_container".tr,
                          onTapScreenTitle: () => onTapScreenTitle(
                              AppRoutes.homePageContainerScreen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "msg_home_page_after".tr,
                          onTapScreenTitle: () => onTapScreenTitle(
                              AppRoutes.homePageAfterJoiningACourseScreen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "lbl_breff".tr,
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.breffScreen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "lbl_breffini".tr,
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.breffiniScreen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "lbl_search_page".tr,
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.searchPageScreen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "msg_filter_bottom_sheet".tr,
                          onTapScreenTitle: () => onTapBottomSheetTitle(
                              context,
                              FilterBottomSheetBottomsheet(
                                  Get.put(FilterBottomSheetController()))),
                        ),
                        _buildScreenTitle(
                          screenTitle: "msg_course_details_page".tr,
                          onTapScreenTitle: () => onTapScreenTitle(
                              AppRoutes.courseDetailsPageScreen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "msg_frame_1000004952".tr,
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.frame1000004952Screen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "lbl_playing_course".tr,
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.playingCourseScreen),
                        ),
                        // _buildScreenTitle(
                        //   screenTitle: "msg_course_details_page".tr,
                        //   onTapScreenTitle: () => onTapScreenTitle(
                        //       AppRoutes.courseDetailsPage1Screen),
                        // ),
                        _buildScreenTitle(
                          screenTitle: "msg_added_to_cart".tr,
                          onTapScreenTitle: () => onTapBottomSheetTitle(
                              context,
                              AddedToCartBottomsheet(
                                  Get.put(AddedToCartController()))),
                        ),
                        _buildScreenTitle(
                          screenTitle: "lbl_cart_checkout".tr,
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.cartCheckoutScreen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "msg_android_large".tr,
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.androidLarge7Screen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "msg_android_large2".tr,
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.chatScreen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "msg_frame_1000004938".tr,
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.frame1000004938Screen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "msg_frame_1000004939".tr,
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.frame1000004939Screen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "msg_frame_1000004940".tr,
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.frame1000004940Screen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "msg_frame_1000004949".tr,
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.frame1000004949Screen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "msg_frame_1000005261".tr,
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.frame1000005261Screen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "msg_frame_1000004962".tr,
                          onTapScreenTitle: () =>
                              onTapScreenTitle(AppRoutes.frame1000004962Screen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "msg_writing_test_question".tr,
                          onTapScreenTitle: () => onTapScreenTitle(
                              AppRoutes.writingTestQuestionScreen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "msg_reading_test_passage".tr,
                          onTapScreenTitle: () => onTapScreenTitle(
                              AppRoutes.readingTestPassageScreen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "msg_reading_test_questions".tr,
                          onTapScreenTitle: () => onTapScreenTitle(
                              AppRoutes.readingTestQuestionsScreen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "msg_reading_test_question".tr,
                          onTapScreenTitle: () => onTapScreenTitle(
                              AppRoutes.readingTestQuestionScreen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "msg_reading_test_questions".tr,
                          onTapScreenTitle: () => onTapScreenTitle(
                              AppRoutes.readingTestQuestions1Screen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "msg_speaking_test".tr,
                          onTapScreenTitle: () => onTapScreenTitle(
                              AppRoutes.speakingTestQuestionScreen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "msg_speaking_test_checking".tr,
                          onTapScreenTitle: () => onTapScreenTitle(
                              AppRoutes.speakingTestCheckingScreen),
                        ),
                        _buildScreenTitle(
                          screenTitle: "msg_listening_test".tr,
                          onTapScreenTitle: () => onTapScreenTitle(
                              AppRoutes.listeningTestOngoingScreen),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildAppNavigation() {
    return Container(
      decoration: AppDecoration.fillWhiteA,
      child: Column(
        children: [
          SizedBox(height: 10.v),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Text(
                "lbl_app_navigation".tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: appTheme.black900,
                  fontSize: 20.fSize,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(height: 10.v),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 20.h),
              child: Text(
                "msg_check_your_app_s".tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: appTheme.blueGray40001,
                  fontSize: 16.fSize,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(height: 5.v),
          Divider(
            height: 1.v,
            thickness: 1.v,
            color: appTheme.black900,
          )
        ],
      ),
    );
  }

  /// Common click event for bottomsheet
  void onTapBottomSheetTitle(
    BuildContext context,
    Widget className,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return className;
      },
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  /// Common widget
  Widget _buildScreenTitle({
    required String screenTitle,
    Function? onTapScreenTitle,
  }) {
    return GestureDetector(
      onTap: () {
        onTapScreenTitle?.call();
      },
      child: Container(
        decoration: AppDecoration.fillWhiteA,
        child: Column(
          children: [
            SizedBox(height: 10.v),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: Text(
                  screenTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: appTheme.black900,
                    fontSize: 20.fSize,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.v),
            SizedBox(height: 5.v),
            Divider(
              height: 1.v,
              thickness: 1.v,
              color: appTheme.blueGray40001,
            )
          ],
        ),
      ),
    );
  }

  /// Common click event
  void onTapScreenTitle(String routeName) {
    Get.toNamed(routeName);
  }
}
