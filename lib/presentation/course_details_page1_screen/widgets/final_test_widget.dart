import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:anandhu_s_application4/core/colors_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class FinalTestWidget extends StatelessWidget {
  const FinalTestWidget({super.key});

  void _showNotificationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            height: 355,
            width: 316,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: ColorResources.colorgrey100,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 48,
                ),
                Container(
                  height: 100,
                  width: 130,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/time_loader.png'))),
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  'Course Incomplete',
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: ColorResources.colorgrey700),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    "You haven't completed all sections Finish the remaining ones to unlock the final exam",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      color: ColorResources.colorgrey600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                SizedBox(
                  width: 220,
                  height: 36,
                  child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        'Continue Learning',
                        style: GoogleFonts.plusJakartaSans(
                          color: ColorResources.colorwhite,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      )),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 126,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: ColorResources.colorgrey300),
          color: ColorResources.colorwhite),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Final Test',
                  style: GoogleFonts.plusJakartaSans(
                    color: ColorResources.colorgrey700,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'Completed the course?\nNotify your mentor for the exam',
                  style: GoogleFonts.plusJakartaSans(
                    color: ColorResources.colorgrey600,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: 100,
                  height: 30,
                  child: ElevatedButton(
                      onPressed: () => _showNotificationDialog(context),
                      child: Text(
                        'Notify now',
                        style: GoogleFonts.plusJakartaSans(
                          color: ColorResources.colorwhite,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      )),
                )
              ],
            ),
            Expanded(child: SizedBox()),
            SvgPicture.asset(
              'assets/images/EmptyState.svg',
              height: 80,
              width: 80,
            )
          ],
        ),
      ),
    );
  }
}
