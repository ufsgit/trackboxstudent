import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_iconbutton.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import 'controller/frame_1000004949_controller.dart'; // ignore_for_file: must_be_immutable

class Frame1000004949Screen extends GetWidget<Frame1000004949Controller> {
  const Frame1000004949Screen({Key? key})
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
                          backgroundColor: theme.colorScheme.onPrimaryContainer
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
                          backgroundColor: theme.colorScheme.onPrimaryContainer,
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 395.v,
                        width: double.maxFinite,
                        child: CircularProgressIndicator(
                          value: 0.5,
                          backgroundColor: theme.colorScheme.onPrimaryContainer
                              .withOpacity(0.46),
                          color: theme.colorScheme.onPrimaryContainer
                              .withOpacity(0.46),
                        ),
                      ),
                    ),
                    Opacity(
                      opacity: 0.5,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          height: 114.adaptSize,
                          width: 114.adaptSize,
                          margin: EdgeInsets.only(
                            right: 107.h,
                            bottom: 114.v,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              57.h,
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
                      imagePath: ImageConstant.imgEllipse32125x125,
                      height: 125.adaptSize,
                      width: 125.adaptSize,
                      radius: BorderRadius.circular(
                        62.h,
                      ),
                      alignment: Alignment.center,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 112.h,
                          right: 112.h,
                          bottom: 27.v,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "lbl_arathy_krishnan".tr,
                              style: CustomTextStyles.titleMediumBluegray80018,
                            ),
                            SizedBox(height: 7.v),
                            Text(
                              "lbl_calling".tr,
                              style:
                                  CustomTextStyles.titleMediumBluegray800Medium,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Spacer(),
              CustomImageView(
                imagePath: ImageConstant.imgFrame1000004943,
                height: 56.v,
                width: 240.h,
              ),
              SizedBox(height: 24.v),
              CustomImageView(
                imagePath: ImageConstant.imgFrame2609034,
                height: 47.v,
                width: 324.h,
                radius: BorderRadius.circular(
                  16.h,
                ),
              ),
              SizedBox(height: 27.v)
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
      leadingWidth: double.maxFinite,
      leading: AppbarLeadingIconbutton(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.fromLTRB(16.h, 16.v, 320.h, 16.v),
        onTap: () {
          onTapArrowleftone();
        },
      ),
    );
  }

  /// Navigates to the previous screen.
  onTapArrowleftone() {
    Get.back();
  }
}
