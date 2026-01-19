import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_outlined_button.dart';
import 'controller/added_to_cart_controller.dart';

// ignore_for_file: must_be_immutable
class AddedToCartBottomsheet extends StatelessWidget {
  AddedToCartBottomsheet(this.controller, {Key? key})
      : super(
          key: key,
        );

  AddedToCartController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 359.h,
      padding: EdgeInsets.symmetric(
        horizontal: 15.h,
        vertical: 24.v,
      ),
      decoration: AppDecoration.fillGray.copyWith(
        borderRadius: BorderRadiusStyle.customBorderTL12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 2.v),
          _buildTotalRow(
            totalText: "lbl_checkout".tr,
            priceText: "lbl_1_item".tr,
          ),
          SizedBox(height: 17.v),
          Container(
            padding: EdgeInsets.all(3.h),
            decoration: AppDecoration.outlineBluegray50.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder12,
            ),
            child: Row(
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgImage2864x64,
                  height: 64.adaptSize,
                  width: 64.adaptSize,
                  radius: BorderRadius.circular(
                    9.h,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 12.h,
                    bottom: 2.v,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 207.h,
                        child: Text(
                          "msg_the_complete_oet".tr,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: CustomTextStyles.titleSmall_1.copyWith(
                            height: 1.29,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.v),
                      Row(
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.imgBooks,
                            height: 12.adaptSize,
                            width: 12.adaptSize,
                            margin: EdgeInsets.only(
                              top: 1.v,
                              bottom: 2.v,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 2.h),
                            child: Text(
                              "lbl_54".tr,
                              style: CustomTextStyles.labelLargeBluegray500_2,
                            ),
                          ),
                          CustomImageView(
                            imagePath: ImageConstant.imgClock,
                            height: 12.adaptSize,
                            width: 12.adaptSize,
                            margin: EdgeInsets.only(
                              left: 18.h,
                              top: 1.v,
                              bottom: 2.v,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 2.h),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "lbl_48".tr,
                                    style: CustomTextStyles
                                        .labelLargeBluegray500_3,
                                  ),
                                  TextSpan(
                                    text: " ",
                                  ),
                                  TextSpan(
                                    text: "lbl_hrs2".tr,
                                    style: CustomTextStyles
                                        .labelLargeBluegray500Medium_1,
                                  )
                                ],
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          CustomImageView(
                            imagePath: ImageConstant.imgStarBlueGray20001,
                            height: 12.adaptSize,
                            width: 12.adaptSize,
                            margin: EdgeInsets.only(
                              left: 18.h,
                              top: 1.v,
                              bottom: 2.v,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 2.h),
                            child: Text(
                              "lbl_4_5".tr,
                              style: theme.textTheme.labelLarge,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 19.v),
          _buildTotalRow(
            totalText: "lbl_total".tr,
            priceText: "lbl_50002".tr,
          ),
          SizedBox(height: 26.v),
          CustomElevatedButton(
            text: "lbl_checkout".tr,
          ),
          SizedBox(height: 9.v),
          CustomOutlinedButton(
            height: 36.v,
            text: "lbl_cancel".tr,
            buttonStyle: CustomButtonStyles.outlineBlueGrayTL18,
            buttonTextStyle: theme.textTheme.titleSmall!,
            onPressed: () {
              onTapCancel();
            },
          )
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildTotalRow({
    required String totalText,
    required String priceText,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          totalText,
          style: CustomTextStyles.titleMediumMedium_1.copyWith(
            color: appTheme.blueGray80003,
          ),
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "lbl".tr,
                style: CustomTextStyles.bodyLargePlusJakartaSansBluegray80003,
              ),
              TextSpan(
                text: "lbl_50003".tr,
                style: CustomTextStyles.titleMedium_1,
              )
            ],
          ),
          textAlign: TextAlign.left,
        )
      ],
    );
  }

  /// Navigates to the courseDetailsPageScreen when the action is triggered.
  onTapCancel() {
    Get.toNamed(
      AppRoutes.courseDetailsPageScreen,
    );
  }
}
