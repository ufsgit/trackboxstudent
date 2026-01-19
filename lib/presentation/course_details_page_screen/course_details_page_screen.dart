import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_iconbutton.dart';
import '../../widgets/app_bar/appbar_subtitle_one.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/custom_outlined_button.dart';
import '../../widgets/custom_rating_bar.dart';
import 'controller/course_details_page_controller.dart';
// ignore_for_file: must_be_immutable

class CourseDetailsPageScreen extends GetWidget<CourseDetailsPageController> {
  const CourseDetailsPageScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 18.v),
            child: Column(
              children: [
                _buildCourseOverview(),
                SizedBox(height: 18.v),
                Divider(
                  indent: 16.h,
                  endIndent: 16.h,
                ),
                SizedBox(height: 20.v),
                _buildWhatYoullLearn(),
                SizedBox(height: 17.v),
                Divider(
                  indent: 16.h,
                  endIndent: 16.h,
                ),
                SizedBox(height: 18.v),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.h),
                    child: Text(
                      "lbl_course_overview".tr,
                      style: theme.textTheme.titleSmall,
                    ),
                  ),
                ),
                SizedBox(height: 10.v),
                _buildCourseDuration(),
                SizedBox(height: 18.v),
                Divider(
                  indent: 16.h,
                  endIndent: 16.h,
                ),
                SizedBox(height: 20.v),
                _buildCourseSummary(),
                SizedBox(height: 14.v),
                _buildChapterDetails(),
                SizedBox(height: 19.v),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.h),
                    child: Text(
                      "lbl_reviews".tr,
                      style: theme.textTheme.titleSmall,
                    ),
                  ),
                ),
                SizedBox(height: 12.v),
                _buildReviewJohnJohnson(),
                SizedBox(height: 17.v),
                Container(
                  width: 320.h,
                  margin: EdgeInsets.only(
                    left: 16.h,
                    right: 22.h,
                  ),
                  child: Text(
                    "msg_the_oet_speaking".tr,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium!.copyWith(
                      height: 1.43,
                    ),
                  ),
                ),
                SizedBox(height: 9.v),
                _buildReviewArthur(),
                SizedBox(height: 19.v),
                Container(
                  width: 309.h,
                  margin: EdgeInsets.only(
                    left: 16.h,
                    right: 33.h,
                  ),
                  child: Text(
                    "msg_i_m_your_ai_assistant".tr,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium!.copyWith(
                      height: 1.43,
                    ),
                  ),
                ),
                SizedBox(height: 93.v),
                _buildEnrollmentSection()
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      leadingWidth: 40.h,
      leading: AppbarLeadingIconbutton(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.only(left: 16.h),
        onTap: () {
          onTapArrowleftone();
        },
      ),
      title: AppbarSubtitleOne(
        text: "lbl_course_details".tr,
        margin: EdgeInsets.only(left: 8.h),
      ),
    );
  }

  /// Section Widget
  Widget _buildCourseOverview() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: Column(
        children: [
          SizedBox(
            height: 182.v,
            width: 328.h,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgRectangle23,
                  height: 182.v,
                  width: 328.h,
                  radius: BorderRadius.circular(
                    12.h,
                  ),
                  alignment: Alignment.center,
                  onTap: () {
                    onTapImgImage();
                  },
                ),
                CustomIconButton(
                  height: 60.adaptSize,
                  width: 60.adaptSize,
                  padding: EdgeInsets.all(17.h),
                  decoration: IconButtonStyleHelper.fillWhiteA,
                  alignment: Alignment.center,
                  child: CustomImageView(
                    imagePath: ImageConstant.imgOverflowMenuBlue80003,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 20.v),
          Container(
            width: 322.h,
            margin: EdgeInsets.only(right: 5.h),
            child: Text(
              "msg_the_complete_oet".tr,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: CustomTextStyles.titleMedium18_1.copyWith(
                height: 1.50,
              ),
            ),
          ),
          SizedBox(height: 3.v),
          SizedBox(
            width: 323.h,
            child: Text(
              "msg_you_will_score_a".tr,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: CustomTextStyles.bodyMediumBluegray500_1.copyWith(
                height: 1.43,
              ),
            ),
          ),
          SizedBox(height: 15.v),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 49.h,
                padding: EdgeInsets.symmetric(
                  horizontal: 12.h,
                  vertical: 2.v,
                ),
                decoration: AppDecoration.fillBlue80003.copyWith(
                  borderRadius: BorderRadiusStyle.roundedBorder12,
                ),
                child: Text(
                  "lbl_oet".tr,
                  style: CustomTextStyles.labelLargeBlue80003,
                ),
              ),
              Container(
                width: 87.h,
                margin: EdgeInsets.only(left: 4.h),
                padding: EdgeInsets.symmetric(
                  horizontal: 12.h,
                  vertical: 2.v,
                ),
                decoration: AppDecoration.fillOrange.copyWith(
                  borderRadius: BorderRadiusStyle.roundedBorder12,
                ),
                child: Text(
                  "lbl_best_seller".tr,
                  style: CustomTextStyles.labelLargeAmber700,
                ),
              ),
              Spacer(),
              Container(
                width: 106.h,
                margin: EdgeInsets.only(top: 3.v),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "lbl_4_4".tr,
                      style: CustomTextStyles.labelLargeBlack900,
                    ),
                    CustomImageView(
                      imagePath: ImageConstant.imgStarAmber600,
                      height: 10.adaptSize,
                      width: 10.adaptSize,
                      margin: EdgeInsets.only(
                        top: 2.v,
                        bottom: 4.v,
                      ),
                    ),
                    Text(
                      "lbl_56_reviews".tr,
                      style: CustomTextStyles.bodySmallBluegray700,
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildWhatYoullLearn() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "msg_what_you_ll_learn".tr,
            style: theme.textTheme.titleSmall,
          ),
          SizedBox(height: 6.v),
          Padding(
            padding: EdgeInsets.only(right: 29.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgFrame1000004924,
                  height: 15.v,
                  width: 12.h,
                  margin: EdgeInsets.only(bottom: 22.v),
                ),
                Expanded(
                  child: Container(
                    width: 278.h,
                    margin: EdgeInsets.only(left: 8.h),
                    child: Text(
                      "msg_learn_the_templ".tr,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: CustomTextStyles.labelLargeMedium.copyWith(
                        height: 1.50,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 6.v),
          Padding(
            padding: EdgeInsets.only(right: 31.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgFrame1000004924,
                  height: 15.v,
                  width: 12.h,
                  margin: EdgeInsets.only(bottom: 22.v),
                ),
                Expanded(
                  child: Container(
                    width: 276.h,
                    margin: EdgeInsets.only(left: 8.h),
                    child: Text(
                      "msg_understand_how_to".tr,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: CustomTextStyles.labelLargeMedium.copyWith(
                        height: 1.50,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 6.v),
          Padding(
            padding: EdgeInsets.only(right: 20.h),
            child: Row(
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgFrame1000004924,
                  height: 15.v,
                  width: 12.h,
                  margin: EdgeInsets.only(bottom: 3.v),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 8.h,
                    top: 2.v,
                  ),
                  child: Text(
                    "msg_gain_expert_guidance".tr,
                    style: CustomTextStyles.labelLargeMedium,
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
  Widget _buildCourseDuration() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(
          left: 16.h,
          right: 52.h,
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "lbl_4".tr,
                  style: theme.textTheme.titleSmall,
                ),
                SizedBox(height: 1.v),
                Text(
                  "lbl_weeks".tr,
                  style: CustomTextStyles.labelLargeBluegray500Medium,
                )
              ],
            ),
            Spacer(
              flex: 53,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "lbl_56".tr,
                  style: theme.textTheme.titleSmall,
                ),
                SizedBox(height: 1.v),
                Text(
                  "lbl_classes".tr,
                  style: CustomTextStyles.labelLargeBluegray500Medium,
                )
              ],
            ),
            Spacer(
              flex: 46,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "lbl_56".tr,
                  style: theme.textTheme.titleSmall,
                ),
                SizedBox(height: 1.v),
                Text(
                  "lbl_resourses".tr,
                  style: CustomTextStyles.labelLargeBluegray500Medium,
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 26.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "lbl_14".tr,
                    style: theme.textTheme.titleSmall,
                  ),
                  SizedBox(height: 1.v),
                  Text(
                    "lbl_tests".tr,
                    style: CustomTextStyles.labelLargeBluegray500Medium,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildCourseSummary() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "lbl_summary".tr,
            style: theme.textTheme.titleSmall,
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
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(3.h),
                decoration: AppDecoration.outlineBlueGray.copyWith(
                  borderRadius: BorderRadiusStyle.roundedBorder12,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildColumntwo(
                        dynamicText: "lbl_1".tr,
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
                      child: _buildColumntwo(
                        dynamicText: "lbl_2".tr,
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
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildChapterDetails() {
    return SizedBox(
      height: 219.v,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          CustomOutlinedButton(
            height: 36.v,
            width: 327.h,
            text: "msg_view_all_23_chapters".tr,
            buttonStyle: CustomButtonStyles.outlineBlueGray,
            buttonTextStyle: CustomTextStyles.titleSmallMedium_1,
            alignment: Alignment.bottomCenter,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16.h),
                  child: Text(
                    "msg_chapter_2_oet".tr,
                    style: CustomTextStyles.labelLargeInterBluegray500,
                  ),
                ),
                SizedBox(height: 4.v),
                // Obx(
                //   () => ListView.separated(
                //     physics: NeverScrollableScrollPhysics(),
                //     shrinkWrap: true,
                //     separatorBuilder: (context, index) {
                //       return SizedBox(
                //         height: 1.v,
                //       );
                //     },
                //     itemCount: controller.courseDetailsPageModelObj.value
                //         .viewhierarchy1ItemList.value.length,
                //     itemBuilder: (context, index) {
                //       Viewhierarchy1ItemModel model = controller
                //           .courseDetailsPageModelObj
                //           .value
                //           .viewhierarchy1ItemList
                //           .value[index];
                //       return Viewhierarchy1ItemWidget(
                //         model,
                //       );
                //     },
                //   ),//TODO need to edit
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildReviewJohnJohnson() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgEllipse8,
            height: 36.adaptSize,
            width: 36.adaptSize,
            radius: BorderRadius.circular(
              18.h,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 12.h,
              bottom: 3.v,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "lbl_john_johnson".tr,
                  style: CustomTextStyles.labelLargeInterBlack900_1,
                ),
                SizedBox(height: 1.v),
                Text(
                  "lbl_04_02_2023".tr,
                  style: CustomTextStyles.labelLargeInterBlack900Medium,
                )
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(
              top: 17.v,
              bottom: 3.v,
            ),
            child: Text(
              "lbl_4_4".tr,
              style: CustomTextStyles.labelLargeInterPrimaryContainer,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 4.h,
              top: 19.v,
              bottom: 5.v,
            ),
            child: CustomRatingBar(
              initialRating: 5,
              color: appTheme.gray200,
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildReviewArthur() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgEllipse8,
            height: 36.adaptSize,
            width: 36.adaptSize,
            radius: BorderRadius.circular(
              18.h,
            ),
            margin: EdgeInsets.only(bottom: 2.v),
          ),
          Padding(
            padding: EdgeInsets.only(left: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "lbl_arthur".tr,
                  style: CustomTextStyles.labelLargeInterBlack900,
                ),
                SizedBox(height: 6.v),
                Text(
                  "lbl_04_02_2023".tr,
                  style: CustomTextStyles.labelLargeInterBlack900Medium,
                )
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(top: 23.v),
            child: Text(
              "lbl_4_4".tr,
              style: CustomTextStyles.labelLargeInterBlack900Medium_1,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 4.h,
              top: 25.v,
            ),
            child: CustomRatingBar(
              initialRating: 5,
              color: appTheme.gray200,
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildEnrollmentSection() {
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
          )
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildColumntwo({required String dynamicText}) {
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
            dynamicText,
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

  /// Navigates to the frame1000004952Screen when the action is triggered.
  onTapImgImage() {
    Get.toNamed(
      AppRoutes.frame1000004952Screen,
    );
  }
}
