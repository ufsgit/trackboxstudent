import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:anandhu_s_application4/core/colors_res.dart';
import 'package:anandhu_s_application4/data/models/home/course_content_by_module_model.dart';
import 'package:anandhu_s_application4/http/http_urls.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/models/recordings_model.dart';
import 'package:anandhu_s_application4/presentation/home_page/controller/home_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class CourseRecordingWidgets extends StatelessWidget {
  const CourseRecordingWidgets({
    super.key,
    required this.controllerCourseDetailsController,
    required this.scrollController,
    this.modules,
    required this.toggleVideo,
  });
  final HomeController controllerCourseDetailsController;
  final ScrollController scrollController;
  final List<RecordingsModel>? modules;
  final void Function(String) toggleVideo;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: modules!.asMap().entries.map((v) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0),
            child: Material(
              // elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  side: controllerCourseDetailsController.selectedIndex == v.key
                      ? BorderSide(color: Color(0xFF2B83D5))
                      : BorderSide.none,
                  borderRadius: BorderRadius.circular(12),
                ),
                onTap: v.key == 0
                    ? () {}
                    : () {
                        scrollController.animateTo(0,
                            curve: Curves.fastEaseInToSlowEaseOut,
                            duration: Duration(milliseconds: 700));
                      },
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                dense: true,
                minVerticalPadding: 2,
                visualDensity: VisualDensity.comfortable,
                title: Text(
                  v.value.recordClassLink,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w500, fontSize: 14),
                ),
                leading: Container(
                    height: 44,
                    width: 48,
                    decoration: BoxDecoration(
                        color: v.key == 0
                            ? Colors.blue.shade200
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(7)),
                    child: CachedNetworkImage(
                      imageUrl: '${HttpUrls.imgBaseUrl}${v.value.liveClassId}',
                      fit: BoxFit.contain,
                      placeholder: (BuildContext context, String url) {
                        return Center(
                            child: CircularProgressIndicator(
                          color: ColorResources.colorBlue500,
                        ));
                      },
                      errorWidget:
                          (BuildContext context, String url, dynamic error) {
                        return Center(
                          child: Icon(
                            Icons.image_not_supported_outlined,
                            color: ColorResources.colorBlue100,
                            size: 40,
                          ),
                        );
                      },
                    )),
                subtitle: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        v.value.recordClassLink,
                        style: GoogleFonts.plusJakartaSans(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                            fontSize: 12),
                      ),
                    ),
                    SizedBox(width: 10),
                    // Text(
                    //   v.value['content_length'],
                    //   style: GoogleFonts.plusJakartaSans(
                    //       color: Colors.grey.shade500,
                    //       fontWeight: FontWeight.w500,
                    //       fontSize: 12),
                    // ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      );
    });
  }
}

List<Map<String, dynamic>> courseCurriculams = [
  {
    'icon': Icons.play_arrow,
    'title': '1. Introduction to OET Masterclass',
    'category': 'Video',
    'content_length': '15:04 mins',
  },
  {
    'icon': Icons.document_scanner,
    'title': '2. OET Exam Overview',
    'category': 'PDF',
    'content_length': '24 Pages',
  },
  {
    'icon': Icons.play_arrow,
    'title': '3. Tips for OET Listening',
    'category': 'Video',
    'content_length': '15:04 mins',
  },
  {
    'icon': Icons.headphones,
    'title': '4. OET listening practice test',
    'category': 'Test',
    'content_length': 'Listening',
  },
  {
    'icon': Icons.document_scanner,
    'title': '5. Essential OET Vocabulary for Health...',
    'category': 'PDF',
    'content_length': '28 pages',
  },
  {
    'icon': Icons.play_arrow,
    'title': '7. Sample OET Writing Task',
    'category': 'Video',
    'content_length': '15:04 mins',
  },
];
