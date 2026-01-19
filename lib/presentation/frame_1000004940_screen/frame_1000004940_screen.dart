import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_iconbutton.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_icon_button.dart';
import 'controller/frame_1000004940_controller.dart'; // ignore_for_file: must_be_immutable

class Frame1000004940Screen extends GetWidget<Frame1000004940Controller> {
  const Frame1000004940Screen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(vertical: 24.v),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 395.v,
                  width: double.maxFinite,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: 182.adaptSize,
                          width: 182.adaptSize,
                          child: CircularProgressIndicator(
                            value: 0.5,
                            backgroundColor: theme
                                .colorScheme.onPrimaryContainer
                                .withOpacity(1),
                            color: theme.colorScheme.onPrimaryContainer
                                .withOpacity(1),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: 277.adaptSize,
                          width: 277.adaptSize,
                          child: CircularProgressIndicator(
                            value: 0.5,
                            backgroundColor:
                                theme.colorScheme.onPrimaryContainer,
                            color: theme.colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ),
                      // Align(
                      //   alignment: Alignment.center,
                      //   child: SizedBox(
                      //     height: 395.v,
                      //     width: double.maxFinite,
                      //     child: CircularProgressIndicator(
                      //       value: 0.5,
                      //       backgroundColor: theme.colorScheme.onPrimaryContainer
                      //           .withOpacity(0.46),
                      //       color: theme.colorScheme.onPrimaryContainer
                      //           .withOpacity(0.46),
                      //     ),
                      //   ),
                      // ),
                      // Opacity(
                      //   opacity: 0.5,
                      //   child: Align(
                      //     // alignment: Alignment.bottomRight,
                      //     child: Container(
                      //       height: 114.adaptSize,
                      //       width: 114.adaptSize,
                      //       margin: EdgeInsets.only(
                      //         right: 107.h,
                      //         bottom: 114.v,
                      //       ),
                      //       decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(
                      //           57.h,
                      //         ),
                      //         gradient: LinearGradient(
                      //           begin: Alignment(0.5, 0),
                      //           end: Alignment(0.5, 1),
                      //           colors: [
                      //             appTheme.blue60001.withOpacity(0.53),
                      //             appTheme.blue80003.withOpacity(0.53)
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      CustomImageView(
                        imagePath: ImageConstant.imgEllipse32125x125,
                        height: 125.adaptSize,
                        width: 125.adaptSize,
                        radius: BorderRadius.circular(
                          62.h,
                        ),
                        alignment: Alignment.center,
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "lbl_arathy_krishnan".tr,
                        style: CustomTextStyles.titleMediumBluegray80018,
                      ),
                      SizedBox(height: 6.v),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.imgClose,
                            height: 18.adaptSize,
                            width: 18.adaptSize,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 4.h),
                            child: Text(
                              "lbl_online".tr,
                              style:
                                  CustomTextStyles.titleSmallBluegray800Medium,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20.v),
                SizedBox(height: 5.v)
              ],
            ),
          ),
        ),
        bottomNavigationBar: _buildCallControls(),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      height: 65.v,
      leadingWidth: 40.h,
      leading: AppbarLeadingIconbutton(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.only(
          left: 16.h,
          top: 16.v,
          bottom: 16.v,
        ),
        onTap: () {
          onTapArrowleftone();
        },
      ),
      title: AppbarSubtitle(
        text: "lbl_find_a_mentor3".tr,
        margin: EdgeInsets.only(left: 8.h),
      ),
    );
  }

  /// Section Widget
  Widget _buildCallControls() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.h),
      padding: EdgeInsets.all(5.h),
      decoration: AppDecoration.outlineBluegray50.copyWith(
        borderRadius: BorderRadiusStyle.circleBorder21,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 18.v),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 42.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomIconButton(
                  height: 56.adaptSize,
                  width: 56.adaptSize,
                  padding: EdgeInsets.all(12.h),
                  decoration: IconButtonStyleHelper.outlineGray,
                  child: CustomImageView(
                    imagePath: ImageConstant.imgChatteardropdots,
                  ),
                ),
                Spacer(
                  flex: 50,
                ),
                CustomIconButton(
                  height: 56.adaptSize,
                  width: 56.adaptSize,
                  padding: EdgeInsets.all(18.h),
                  decoration: IconButtonStyleHelper.outlineGrayTL25,
                  child: CustomImageView(
                    imagePath: ImageConstant.imgMicrophone,
                  ),
                ),
                Spacer(
                  flex: 50,
                ),
                CustomIconButton(
                  height: 56.adaptSize,
                  width: 56.adaptSize,
                  padding: EdgeInsets.all(12.h),
                  decoration: IconButtonStyleHelper.outlineGrayTL25,
                  child: CustomImageView(
                    imagePath: ImageConstant.imgVideocameraBlue80003,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 24.v),
          CustomElevatedButton(
            height: 47.v,
            text: "lbl_start_call".tr,
            buttonStyle: CustomButtonStyles.none,
            decoration: CustomButtonStyles.gradientBlueToBlueTL16Decoration,
            buttonTextStyle: CustomTextStyles.titleMediumWhiteA700,
            onPressed: () {
              onTapStartcall();
            },
          )
        ],
      ),
    );
  }

  /// Navigates to the previous screen.
  onTapArrowleftone() {
    Get.back();
  }

  /// Navigates to the frame1000004949Screen when the action is triggered.
  onTapStartcall() {
    Get.toNamed(
      AppRoutes.frame1000004949Screen,
    );
  }
}
