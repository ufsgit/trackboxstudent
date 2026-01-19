import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_iconbutton.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_outlined_button.dart';
import 'controller/writing_test_question_controller.dart'; // ignore_for_file: must_be_immutable

class WritingTestQuestionScreen
    extends GetWidget<WritingTestQuestionController> {
  const WritingTestQuestionScreen({Key? key})
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
          padding: EdgeInsets.symmetric(vertical: 16.v),
          child: Column(
            children: [
              SizedBox(height: 20.v),
              Expanded(
                child: SingleChildScrollView(
                  child: _buildWritingTestSection(),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: _buildStartNowButton(),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      leadingWidth: double.maxFinite,
      leading: AppbarLeadingIconbutton(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.only(
          left: 16.h,
          right: 320.h,
        ),
        onTap: () {
          onTapArrowleftone();
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildWritingTestSection() {
    return Container(
      margin: EdgeInsets.only(bottom: 5.v),
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "msg_writing_mock_test".tr,
            style: CustomTextStyles.titleMediumBluegray8000118,
          ),
          SizedBox(height: 23.v),
          Padding(
            padding: EdgeInsets.only(right: 20.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgFrame2147223522,
                  height: 13.v,
                  width: 4.h,
                  margin: EdgeInsets.only(bottom: 29.v),
                ),
                Expanded(
                  child: Container(
                    width: 295.h,
                    margin: EdgeInsets.only(left: 8.h),
                    child: Text(
                      "msg_you_have_30_minutes".tr,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: CustomTextStyles.titleSmallBluegray80001.copyWith(
                        height: 1.43,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 9.v),
          Padding(
            padding: EdgeInsets.only(right: 27.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgFrame2147223522,
                  height: 13.v,
                  width: 4.h,
                  margin: EdgeInsets.only(bottom: 49.v),
                ),
                Expanded(
                  child: Container(
                    width: 288.h,
                    margin: EdgeInsets.only(left: 8.h),
                    child: Text(
                      "msg_in_the_first_tab".tr,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: CustomTextStyles.titleSmallBluegray80001.copyWith(
                        height: 1.43,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 9.v),
          Padding(
            padding: EdgeInsets.only(right: 8.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgFrame2147223522,
                  height: 13.v,
                  width: 4.h,
                  margin: EdgeInsets.only(bottom: 29.v),
                ),
                Expanded(
                  child: Container(
                    width: 307.h,
                    margin: EdgeInsets.only(left: 8.h),
                    child: Text(
                      "msg_in_the_second_tab".tr,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: CustomTextStyles.titleSmallBluegray80001.copyWith(
                        height: 1.43,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 9.v),
          Padding(
            padding: EdgeInsets.only(right: 18.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgFrame2147223522,
                  height: 13.v,
                  width: 4.h,
                  margin: EdgeInsets.only(bottom: 29.v),
                ),
                Expanded(
                  child: Container(
                    width: 297.h,
                    margin: EdgeInsets.only(left: 8.h),
                    child: Text(
                      "msg_you_can_switch_between".tr,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: CustomTextStyles.titleSmallBluegray80001.copyWith(
                        height: 1.43,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 9.v),
          Padding(
            padding: EdgeInsets.only(right: 35.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgFrame2147223522,
                  height: 13.v,
                  width: 4.h,
                  margin: EdgeInsets.only(bottom: 28.v),
                ),
                Expanded(
                  child: Container(
                    width: 280.h,
                    margin: EdgeInsets.only(left: 8.h),
                    child: Text(
                      "msg_when_you_re_finished".tr,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: CustomTextStyles.titleSmallBluegray80001.copyWith(
                        height: 1.43,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 10.v),
          Padding(
            padding: EdgeInsets.only(right: 16.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgFrame2147223522,
                  height: 13.v,
                  width: 4.h,
                  margin: EdgeInsets.only(bottom: 28.v),
                ),
                Expanded(
                  child: Container(
                    width: 299.h,
                    margin: EdgeInsets.only(left: 8.h),
                    child: Text(
                      "msg_note_that_you_won_t".tr,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: CustomTextStyles.titleSmallBluegray80001.copyWith(
                        height: 1.43,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildStartNowButton() {
    return CustomOutlinedButton(
      text: "lbl_start_now".tr,
      margin: EdgeInsets.only(
        left: 16.h,
        right: 16.h,
        bottom: 48.v,
      ),
      buttonStyle: CustomButtonStyles.outlineBlue,
    );
  }

  /// Navigates to the previous screen.
  onTapArrowleftone() {
    Get.back();
  }
}
