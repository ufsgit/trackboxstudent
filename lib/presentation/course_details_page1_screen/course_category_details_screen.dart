import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/controller/exam_result_controller.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/day_category_screen.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/result_viewing_screen.dart';
import 'package:anandhu_s_application4/testpage/examcompletedpage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:anandhu_s_application4/core/colors_res.dart';
import 'package:anandhu_s_application4/http/http_urls.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/controller/course_details_page1_controller.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/controller/course_enrol_controller.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/controller/tab_controller.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/widgets/bottom_sheet_guidance.dart';

import 'package:anandhu_s_application4/presentation/course_details_page1_screen/widgets/read_more_widget.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/widgets/final_test_widget.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/course_module_page.dart';
import 'package:anandhu_s_application4/widgets/custom_elevated_button.dart';
import 'package:lottie/lottie.dart';
import '../../../core/utils/pref_utils.dart';
import '../../../testpage/exams_screen.dart';

class CourseCategoryDetailsScreen extends StatefulWidget {
  final int courseId;
  const CourseCategoryDetailsScreen({super.key, required this.courseId});

  @override
  State<CourseCategoryDetailsScreen> createState() =>
      _CourseCategoryDetailsScreenState();
}

class _CourseCategoryDetailsScreenState
    extends State<CourseCategoryDetailsScreen>
    with SingleTickerProviderStateMixin {
  final CourseModuleController controller = Get.find();
  final CourseEnrolController enrolController = Get.find();
  final TabControllerState tabControllerState = Get.put(TabControllerState());
  final ExamResultController examResultController = Get.find();
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
        length: enrolController.courseEnrollist.isNotEmpty &&
                enrolController.courseEnrollist[0].studentCourseId != 0
            ? 4
            : 3,
        vsync: this);
    _tabController.addListener(_handleTabChange);
    if (enrolController.courseEnrollist[0].studentCourseId != 0) {
      examResultController.getExamResults(widget.courseId.toString());
    }

    super.initState();
  }

  void _handleTabChange() {
    tabControllerState.setIndex(_tabController.index);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(75),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                      color: ColorResources.colorBlue100,
                      borderRadius: BorderRadius.circular(100)),
                  child: IconButton(
                    padding: EdgeInsets.all(0),
                    constraints: BoxConstraints(),
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      CupertinoIcons.back,
                      color: ColorResources.colorBlack.withOpacity(.8),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  'Course details',
                  style: GoogleFonts.plusJakartaSans(
                    color: ColorResources.colorBlack,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Obx(
          () {
            if (controller.courseInfo.isEmpty &&
                enrolController.courseEnrollist.isEmpty) {
              return Center(
                child: CircularProgressIndicator(
                  color: ColorResources.colorBlue500,
                ),
              );
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            '${HttpUrls.imgBaseUrl}${controller.courseInfo[0].thumbnailPath ?? ''}',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      controller.courseInfo[0].courseName,
                      style: GoogleFonts.plusJakartaSans(
                        color: ColorResources.colorBlack,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  controller.courseInfo[0].description != ''
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: ReadMoreWidget(
                            description: controller.courseInfo[0].description,
                          ),
                        )
                      : SizedBox(),
                  controller.courseInfo[0].description != ''
                      ? SizedBox(height: 32)
                      : SizedBox(),
                  Obx(() {
                    // double listViewHeight;

                    // if (tabControllerState.currentIndex.value == 2) {
                    //   listViewHeight = Get.height / 1.8;
                    // } else if (tabControllerState.currentIndex.value == 1) {
                    //   int itemCount = 6;
                    //   listViewHeight = itemCount * 55.0;
                    // } else {
                    //   int itemCount = controller.courseModulesList.isNotEmpty
                    //       ? controller.courseModulesList.length + 1
                    //       : controller.courseModulesList.length;
                    //   listViewHeight = itemCount * 70.0;
                    // }

                    return DefaultTabController(
                      length:
                          enrolController.courseEnrollist[0].studentCourseId !=
                                  0
                              ? 4
                              : 3,
                      child: Column(
                        children: [
                          TabBar(
                            controller: _tabController,
                            isScrollable: false,
                            tabAlignment: TabAlignment.fill,
                            dividerColor: Colors.white,
                            tabs: [
                              Tab(
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    'Modules',
                                    style: GoogleFonts.plusJakartaSans(
                                      color: ColorResources.colorgrey700,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                              Tab(
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    'Library',
                                    style: GoogleFonts.plusJakartaSans(
                                      color: ColorResources.colorgrey700,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                              Tab(
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    'Exams',
                                    style: GoogleFonts.plusJakartaSans(
                                      color: ColorResources.colorgrey700,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                              if (enrolController
                                      .courseEnrollist[0].studentCourseId !=
                                  0)
                                Tab(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      'Results',
                                      style: GoogleFonts.plusJakartaSans(
                                        color: ColorResources.colorgrey700,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                            indicatorColor: ColorResources.colorBlue300,
                            labelColor: ColorResources.colorBlack,
                            unselectedLabelColor: ColorResources.colorgrey500,
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                            height: Get.height / 2,
                            child: TabBarView(
                              // physics: NeverScrollableScrollPhysics(),
                              controller: _tabController,
                              children: [
                                Obx(
                                  () {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: CourseModulePage(
                                        indexx: tabControllerState
                                            .currentIndex.value,
                                        isLibrary: false,
                                        IsEnrollCourse: enrolController
                                            .courseEnrollist[0].studentCourseId,
                                        badgeIcons: [
                                          'assets/images/Bronze.png',
                                          'assets/images/Silver.png',
                                          'assets/images/Gold.png',
                                        ],
                                        courseId: widget.courseId,
                                      ),
                                    );
                                  },
                                ),
                                DayCategoryScreen(
                                  title: '',
                                  IsEnrollCourse: enrolController
                                      .courseEnrollist[0].studentCourseId,
                                  isTab: true,
                                  isExam: true,
                                  isLibrary: true,
                                  dayId: '0',
                                  courseId: widget.courseId.toString(),
                                  moduleId: '0',
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8, left: 18, right: 16, bottom: 24),
                                  child: ExamsHomeScreen(
                                    courseId: widget.courseId.toString(),
                                    token: PrefUtils().getAuthToken(),
                                  ),
                                ),
                                if (enrolController
                                        .courseEnrollist[0].studentCourseId !=
                                    0)
                                  ExamResultsScreen(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: Obx(() {
          if (enrolController.courseEnrollist.isNotEmpty &&
              enrolController.courseEnrollist[0].studentCourseId != 0) {
            return SizedBox();
          }
          return _buildTotalPriceRow();
        }),
      ),
    );
  }

////widget for course enrolling
  Widget _buildTotalPriceRow() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 12, top: 12),
      child: Container(
        decoration: AppDecoration.gradientWhiteAToWhiteA,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Price',
                    style: CustomTextStyles.titleSmallBluegray80001Medium,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (controller.courseInfo[0].price != "0.00")
                        Padding(
                          padding: EdgeInsets.only(bottom: 1.v),
                          child: Text(
                            "lbl".tr,
                            style: CustomTextStyles.titleMediumMedium,
                          ),
                        ),
                      Text(
                        controller.courseInfo.isEmpty
                            ? ''
                            : controller.courseInfo[0].price == "0.00"
                                ? 'Free'
                                : controller.courseInfo[0].price,
                        style: CustomTextStyles.titleMedium18,
                      )
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16, top: 8),
              child: CustomElevatedButton(
                onPressed: () async {
                  enrolController.courseEnrollist[0].studentCourseId != 0
                      ? Get.showSnackbar(GetSnackBar(
                          message: 'Already Enrolled',
                          duration: Duration(milliseconds: 2000),
                        ))
                      : await showModalBottomSheet(
                          context: Get.context!,
                          builder: (context) => BottomSheetGuidanceWidget(
                            amount: controller.courseInfo[0].price,
                            courseId: controller.courseInfo[0].courseId,
                            courseName: controller.courseInfo[0].courseName,
                            description: controller.courseInfo[0].description,
                            price: controller.courseInfo[0].price,
                            slotId: '0',
                            thumbNailPath:
                                controller.courseInfo[0].thumbnailPath,
                          ),
                        );
                },
                width: 169.h,
                text: "lbl_enroll_now".tr,
              ),
            )
          ],
        ),
      ),
    );
  }
}
