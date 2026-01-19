import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_image_one.dart';
import '../../widgets/app_bar/appbar_subtitle_one.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import 'controller/reading_test_passage_controller.dart'; // ignore_for_file: must_be_immutable

class ReadingTestPassageScreen extends GetWidget<ReadingTestPassageController> {
  const ReadingTestPassageScreen({Key? key})
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
            padding: EdgeInsets.only(top: 22.v),
            child: _buildReadingTestPassage(),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      height: 21.v,
      leadingWidth: 36.h,
      leading: AppbarLeadingImageOne(
        imagePath: ImageConstant.imgArrowLeftBlack900,
        margin: EdgeInsets.only(
          left: 16.h,
          bottom: 1.v,
        ),
        onTap: () {
          onTapArrowleftone();
        },
      ),
      title: AppbarSubtitleOne(
        text: "lbl_writing_test".tr,
        margin: EdgeInsets.only(left: 16.h),
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgClockBlack900,
          margin: EdgeInsets.only(
            left: 16.h,
            top: 1.v,
            right: 1.h,
          ),
        ),
        AppbarTitle(
          text: "lbl_29_00".tr,
          margin: EdgeInsets.only(
            left: 4.h,
            top: 1.v,
            right: 17.h,
          ),
        )
      ],
    );
  }

  /// Section Widget
  Widget _buildReadingTestPassage() {
    return Container(
      margin: EdgeInsets.only(bottom: 5.v),
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Text(
                    "lbl_question".tr,
                    style: theme.textTheme.labelLarge,
                  ),
                  SizedBox(height: 8.v),
                  CustomImageView(
                    imagePath: ImageConstant.imgLine266,
                    height: 1.v,
                    width: 24.h,
                  )
                ],
              ),
              InkWell(
                onTap: (){
                  // Get.toNamed(AppRoutes.read);
                },
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 24.h,
                    bottom: 9.v,
                  ),
                  child: Text(
                    "lbl_answer".tr,
                    style: CustomTextStyles.labelLargeOnError,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 17.v),
          SizedBox(
            width: 324.h,
            child: Text(
              "msg_you_are_a_healthcare".tr,
              maxLines: 6,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleMedium!.copyWith(
                height: 1.50,
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Navigates to the previous screen.
  onTapArrowleftone() {
    Get.back();
  }
}
