// import 'package:anandhu_s_application4/core/app_export.dart';
// import 'package:anandhu_s_application4/core/colors_res.dart';
// import 'package:anandhu_s_application4/presentation/course_details_page1_screen/widgets/checkout_bottom_sheet.dart';

// import 'package:flutter/material.dart';
// import 'package:hypersdkflutter/hypersdkflutter.dart';

// import '../../home_page/controller/home_controller.dart';
// import '../../home_page/models/home_model.dart';

// class TimeSlotsBottomSheetWidget extends StatefulWidget {
//   final String amount;
//   final int courseId;
//   final String courseName;
//   final String thumbNailPath;
//   final String description;
//   final String price;
//   TimeSlotsBottomSheetWidget(
//       {Key? key,
//       required this.amount,
//       required this.courseId,
//       required this.courseName,
//       required this.thumbNailPath,
//       required this.description,
//       required this.price})
//       : super(key: key);

//   // final CourseDetailsListModel? courseDetails;

//   @override
//   _TimeSlotsBottomSheetWidgetState createState() =>
//       _TimeSlotsBottomSheetWidgetState();
// }

// class _TimeSlotsBottomSheetWidgetState
//     extends State<TimeSlotsBottomSheetWidget> {
//   int? _selectedIndex;
//   HomeController controllerCourseDetailsController =
//       Get.put(HomeController(HomeModel().obs));
//   HyperSDK hyperSDK = HyperSDK();

//   @override
//   void initState() {
//     controllerCourseDetailsController.getCourseTimeSlot(widget.courseId);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () {
//         return Container(
//           // height: 401.v,
//           width: Get.width,
//           decoration: BoxDecoration(
//               color: Colors.white, borderRadius: BorderRadius.circular(12.v)),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//             child: Column(children: [
//               Container(
//                 width: 50.v,
//                 height: 6.v,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(30),
//                   color: ColorResources.colorgrey300,
//                 ),
//               ),
//               SizedBox(
//                 height: 16.v,
//               ),
//               Row(
//                 children: [
//                   InkWell(
//                       onTap: () {
//                         Get.back();
//                       },
//                       child: Icon(Icons.arrow_back_ios_rounded)),
//                   Expanded(child: SizedBox()),
//                   Text(
//                     'Choose a time',
//                     style: TextStyle(
//                         fontFamily: 'Plus Jakarta Sans',
//                         fontWeight: FontWeight.w700,
//                         fontSize: 16,
//                         color: ColorResources.colorgrey700),
//                   ),
//                   Expanded(child: SizedBox()),
//                 ],
//               ),
//               SizedBox(
//                 height: 24.v,
//               ),
//               Text(
//                 'Pick a time slot that works best for your\nmentoring session',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                     fontFamily: 'Plus Jakarta Sans',
//                     fontWeight: FontWeight.w400,
//                     fontSize: 14,
//                     color: ColorResources.colorgrey600),
//               ),
//               SizedBox(
//                 height: 24.v,
//               ),
//               Expanded(
//                 child: GridView.builder(
//                   shrinkWrap: true,
//                   physics: ClampingScrollPhysics(),
//                   itemCount:
//                       controllerCourseDetailsController.timeSlotList.length,
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       mainAxisExtent: 35,
//                       mainAxisSpacing: 16,
//                       crossAxisSpacing: 12),
//                   itemBuilder: (context, index) {
//                     return InkWell(
//                       onTap: () {
//                         setState(() {
//                           _selectedIndex = index;
//                         });
//                       },
//                       child: Container(
//                         height: 35,
//                         width: 150,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(50),
//                           border: Border.all(
//                             color: _selectedIndex == index
//                                 ? Colors.transparent
//                                 : ColorResources.colorgrey500,
//                           ),
//                           color: _selectedIndex == index
//                               ? ColorResources.colorBlue400
//                               : ColorResources.colorwhite,
//                         ),
//                         child: Center(
//                           child: Text(
//                             '${controllerCourseDetailsController.timeSlotList[index].startTime!} - ${controllerCourseDetailsController.timeSlotList[index].endTime!}',
//                             style: TextStyle(
//                                 fontFamily: 'Plus Jakarta Sans',
//                                 fontWeight: FontWeight.w700,
//                                 fontSize: 12,
//                                 color: _selectedIndex == index
//                                     ? ColorResources.colorwhite
//                                     : ColorResources.colorgrey700),
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               InkWell(
//                 onTap: _selectedIndex != null
//                     ? () async {
//                         await showModalBottomSheet(
//                           context: Get.context!,isDismissible: false,
//                           builder: (context) => CheckoutBottomSheetWidget(
//                             amount: widget.amount,
//                             courseId: widget.courseId.toString(),
//                             courseName: widget.courseName,
//                             description: widget.description,
//                             price: widget.price,
//                             thumbNailPath: widget.thumbNailPath,
//                             slotId: controllerCourseDetailsController
//                                 .timeSlotList[_selectedIndex!].slotId!
//                                 .toString(),
//                             hyperSdk: hyperSDK,
//                           ),
//                         );
//                       }
//                     : null,
//                 child: Container(
//                   width: 328.v,
//                   height: 40.v,
//                   decoration: BoxDecoration(
//                       color: _selectedIndex != null
//                           ? Color(0xff1863D3)
//                           : ColorResources.colorgrey400,
//                       borderRadius: BorderRadius.circular(42.v)),
//                   child: Center(
//                     child: Text(
//                       'Choose Schedule',
//                       style: TextStyle(
//                           color: Colors.white, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//               ),
//             ]),
//           ),
//         );
//       },
//     );
//   }
// }
