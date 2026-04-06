// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:anandhu_s_application4/presentation/course_details_page1_screen/controller/course_details_page1_controller.dart';
// import 'package:anandhu_s_application4/presentation/course_details_page1_screen/widgets/module_widget.dart';
// import 'package:anandhu_s_application4/presentation/course_details_page1_screen/course_details_page1_screen.dart';

// class CourseModulePage extends StatefulWidget {
//   final List<String> badgeIcons;
//   final List<String> moduleNames;
//   final int courseId;
//   final int IsEnrollCourse;

//   const CourseModulePage({
//     super.key,
//     required this.badgeIcons,
//     required this.moduleNames,
//     required this.courseId,
//     required this.IsEnrollCourse,
//   });

//   @override
//   State<CourseModulePage> createState() => _CourseModulePageState();
// }

// class _CourseModulePageState extends State<CourseModulePage> {
//   final CourseModuleController controller = Get.put(CourseModuleController());

//   @override
//   void initState() {
//     super.initState();
//     controller.getCourseModules();
//   }

//   void _onModuleTap(BuildContext context, int index,
//       {required String courseId, required String moduleId}) {
//     final module = controller.courseModulesList[index];
//     final isLocked = widget.IsEnrollCourse == 0 || module.lockedStatus == 1;

//     if (isLocked) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Please purchase the course to see full contents.'),
//           duration: Duration(seconds: 2),
//         ),
//       );
//     } else {
//       Get.to(() =>
//           CourseDetailsPage1Screen(courseId: courseId, moduleId: moduleId));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () {
//         print('courseModulesList length: ${controller.courseModulesList.length}');
//         print('BadgeIcons length: ${widget.badgeIcons.length}');

//         if (controller.courseModulesList.isEmpty) {
//           return Center(child: CircularProgressIndicator());
//         }

//         return ListView.separated(
//           separatorBuilder: (context, index) => SizedBox(height: 8),
//           itemCount: controller.courseModulesList.length,
//           itemBuilder: (context, index) {
//             final badgeIcon = index < widget.badgeIcons.length
//                 ? widget.badgeIcons[index]
//                 : 'assets/images/Bronze.png';

//             final module = controller.courseModulesList[index];
//             final isLocked =
//                 widget.IsEnrollCourse == 0 || module.lockedStatus == 1;

//             return ModuleWidget(
//               isLocked: isLocked,
//               onTap: !isLocked
//                   ? () {
//                       _onModuleTap(
//                         context,
//                         index,
//                         moduleId: module.moduleId.toString(),
//                         courseId: widget.courseId.toString(),
//                       );
//                     }
//                   : () {
//                       _onModuleTap(
//                         context,
//                         index,
//                         moduleId: module.moduleId.toString(),
//                         courseId: widget.courseId.toString(),
//                       );
//                     },
//               badgeIcon: badgeIcon,
//               moduleName: module.moduleName,
//             );
//           },
//         );
//       },
//     );
//   }
// }

import 'package:anandhu_s_application4/core/colors_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/controller/course_details_page1_controller.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/controller/course_enrol_controller.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/models/batch_day_model.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/widgets/grid_view_day_widget.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/day_category_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class CourseModulePage extends StatefulWidget {
  final List<String> badgeIcons;
  final int courseId;
  final int IsEnrollCourse;
  final bool isLibrary;
  final int indexx;

  const CourseModulePage({
    Key? key,
    required this.badgeIcons,
    required this.courseId,
    required this.IsEnrollCourse,
    required this.isLibrary,
    required this.indexx,
  }) : super(key: key);

  @override
  State<CourseModulePage> createState() => _CourseModulePageState();
}

class _CourseModulePageState extends State<CourseModulePage> {
  final CourseModuleController controller = Get.put(CourseModuleController());
  final CourseEnrolController enrolController = Get.find();
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    controller.getCoursesModules(courseId: widget.courseId.toString());
  }


  //on day tap function
  void _onDayTap(BuildContext context, BatchWithDaysModel day,
      {required String courseId, required String moduleId}) {
    final isLocked = widget.IsEnrollCourse == 0;

    if (isLocked) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please purchase the course to see full contents.'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      Get.to(() => DayCategoryScreen(
            isTab: false,
            isExam: false,
            isLibrary: widget.isLibrary,
            dayId: day.daysId.toString(),
            courseId: courseId,
            moduleId: moduleId,
            title: day.dayName,
          ));
    }
  }

