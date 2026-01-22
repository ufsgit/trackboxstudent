// import 'package:anandhu_s_application4/core/app_export.dart';
// import 'package:anandhu_s_application4/http/http_urls.dart';
// import 'package:anandhu_s_application4/presentation/course_details_page1_screen/controller/course_details_page1_controller.dart';
// import 'package:anandhu_s_application4/presentation/course_details_page1_screen/controller/course_enrol_controller.dart';
// import 'package:anandhu_s_application4/presentation/course_details_page1_screen/course_category_details_screen.dart';
// import 'package:anandhu_s_application4/presentation/explore_courses/controller/course_access_controller.dart';
// import 'package:anandhu_s_application4/presentation/explore_courses/controller/explore_course_controller.dart';
// import 'package:anandhu_s_application4/presentation/explore_courses/model/explore_course_model.dart';
// import 'package:anandhu_s_application4/presentation/home_page/controller/home_controller.dart';
// import 'package:anandhu_s_application4/presentation/profile/controller/profile_controller.dart';
// import 'package:anandhu_s_application4/widgets/custom_search_view.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import '../../core/colors_res.dart';

// class ExploreCourses extends StatefulWidget {
//   ExploreCourses({super.key});

//   @override
//   State<ExploreCourses> createState() => _ExploreCoursesState();
// }

// class _ExploreCoursesState extends State<ExploreCourses> with RouteAware {
//   late ExploreCourseController expController;
//   TextEditingController searchController = TextEditingController();
//   var controller = Get.find<HomeController>();
//   final courseInfoController = Get.find<CourseModuleController>();
//   final enrolController = Get.find<CourseEnrolController>();
//   final profileController = Get.find<ProfileController>();

//   // Add selected course ID tracking
//   RxInt selectedCourseId = RxInt(-1);

//   @override
//   void initState() {
//     super.initState();
//     expController = Get.put(ExploreCourseController());
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       RouteObserver<PageRoute>()
//           .subscribe(this, ModalRoute.of(context)! as PageRoute);

//       expController.getAllExploreCourses();
//     });
//   }

//   @override
//   void didPopNext() {
//     searchController.clear();
//     expController.resetSearch();
//     // Reset selected course when returning to this screen
//     selectedCourseId.value = -1;
//     super.didPopNext();
//   }

//   @override
//   void dispose() {
//     searchController.dispose();
//     RouteObserver<PageRoute>().unsubscribe(this);
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         backgroundColor: appTheme.whiteA700,
//         appBar: AppBar(
//           leadingWidth: 36.h,
//           leading: InkWell(
//             onTap: () {
//               onTapArrowleftone();
//             },
//             child: Padding(
//               padding: EdgeInsets.only(left: 16.v),
//               child: Icon(
//                 Icons.arrow_back_ios,
//                 color: ColorResources.colorBlack.withOpacity(.2),
//               ),
//             ),
//           ),
//           title: Text(
//             'Explore Courses',
//             style: CustomTextStyles.titleMediumBluegray8000118,
//           ),
//         ),
//         body: SizedBox(
//           width: SizeUtils.width,
//           child: SingleChildScrollView(
//             padding: EdgeInsets.only(top: 0.v),
//             child: Container(
//               margin: EdgeInsets.only(bottom: 5.v),
//               padding: EdgeInsets.symmetric(horizontal: 16.h),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: 10.v),
//                   CustomSearchView(
//                     controller: searchController,
//                     hintText: "lbl_search_courses".tr,
//                     suffix: SizedBox(),
//                     onChanged: (value) {
//                       expController.filterCourses(value);
//                     },
//                   ),
//                   SizedBox(height: 22.v),
//                   Obx(
//                     () => expController.isLoading.value
//                         ? Column(
//                             children: [
//                               SizedBox(
//                                 height: Get.height / 3,
//                               ),
//                               Center(
//                                   child: CircularProgressIndicator(
//                                 color: ColorResources.colorBlue500,
//                               )),
//                             ],
//                           )
//                         : expController.exploreCoursesList.isEmpty
//                             ? Container(
//                                 width: Get.width,
//                                 height: Get.height / 1.5,
//                                 child: Center(
//                                   child: Text(
//                                     "Courses List is Empty!",
//                                     style: CustomTextStyles.bodySmallBlack900,
//                                   ),
//                                 ),
//                               )
//                             : expController.displayedCourses.isEmpty
//                                 ? Container(
//                                     width: Get.width,
//                                     height: Get.height / 1.5,
//                                     child: Center(
//                                       child: Text(
//                                         "No courses found",
//                                         style:
//                                             CustomTextStyles.bodySmallBlack900,
//                                       ),
//                                     ),
//                                   )
//                                 : _buildViewhierarchy(),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildViewhierarchy() {
//     return ListView.separated(
//       physics: NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       separatorBuilder: (context, index) {
//         return SizedBox(height: 24.v);
//       },
//       itemCount: expController.displayedCourses.length,
//       itemBuilder: (context, index) {
//         ExploreCoursesModel model = expController.displayedCourses[index];
//         return Obx(() => InkWell(
//               onTap: () async {
//                 // selectedCourseId.value = model.courseId ?? -1;
//                 // await courseInfoController.getCourseInfo(
//                 //     courseId: model.courseId ?? 0);
//                 // await enrolController
//                 //     .checkCourseEnrolled(model.courseId.toString());
//                 // Get.to(() =>
//                 //     CourseCategoryDetailsScreen(courseId: model.courseId ?? 0));
//                 final CourseAccessController accessController =
//                     Get.find<CourseAccessController>();

