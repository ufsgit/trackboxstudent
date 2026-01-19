import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../controller/home_page_after_joining_a_course_controller.dart';
import '../models/popularcoursesgrid_item_model.dart';

// ignore_for_file: must_be_immutable
class PopularcoursesgridItemWidget extends StatelessWidget {
  PopularcoursesgridItemWidget(this.popularcoursesgridItemModelObj, {Key? key})
      : super(
          key: key,
        );

  PopularcoursesgridItemModel popularcoursesgridItemModelObj;

  var controller = Get.find<HomePageAfterJoiningACourseController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3.h),
      decoration: AppDecoration.outlineIndigo5001.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder12,
      ),
      width: 188.h,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(
            () => CustomImageView(
              imagePath: popularcoursesgridItemModelObj.image1!.value,
              height: 105.v,
              width: 180.h,
              radius: BorderRadius.circular(
                10.h,
              ),
            ),
          ),
          SizedBox(height: 17.v),
          Container(
            width: 145.h,
            margin: EdgeInsets.only(left: 4.h),
            child: Obx(
              () => Text(
                popularcoursesgridItemModelObj.text1!.value,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleSmall!.copyWith(
                  height: 1.43,
                ),
              ),
            ),
          ),
          SizedBox(height: 2.v),
          Padding(
            padding: EdgeInsets.only(left: 4.h),
            child: Row(
              children: [
                Obx(
                  () => CustomImageView(
                    imagePath: popularcoursesgridItemModelObj.image2!.value,
                    height: 12.adaptSize,
                    width: 12.adaptSize,
                    margin: EdgeInsets.only(
                      top: 1.v,
                      bottom: 2.v,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 2.h),
                  child: Obx(
                    () => Text(
                      popularcoursesgridItemModelObj.text2!.value,
                      style: CustomTextStyles.labelLargeBluegray500_1,
                    ),
                  ),
                ),
                Obx(
                  () => CustomImageView(
                    imagePath: popularcoursesgridItemModelObj.image3!.value,
                    height: 12.adaptSize,
                    width: 12.adaptSize,
                    margin: EdgeInsets.only(
                      left: 18.h,
                      top: 1.v,
                      bottom: 2.v,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 2.h),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "lbl_48".tr,
                          style: CustomTextStyles.labelLargeBluegray500,
                        ),
                        TextSpan(
                          text: "lbl_hrs".tr,
                          style: CustomTextStyles.bodySmallBluegray50012,
                        )
                      ],
                    ),
                    textAlign: TextAlign.left,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 13.v),
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => Text(
                    popularcoursesgridItemModelObj.text4!.value,
                    style: theme.textTheme.titleSmall,
                  ),
                ),
                Container(
                  width: 37.h,
                  margin: EdgeInsets.only(left: 82.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(
                        () => CustomImageView(
                          imagePath:
                              popularcoursesgridItemModelObj.image4!.value,
                          height: 16.adaptSize,
                          width: 16.adaptSize,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 2.h),
                        child: Obx(
                          () => Text(
                            popularcoursesgridItemModelObj.text5!.value,
                            style: CustomTextStyles.labelLarge_1,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 4.v)
        ],
      ),
    );
  }
}
