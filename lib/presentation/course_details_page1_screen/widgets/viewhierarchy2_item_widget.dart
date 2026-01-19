import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../controller/course_details_page1_controller.dart';
import '../models/viewhierarchy2_item_model.dart';

// ignore: must_be_immutable
class Viewhierarchy2ItemWidget extends StatelessWidget {
  Viewhierarchy2ItemWidget(this.viewhierarchy2ItemModelObj, {Key? key})
      : super(
          key: key,
        );

  Viewhierarchy2ItemModel viewhierarchy2ItemModelObj;

  var controller = Get.find<CourseModuleController>();

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
              horizontal: 8.h,
              vertical: 2.v,
            ),
            decoration: AppDecoration.fillBlack9002.copyWith(
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
                    viewhierarchy2ItemModelObj.text!.value,
                    style: CustomTextStyles.bodySmallWhiteA700,
                  ),
                ),
                SizedBox(height: 10.v),
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
                    viewhierarchy2ItemModelObj.text1!.value,
                    style: theme.textTheme.labelLarge,
                  ),
                ),
                SizedBox(height: 3.v),
                Row(
                  children: [
                    Obx(
                      () => Text(
                        viewhierarchy2ItemModelObj.text2!.value,
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
                          viewhierarchy2ItemModelObj.text3!.value,
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
                          viewhierarchy2ItemModelObj.text4!.value,
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
