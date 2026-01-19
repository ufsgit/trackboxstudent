import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../controller/frame_1000004952_controller.dart';
import '../models/chapterlist_item_model.dart';

// ignore_for_file: must_be_immutable
class ChapterlistItemWidget extends StatelessWidget {
  ChapterlistItemWidget(this.chapterlistItemModelObj, {Key? key})
      : super(
          key: key,
        );

  ChapterlistItemModel chapterlistItemModelObj;

  var controller = Get.find<Frame1000004952Controller>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3.h),
      decoration: AppDecoration.outlineBlueGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder12,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 11.h,
              vertical: 3.v,
            ),
            decoration: AppDecoration.fillBlack900.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder8,
              image: DecorationImage(
                image: AssetImage(
                  ImageConstant.imgFrame260916740x62,
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Text(
                    chapterlistItemModelObj.text!.value,
                    style: CustomTextStyles.bodySmallWhiteA700,
                  ),
                ),
                SizedBox(height: 9.v),
                CustomImageView(
                  imagePath: ImageConstant.imgPlay,
                  height: 13.adaptSize,
                  width: 13.adaptSize,
                  alignment: Alignment.center,
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 8.h,
              top: 2.v,
              bottom: 5.v,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Text(
                    chapterlistItemModelObj.text1!.value,
                    style: theme.textTheme.labelLarge,
                  ),
                ),
                SizedBox(height: 2.v),
                Row(
                  children: [
                    Obx(
                      () => Text(
                        chapterlistItemModelObj.text2!.value,
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                    Opacity(
                      opacity: 0.5,
                      child: Container(
                        height: 2.adaptSize,
                        width: 2.adaptSize,
                        margin: EdgeInsets.only(
                          left: 4.h,
                          top: 5.v,
                          bottom: 5.v,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(
                            1.h,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4.h),
                      child: Obx(
                        () => Text(
                          chapterlistItemModelObj.text3!.value,
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                    ),
                    Opacity(
                      opacity: 0.5,
                      child: Container(
                        height: 2.adaptSize,
                        width: 2.adaptSize,
                        margin: EdgeInsets.only(
                          left: 4.h,
                          top: 5.v,
                          bottom: 5.v,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(
                            1.h,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4.h),
                      child: Obx(
                        () => Text(
                          chapterlistItemModelObj.text4!.value,
                          style: theme.textTheme.bodySmall,
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
