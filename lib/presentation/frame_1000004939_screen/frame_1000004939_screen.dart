import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_iconbutton.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_icon_button.dart';
import 'controller/frame_1000004939_controller.dart'; // ignore_for_file: must_be_immutable

class Frame1000004939Screen extends GetWidget<Frame1000004939Controller> {
  const Frame1000004939Screen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: Container(
          height: 715.v,
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(vertical: 52.v),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 237.adaptSize,
                  width: 237.adaptSize,
                  child: CircularProgressIndicator(
                    value: 0.5,
                    backgroundColor:
                        theme.colorScheme.onPrimaryContainer.withOpacity(1),
                    color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 361.v,
                  width: double.maxFinite,
                  child: CircularProgressIndicator(
                    value: 0.5,
                    backgroundColor: theme.colorScheme.onPrimaryContainer,
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 514.v,
                  width: double.maxFinite,
                  child: CircularProgressIndicator(
                    value: 0.5,
                    backgroundColor:
                        theme.colorScheme.onPrimaryContainer.withOpacity(0.46),
                    color:
                        theme.colorScheme.onPrimaryContainer.withOpacity(0.46),
                  ),
                ),
              ),
              Opacity(
                opacity: 0.5,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 148.adaptSize,
                    width: 148.adaptSize,
                    margin: EdgeInsets.only(
                      right: 86.h,
                      bottom: 197.v,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        74.h,
                      ),
                      gradient: LinearGradient(
                        begin: Alignment(0.5, 0),
                        end: Alignment(0.5, 1),
                        colors: [
                          appTheme.blue60001.withOpacity(0.53),
                          appTheme.blue80003.withOpacity(0.53)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              CustomImageView(
                imagePath: ImageConstant.imgEllipse32163x163,
                height: 163.adaptSize,
                width: 163.adaptSize,
                radius: BorderRadius.circular(
                  81.h,
                ),
                alignment: Alignment.center,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    onTapRowphoneone();
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(54.h, 522.v, 54.h, 5.v),
                    padding: EdgeInsets.all(10.h),
                    decoration: AppDecoration.fillWhiteA.copyWith(
                      borderRadius: BorderRadiusStyle.circleBorder38,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomIconButton(
                          height: 56.adaptSize,
                          width: 56.adaptSize,
                          padding: EdgeInsets.all(15.h),
                          decoration: IconButtonStyleHelper.fillGray,
                          child: CustomImageView(
                            imagePath: ImageConstant.imgPhoneBlack900,
                          ),
                        ),
                        Spacer(
                          flex: 50,
                        ),
                        CustomIconButton(
                          height: 56.adaptSize,
                          width: 56.adaptSize,
                          padding: EdgeInsets.all(12.h),
                          decoration: IconButtonStyleHelper.fillGray,
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
                          padding: EdgeInsets.all(12.h),
                          decoration: IconButtonStyleHelper.fillGray,
                          child: CustomImageView(
                            imagePath: ImageConstant.imgVideocamera,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 91.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "lbl_arathy_krishnan".tr,
                        style: CustomTextStyles.headlineSmallBluegray800,
                      ),
                      SizedBox(height: 9.v),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 26.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomImageView(
                              imagePath: ImageConstant.imgClose,
                              height: 18.adaptSize,
                              width: 18.adaptSize,
                              margin: EdgeInsets.only(bottom: 2.v),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 4.h),
                              child: Text(
                                "lbl_available_now".tr,
                                style: CustomTextStyles
                                    .titleMediumBluegray800Medium,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
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

  /// Navigates to the previous screen.
  onTapArrowleftone() {
    Get.back();
  }

  /// Navigates to the frame1000004940Screen when the action is triggered.
  onTapRowphoneone() {
    Get.toNamed(
      AppRoutes.frame1000004940Screen,
    );
  }
}
