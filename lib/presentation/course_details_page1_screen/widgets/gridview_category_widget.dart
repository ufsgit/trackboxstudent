import 'package:anandhu_s_application4/presentation/course_details_page1_screen/models/section_by_course_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:anandhu_s_application4/core/colors_res.dart';

class GridviewCategoryWidget extends StatelessWidget {
  final List<SectionByCourseModel> sectionByCourse;
  final int? selectedIndex;
  final void Function(SectionByCourseModel) onDayTapped;
  final bool isTab;
  final bool isLocked;
  final VoidCallback? onRecordingTapped;

  const GridviewCategoryWidget({
    Key? key,
    required this.onDayTapped,
    required this.isLocked,
    required this.sectionByCourse,
    this.selectedIndex,
    required this.isTab,
    this.onRecordingTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> sectionIcons = [
      "assets/images/listening.png",
      "assets/images/reading.png",
      "assets/images/writing.png",
      "assets/images/speaking.png"
    ];

    if (isTab) {
      sectionIcons.add("assets/images/speaking.png");
    }

    return Obx(
      () {
        final filteredSections = sectionByCourse
            .where((s) => s.sectionName.trim().isNotEmpty)
            .toList();

        return GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: filteredSections.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            mainAxisExtent: 85,
          ),
          itemBuilder: (context, index) {
            final isSelected = selectedIndex == index;

            return GestureDetector(
              onTap: () {
                onDayTapped(filteredSections[index]);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isLocked
                      ? ColorResources.colorgrey300
                      : ColorResources.colorwhite,
                  borderRadius: BorderRadius.circular(8.0),
                  border: isSelected
                      ? Border.all(color: Colors.blue, width: 2)
                      : isLocked
                          ? Border.all(
                              color: ColorResources.colorgrey400, width: 2)
                          : null,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(sectionIcons[index]),
                          isLocked
                              ? Container(
                                  width: 25,
                                  height: 25,
                                  child: Image.asset(
                                      'assets/images/LockSimple.png'),
                                )
                              : SizedBox()
                        ],
                      ),
                      Text(
                        filteredSections[index].sectionName,
                        style: GoogleFonts.plusJakartaSans(
                          color: ColorResources.colorgrey700,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
