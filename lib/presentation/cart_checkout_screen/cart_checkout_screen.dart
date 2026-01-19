import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_iconbutton.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_outlined_button.dart';
import 'controller/cart_checkout_controller.dart';
import 'models/viewhierarchy3_item_model.dart';
import 'widgets/viewhierarchy3_item_widget.dart'; // ignore_for_file: must_be_immutable

class CartCheckoutScreen extends GetWidget<CartCheckoutController> {
  const CartCheckoutScreen({Key? key})
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
          padding: EdgeInsets.symmetric(
            horizontal: 16.h,
            vertical: 4.v,
          ),
          child: Column(
            children: [
              _buildAddedToCartSection(),
             Spacer(),
              _buildTotalPriceRow(
                total: "lbl_total_items".tr,
                price: "lbl_x3".tr,
              ),
              SizedBox(height: 11.v),
              _buildTotalPriceRow(
                total: "lbl_total".tr,
                price: "lbl_15_000".tr,
              ),
              SizedBox(height: 17.v),
              CustomOutlinedButton(
                
                text: "lbl_save_for_later".tr,
                decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15.v),border: Border.all()),
                buttonStyle: CustomButtonStyles.outlineBlueGrayTL20,
                buttonTextStyle: CustomTextStyles.titleMedium_2,
              ),
              SizedBox(height: 9.v),
              CustomElevatedButton(
                height: 40.v,
                text: "lbl_checkout".tr,
                buttonTextStyle: CustomTextStyles.titleMediumWhiteA700,
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
      height: 52.v,
      leadingWidth: 40.h,
      leading: AppbarLeadingIconbutton(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.only(
          left: 16.h,
          top: 14.v,
          bottom: 14.v,
        ),
        onTap: () {
          onTapArrowleftone();
        },
      ),
      title: AppbarSubtitle(
        text: "lbl_checkout".tr,
        margin: EdgeInsets.only(left: 8.h),
      ),
    );
  }

  /// Section Widget
  Widget _buildAddedToCartSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "lbl_added_to_cart".tr,
          style: CustomTextStyles.titleMediumBluegray8000118,
        ),
        SizedBox(height: 6.v),
        Text(
          "lbl_3_item".tr,
          style: CustomTextStyles.bodyMediumBluegray80001,
        ),
        SizedBox(height: 20.v),
        Obx(
          () => ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 12.v,
              );
            },
            itemCount: controller
                .cartCheckoutModelObj.value.viewhierarchy3ItemList.value.length,
            itemBuilder: (context, index) {
              Viewhierarchy3ItemModel model = controller.cartCheckoutModelObj
                  .value.viewhierarchy3ItemList.value[index];
              return Viewhierarchy3ItemWidget(
                model,
              );
            },
          ),
        )
      ],
    );
  }

  /// Common widget
  Widget _buildTotalPriceRow({
    required String total,
    required String price,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 1.v),
          child: Text(
            total,
            style: CustomTextStyles.titleMediumMedium.copyWith(
              color: appTheme.blueGray80003,
            ),
          ),
        ),
        Text(
          price,
          style: CustomTextStyles.titleMedium18_1.copyWith(
            color: appTheme.blueGray80003,
          ),
        )
      ],
    );
  }

  /// Navigates to the previous screen.
  onTapArrowleftone() {
    Get.back();
  }
}
