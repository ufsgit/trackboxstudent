import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:anandhu_s_application4/core/colors_res.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/controller/course_details_page1_controller.dart';

class ReadMoreWidget extends StatelessWidget {
  final String? description;
  const ReadMoreWidget({
    super.key,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final CourseModuleController controller =
        Get.find<CourseModuleController>();

    return GetX<CourseModuleController>(
      builder: (controller) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                description!,
                maxLines: controller.isExpanded.value ? null : 2,
                overflow:
                    controller.isExpanded.value ? null : TextOverflow.ellipsis,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 8),
              InkWell(
                onTap: () {
                  controller.toggleExpansion();
                },
                child: Text(
                  controller.isExpanded.value ? 'Read less' : 'Read more',
                  style: GoogleFonts.plusJakartaSans(
                    color: ColorResources.colorgrey600,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
