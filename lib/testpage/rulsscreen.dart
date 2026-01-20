import 'package:flutter/material.dart';
import '../core/app_export.dart';
import 'exam_modal.dart';
import 'testscreen.dart';

class RulesScreen extends StatelessWidget {
  final ExamModel exam;

  const RulesScreen({super.key, required this.exam});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Exam Rules", // ✅ FIXED (no examName in backend)
          style: theme.textTheme.titleMedium,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.v),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ================= HEADER =================
            Text(
              "Exam Instructions",
              style: theme.textTheme.headlineSmall,
            ),

            SizedBox(height: 16.v),

            /// ================= EXAM INFO CARD =================
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.v),
              decoration: BoxDecoration(
                color: appTheme.whiteA700,
                borderRadius: BorderRadius.circular(12.v),
                boxShadow: [
                  BoxShadow(
                    color: appTheme.gray5005e,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _infoRow("Course ID", exam.courseId.toString()),
                  _infoRow("Total Questions", exam.questions.toString()),
                  _infoRow("Duration", "${exam.duration} minutes"),
                  _infoRow("Pass Count", exam.passCount.toString()),
                ],
              ),
            ),

            SizedBox(height: 20.v),

            /// ================= RULES CARD =================
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.v),
              decoration: BoxDecoration(
                color: appTheme.whiteA700,
                borderRadius: BorderRadius.circular(12.v),
                boxShadow: [
                  BoxShadow(
                    color: appTheme.gray5005e,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Rules",
                    style: theme.textTheme.titleSmall,
                  ),
                  SizedBox(height: 12.v),
                  _ruleText("Each question has 4 options"),
                  _ruleText("Select only one answer"),
                  _ruleText("No negative marks"),
                  _ruleText("Do not refresh or close the app"),
                ],
              ),
            ),

            const Spacer(),

            /// ================= START BUTTON =================
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TestScreen(
                        courseExamId: exam.courseExamId, // ✅ FIXED
                        duration: exam.duration,
                      ),
                    ),
                  );
                },
                child: Text(
                  "Start Exam",
                  style: theme.textTheme.labelMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ================= INFO ROW =================
  Widget _infoRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.v),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: theme.textTheme.bodyMedium!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          Text(
            value,
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  /// ================= RULE TEXT =================
  Widget _ruleText(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.v),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("• ", style: theme.textTheme.bodyMedium),
          Expanded(
            child: Text(text, style: theme.textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}
