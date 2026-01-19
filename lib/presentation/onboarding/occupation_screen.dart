import 'dart:developer';
import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:anandhu_s_application4/presentation/onboarding/occupation_list_model.dart';
import 'package:anandhu_s_application4/presentation/onboarding/onboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/colors_res.dart';
import '../login/widgets/verification_widgets.dart';
import 'specific_course_screen.dart';

class OccupationScreen extends StatefulWidget {
  OccupationScreen({Key? key}) : super(key: key);

  @override
  State<OccupationScreen> createState() => _OccupationScreenState();
}

class _OccupationScreenState extends State<OccupationScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      onboardingController.getOccupationDropdownValue();
    });

    super.initState();
  }

  final OnboardingController onboardingController =
      Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    if (onboardingController.occupationDropdownValue == null) {
      log('not selected occupation');
    } else {
      log(onboardingController.occupationDropdownValue!.occupationId
          .toString());
    }
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Icon(
                  Icons.arrow_back_rounded,
                  color: ColorResources.colorBlack,
                  size: 25,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
          child: PopScope(
        canPop: true,
        // onPopInvoked: (didPop) async {
        //   if (didPop) {
        //     return false; // If the route was popped, we don't need to do anything
        //   }
        // },
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
                'What is your current role or occupation?',
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
                'Tell us your current role or occupation to personalize your learning experience.',
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
                child: DropdownButtonFormField<OccupationListModel>(
                  value: occupationData.occupationDropdownValue,
                  onChanged: (value) {
                    if (value != null) {
                      occupationData.occupationDropdownValue = value;
                      log(occupationData.occupationDropdownValue.toString());
                      log(occupationData.occupationDropdownValue!.occupationId
                          .toString());
                      occupationData.update();
                    }
                  },
                  items:
                      occupationData.occupationDropdownListValue.map((value) {
                    return DropdownMenuItem<OccupationListModel>(
                      value: value,
                      child: Text(value.occupation ?? 'Select Your Role'),
                    );
                  }).toList(),
                  style: GoogleFonts.plusJakartaSans(
                    color: ColorResources.colorBlack,
                    fontSize: 14.fSize,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Select your current role',
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
          ]),
        ),
      )),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: GetBuilder<OnboardingController>(builder: (obControl) {
            return buttonWidget(
                backgroundColor: obControl.occupationDropdownValue != null
                    ? ColorResources.colorBlue600
                    : ColorResources.colorgrey400,
                txtColor: ColorResources.colorwhite,
                context: context,
                text: 'Continue',
                onPressed: () async {
                  if (obControl.occupationDropdownValue != null) {
                    Get.to(() => SpecificCourseScreen());
                  } else {
                    Get.showSnackbar(GetSnackBar(
                      message: 'Select your occupation!!',
                      duration: Duration(seconds: 1),
                    ));
                  }
                });
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
