import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/controller/exam_result_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:anandhu_s_application4/core/colors_res.dart';

class ResultViewingScreen extends StatelessWidget {
  ResultViewingScreen({
    super.key,
  });

  final ExamResultController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.colorgrey200,
      body: Obx(() {
        return controller.examResult.isEmpty
            ? Column(
                children: [
                  SizedBox(height: Get.height / 5),
                  Center(
                    child: Text('No results to show'),
                  ),
                ],
              )
            : ListView.builder(
                itemCount: controller.examResult.length,
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) => ResultCard(
                  testname: controller.examResult[index].contentName,
                  testDate: controller.examResult[index].resultDate,
                  cefrLevel: controller.examResult[index].cefrLevel,
                  overallMark: controller.examResult[index].overallScore,
                  readingMark: controller.examResult[index].reading,
                  speakingMark: controller.examResult[index].speaking,
                  writingMark: controller.examResult[index].writing,
                  listeningMark: controller.examResult[index].listening,
                ),
              );
      }),
    );
  }
}

class ResultCard extends StatelessWidget {
  final String testname;
  final String testDate;
  final String readingMark;
  final String writingMark;
  final String listeningMark;
  final String speakingMark;
  final String overallMark;
  final String cefrLevel;
  const ResultCard(
      {Key? key,
      required this.testname,
      required this.testDate,
      required this.readingMark,
      required this.writingMark,
      required this.listeningMark,
      required this.speakingMark,
      required this.overallMark,
      required this.cefrLevel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        height: 85,
        decoration: BoxDecoration(
          color: ColorResources.colorwhite,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            CardHeader(
              testDate: testDate,
              testname: testname,
            ),
            CardBody(
              cefrLevel: cefrLevel,
              listeningMark: listeningMark,
              overallMark: overallMark,
              readingMark: readingMark,
              speakingMark: speakingMark,
              writingMark: writingMark,
            ),
          ],
        ),
      ),
    );
  }
}

class CardHeader extends StatelessWidget {
  final String testname;
  final String testDate;
  const CardHeader({super.key, required this.testname, required this.testDate});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        HeaderTag(
            text: testname,
            color: ColorResources.colorgreen.withOpacity(.2),
            textColor: ColorResources.colorgreen),
        HeaderTag(
          text: testDate,
          color: ColorResources.colorBlue100,
          textColor: ColorResources.colorBlue300,
          icon: Icons.calendar_month,
          isRight: true,
        ),
      ],
    );
  }
}

class HeaderTag extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final IconData? icon;
  final bool isRight;

  const HeaderTag({
    Key? key,
    required this.text,
    required this.color,
    required this.textColor,
    this.icon,
    this.isRight = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: icon != null ? 135 : 55,
      height: 22,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(isRight ? 0 : 8),
          bottomLeft: Radius.circular(isRight ? 8 : 0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 12, color: textColor),
              const SizedBox(width: 4),
            ],
            Text(
              text,
              style: GoogleFonts.plusJakartaSans(
                color: textColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardBody extends StatelessWidget {
  final String readingMark;
  final String writingMark;
  final String listeningMark;
  final String speakingMark;
  final String overallMark;
  final String cefrLevel;
  const CardBody(
      {Key? key,
      required this.readingMark,
      required this.writingMark,
      required this.listeningMark,
      required this.speakingMark,
      required this.overallMark,
      required this.cefrLevel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ScoreItem(label: 'R', value: readingMark),
          VerticalDivider(),
          ScoreItem(label: 'W', value: writingMark),
          VerticalDivider(),
          ScoreItem(label: 'L', value: listeningMark),
          VerticalDivider(),
          ScoreItem(label: 'S', value: speakingMark),
          VerticalDivider(),
          ScoreItem(label: 'O', value: overallMark),
          VerticalDivider(),
          ScoreItem(label: 'CEFR Level', value: cefrLevel, isWide: true),
        ],
      ),
    );
  }
}

class ScoreItem extends StatelessWidget {
  final String label;
  final String value;
  final bool isWide;

  const ScoreItem({
    Key? key,
    required this.label,
    required this.value,
    this.isWide = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isWide ? 65 : 24,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              color: ColorResources.colorgrey600,
              fontSize: isWide ? 11 : 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.plusJakartaSans(
              color: ColorResources.colorgrey600,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class VerticalDivider extends StatelessWidget {
  const VerticalDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 26,
      width: 1,
      color: ColorResources.colorgrey300,
    );
  }
}
