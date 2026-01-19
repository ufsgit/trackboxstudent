import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:anandhu_s_application4/core/colors_res.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/controller/course_content_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class MockTestContentScreen extends StatefulWidget {
  final String? courseId;
  final String? moduleId;
  final String? sectionId;
  final String? dayId;
  final String? appBarTitle;
  const MockTestContentScreen(
      {super.key,
      this.courseId,
      this.moduleId,
      this.sectionId,
      this.dayId,
      this.appBarTitle});

  @override
  State<MockTestContentScreen> createState() => _MockTestContentScreenState();
}

class _MockTestContentScreenState extends State<MockTestContentScreen> {
  CourseContentController courseContentController =
      Get.put(CourseContentController());
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
          courseContentController.getMockContents(
      isLibrary: false,
      courseId: widget.courseId!,
      moduleId: widget.moduleId!,
      dayId: widget.dayId.toString(),
      sectionId: widget.sectionId.toString(),
    );
    });

    super.initState();
  }

 

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorResources.colorgrey200,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: Container(
            height: 100,
            color: ColorResources.colorwhite,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: 24,
                      width: 24,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: ColorResources.colorBlue100,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: ColorResources.colorBlack.withOpacity(.4),
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    widget.appBarTitle!,
                    style: GoogleFonts.plusJakartaSans(
                      color: ColorResources.colorBlack,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Obx(
          () => SingleChildScrollView(
            child: courseContentController.courseContentMock.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Questions',
                              style: GoogleFonts.plusJakartaSans(
                                color: ColorResources.colorBlack,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount:
                              courseContentController.courseContentMock.length,
                          itemBuilder: (context, index) {
                            return Text('s');
                          },
                        ),
                      ],
                    ),
                  )
                : Text('No contents'),
          ),
        ),
      ),
    );
  }
}
