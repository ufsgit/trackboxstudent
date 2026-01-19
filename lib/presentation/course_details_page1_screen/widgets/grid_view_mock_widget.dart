import 'package:anandhu_s_application4/presentation/course_details_page1_screen/models/exam_day_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:anandhu_s_application4/core/colors_res.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/controller/course_enrol_controller.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/models/batch_day_model.dart';

class GridViewMockExamWidget extends StatelessWidget {
  final List<ExamDayModel> examDays;
  final void Function(ExamDayModel, String) onDayTapped;

  const GridViewMockExamWidget({
    super.key,
    required this.examDays,
    required this.onDayTapped,
  });

  @override
  Widget build(BuildContext context) {
    final CourseEnrolController controller = Get.find();

    return Obx(
      () {
        return GridView.builder(
          itemCount: examDays.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
          ),
          itemBuilder: (context, index) {
            final day = examDays[index];
            bool isUnlocked = day.isExamDayUnlocked != 1;
            bool isSelected = controller.isExamSelected(day);

            return GestureDetector(
              onTap: isUnlocked
                  ? () {
                      controller.selectExamDay(day);
                      onDayTapped(day, 'Test');
                    }
                  : null,
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 8),
                        Center(
                          child: Builder(
                            builder: (context) {
                              String dayName = day.dayName;
                              List<String> parts = dayName.split(' ');
                              if (parts.length < 2) {
                                return Text("Invalid format");
                              }

                              String dayText = 'Test';
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
