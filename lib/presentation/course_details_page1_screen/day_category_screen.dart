import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:anandhu_s_application4/core/colors_res.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/controller/course_content_controller.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/controller/course_details_page1_controller.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/controller/course_enrol_controller.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/course_details_page1_screen.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/course_recordings_screen.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/mock_test_module_screen.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/widgets/gridview_category_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DayCategoryScreen extends StatefulWidget {
  final String courseId;
  final String moduleId;
  final String dayId;
  final bool isLibrary;
  final bool isExam;
  final bool isTab;
  int? IsEnrollCourse;
  final String title;
  DayCategoryScreen(
      {super.key,
      required this.courseId,
      required this.moduleId,
      required this.dayId,
      required this.isLibrary,
      required this.isExam,
      required this.isTab,
      this.IsEnrollCourse,
      required this.title});

  @override
  State<DayCategoryScreen> createState() => _DayCategoryScreenState();
}

class _DayCategoryScreenState extends State<DayCategoryScreen> {
  final CourseEnrolController enrolController = Get.find();
  final CourseModuleController controller = Get.find();
  CourseContentController courseContentController =
      Get.put(CourseContentController());

  @override
  void initState() {
    controller.getSectionByCourse(courseId: widget.courseId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isLocked = widget.IsEnrollCourse == 0;
    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize:
                widget.isTab ? Size.fromHeight(0) : Size.fromHeight(60),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (widget.isTab == false)
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: 24,
                        width: 24,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: ColorResources.colorBlue100,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: ColorResources.colorBlack.withOpacity(.4),
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  SizedBox(width: 8),
                  Text(
                    widget.title,
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
          body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: GridviewCategoryWidget(
                isLocked: isLocked,
                onRecordingTapped: () {
                  isLocked
                      ? ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Please purchase the course to see full contents.'),
                            duration: Duration(seconds: 2),
                          ),
                        )
                      : Get.to(() => CourseRecordingsScreen(
                          courseId: widget.courseId.toString()));
                },
                isTab: widget.isTab,
                sectionByCourse: controller.sectionByModule,
                onDayTapped: (day) {
                  isLocked
                      ? ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Please purchase the course to see full contents.'),
                            duration: Duration(seconds: 2),
                          ),
                        )
                      : Get.to(() => CourseDetailsPage1Screen(
                            isLibrary: widget.isLibrary ? true : false,
                            courseId: widget.courseId,
                            moduleId: widget.moduleId,
                            sectionId: day.sectionId.toString(),
                            dayId: widget.dayId,
                          ));
                },
              ))),
    );
  }
}
