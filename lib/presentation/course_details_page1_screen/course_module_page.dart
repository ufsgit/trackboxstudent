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
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/mock_test_module_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/controller/course_details_page1_controller.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/widgets/module_widget.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/day_by_module_screen.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/course_recordings_screen.dart';
import 'package:lottie/lottie.dart';

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
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    controller.getCoursesModules(courseId: widget.courseId.toString());
  }

//on module tap function
  void _onModuleTap(BuildContext context, int index,
      {required String courseId,
      required String moduleId,
      required String title}) {
    setState(() {
      selectedIndex = index;
    });
    // final filteredModules = !widget.isLibrary
    //     ? controller.courseModulesList
    //         .where((module) => module.moduleName != 'Running Materials')
    //         .toList()
    //     : controller.courseModulesList
    //         .where((module) =>
    //             module.moduleName != 'Advance' &&
    //             module.moduleName != 'Exam' &&
    //             module.moduleName != 'Mock Exam')
    // .toList();
    if (index < controller.courseModulesList.length) {
      final module = controller.courseModulesList[index];
      final isLocked =
          widget.IsEnrollCourse == 0 || module.isStudentModuleLocked == 1;

      if (isLocked) {
        if (module.isStudentModuleLocked == 1) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('This module is locked'),
              duration: Duration(seconds: 2),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Please purchase the course to see full contents.'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      } else {
        Get.to(() => DayByModuleScreen(
              courseId: courseId,
              moduleId: moduleId,
              appBarTitle: title,
              isLibrary: widget.isLibrary,
            ));
      }
    } else if (index == controller.courseModulesList.length) {
      if (widget.indexx == 1) {
        if (widget.IsEnrollCourse == 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Please purchase the course to see full contents.'),
              duration: Duration(seconds: 2),
            ),
          );
        } else {
          Get.to(() =>
              CourseRecordingsScreen(courseId: widget.courseId.toString()));
        }
      } else if (widget.indexx == 0) {
        final isLocked = widget.IsEnrollCourse == 0;
        if (isLocked) {
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

  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.courseModulesList.isEmpty) {
        return Center(
          child: CircularProgressIndicator(
            color: ColorResources.colorBlue500,
          ),
        );
      }
      // final filteredModules = widget.isLibrary
      //     ? controller.courseModulesList
      //         .where((module) => module.moduleName != 'Running Materials')
      //         .toList()
      //     : controller.courseModulesList
      //         .where((module) =>
      //             module.moduleName != 'Advance' &&
      //             module.moduleName != 'Exam' &&
      //             module.moduleName != 'Mock Exam')
      //         .toList();

      final totalItemCount = controller.courseModulesList.length + 1;

      return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          mainAxisExtent: 120,
        ),
        itemCount: totalItemCount,
        itemBuilder: (context, index) {
          if (index < controller.courseModulesList.length) {
            final badgeIcon = index < widget.badgeIcons.length
                ? widget.badgeIcons[index]
                : 'assets/images/Bronze.png';

            final module = controller.courseModulesList[index];
            final isLocked =
                widget.IsEnrollCourse == 0 || module.isStudentModuleLocked == 1;
            final isSelected = selectedIndex == index;

            return ModuleWidget(
              isLocked: isLocked,
              isSelected: isSelected,
              onTap: () => _onModuleTap(context, index,
                  moduleId: module.moduleId.toString(),
                  courseId: widget.courseId.toString(),
                  title: module.moduleName),
              badgeIcon: badgeIcon,
              moduleName: module.moduleName,
            );
          } else if (index == controller.courseModulesList.length) {
            final isSelected = selectedIndex == index;
            final isLocked = widget.IsEnrollCourse == 0;

            // if (widget.indexx == 1) {
            //   return ModuleWidget(
            //     isLocked: isLocked,
            //     isSelected: isSelected,
            //     onTap: () => _onModuleTap(context, index,
            //         moduleId: '',
            //         courseId: widget.courseId.toString(),
            //         title: 'Recordings'),
            //     badgeIcon: 'assets/images/time_loader.png',
            //     moduleName: 'Recordings',
            //   );
            // } else if (widget.indexx == 0) {
            //   return SizedBox();
            //   // return ModuleWidget(
            //   //   isLocked: isLocked,
            //   //   isSelected: isSelected,
            //   //   onTap: () => _onModuleTap(context, index,
            //   //       moduleId: '',
            //   //       courseId: widget.courseId.toString(),
            //   //       title: 'Mock Test'),
            //   //   badgeIcon: 'assets/images/EmptyState (1).png',
            //   //   moduleName: 'Mock Test',
            //   // );
            // }
          }
          return SizedBox.shrink();
        },
      );
    });
  }
}
