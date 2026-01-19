import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:anandhu_s_application4/core/colors_res.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/controller/course_enrol_controller.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/day_category_screen.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/widgets/grid_view_day_widget.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/widgets/grid_view_mock_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DayByMockExamScreen extends StatefulWidget {
  final String courseId;
  final String moduleId;
  final String appBarTitle;
  int? isEnrollCourse;
  DayByMockExamScreen({
    super.key,
    required this.courseId,
    required this.moduleId,
    required this.appBarTitle,
    this.isEnrollCourse,
  });

  @override
  State<DayByMockExamScreen> createState() => _DayByMockExamScreenState();
}

class _DayByMockExamScreenState extends State<DayByMockExamScreen> {
  final CourseEnrolController enrolController = Get.find();
  @override
  void initState() {
    enrolController.getExamWithDays(widget.courseId, widget.moduleId!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                    widget.appBarTitle,
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
              child: GridViewMockExamWidget(
                examDays: enrolController.examDayList,
                onDayTapped: (day, title) {
                  Get.to(() => DayCategoryScreen(
                        title: title,
                        IsEnrollCourse: widget.isEnrollCourse,
                        isTab: false,
                        isExam: true,
                        isLibrary: false,
                        dayId: day.daysId.toString(),
                        courseId: widget.courseId,
                        moduleId: widget.moduleId!,
                      ));
                },
              ))),
    );
  }
}
