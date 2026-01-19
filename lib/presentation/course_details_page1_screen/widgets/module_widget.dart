import 'package:anandhu_s_application4/presentation/course_details_page1_screen/widgets/circle_progress_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:anandhu_s_application4/core/colors_res.dart';

class ModuleWidget extends StatelessWidget {
  final String badgeIcon;
  final String moduleName;
  final VoidCallback? onTap;
  final bool isLocked;
  final bool isSelected;

  const ModuleWidget({
    Key? key,
    required this.badgeIcon,
    required this.moduleName,
    required this.onTap,
    required this.isLocked,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: !isLocked ? Colors.white : ColorResources.colorgrey300,
          border: Border.all(
            color: isSelected
                ? Colors.blue
                : (!isLocked
                    ? ColorResources.colorgrey100
                    : ColorResources.colorgrey400),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 30,
                          height: 40,
                          child: Image.asset(badgeIcon),
                        ),
                        Expanded(child: SizedBox()),
                        isLocked
                            ? Container(
                                width: 25,
                                height: 25,
                                child:
                                    Image.asset('assets/images/LockSimple.png'),
                              )
                            : SizedBox()
                      ],
                    ),
                    SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            moduleName,
                            style: GoogleFonts.plusJakartaSans(
                              color: ColorResources.colorgrey700,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          // Text(
                          //   '28/28 Days',
                          //   style: GoogleFonts.plusJakartaSans(
                          //     color: ColorResources.colorgrey600,
                          //     fontSize: 11,
                          //     fontWeight: FontWeight.w400,
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
