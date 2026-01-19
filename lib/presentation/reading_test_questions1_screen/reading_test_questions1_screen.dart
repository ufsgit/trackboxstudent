import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_image_one.dart';
import '../../widgets/app_bar/appbar_subtitle_one.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_outlined_button.dart';
import '../../widgets/custom_radio_button.dart';
import 'controller/reading_test_questions1_controller.dart'; // ignore_for_file: must_be_immutable

class ReadingTestQuestions1Screen
    extends GetWidget<ReadingTestQuestions1Controller> {
  const ReadingTestQuestions1Screen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 22.v),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.v),
                      child: Text(
                        "lbl_passage".tr,
                        style: CustomTextStyles.labelLargeOnError,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 24.h),
                      child: Column(
                        children: [
                          Text(
                            "lbl_questions".tr,
                            style: theme.textTheme.labelLarge,
                          ),
                          SizedBox(height: 8.v),
                          CustomImageView(
                            imagePath: ImageConstant.imgLine266,
                            height: 1.v,
                            width: 24.h,
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 16.v),
                _buildQuestionSection(),
                SizedBox(height: 25.v),
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
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 249.h,
                    margin: EdgeInsets.only(left: 16.h),
                    child: Text(
                      "msg_why_is_effective".tr,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium!.copyWith(
                        height: 1.50,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 29.v),
                _buildRadioOption(),
                SizedBox(height: 8.v),
                _buildQuestionStack()
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      height: 21.v,
      leadingWidth: 36.h,
      leading: AppbarLeadingImageOne(
        imagePath: ImageConstant.imgArrowLeftBlack900,
        margin: EdgeInsets.only(
          left: 16.h,
          bottom: 1.v,
        ),
        onTap: () {
          onTapArrowleftone();
        },
      ),
      title: AppbarSubtitleOne(
        text: "lbl_reading_test".tr,
        margin: EdgeInsets.only(left: 16.h),
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgClockBlack900,
          margin: EdgeInsets.only(
            left: 16.h,
            top: 1.v,
            right: 1.h,
          ),
        ),
        AppbarTitle(
          text: "lbl_29_00".tr,
          margin: EdgeInsets.only(
            left: 4.h,
            top: 1.v,
            right: 17.h,
          ),
        )
      ],
    );
  }

  /// Section Widget
  Widget _buildQuestionSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: Obx(
        () => Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 30.v),
              child: CustomRadioButton(
                text: "msg_the_importance_of".tr,
                value: controller
                    .readingTestQuestions1ModelObj.value.radioList.value[0],
                groupValue: controller.radioGroup.value,
                padding: EdgeInsets.fromLTRB(13.h, 10.v, 12.h, 10.v),
                onChange: (value) {
                  controller.radioGroup.value = value;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.v),
              child: CustomRadioButton(
                text: "msg_the_role_of_effective".tr,
                value: controller
                    .readingTestQuestions1ModelObj.value.radioList.value[1],
                groupValue: controller.radioGroup.value,
                padding: EdgeInsets.fromLTRB(12.h, 7.v, 30.h, 7.v),
                onChange: (value) {
                  controller.radioGroup.value = value;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.v),
              child: CustomRadioButton(
                text: "msg_documentation_requirements".tr,
                value: controller
                    .readingTestQuestions1ModelObj.value.radioList.value[2],
                groupValue: controller.radioGroup.value,
                padding: EdgeInsets.fromLTRB(12.h, 7.v, 30.h, 7.v),
                onChange: (value) {
                  controller.radioGroup.value = value;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.v),
              child: CustomRadioButton(
                text: "msg_strategies_for_managing".tr,
                value: controller
                    .readingTestQuestions1ModelObj.value.radioList.value[3],
                groupValue: controller.radioGroup.value,
                padding: EdgeInsets.fromLTRB(12.h, 8.v, 8.h, 8.v),
                onChange: (value) {
                  controller.radioGroup.value = value;
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildRadioOption() {
    return Obx(
      () => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        child: CustomRadioButton(
          text: "msg_to_increase_healthcare".tr,
          value: "msg_to_increase_healthcare".tr,
          groupValue: controller.radioGroup1.value,
          padding: EdgeInsets.fromLTRB(12.h, 12.v, 30.h, 12.v),
          onChange: (value) {
            controller.radioGroup1.value = value;
          },
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildQuestionStack() {
    return SizedBox(
      height: 191.v,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Obx(
              () => CustomRadioButton(
                text: "msg_to_prevent_errors".tr,
                value: "msg_to_prevent_errors".tr,
                groupValue: controller.radioGroup2.value,
                padding: EdgeInsets.fromLTRB(12.h, 8.v, 30.h, 8.v),
                onChange: (value) {
                  controller.radioGroup2.value = value;
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 141.v,
              width: double.maxFinite,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16.h, 18.v, 16.h, 11.v),
                      child: Obx(
                        () => Column(
                          children: [
                            CustomRadioButton(
                              text: "msg_to_assert_authority".tr,
                              value: controller.readingTestQuestions1ModelObj
                                  .value.radioList1.value[0],
                              groupValue: controller.radioGroup3.value,
                              padding:
                                  EdgeInsets.fromLTRB(12.h, 10.v, 30.h, 10.v),
                              onChange: (value) {
                                controller.radioGroup3.value = value;
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 8.v),
                              child: CustomRadioButton(
                                text: "msg_to_minimize_patient".tr,
                                value: controller.readingTestQuestions1ModelObj
                                    .value.radioList1.value[1],
                                groupValue: controller.radioGroup3.value,
                                padding:
                                    EdgeInsets.fromLTRB(12.h, 10.v, 8.h, 10.v),
                                onChange: (value) {
                                  controller.radioGroup3.value = value;
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.symmetric(vertical: 48.v),
                      decoration: AppDecoration.gradientGrayToGray,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: CustomOutlinedButton(
                              text: "lbl_previous".tr,
                              margin: EdgeInsets.only(
                                top: 5.v,
                                right: 8.h,
                              ),
                              buttonStyle: CustomButtonStyles.outlineBlueTL121,
                              buttonTextStyle:
                                  CustomTextStyles.titleSmallBlue800,
                            ),
                          ),
                          Expanded(
                            child: CustomOutlinedButton(
                              text: "lbl_next".tr,
                              margin: EdgeInsets.only(
                                left: 8.h,
                                top: 5.v,
                              ),
                              buttonStyle: CustomButtonStyles.outlineBlueTL12,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
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
