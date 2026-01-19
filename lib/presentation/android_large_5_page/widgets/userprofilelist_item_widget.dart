import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../controller/android_large_5_controller.dart';
import '../models/userprofilelist_item_model.dart';
// ignore_for_file: must_be_immutable

class UserprofilelistItemWidget extends StatelessWidget {
  UserprofilelistItemWidget(this.userprofilelistItemModelObj,
      {Key? key, this.onTapUserprofile})
      : super(
          key: key,
        );

  UserprofilelistItemModel userprofilelistItemModelObj;

  var controller = Get.find<AndroidLarge5Controller>();

  VoidCallback? onTapUserprofile;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapUserprofile?.call();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => CustomImageView(
              imagePath: userprofilelistItemModelObj.userImage!.value,
              height: 42.adaptSize,
              width: 42.adaptSize,
              radius: BorderRadius.circular(
                21.h,
              ),
              margin: EdgeInsets.only(bottom: 10.v),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 12.h,
              top: 3.v,
              bottom: 9.v,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Text(
                    userprofilelistItemModelObj.username!.value,
                    style: theme.textTheme.titleMedium,
                  ),
                ),
                SizedBox(height: 5.v),
                Obx(
                  () => Text(
                    userprofilelistItemModelObj.description!.value,
                    style: CustomTextStyles.labelLargeBluegray500Medium,
                  ),
                )
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(
              top: 3.v,
              bottom: 10.v,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Obx(
                  () => Text(
                    userprofilelistItemModelObj.date!.value,
                    style: CustomTextStyles.labelLargeBluegray500Medium,
                  ),
                ),
                SizedBox(height: 4.v),
                Container(
                  width: 18.adaptSize,
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.h,
                    vertical: 1.v,
                  ),
                  decoration: AppDecoration.fillBlue.copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorder8,
                  ),
                  child: Obx(
                    () => Text(
                      userprofilelistItemModelObj.count!.value,
                      style: theme.textTheme.labelMedium,
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
}
