import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:anandhu_s_application4/core/colors_res.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/controller/course_enrol_controller.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/models/batch_day_model.dart';

class GridViewDayWidget extends StatelessWidget {
  final List<BatchWithDaysModel> batchDays;
  final void Function(BatchWithDaysModel) onDayTapped;

  const GridViewDayWidget({
    super.key,
    required this.batchDays,
    required this.onDayTapped,
  });

  @override
  Widget build(BuildContext context) {
    final CourseEnrolController controller = Get.find();

    return Obx(
      () {
        return GridView.builder(
          itemCount: batchDays.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
          ),
          itemBuilder: (context, index) {
            final day = batchDays[index];
            bool isUnlocked = day.isDayUnlocked != 0;
            // bool isSelected = controller.isSelected(day);
            // final String dayTitle =
            //     day.is_exam_day == 1 ? 'Day ${index + 1}' : 'Day ${index + 1}';
            return GestureDetector(
              onTap: isUnlocked
                  ? () {
                      controller.selectDay(day);
                      onDayTapped(day);
                    }
                  : () {
                      Get.showSnackbar(GetSnackBar(
                        message: 'Locked',
                        duration: Duration(milliseconds: 2000),
                      ));
                    },
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    height: 85,
                    width: 75,
                    decoration: BoxDecoration(
                      color: ColorResources.colorwhite,
                      borderRadius: BorderRadius.circular(8.0),
                      // border: Border.all(
                      //   color: isSelected ? Colors.blue : Colors.transparent,
                      //   width: 2.0,
                      // ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 22,
                          width: 55,
                          decoration: BoxDecoration(
                            color: ColorResources.colorBlue100,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ),
                          ),
                          child: Center(
                            child: day.is_exam_day == 1
                                ? Text(
                                    'Test',
                                    style: GoogleFonts.plusJakartaSans(
                                      color: const Color(0xFF509144),
                                      fontSize: day.is_exam_day == 1 ? 10 : 12,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )
                                : Text(
                                    'Class',
                                    style: GoogleFonts.plusJakartaSans(
                                      color: ColorResources.colorBlue500,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Center(
                          child: Builder(
                            builder: (context) {
                              String dayName = day.dayName;
                              List<String> parts = dayName.split(' ');
                              if (parts.length < 2) {
                                return Text("Invalid format");
                              }
                              log(batchDays.length.toString());
                              String dayText = parts[0];
                              String numericPart = parts[1];
                              String formattedNumericPart =
                                  numericPart.padLeft(2, '0');

                              return RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '$dayText\n',
                                      style: GoogleFonts.plusJakartaSans(
                                        color: ColorResources.colorgrey500,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    TextSpan(
                                      text: formattedNumericPart,
                                      style: GoogleFonts.plusJakartaSans(
                                        color: ColorResources.colorgrey700,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!isUnlocked)
                    Positioned(
                      child: Container(
                        height: 85,
                        width: 75,
                        decoration: BoxDecoration(
                          color: ColorResources.colorgrey400.withOpacity(.7),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Center(
                          child: Image.asset(
                            'assets/images/lock_key_day_module.png',
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
