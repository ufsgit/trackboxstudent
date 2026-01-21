import 'package:anandhu_s_application4/core/colors_res.dart';
import 'package:anandhu_s_application4/http/http_urls.dart';
import 'package:anandhu_s_application4/http/loader.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/certificate_download_page.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/controller/course_details_page1_controller.dart';
import 'package:anandhu_s_application4/presentation/my_courses_page/controller/live_class_controller.dart';
import 'package:anandhu_s_application4/presentation/profile/controller/profile_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../../../core/app_export.dart';
import '../../exam_details_screen/exam_details_screen.dart';
import '../../filter_bottom_sheet_bottomsheet/controller/filter_bottom_sheet_controller.dart';
import '../../home_page/controller/home_controller.dart';
import '../../home_page/models/home_model.dart';
import '../controller/my_courses_controller.dart';
import '../models/my_courses_details_model.dart';

// ignore_for_file: must_be_immutable
class Viewhierarchy4ItemWidget extends StatelessWidget {
  Viewhierarchy4ItemWidget(
    this.viewhierarchy4ItemModelObj, {
    Key? key,
  }) : super(key: key);

  MyCourseDetailsModel viewhierarchy4ItemModelObj;

  var controller = Get.find<MyCoursesController>();
  HomeController homeController = Get.put(HomeController(HomeModel().obs));
  final ProfileController profileController = Get.find<ProfileController>();

  var filteredBottomController = Get.put(FilterBottomSheetController());

  CourseModuleController moduleController = Get.put(CourseModuleController());

  String formatDate(String date) {
    DateTime parsedDate = DateTime.parse(date);
    return "${parsedDate.day.toString().padLeft(2, '0')}-"
        "${parsedDate.month.toString().padLeft(2, '0')}-"
        "${parsedDate.year}";
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        // ✅ ONLY FIX: THIS WAS COMMENTED BEFORE
        Loader.showLoader();

        await moduleController.getCourseInfo(
          courseId: viewhierarchy4ItemModelObj.courseId,
        );

        Loader.stopLoader();

        Get.to(() => ExamDetailsScreen(
              isNotificationClick: false,
              courseId: viewhierarchy4ItemModelObj.courseId,
              batchId: viewhierarchy4ItemModelObj.batchID,
            ));
      },
      child: Container(
        padding: EdgeInsets.all(5.h),
        decoration: AppDecoration.outlineIndigo5001.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 19.h),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
                    child: Container(
                      height: 65.v,
                      width: 103.h,
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          blurRadius: 2,
                          color: viewhierarchy4ItemModelObj.imagePath != 'null'
                              ? ColorResources.colorgrey400
                              : ColorResources.colorgrey300,
                        )
                      ]),
                      child: CachedNetworkImage(
                        imageUrl:
                            '${HttpUrls.imgBaseUrl}${viewhierarchy4ItemModelObj.imagePath}',
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => Center(
                          child: Icon(
                            Icons.image_not_supported_outlined,
                            color: ColorResources.colorBlue100,
                            size: 40,
                          ),
                        ),
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(
                            color: ColorResources.colorBlue500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 170.h,
                        child: Text(
                          viewhierarchy4ItemModelObj.courseName,
                          style: theme.textTheme.titleSmall!.copyWith(
                            height: 1.43,
                          ),
                          softWrap: true,
                        ),
                      ),
                      SizedBox(height: 2.v),
                      Container(
                        width: 170.h,
                        child: Text(
                          'Batch:${viewhierarchy4ItemModelObj.batchName}',
                          style: theme.textTheme.titleSmall!.copyWith(
                            height: 1.43,
                          ),
                          softWrap: true,
                        ),
                      ),
                      SizedBox(height: 4.v),
                      Row(
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.imgFiles,
                            height: 18.adaptSize,
                            width: 18.adaptSize,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 4.h, top: 2.v),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        "${viewhierarchy4ItemModelObj.content_position} / ",
                                    style: CustomTextStyles
                                        .titleSmallPrimaryContainerMedium,
                                  ),
                                  TextSpan(
                                    text: viewhierarchy4ItemModelObj
                                        .total_content_count
                                        .toString(),
                                    style: CustomTextStyles
                                        .labelLargeBluegray500Medium_1,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 13.v),
            Row(
              children: [
                Text(
                  "${viewhierarchy4ItemModelObj.course_completion_percentage}%",
                  style: theme.textTheme.titleSmall,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: LinearProgressIndicator(
                      backgroundColor: const Color.fromARGB(255, 235, 235, 235),
                      color: const Color.fromARGB(255, 56, 175, 255),
                      value: double.parse(viewhierarchy4ItemModelObj
                              .course_completion_percentage) /
                          100,
                      minHeight: 3,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 6),
            Text(
              'Batch Start: ${formatDate(viewhierarchy4ItemModelObj.batchStartDate)}',
              style: theme.textTheme.titleSmall,
            ),
            SizedBox(height: 6),
            Text(
              'Batch End: ${formatDate(viewhierarchy4ItemModelObj.batchEndDate)}',
              style: theme.textTheme.titleSmall,
            ),
            SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Expiry date: ${DateFormat('dd-MM-yyyy').format(viewhierarchy4ItemModelObj.expiryDate)}',
                  style: theme.textTheme.titleSmall,
                ),
                viewhierarchy4ItemModelObj.certificateIssue == 1
                    ? InkWell(
                        onTap: () {
                          // Get.to(() => CertificateDownloadPage(
                          //       profileController.profileData!.firstName +
                          //           profileController.profileData!.lastName,
                          //       viewhierarchy4ItemModelObj.courseName,
                          //     ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Text(
                            'View certificate',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              color: ColorResources.colorBlue500,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      )
                    : SizedBox()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
