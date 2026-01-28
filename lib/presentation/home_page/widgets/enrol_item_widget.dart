import 'package:anandhu_s_application4/core/colors_res.dart';
import 'package:anandhu_s_application4/http/http_urls.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/controller/course_enrol_controller.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/course_category_details_screen.dart';
import 'package:anandhu_s_application4/presentation/explore_courses/controller/course_access_controller.dart';
import 'package:anandhu_s_application4/presentation/my_courses_page/models/my_courses_details_model.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../../../core/app_export.dart';
import '../../course_details_page1_screen/controller/course_details_page1_controller.dart';
import '../../onboarding/course_list_model.dart';
import '../controller/home_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EnrolItemWidget extends StatelessWidget {
  EnrolItemWidget(this.viewhierarchyItemModelObj);

  final MyCourseDetailsModel viewhierarchyItemModelObj;
  final HomeController controller = Get.find<HomeController>();
  final CourseModuleController courseInfoController =
      Get.find<CourseModuleController>();
  final CourseEnrolController enrolController =
      Get.find<CourseEnrolController>();
  String formatDateTime(DateTime dateTime) {
    String formattedDate = DateFormat('dd/MM/yy').format(dateTime);
    return formattedDate;
  }

  String formatDate(String date) {
    // Parse the date from the input string
    DateTime parsedDate = DateTime.parse(date).toLocal();

    // Format the date in dd/mm/yyyy format
    String formattedDate = "${parsedDate.day.toString().padLeft(2, '0')}/"
        "${parsedDate.month.toString().padLeft(2, '0')}/"
        "${parsedDate.year}";

    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        print(
            "Image Path ${HttpUrls.imgBaseUrl}${viewhierarchyItemModelObj.imagePath}");
        await courseInfoController.getCourseInfo(
            courseId: viewhierarchyItemModelObj.courseId ?? 0);
        await enrolController
            .checkCourseEnrolled(viewhierarchyItemModelObj.courseId.toString());
        Get.to(() => CourseCategoryDetailsScreen(
            courseId: viewhierarchyItemModelObj.courseId ?? 0));

        final CourseAccessController accessController =
            Get.find<CourseAccessController>();

        if (!accessController
            .canAccessCourse(viewhierarchyItemModelObj.courseId ?? 0)) {
          if (viewhierarchyItemModelObj.batchID == 0) {
            Fluttertoast.showToast(
                msg: 'No batches assigned to this course',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: ColorResources.colorBlack,
                textColor: ColorResources.colorwhite);
          }
          //  else {
          //   Fluttertoast.showToast(
          //       msg: 'Course access currently restricted',
          //       toastLength: Toast.LENGTH_LONG,
          //       gravity: ToastGravity.BOTTOM,
          //       backgroundColor: ColorResources.colorBlack,
          //       textColor: ColorResources.colorwhite);
          // }
          return;
        }

        await courseInfoController.getCourseInfo(
            courseId: viewhierarchyItemModelObj.courseId ?? 0);

        await enrolController
            .checkCourseEnrolled(viewhierarchyItemModelObj.courseId.toString());

        Get.to(() => CourseCategoryDetailsScreen(
            courseId: viewhierarchyItemModelObj.courseId ?? 0));
      },
      child: Container(
        padding: EdgeInsets.all(3.v),
        decoration: AppDecoration.outlineIndigo5001.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder12,
        ),
        width: 220.v,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Container(
                height: 105.v,
                width: 180.v,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.h),
                    boxShadow: [
                      BoxShadow(
                          color: ColorResources.colorgrey300, blurRadius: 4)
                    ]),
                child: CachedNetworkImage(
                  imageUrl:
                      '${HttpUrls.imgBaseUrl}${viewhierarchyItemModelObj.imagePath}',
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(
                    color: ColorResources.colorBlue500,
                  )),
                  errorWidget: (context, url, error) => Center(
                    child: Icon(Icons.image_not_supported_outlined,
                        color: ColorResources.colorBlue200, size: 40),
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.v),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 8),
            //   child: Row(
            //     children: [
            //       SvgPicture.asset(
            //         'assets/images/book.svg',
            //         color: appTheme.blueGray500,
            //         width: 15,
            //         height: 15,
            //       ),
            //       Padding(
            //         padding: EdgeInsets.only(left: 2.h),
            //         child: RichText(
            //           text: TextSpan(
            //             children: [
            //               TextSpan(
            //                 text: viewhierarchyItemModelObj.content_position
            //                         .toString() +
            //                     "  / ",
            //                 style: CustomTextStyles
            //                     .titleSmallPrimaryContainerMedium,
            //               ),
            //               TextSpan(
            //                 text: " ",
            //               ),
            //               TextSpan(
            //                 text: viewhierarchyItemModelObj.total_content_count
            //                     .toString(),
            //                 style: CustomTextStyles
            //                     .titleSmallPrimaryContainerMedium,
            //               )
            //             ],
            //           ),
            //           textAlign: TextAlign.left,
            //         ),
            //       ),
            //       CustomImageView(
            //         imagePath: ImageConstant.imgClock,
            //         height: 12.adaptSize,
            //         width: 12.adaptSize,
            //         margin: EdgeInsets.only(
            //           left: 18.h,
            //           top: 1.v,
            //           bottom: 2.v,
            //         ),
            //       ),
            //       Padding(
            //         padding: EdgeInsets.only(left: 2.h),
            //         child: RichText(
            //           text: TextSpan(
            //             children: [
            //               TextSpan(
            //                 text:
            //                     "${formatDateTime(viewhierarchyItemModelObj.expiryDate)}"
            //                         .tr,
            //                 style: CustomTextStyles.labelLargeBluegray500,
            //               ),
            //               // TextSpan(
            //               //   text: "lbl_hrs".tr,
            //               //   style: CustomTextStyles.bodySmallBluegray50012,
            //               // )
            //             ],
            //           ),
            //           textAlign: TextAlign.left,
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            // SizedBox(height: 2.v),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                child: Text(
                  viewhierarchyItemModelObj.courseName ?? '',
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleSmall!.copyWith(
                    height: 1.43,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.v),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                viewhierarchyItemModelObj.batchStartDate.isNotEmpty
                    ? 'Batch Start: ${formatDate(viewhierarchyItemModelObj.batchStartDate)}'
                    : 'Batch Start: ${viewhierarchyItemModelObj.batchStartDate}',
                style: GoogleFonts.plusJakartaSans(
                  color: ColorResources.colorBlack,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 4.v),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      viewhierarchyItemModelObj.batchStartDate.isNotEmpty
                          ? 'Batch End   : ${formatDate(viewhierarchyItemModelObj.batchEndDate)}'
                          : 'Batch End   : ${viewhierarchyItemModelObj.batchEndDate}',
                      style: GoogleFonts.plusJakartaSans(
                        color: ColorResources.colorBlack,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  // Container(
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       CustomImageView(
                  //         imagePath: ImageConstant.imgStar,
                  //         height: 16.adaptSize,
                  //         width: 16.adaptSize,
                  //       ),
                  //       Padding(
                  //         padding: EdgeInsets.only(left: 2.v),
                  //         child: Text(
                  //           '${double.parse("20.00" ?? '0.0').toStringAsFixed(1)}',
                  //           style: CustomTextStyles.labelLarge_1,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
