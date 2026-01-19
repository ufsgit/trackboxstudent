import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'controller/breffini_controller.dart'; // ignore_for_file: must_be_immutable

class BreffiniScreen extends GetWidget<BreffiniController> {
  const BreffiniScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: appTheme.whiteA700,
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              _buildImageSection(),
              SizedBox(height: 29.v),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 16.h),
                  child: Text(
                    "msg_how_can_i_help".tr,
                    style: theme.textTheme.headlineSmall,
                  ),
                ),
              ),
              SizedBox(height: 12.v),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.h),
                child: _buildCourseSearch(
                  helpmetofind: "msg_find_me_a_good_tutor".tr,
                ),
              ),
              SizedBox(height: 4.v),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.h),
                child: _buildCourseSearch(
                  helpmetofind: "msg_help_me_to_find".tr,
                ),
              ),
              SizedBox(height: 4.v),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.h),
                child: _buildCourseSearch(
                  helpmetofind: "msg_suggest_some_online".tr,
                ),
              ),
              Spacer(),
              SizedBox(height: 15.v),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 20.h),
                  child: Row(
                    children: [
                      Container(
                        height: 42.adaptSize,
                        width: 42.adaptSize,
                        decoration: AppDecoration.fillBlue.copyWith(
                          borderRadius: BorderRadiusStyle.circleBorder21,
                        ),
                        child: CustomImageView(
                          imagePath: ImageConstant.imgImage2241x41,
                          height: 41.adaptSize,
                          width: 41.adaptSize,
                          alignment: Alignment.center,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 4.h),
                        padding: EdgeInsets.symmetric(
                          horizontal: 18.h,
                          vertical: 9.v,
                        ),
                        decoration: AppDecoration.fillIndigo.copyWith(
                          borderRadius: BorderRadiusStyle.customBorderBL21,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 4.v),
                            Text(
                              "msg_how_i_can_help_you".tr,
                              style: CustomTextStyles.titleSmallMedium_4,
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
        bottomNavigationBar: _buildAskAnything(),
      ),
    );
  }

  /// Section Widget
  Widget _buildImageSection() {
    return SizedBox(
      height: 231.v,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 231.v,
              width: double.maxFinite,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgRectangle27231x360,
                    height: 231.v,
                    width: 360.h,
                    radius: BorderRadius.vertical(
                      bottom: Radius.circular(24.h),
                    ),
                    alignment: Alignment.center,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 220.v,
                      width: double.maxFinite,
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.imgVector19,
                            height: 16.v,
                            width: 360.h,
                            alignment: Alignment.bottomCenter,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: SizedBox(
                              height: 220.v,
                              width: 198.h,
                              child: Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  CustomImageView(
                                    imagePath: ImageConstant.imgImage29220x198,
                                    height: 220.v,
                                    width: 198.h,
                                    alignment: Alignment.center,
                                  ),
                                  CustomImageView(
                                    imagePath: ImageConstant.imgImage27218x109,
                                    height: 218.v,
                                    width: 109.h,
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.only(left: 28.h),
                                  )
                                ],
                              ),
                            ),
                          ),
                          CustomImageView(
                            imagePath: ImageConstant.imgEllipse13BlueGray10001,
                            height: 45.v,
                            width: 360.h,
                            alignment: Alignment.bottomCenter,
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              width: 120.h,
                              margin: EdgeInsets.only(
                                right: 32.h,
                                bottom: 28.v,
                              ),
                              child: Text(
                                "msg_hi_there_i_m2".tr,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: CustomTextStyles.headlineSmallWhiteA700
                                    .copyWith(
                                  height: 1.52,
                                ),
                              ),
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
          CustomImageView(
            imagePath: ImageConstant.imgVector20,
            height: 48.v,
            width: 360.h,
            alignment: Alignment.topCenter,
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildAskAnything() {
    return Padding(
      padding: EdgeInsets.only(
        left: 16.h,
        right: 16.h,
        bottom: 19.v,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: CustomTextFormField(
              controller: controller.askanythingoneController,
              hintText: "lbl_ask_me_anything".tr,
              textInputAction: TextInputAction.done,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 4.h),
            child: CustomIconButton(
              height: 40.adaptSize,
              width: 40.adaptSize,
              padding: EdgeInsets.all(8.h),
              decoration: IconButtonStyleHelper.outlineWhiteA,
              child: CustomImageView(
                imagePath: ImageConstant.imgPaperplaneright,
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildCourseSearch({required String helpmetofind}) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.h,
        vertical: 10.v,
      ),
      decoration: AppDecoration.fillGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 4.v),
            child: Text(
              helpmetofind,
              style: CustomTextStyles.titleSmallMedium_3.copyWith(
                color: appTheme.blueGray80003,
              ),
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgArrowRightGray10002,
            height: 20.adaptSize,
            width: 20.adaptSize,
            margin: EdgeInsets.only(top: 1.v),
          )
        ],
      ),
    );
  }
}
