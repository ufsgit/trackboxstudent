import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_drop_down.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_rating_bar.dart';
import 'controller/filter_bottom_sheet_controller.dart';

// ignore_for_file: must_be_immutable
class FilterBottomSheetBottomsheet extends StatelessWidget {
  FilterBottomSheetBottomsheet(this.controller, {Key? key})
      : super(
          key: key,
        );

  FilterBottomSheetController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 23.h,
        vertical: 24.v,
      ),
      decoration: AppDecoration.fillWhiteA.copyWith(
        borderRadius: BorderRadiusStyle.customBorderTL18,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 2.v),
            _buildFilterControls(),
            SizedBox(height: 30.v),
            _buildExamTypeSelection(),
            SizedBox(height: 19.v),
            _buildCategorySelection(),
            SizedBox(height: 19.v),
            _buildRatingSection(),
            SizedBox(height: 19.v),
            _buildPriceRangeSlider(),
            SizedBox(height: 42.v),
            CustomElevatedButton(
              height: 40.v,
              text: "lbl_apply".tr,
              buttonStyle: CustomButtonStyles.outlinePrimary,
              onPressed: () {
                onTapApply();
              },
            )
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildFilterControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 70.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgFadershorizontal,
                height: 20.adaptSize,
                width: 20.adaptSize,
                margin: EdgeInsets.only(top: 1.v),
              ),
              Text(
                "lbl_filter".tr,
                style: CustomTextStyles.titleMediumSyne,
              )
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Get.toNamed(AppRoutes.myCoursesPage, id: 1);
          },
          child: CustomImageView(
            imagePath: ImageConstant.imgVector,
            height: 22.adaptSize,
            width: 22.adaptSize,
          ),
        )
      ],
    );
  }

  /// Section Widget
  Widget _buildExamTypeSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "msg_choose_exam_type".tr,
          style: CustomTextStyles.titleSmallMedium_4,
        ),
        SizedBox(height: 6.v),
        CustomDropDown(
          icon: Container(
            margin: EdgeInsets.symmetric(horizontal: 12.h),
            child: CustomImageView(
              imagePath: ImageConstant.imgArrowdown,
              height: 24.adaptSize,
              width: 24.adaptSize,
            ),
          ),
          hintText: "lbl_exam_type".tr,
          items:
              controller.filterBottomSheetModelObj.value.dropdownItemList.value,
        )
      ],
    );
  }

  /// Section Widget
  Widget _buildCategorySelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "lbl_choose_category".tr,
          style: CustomTextStyles.titleSmallMedium_4,
        ),
        SizedBox(height: 6.v),
        CustomDropDown(
          icon: Container(
            margin: EdgeInsets.symmetric(horizontal: 12.h),
            child: CustomImageView(
              imagePath: ImageConstant.imgArrowdown,
              height: 24.adaptSize,
              width: 24.adaptSize,
            ),
          ),
          hintText: "lbl_category_type".tr,
          items: controller
              .filterBottomSheetModelObj.value.dropdownItemList1.value,
        )
      ],
    );
  }

  /// Section Widget
  Widget _buildRatingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "lbl_rating".tr,
          style: CustomTextStyles.titleSmallMedium_4,
        ),
        SizedBox(height: 6.v),
        Padding(
          padding: EdgeInsets.only(right: 36.h),
          child: Row(
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgUser,
                height: 24.adaptSize,
                width: 24.adaptSize,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 8.h,
                  top: 3.v,
                  bottom: 2.v,
                ),
                child: Text(
                  "lbl_all".tr,
                  style: CustomTextStyles.titleSmallMedium_4,
                ),
              ),
              Spacer(),
              CustomRatingBar(
                initialRating: 0,
                itemSize: 24,
                itemCount: 2,
              )
            ],
          ),
        ),
        SizedBox(height: 12.v),
        Padding(
          padding: EdgeInsets.only(right: 36.h),
          child: Row(
            children: [
              CustomRatingBar(
                initialRating: 0,
                itemSize: 24,
                itemCount: 2,
              ),
              Spacer(),
              CustomImageView(
                imagePath: ImageConstant.imgContrast,
                height: 24.adaptSize,
                width: 24.adaptSize,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 8.h,
                  top: 4.v,
                  bottom: 4.v,
                ),
                child: CustomRatingBar(
                  initialRating: 0,
                  itemSize: 16,
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 12.v),
        Padding(
          padding: EdgeInsets.only(right: 36.h),
          child: Row(
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgContrast,
                height: 24.adaptSize,
                width: 24.adaptSize,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 8.h,
                  top: 4.v,
                  bottom: 4.v,
                ),
                child: CustomRatingBar(
                  initialRating: 0,
                  itemSize: 16,
                ),
              ),
              Spacer(),
              CustomImageView(
                imagePath: ImageConstant.imgContrast,
                height: 24.adaptSize,
                width: 24.adaptSize,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 8.h,
                  top: 4.v,
                  bottom: 4.v,
                ),
                child: CustomRatingBar(
                  initialRating: 0,
                  itemSize: 16,
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  /// Section Widget
  Widget _buildPriceRangeSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "lbl_price_range".tr,
          style: CustomTextStyles.titleSmallMedium_4,
        ),
        SizedBox(height: 6.v),
        SizedBox(
          height: 68.v,
          width: 297.h,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.only(top: 10.v),
                  child: SizedBox(
                    width: 281.h,
                    child: Divider(
                      color: appTheme.indigo5001,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  height: 68.v,
                  width: 113.h,
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(top: 10.v),
                          child: SizedBox(
                            width: 86.h,
                            child: Divider(
                              color: appTheme.blue60002,
                              indent: 16.h,
                            ),
                          ),
                        ),
                      ),
                      CustomImageView(
                        imagePath: ImageConstant.imgUser,
                        height: 24.adaptSize,
                        width: 24.adaptSize,
                        alignment: Alignment.topRight,
                        margin: EdgeInsets.only(right: 15.h),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          margin: EdgeInsets.only(left: 59.h),
                          decoration: AppDecoration.outlineOnPrimary.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder8,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomImageView(
                                imagePath: ImageConstant.imgArrowUp,
                                height: 6.v,
                                width: 16.h,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.h,
                                  vertical: 9.v,
                                ),
                                decoration: AppDecoration.fillBlue.copyWith(
                                  borderRadius:
                                      BorderRadiusStyle.roundedBorder8,
                                ),
                                child: Text(
                                  "lbl_2_5_k".tr,
                                  style:
                                      CustomTextStyles.labelLargeInterWhiteA700,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(right: 81.h),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomImageView(
                                imagePath: ImageConstant.imgUser,
                                height: 24.adaptSize,
                                width: 24.adaptSize,
                              ),
                              SizedBox(height: 4.v),
                              Container(
                                decoration:
                                    AppDecoration.outlineOnPrimary.copyWith(
                                  borderRadius:
                                      BorderRadiusStyle.roundedBorder8,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomImageView(
                                      imagePath: ImageConstant.imgArrowUp,
                                      height: 6.v,
                                      width: 16.h,
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12.h,
                                        vertical: 9.v,
                                      ),
                                      decoration:
                                          AppDecoration.fillBlue.copyWith(
                                        borderRadius:
                                            BorderRadiusStyle.roundedBorder8,
                                      ),
                                      child: Text(
                                        "lbl_0".tr,
                                        style: CustomTextStyles
                                            .labelLargeInterWhiteA700,
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
              )
            ],
          ),
        )
      ],
    );
  }

  /// Navigates to the searchPageScreen when the action is triggered.
  onTapApply() {
    Get.toNamed(
      AppRoutes.searchPageScreen,
    );
  }
}
