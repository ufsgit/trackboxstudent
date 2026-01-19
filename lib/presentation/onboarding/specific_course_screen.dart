import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:anandhu_s_application4/presentation/onboarding/course_list_model.dart';
import 'package:anandhu_s_application4/presentation/onboarding/onboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/colors_res.dart';
import '../login/widgets/verification_widgets.dart';

class SpecificCourseScreen extends StatefulWidget {
  SpecificCourseScreen({Key? key}) : super(key: key);

  @override
  State<SpecificCourseScreen> createState() => _SpecificCourseScreenState();
}

class _SpecificCourseScreenState extends State<SpecificCourseScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      onboardingController.getOccupationDropdownValue();
      init();
    });

    super.initState();
  }

  init() async {
    onboardingController.getCourseDropdownValue(courseName: '');
  }

  final OnboardingController onboardingController =
      Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: PopScope(
        canPop: false,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.v),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 64.v,
            ),
            Container(
              width: 312.v,
              child: Text(
                'Which specific courses are you interested in?',
                style: TextStyle(
                    color: ColorResources.colorgrey700,
                    fontSize: 24.v,
                    fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: 8.v,
            ),
            Container(
              width: 312.v,
              child: Text(
                'Select the course that interest you to customize your learning journey.',
                style: TextStyle(
                    color: ColorResources.colorgrey600,
                    fontSize: 14.v,
                    fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(
              height: 24.v,
            ),
            GetBuilder<OnboardingController>(builder: (occupationData) {
              return SizedBox(
                height: 54.v,
                child: DropdownButtonFormField<CourseListModel>(
                  isExpanded: true,

                  value: occupationData.courseModelDropdownValue,
                  onChanged: (value) {
                    if (value != null) {
                      occupationData.courseListWidget.clear();
                      occupationData.courseModelDropdownValue = value;
                      occupationData.courseListWidget.add(value);
                      onboardingController.update();
                    }
                    // if (value != null) {
                    //   occupationData.courseModelDropdownValue = value;
                    //   occupationData.courseListWidget.add(value);

                    //   onboardingController.update();
                    // }
                  },
                  items: occupationData.courseList.map((value) {
                    return DropdownMenuItem<CourseListModel>(
                      value: value,
                      child: Text(value.courseName ?? '',maxLines: 1,),
                    );
                  }).toList(),
                  style: GoogleFonts.plusJakartaSans(
                    color: ColorResources.colorBlack,
                    fontSize: 14.fSize,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Select your course interests',
                    labelStyle: GoogleFonts.plusJakartaSans(
                      color: ColorResources.colorgrey600,
                      fontSize: 12.fSize,
                      fontWeight: FontWeight.w400,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    fillColor: ColorResources.colorwhite,
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: ColorResources.colorBlack),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: ColorResources.colorgrey300),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: ColorResources.colorgrey200),
                    ),
                  ),
                ),
              );
            }),
            SizedBox(
              height: 10.v,
            ),
            // GetBuilder<OnboardingController>(builder: (selectedCourseData) {
            //   return Wrap(
            //     runSpacing: 15.v,
            //     spacing: 15.v,
            //     children: List.generate(
            //         selectedCourseData.courseListWidget.length,
            //         (index) => Container(
            //               padding: EdgeInsets.all(8.v),
            //               decoration: BoxDecoration(
            //                   border: Border.all(),
            //                   borderRadius: BorderRadius.circular(15.v)),
            //               child: Text(selectedCourseData
            //                       .courseListWidget[index].courseName ??
            //                   ''),
            //             )),
            //   );
            // })
          ]),
        ),
      ),
      bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.v, vertical: 16.h),
          child: GetBuilder<OnboardingController>(builder: (obControl) {
            return buttonWidget(
              backgroundColor: onboardingController.courseListWidget.isNotEmpty
                  ? ColorResources.colorBlue600
                  : ColorResources.colorwhite,
              txtColor: onboardingController.courseListWidget.isNotEmpty
                  ? ColorResources.colorwhite
                  : ColorResources.colorgrey600,
              context: context,
              text: 'Continue',
              onPressed: () async {
                if (onboardingController.courseListWidget.isNotEmpty) {
                  await onboardingController.saveOccupation();
                } else {
                  Get.showSnackbar(GetSnackBar(
                    message: 'Select atleast one course!!',
                    duration: Duration(seconds: 1),
                  ));
                }

                // _loginController.signInWithGoogle();
              },
            );
          })

          // : buttonWidget(
          //     backgroundColor: ColorResources.colorBlue600,
          //     txtColor: otpController.text.isEmpty
          //         ? ColorResources.colorgrey600
          //         : ColorResources.colorwhite,
          //     context: context,
          //     text: 'Verify',
          //     onPressed: otpController.text.isNotEmpty ? () {} : null,
          //   ),
          ),
    );
  }
}
