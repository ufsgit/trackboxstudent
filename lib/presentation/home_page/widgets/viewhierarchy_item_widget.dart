import 'package:anandhu_s_application4/core/colors_res.dart';
import 'package:anandhu_s_application4/http/http_urls.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/controller/course_enrol_controller.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/course_category_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lottie/lottie.dart';
import '../../../core/app_export.dart';
import '../../course_details_page1_screen/controller/course_details_page1_controller.dart';
import '../../onboarding/course_list_model.dart';
import '../controller/home_controller.dart';

class ViewhierarchyItemWidget extends StatelessWidget {
  ViewhierarchyItemWidget(this.viewhierarchyItemModelObj);

  final CourseListModel viewhierarchyItemModelObj;
  final HomeController controller = Get.find<HomeController>();
  final CourseModuleController courseInfoController =
      Get.find<CourseModuleController>();
  final CourseEnrolController enrolController =
      Get.find<CourseEnrolController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await courseInfoController.getCourseInfo(
            courseId: viewhierarchyItemModelObj.courseID ?? 0);
        await enrolController
            .checkCourseEnrolled(viewhierarchyItemModelObj.courseID.toString());
        Get.to(() => CourseCategoryDetailsScreen(
            courseId: viewhierarchyItemModelObj.courseID ?? 0));
      },
      child: Container(
        decoration: AppDecoration.outlineIndigo5001.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder12,
        ),
        width: 180.v,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 105.v,
                width: 180.v,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.h),
                ),
                child: CachedNetworkImage(
                  imageUrl:
                      '${HttpUrls.imgBaseUrl}${viewhierarchyItemModelObj.courseThumbnailPath}',
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(
                    color: ColorResources.colorBlue500,
                  )),
                  errorWidget: (context, url, error) => Center(
                    child: Icon(Icons.image_not_supported_outlined,
                        color: ColorResources.colorBlue100, size: 40),
                  ),
                ),
              ),
              SizedBox(height: 8.v),
              Container(
                child: Text(
                  viewhierarchyItemModelObj.courseName ?? '',
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleSmall!.copyWith(
                    height: 1.43,
                  ),
                ),
              ),
              SizedBox(height: 2.v),
              Row(
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgClock,
                    height: 12.adaptSize,
                    width: 12.adaptSize,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "${viewhierarchyItemModelObj.validity}".tr,
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
                ],
              ),
              SizedBox(height: 13.v),
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '₹ ${viewhierarchyItemModelObj.price}',
                      style: theme.textTheme.titleSmall,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.imgStar,
                            height: 16.adaptSize,
                            width: 16.adaptSize,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 2.v),
                            child: Text(
                              '${double.parse(viewhierarchyItemModelObj.averageRating ?? '0.0').toStringAsFixed(1)}',
                              style: CustomTextStyles.labelLarge_1,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