//                 if (profileController.studentIdsss.isNotEmpty) {
//                   if (!accessController.canAccessCourse(model.courseId ?? -1)) {
//                     selectedCourseId.value = model.courseId ?? -1;
//                     print('////////course courseid${model.courseId}');
//                     print('////////selected courseid${selectedCourseId}');
//                     accessController.showAccessDeniedToast(
//                         message:
//                             'Contact our supporting team member for enrollment and further assistance +918891504777',
//                         textColor: ColorResources.colorwhite,
//                         backgroundColor: const Color.fromARGB(255, 0, 0, 0));
//                     return;
//                   }
//                 }

//                 selectedCourseId.value = model.courseId ?? -1;
//                 await courseInfoController.getCourseInfo(
//                     courseId: model.courseId ?? 0);
//                 await enrolController
//                     .checkCourseEnrolled(model.courseId.toString());
//                 Get.to(() =>
//                     CourseCategoryDetailsScreen(courseId: model.courseId ?? 0));
//               },
//               child: AnimatedContainer(
//                 duration: Duration(milliseconds: 300),
//                 padding: EdgeInsets.all(5.h),
//                 decoration: AppDecoration.outlineIndigo5001.copyWith(
//                   borderRadius: BorderRadiusStyle.roundedBorder8,
//                   border: Border.all(
//                     color: selectedCourseId.value == model.courseId
//                         ? ColorResources.colorBlue500
//                         : Colors.transparent,
//                     width: 1.5,
//                   ),
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 8, vertical: 8),
//                           child: Container(
//                             height: 80.h,
//                             width: 110.v,
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(8.v),
//                                 boxShadow: [
//                                   BoxShadow(
//                                       blurRadius: 2,
//                                       color: model.thumbnailPath != 'null'
//                                           ? ColorResources.colorgrey500
//                                           : ColorResources.colorgrey300)
//                                 ]),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(8.v),
//                               child: CachedNetworkImage(
//                                 imageUrl:
//                                     '${HttpUrls.imgBaseUrl}${model.thumbnailPath}',
//                                 fit: BoxFit.cover,
//                                 placeholder: (context, url) => Center(
//                                     child: CircularProgressIndicator(
//                                   color: ColorResources.colorBlue500,
//                                 )),
//                                 errorWidget: (context, url, error) => Center(
//                                   child: Icon(
//                                     Icons.image_not_supported_outlined,
//                                     color: ColorResources.colorgrey600,
//                                     size: 40,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(left: 12.h, top: 2.v),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               SizedBox(
//                                 width: 180.h,
//                                 child: Text(
//                                   model.courseName ?? 'No name',
//                                   maxLines: 2,
//                                   overflow: TextOverflow.ellipsis,
//                                   style: theme.textTheme.titleSmall!
//                                       .copyWith(height: 1.43),
//                                 ),
//                               ),
//                               SizedBox(height: 2.v),
//                               SizedBox(
//                                 width: 180.h,
//                                 child: Text(
//                                   model.price == '0.00'
//                                       ? 'FREE'
//                                       : '₹ ${model.price}',
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                   style: theme.textTheme.titleSmall!
//                                       .copyWith(height: 1.43),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ));
//       },
//     );
//   }

//   void onTapArrowleftone() {
//     Get.back();
//   }
// }
