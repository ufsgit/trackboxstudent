import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../controller/search_page_controller.dart';
import '../models/oetprogram_item_model.dart';

// ignore_for_file: must_be_immutable
class OetprogramItemWidget extends StatelessWidget {
  OetprogramItemWidget(this.oetprogramItemModelObj,
      {Key? key, this.onTapOetprogram})
      : super(
          key: key,
        );

  OetprogramItemModel oetprogramItemModelObj;

  var controller = Get.find<SearchPageController>();

  VoidCallback? onTapOetprogram;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapOetprogram?.call();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 1.v),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 141.h,
                  margin: EdgeInsets.only(left: 2.h),
                  child: Obx(
                    () => Text(
                      oetprogramItemModelObj.programTitle!.value,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleSmall!.copyWith(
                        height: 1.43,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.v),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 1.v),
                      child: Obx(
                        () => Text(
                          oetprogramItemModelObj.programPrice!.value,
                          style:
                              CustomTextStyles.labelLargeInterBluegray500Bold,
                        ),
                      ),
                    ),
                    Container(
                      width: 38.h,
                      margin: EdgeInsets.only(left: 12.h),
                      child: Row(
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.imgStar,
                            height: 16.adaptSize,
                            width: 16.adaptSize,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 2.h),
                            child: Obx(
                              () => Text(
                                oetprogramItemModelObj.fortyFive!.value,
                                style: CustomTextStyles.labelLargeBluegray500_2,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgFrame2609167,
            height: 67.v,
            width: 105.h,
            radius: BorderRadius.circular(
              8.h,
            ),
          )
        ],
      ),
    );
  }
}
