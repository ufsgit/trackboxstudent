import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:anandhu_s_application4/core/colors_res.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/controller/course_enrol_controller.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/day_category_screen.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/widgets/grid_view_day_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class DayByModuleScreen extends StatefulWidget {
  final String courseId;
  final String moduleId;
  final bool isLibrary;
  final String appBarTitle;

  DayByModuleScreen({
    super.key,
    required this.courseId,
    required this.moduleId,
    required this.appBarTitle,
    required this.isLibrary,
  });

  @override
  State<DayByModuleScreen> createState() => _DayByModuleScreenState();
}

class _DayByModuleScreenState extends State<DayByModuleScreen> {
  final CourseEnrolController enrolController = Get.find();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await enrolController.getBatchWithDays(widget.courseId, widget.moduleId);
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
          child: Obx(
            () => enrolController.isLoading.value
                ? Center(
                    child: CircularProgressIndicator(
                    color: ColorResources.colorBlue500,
                  ))
                : enrolController.batchDaysList.isEmpty
                    ? Center(
                        child: Text(
                          'No days available',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: _loadData,
                        child: GridViewDayWidget(
                          batchDays: enrolController.batchDaysList,
                          onDayTapped: (day) {
                            Get.to(() => DayCategoryScreen(
                                  isTab: false,
                                  isExam: false,
                                  isLibrary: widget.isLibrary,
                                  dayId: day.daysId.toString(),
                                  courseId: widget.courseId,
                                  moduleId: widget.moduleId,
                                  title: '${widget.appBarTitle}-${day.dayName}',
                                ));
                          },
                        ),
                      ),
          ),
        ),
      ),
    );
  }
}
