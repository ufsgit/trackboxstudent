import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_iconbutton.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../added_to_cart_bottomsheet/added_to_cart_bottomsheet.dart';
import '../added_to_cart_bottomsheet/controller/added_to_cart_controller.dart';
import 'controller/frame_1000004952_controller.dart';
import 'models/chapterlist_item_model.dart';
import 'widgets/chapterlist_item_widget.dart'; // ignore_for_file: must_be_immutable

class Frame1000004952Screen extends GetWidget<Frame1000004952Controller> {
  const Frame1000004952Screen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 4.v),
              _buildIntroductionSection(),
              SizedBox(height: 21.v),
              _buildUpcomingLessons(),
              SizedBox(height: 14.v),
              Padding(
                padding: EdgeInsets.only(left: 16.h),
                child: Text(
                  "msg_chapter_2_oet".tr,
                  style: CustomTextStyles.labelLargeInterBluegray500,
                ),
              ),
              SizedBox(height: 4.v),
              _buildChapterList(),
              SizedBox(height: 43.v),
              _buildTotalPriceRow()
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
      leadingWidth: double.maxFinite,
      leading: AppbarLeadingIconbutton(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.only(
          top: 14.v,
          right: 336.h,
          bottom: 14.v,
        ),
        onTap: () {
          onTapArrowleftone();
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildIntroductionSection() {
    return SizedBox(
      height: 200.v,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgRectangle23200x360,
            height: 200.v,
            width: 360.h,
            alignment: Alignment.center,
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 11.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 4.h,
                      right: 5.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: 5.v,
                            bottom: 3.v,
                          ),
                          child: Text(
                            "msg_introduction_to2".tr,
                            style: CustomTextStyles.titleSmallWhiteA700_1,
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: 30.h,
                          margin: EdgeInsets.symmetric(vertical: 3.v),
                          padding: EdgeInsets.symmetric(
                            horizontal: 7.h,
                            vertical: 2.v,
                          ),
                          decoration: AppDecoration.outlineWhiteA.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder4,
                          ),
                          child: Text(
                            "lbl_1x".tr,
                            style: CustomTextStyles.titleSmallInterWhiteA700,
                          ),
                        ),
                        Container(
                          width: 30.h,
                          margin: EdgeInsets.only(
                            left: 20.h,
                            top: 3.v,
                            bottom: 3.v,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 4.h,
                            vertical: 2.v,
                          ),
                          decoration: AppDecoration.outlineWhiteA.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder4,
                          ),
                          child: Text(
                            "lbl_cc".tr,
                            style: CustomTextStyles.titleSmallInterWhiteA700,
                          ),
                        ),
                        CustomImageView(
                          imagePath: ImageConstant.imgSearch,
                          height: 28.adaptSize,
                          width: 28.adaptSize,
                          margin: EdgeInsets.only(left: 20.h),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 36.v),
                  CustomImageView(
                    imagePath: ImageConstant.imgFrame1000005239,
                    height: 60.v,
                    width: 322.h,
                  ),
                  SizedBox(height: 35.v),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "lbl_02_35".tr,
                                  style: CustomTextStyles.bodySmallWhiteA70012,
                                ),
                                Text(
                                  "lbl_50_35".tr,
                                  style: CustomTextStyles.bodySmallWhiteA70012,
                                )
                              ],
                            ),
                            CustomImageView(
                              imagePath: ImageConstant.imgGroup104,
                              height: 8.v,
                              width: 304.h,
                            )
                          ],
                        ),
                      ),
                      CustomImageView(
                        imagePath: ImageConstant.imgMap,
                        height: 18.adaptSize,
                        width: 18.adaptSize,
                        margin: EdgeInsets.only(
                          left: 15.h,
                          top: 2.v,
                          bottom: 4.v,
                        ),
                        onTap: () {
                          onTapImgMapone();
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildUpcomingLessons() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "msg_upcoming_lessons".tr,
            style: CustomTextStyles.titleSmallBluegray800,
          ),
          SizedBox(height: 6.v),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 2.v),
                child: Text(
                  "msg_chapter_1_oet".tr,
                  style: CustomTextStyles.labelLargeBluegray500Medium,
                ),
              ),
              CustomImageView(
                imagePath: ImageConstant.imgArrowDownBlack900,
                height: 18.adaptSize,
                width: 18.adaptSize,
              )
            ],
          ),
          SizedBox(height: 3.v),
          Container(
            padding: EdgeInsets.all(3.h),
            decoration: AppDecoration.outlineBlueGray.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder12,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildLessonColumnTwo(
                    two: "lbl_1".tr,
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
                      Text(
                        "msg_introduction_to".tr,
                        style: theme.textTheme.labelLarge,
                      ),
                      SizedBox(height: 2.v),
                      Row(
                        children: [
                          Text(
                            "lbl_15_04_mins".tr,
                            style: theme.textTheme.bodySmall,
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
                            child: Text(
                              "lbl_3_tests".tr,
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
                            child: Text(
                              "lbl_8_materials".tr,
                              style: theme.textTheme.bodySmall,
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
          SizedBox(height: 4.v),
          Container(
            padding: EdgeInsets.all(3.h),
            decoration: AppDecoration.outlineBlueGray.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder12,
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildLessonColumnTwo(
                    two: "lbl_2".tr,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 8.h,
                    top: 4.v,
                    bottom: 3.v,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "msg_introduction_to2".tr,
                        style: theme.textTheme.labelLarge,
                      ),
                      SizedBox(height: 2.v),
                      Row(
                        children: [
                          Text(
                            "lbl_15_04_mins".tr,
                            style: theme.textTheme.bodySmall,
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
                            child: Text(
                              "lbl_3_tests".tr,
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
                            child: Text(
                              "lbl_8_materials".tr,
                              style: theme.textTheme.bodySmall,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Spacer(),
                CustomImageView(
                  imagePath: ImageConstant.imgFrame2609175,
                  height: 26.adaptSize,
                  width: 26.adaptSize,
                  margin: EdgeInsets.only(
                    top: 7.v,
                    right: 7.h,
                    bottom: 7.v,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildChapterList() {
    return Obx(
      () => ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 1.v,
          );
        },
        itemCount: controller
            .frame1000004952ModelObj.value.chapterlistItemList.value.length,
        itemBuilder: (context, index) {
          ChapterlistItemModel model = controller
              .frame1000004952ModelObj.value.chapterlistItemList.value[index];
          return ChapterlistItemWidget(
            model,
          );
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildTotalPriceRow() {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(16.h),
      decoration: AppDecoration.fillWhiteA,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 1.v),
            child: Column(
              children: [
                Text(
                  "lbl_total_price".tr,
                  style: CustomTextStyles.titleSmallBluegray80001Medium,
                ),
                SizedBox(height: 2.v),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 1.v),
                      child: Text(
                        "lbl".tr,
                        style: CustomTextStyles.titleMediumMedium,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 2.h),
                      child: Text(
                        "lbl_5_500".tr,
                        style: CustomTextStyles.titleMedium18,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          CustomElevatedButton(
            width: 169.h,
            text: "lbl_enroll_now".tr,
            margin: EdgeInsets.only(
              top: 1.v,
              bottom: 7.v,
            ),
            onPressed: () {
              onTapEnrollnow();
            },
          )
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildLessonColumnTwo({required String two}) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.h,
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
          Text(
            two,
            style: CustomTextStyles.bodySmallWhiteA700.copyWith(
              color: appTheme.whiteA700,
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
    );
  }

  /// Navigates to the previous screen.
  onTapArrowleftone() {
    Get.back();
  }

  /// Navigates to the playingCourseScreen when the action is triggered.
  onTapImgMapone() {
    Get.toNamed(
      AppRoutes.playingCourseScreen,
    );
  }

  /// Displays a scrollable bottom sheet widget using the [Get] package
  /// and the [AddedToCartBottomsheet] widget.
  ///
  /// The bottom sheet is controlled by the [AddedToCartController]
  /// and is displayed using the [Get.bottomSheet] method with
  /// [isScrollControlled] set to true.
  onTapEnrollnow() {
    Get.bottomSheet(
      AddedToCartBottomsheet(
        Get.put(
          AddedToCartController(),
        ),
      ),
      isScrollControlled: true,
    );
  }
}
