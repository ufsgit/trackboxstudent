import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_outlined_button.dart';
import '../../widgets/custom_radio_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'controller/listening_test_ongoing_controller.dart'; // ignore_for_file: must_be_immutable

class ListeningTestOngoingScreen
    extends GetWidget<ListeningTestOngoingController> {
  const ListeningTestOngoingScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              SizedBox(height: 16.v),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildNavigationRow(),
                      SizedBox(height: 10.v),
                      _buildProgressStack(),
                      SizedBox(height: 14.v),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 16.h),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "lbl_question2".tr,
                                  style: CustomTextStyles.titleSmallBluegray500,
                                ),
                                TextSpan(
                                  text: "lbl_1_50".tr,
                                  style: CustomTextStyles.titleSmallMedium,
                                )
                              ],
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      SizedBox(height: 11.v),
                      Container(
                        width: 310.h,
                        margin: EdgeInsets.only(
                          left: 16.h,
                          right: 33.h,
                        ),
                        child: Text(
                          "msg_what_is_the_name".tr,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleMedium!.copyWith(
                            height: 1.50,
                          ),
                        ),
                      ),
                      SizedBox(height: 21.v),
                      _buildAnswerInput(),
                      SizedBox(height: 33.v),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 16.h),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "lbl_question2".tr,
                                  style: CustomTextStyles.titleSmallBluegray500,
                                ),
                                TextSpan(
                                  text: "lbl_2_50".tr,
                                  style: CustomTextStyles.titleSmallMedium,
                                )
                              ],
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      SizedBox(height: 11.v),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: 262.h,
                          margin: EdgeInsets.only(
                            left: 16.h,
                            right: 81.h,
                          ),
                          child: Text(
                            "msg_what_is_the_main2".tr,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.titleMedium!.copyWith(
                              height: 1.50,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 21.v),
                      _buildQuestionRadioGroup(),
                      SizedBox(height: 29.v),
                      _buildContrastStack(),
                      SizedBox(height: 8.v),
                      _buildSummaryStack()
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
  Widget _buildNavigationRow() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgArrowLeftBlack900,
            height: 20.adaptSize,
            width: 20.adaptSize,
            onTap: () {
              onTapImgArrowleftone();
            },
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 16.h,
              top: 3.v,
            ),
            child: Text(
              "lbl_listening_test".tr,
              style: CustomTextStyles.titleSmallBlack900Medium,
            ),
          ),
          Spacer(),
          CustomImageView(
            imagePath: ImageConstant.imgClockBlack900,
            height: 18.v,
            width: 16.h,
            margin: EdgeInsets.only(bottom: 2.v),
          ),
          Padding(
            padding: EdgeInsets.only(left: 4.h),
            child: Text(
              "lbl_29_00".tr,
              style: CustomTextStyles.bodyMediumBlack900,
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildProgressStack() {
    return SizedBox(
      height: 27.v,
      width: 329.h,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              height: 12.adaptSize,
              width: 12.adaptSize,
              margin: EdgeInsets.only(left: 122.h),
              decoration: BoxDecoration(
                color: appTheme.blue60002,
                borderRadius: BorderRadius.circular(
                  6.h,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgLine267,
                  height: 4.v,
                  width: 199.h,
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(right: 1.h),
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgLine268,
                  height: 4.v,
                  width: 127.h,
                ),
                SizedBox(height: 4.v),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "lbl_05_36".tr,
                      style: CustomTextStyles.bodySmallBlack900_1,
                    ),
                    Text(
                      "lbl_07_44".tr,
                      style: CustomTextStyles.bodySmallBlack900_1,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildAnswerInput() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: CustomTextFormField(
        controller: controller.answerInputController,
        hintText: "lbl_enter_here".tr,
        textInputAction: TextInputAction.done,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20.h,
          vertical: 12.v,
        ),
        borderDecoration: TextFormFieldStyleHelper.outlineOnErrorContainerTL12,
      ),
    );
  }

  /// Section Widget
  Widget _buildQuestionRadioGroup() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: Obx(
        () => Column(
          children: [
            CustomRadioButton(
              text: "msg_it_significantly".tr,
              value: controller
                  .listeningTestOngoingModelObj.value.radioList.value[0],
              groupValue: controller.questionRadioGroup.value,
              padding: EdgeInsets.fromLTRB(12.h, 8.v, 30.h, 8.v),
              onChange: (value) {
                controller.questionRadioGroup.value = value;
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.v),
              child: CustomRadioButton(
                text: "msg_it_increases_blood".tr,
                value: controller
                    .listeningTestOngoingModelObj.value.radioList.value[1],
                groupValue: controller.questionRadioGroup.value,
                padding: EdgeInsets.fromLTRB(12.h, 10.v, 30.h, 10.v),
                onChange: (value) {
                  controller.questionRadioGroup.value = value;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.v),
              child: CustomRadioButton(
                text: "msg_it_has_no_effect".tr,
                value: controller
                    .listeningTestOngoingModelObj.value.radioList.value[2],
                groupValue: controller.questionRadioGroup.value,
                padding: EdgeInsets.fromLTRB(12.h, 10.v, 22.h, 10.v),
                onChange: (value) {
                  controller.questionRadioGroup.value = value;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.v),
              child: CustomRadioButton(
                text: "msg_it_varies_depending".tr,
                value: controller
                    .listeningTestOngoingModelObj.value.radioList.value[3],
                groupValue: controller.questionRadioGroup.value,
                padding: EdgeInsets.fromLTRB(12.h, 8.v, 30.h, 8.v),
                onChange: (value) {
                  controller.questionRadioGroup.value = value;
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildNextButton() {
    return CustomOutlinedButton(
      text: "lbl_next".tr,
      buttonStyle: CustomButtonStyles.outlineBlueTL12,
    );
  }

  /// Section Widget
  Widget _buildContrastStack() {
    return SizedBox(
      height: 187.v,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: 141.v,
              width: double.maxFinite,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 16.h,
                        top: 4.v,
                        right: 81.h,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "lbl_question2".tr,
                                  style: CustomTextStyles.titleSmallBluegray500,
                                ),
                                TextSpan(
                                  text: "lbl_2_50".tr,
                                  style: CustomTextStyles.titleSmallMedium,
                                )
                              ],
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(height: 11.v),
                          SizedBox(
                            width: 262.h,
                            child: Text(
                              "msg_what_is_the_main2".tr,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleMedium!.copyWith(
                                height: 1.50,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.h,
                        vertical: 48.v,
                      ),
                      decoration: AppDecoration.gradientGrayToGray,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [SizedBox(height: 5.v), _buildNextButton()],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 16.h,
              top: 127.v,
              right: 16.h,
            ),
            child: _buildNoEffectRow(
              contrastThree: ImageConstant.imgContrastBlue800,
              ithasnoOne: "msg_it_significantly".tr,
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildIncreaseButton() {
    return CustomElevatedButton(
      height: 44.v,
      width: 328.h,
      text: "msg_it_increases_blood".tr,
      leftIcon: Container(
        margin: EdgeInsets.only(right: 12.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgContrast,
          height: 24.adaptSize,
          width: 24.adaptSize,
        ),
      ),
      buttonStyle: CustomButtonStyles.fillWhiteA,
      buttonTextStyle: theme.textTheme.bodyMedium!,
      alignment: Alignment.topCenter,
    );
  }

  /// Section Widget
  Widget _buildNextButton1() {
    return CustomOutlinedButton(
      text: "lbl_next".tr,
      buttonStyle: CustomButtonStyles.outlineBlueTL12,
    );
  }

  /// Section Widget
  Widget _buildSummaryStack() {
    return SizedBox(
      height: 164.v,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          _buildIncreaseButton(),
          Padding(
            padding: EdgeInsets.fromLTRB(16.h, 52.v, 16.h, 68.v),
            child: _buildNoEffectRow(
              contrastThree: ImageConstant.imgContrast,
              ithasnoOne: "msg_it_has_no_effect".tr,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 16.h,
              top: 104.v,
              right: 16.h,
            ),
            child: _buildNoEffectRow(
              contrastThree: ImageConstant.imgContrast,
              ithasnoOne: "msg_it_varies_depending".tr,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.h,
                vertical: 48.v,
              ),
              decoration: AppDecoration.gradientGrayToGray,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [SizedBox(height: 28.v), _buildNextButton1()],
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildNoEffectRow({
    required String contrastThree,
    required String ithasnoOne,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8.h,
        vertical: 10.v,
      ),
      decoration: AppDecoration.fillWhiteA.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageView(
            imagePath: contrastThree,
            height: 24.adaptSize,
            width: 24.adaptSize,
          ),
          Padding(
            padding: EdgeInsets.only(left: 12.h),
            child: Text(
              ithasnoOne,
              style: theme.textTheme.bodyMedium!.copyWith(
                color: appTheme.blueGray80003,
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Navigates to the previous screen.
  onTapImgArrowleftone() {
    Get.back();
  }
}
