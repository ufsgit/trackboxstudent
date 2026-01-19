import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:anandhu_s_application4/core/colors_res.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/widgets/checkout_bottom_sheet.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/widgets/time_slots_bottom_sheet_widget.dart';

import 'package:flutter/material.dart';
import 'package:hypersdkflutter/hypersdkflutter.dart';

import '../../home_page/controller/home_controller.dart';
import '../../home_page/models/home_model.dart';

// ignore: must_be_immutable
class BottomSheetGuidanceWidget extends StatelessWidget {
  final String amount;
  final int courseId;
  final String slotId;
  final String courseName;
  final String thumbNailPath;
  final String description;
  final String price;
  BottomSheetGuidanceWidget({
    Key? key,
    // required this.courseDetails,
    required this.amount,
    required this.courseId,
    required this.slotId,
    required this.courseName,
    required this.thumbNailPath,
    required this.description,
    required this.price,
  }) : super(key: key);

  // final CourseDetailsListModel? courseDetails;
  HomeController controllerCourseDetailsController =
      Get.put(HomeController(HomeModel().obs));
  HyperSDK hyperSDK = HyperSDK();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 401.v,
      width: Get.width,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12.v)),
      child: Column(children: [
        SizedBox(
          height: 12.v,
        ),
        Container(
          width: 50.v,
          height: 6.v,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: ColorResources.colorgrey300,
          ),
        ),
        SizedBox(
          height: 32.v,
        ),
        Container(
          width: 190.v,
          height: 160.v,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/enrol_image.png'))),
        ),
        SizedBox(
          height: 24.v,
        ),
        Text(
          'Exclusive 1:1 Guidance',
          style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: ColorResources.colorgrey700),
        ),
        SizedBox(
          height: 16.v,
        ),
        Text(
          'This course includes 1:1 mentoring support\nPlease choose a suitable time for your sessions',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: ColorResources.colorgrey500),
        ),
        Expanded(child: SizedBox()),
        InkWell(
          onTap: () async {
            await showModalBottomSheet(
              context: Get.context!,
              isDismissible: false,
              builder: (context) => CheckoutBottomSheetWidget(
                amount: amount,
                courseId: courseId.toString(),
                courseName: courseName,
                description: description,
                price: price,
                thumbNailPath: thumbNailPath,
                slotId: '0',
                hyperSdk: hyperSDK,
              ),
            );
          },
          child: Container(
            width: 328.v,
            height: 40.v,
            decoration: BoxDecoration(
                color: Color(0xff1863D3),
                borderRadius: BorderRadius.circular(42.v)),
            child: Center(
              child: Text(
                'Continue',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 24.v,
        ),
      ]),
    );
  }
}
