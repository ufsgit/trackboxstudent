import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_image_one.dart';
import '../../widgets/app_bar/appbar_subtitle_one.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/custom_outlined_button.dart';
import 'controller/speaking_test_checking_controller.dart'; // ignore_for_file: must_be_immutable

class SpeakingTestCheckingScreen
    extends GetWidget<SpeakingTestCheckingController> {
  const SpeakingTestCheckingScreen({Key? key})
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
          padding: EdgeInsets.symmetric(vertical: 6.v),
          child: Column(
            children: [
              SizedBox(height: 42.v),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 5.v),
                    padding: EdgeInsets.symmetric(horizontal: 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "lbl_question".tr,
                                style: CustomTextStyles.bodyMediumBluegray500,
                              ),
                              TextSpan(
                                text: "  ".tr,
                              ),
                              TextSpan(
                                text: "lbl_1".tr,
                                style: CustomTextStyles.titleSmallMedium_2,
                              ),
                              TextSpan(
                                text: "lbl_50".tr,
                                style: CustomTextStyles
                                    .titleSmallBluegray500Medium_1,
                              )
                            ],
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: 13.v),
                        SizedBox(
                          width: 328.h,
                          child: Text(
                            "msg_introduce_yourself".tr,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: CustomTextStyles.titleSmallMedium_4.copyWith(
                              height: 1.43,
                            ),
                          ),
                        ),
                        SizedBox(height: 34.v),
                        _buildQuestionSection(),
                        SizedBox(height: 29.v),
                        _buildQrCodeRow()
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: _buildNextButton(),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      height: 56.v,
      leadingWidth: 36.h,
      leading: AppbarLeadingImageOne(
        imagePath: ImageConstant.imgArrowLeftBlack900,
        margin: EdgeInsets.only(
          left: 16.h,
          top: 17.v,
          bottom: 18.v,
        ),
        onTap: () {
          onTapArrowleftone();
        },
      ),
      title: AppbarSubtitleOne(
        text: "lbl_speaking_test".tr,
        margin: EdgeInsets.only(left: 16.h),
      ),
    );
  }

  /// Section Widget
  Widget _buildQuestionSection() {
    return SizedBox(
      height: 327.adaptSize,
      width: 327.adaptSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 327.adaptSize,
              width: 327.adaptSize,
              child: CircularProgressIndicator(
                value: 0.5,
                backgroundColor: appTheme.blue20075,
                color: appTheme.blue20075,
              ),
            ),
          ),
          CustomIconButton(
            height: 229.adaptSize,
            width: 229.adaptSize,
            padding: EdgeInsets.all(62.h),
            alignment: Alignment.center,
            child: CustomImageView(
              imagePath: ImageConstant.imgGroup532,
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildQrCodeRow() {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 7.v,
            bottom: 5.v,
          ),
          child: _buildQrCodeStack(
            rotationAngle: "lbl_10".tr,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 17.h),
          child: CustomIconButton(
            height: 36.adaptSize,
            width: 36.adaptSize,
            padding: EdgeInsets.all(11.h),
            decoration: IconButtonStyleHelper.gradientBlueToBlueTL18,
            child: CustomImageView(
              imagePath: ImageConstant.imgPlaySvgrepoCom,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 17.h,
            top: 7.v,
            bottom: 5.v,
          ),
          child: _buildQrCodeStack(
            rotationAngle: "lbl_10".tr,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 25.h,
            top: 3.v,
            bottom: 4.v,
          ),
          child: Column(
            children: [
              Slider(
                value: 0.0,
                min: 0.0,
                max: 100.0,
                onChanged: (value) {},
              ),
              SizedBox(height: 2.v),
              SizedBox(
                width: 134.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "lbl_05_36".tr,
                      style: CustomTextStyles.bodySmallBlack900_1,
                    ),
                    Text(
                      "lbl_08_22".tr,
                      style: CustomTextStyles.bodySmallBlack900_1,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 24.h,
            top: 9.v,
            bottom: 8.v,
          ),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "lbl_1_02".tr,
                  style: CustomTextStyles.titleSmallBlack900,
                ),
                TextSpan(
                  text: "lbl_x".tr,
                  style: CustomTextStyles.labelLargeInterBlack900Bold,
                )
              ],
            ),
            textAlign: TextAlign.left,
          ),
        )
      ],
    );
  }

  /// Section Widget
  Widget _buildNextButton() {
    return CustomOutlinedButton(
      text: "lbl_next".tr,
      margin: EdgeInsets.only(
        left: 16.h,
        right: 16.h,
        bottom: 48.v,
      ),
      buttonStyle: CustomButtonStyles.outlineBlue,
    );
  }

  /// Common widget
  Widget _buildQrCodeStack({required String rotationAngle}) {
    return SizedBox(
      height: 22.v,
      width: 21.h,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgQrcode,
            height: 20.adaptSize,
            width: 20.adaptSize,
            alignment: Alignment.topCenter,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              rotationAngle,
              style: CustomTextStyles.labelMediumBlack900.copyWith(
                color: appTheme.black900,
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Navigates to the previous screen.
  onTapArrowleftone() {
    Get.back();
  }
}
