import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../controller/cart_checkout_controller.dart';
import '../models/viewhierarchy3_item_model.dart';
// ignore_for_file: must_be_immutable

class Viewhierarchy3ItemWidget extends StatelessWidget {
  Viewhierarchy3ItemWidget(this.viewhierarchy3ItemModelObj, {Key? key})
      : super(
          key: key,
        );

  Viewhierarchy3ItemModel viewhierarchy3ItemModelObj;

  var controller = Get.find<CartCheckoutController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3.h),
      decoration: AppDecoration.outlineBluegray50.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder12,
      ),
      child: Row(
        children: [
          CustomImageView(
            imagePath: 'assets/images/img_rectangle_23.png',
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
                  child: Obx(
                    () => Text(
                      viewhierarchy3ItemModelObj.text!.value,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: CustomTextStyles.titleSmall_1.copyWith(
                        height: 1.29,
                      ),
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
                      child: Obx(
                        () => Text(
                          viewhierarchy3ItemModelObj.text1!.value,
                          style: CustomTextStyles.labelLargeBluegray500_2,
                        ),
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
                              style: CustomTextStyles.labelLargeBluegray500_3,
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
                      child: Obx(
                        () => Text(
                          viewhierarchy3ItemModelObj.text2!.value,
                          style: theme.textTheme.labelLarge,
                        ),
                      ),
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
}
