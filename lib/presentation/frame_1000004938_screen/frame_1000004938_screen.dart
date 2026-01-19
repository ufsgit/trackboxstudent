import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_iconbutton.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import 'controller/frame_1000004938_controller.dart'; // ignore_for_file: must_be_immutable

class Frame1000004938Screen extends GetWidget<Frame1000004938Controller> {
  const Frame1000004938Screen({Key? key})
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
          padding: EdgeInsets.symmetric(vertical: 51.v),
          child: Column(
            children: [
              SizedBox(
                height: 514.v,
                width: double.maxFinite,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 163.adaptSize,
                        width: 163.adaptSize,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            81.h,
                          ),
                          gradient: LinearGradient(
                            begin: Alignment(0.5, 0),
                            end: Alignment(0.5, 1),
                            colors: [appTheme.blue60001, appTheme.blue80003],
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 237.adaptSize,
                        width: 237.adaptSize,
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
                      alignment: Alignment.bottomRight,
                      child: Container(
                        height: 148.adaptSize,
                        width: 148.adaptSize,
                        margin: EdgeInsets.only(
                          right: 86.h,
                          bottom: 149.v,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            74.h,
                          ),
                          gradient: LinearGradient(
                            begin: Alignment(0.5, 0),
                            end: Alignment(0.5, 1),
                            colors: [appTheme.blue60001, appTheme.blue80003],
                          ),
                        ),
                      ),
                    ),
                    Opacity(
                      opacity: 0.3,
                      child: CustomImageView(
                        imagePath: ImageConstant.imgEllipse31,
                        height: 514.v,
                        width: 360.h,
                        alignment: Alignment.center,
                      ),
                    ),
                    CustomImageView(
                      imagePath: ImageConstant.imgClarityAvatarSolid,
                      height: 143.v,
                      width: 146.h,
                      radius: BorderRadius.circular(
                        71.h,
                      ),
                      alignment: Alignment.center,
                    )
                  ],
                ),
              ),
              SizedBox(height: 17.v),
              Text(
                "msg_finding_mentor_for".tr,
                style: CustomTextStyles.titleMediumBluegray800,
              ),
              SizedBox(height: 5.v)
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
}