/*
  void _onModuleTap(BuildContext context, int index,
      {required String courseId,
      required String moduleId,
      required String title}) {
    setState(() {
      selectedIndex = index;
    });
    
    if (index < controller.courseModulesList.length) {
      // final module = controller.courseModulesList[index];
      // final isLocked =
      //     widget.IsEnrollCourse == 0 || module.isStudentModuleLocked == 1;

      // if (isLocked) {
      //   if (module.isStudentModuleLocked == 1) {
      //     ScaffoldMessenger.of(context).showSnackBar(
      //       SnackBar(
      //         content: Text('This module is locked'),
      //         duration: Duration(seconds: 2),
      //       ),
      //     );
      //   } else {
      //     ScaffoldMessenger.of(context).showSnackBar(
      //       SnackBar(
      //         content: Text('Please purchase the course to see full contents.'),
      //         duration: Duration(seconds: 2),
      //       ),
      //     );
      //   }
      // } else {
      //   Get.to(() => DayByModuleScreen(
      //         courseId: courseId,
      //         moduleId: moduleId,
      //         appBarTitle: title,
      //         isLibrary: widget.isLibrary,
      //       ));
      // }
    } else {
       // Logic for Recordings/Mock Test
       if (widget.indexx == 1) {
          if (widget.IsEnrollCourse == 0) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Please purchase the course to see full contents.'),
                duration: Duration(seconds: 2),
              ),
            );
          } else {
            Get.to(() => CourseRecordingsScreen(courseId: widget.courseId.toString()));
          }
       } else if (widget.indexx == 0) {
          if (widget.IsEnrollCourse == 0) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Please purchase the course to see full contents.'),
                duration: Duration(seconds: 2),
              ),
            );
          } else {
            Get.to(() => MockTestModuleScreen(
                badgeIcons: widget.badgeIcons,
                courseId: widget.courseId,
                IsEnrollCourse: widget.IsEnrollCourse,
              ));
          }
       }
    }
  }
*/

  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.courseModulesList.isEmpty) {
        return Center(
          child: CircularProgressIndicator(
            color: ColorResources.colorBlue500,
          ),
        );
      }

/*
      // Old Module Grid Logic (Commented Out)
      // final totalItemCount = controller.courseModulesList.length + 1;
      // return GridView.builder(
      //   physics: NeverScrollableScrollPhysics(),
      //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //     crossAxisCount: 2,
      //     crossAxisSpacing: 8.0,
      //     mainAxisSpacing: 8.0,
      //     mainAxisExtent: 120,
      //   ),
      //   itemCount: totalItemCount,
      //   itemBuilder: (context, index) {
      //     if (index < controller.courseModulesList.length) {
      //       final badgeIcon = index < widget.badgeIcons.length
      //           ? widget.badgeIcons[index]
      //           : 'assets/images/Bronze.png';

      //       final module = controller.courseModulesList[index];
      //       final isLocked =
      //           widget.IsEnrollCourse == 0 || module.isStudentModuleLocked == 1;
      //       final isSelected = selectedIndex == index;

      //       return ModuleWidget(
      //         isLocked: isLocked,
      //         isSelected: isSelected,
      //         onTap: () => _onModuleTap(context, index,
      //             moduleId: module.moduleId.toString(),
      //             courseId: widget.courseId.toString(),
      //             title: module.moduleName),
      //         badgeIcon: badgeIcon,
      //         moduleName: module.moduleName,
      //       );
      //     }
      //     return SizedBox.shrink();
      //   },
      // );
*/

      final moduleId = controller.courseModulesList[0].moduleId.toString();
      
      // Auto-fetch days if list is empty for the first module
      if (enrolController.batchDaysList.isEmpty && !enrolController.isLoading.value) {
        enrolController.getBatchWithDays(widget.courseId.toString(), moduleId);
      }

      if (enrolController.isLoading.value) {
        return Center(
          child: CircularProgressIndicator(
            color: ColorResources.colorBlue500,
          ),
        );
      }

      if (enrolController.batchDaysList.isEmpty) {
         return Center(
           child: Text(
             'No days available',
             style: GoogleFonts.plusJakartaSans(
               fontSize: 16,
               fontWeight: FontWeight.w500,
             ),
           ),
         );
      }

      return RefreshIndicator(
        onRefresh: () => enrolController.getBatchWithDays(widget.courseId.toString(), moduleId),
        child: GridViewDayWidget(
          batchDays: enrolController.batchDaysList,
          onDayTapped: (day) => _onDayTap(context, day,
              courseId: widget.courseId.toString(),
              moduleId: moduleId),
        ),
      );
    });
  }
}
