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
          "Exam Instructions",
          style: theme.textTheme.titleMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.v),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ================= EXAM DETAILS SECTION =================
              Text(
                "Exam Details",
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 12.v),

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
                  children: [
                    _infoRow("Total Questions", exam.questions.toString()),
                    Divider(height: 20.v),
                    _infoRow("Duration", "${exam.duration} minutes"),
                    Divider(height: 20.v),
                    _infoRow(
                        "Passing Score", "${exam.passCount} correct answers"),
                  ],
                ),
              ),

              SizedBox(height: 24.v),

              /// ================= INSTRUCTIONS SECTION =================
              Text(
                "Instructions & Rules",
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 12.v),

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
                    _ruleText(
                        "Each question has multiple options to choose from"),
                    _ruleText("Select only one answer per question"),
                    _ruleText(
                        "You can review and change answers before submitting"),
                    _ruleText("No negative marking - attempt all questions"),
                    _ruleText("Exam will auto-submit when time expires"),
                    _ruleText(
                        "Do not close or refresh the app during the exam"),
                    _ruleText("Ensure stable internet connection throughout"),
                  ],
                ),
              ),

              SizedBox(height: 24.v),

              /// ================= IMPORTANT NOTES =================
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.v),
                decoration: BoxDecoration(
                  color: appTheme.blue50,
                  borderRadius: BorderRadius.circular(12.v),
                  border: Border.all(
                    color: appTheme.blue800.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: appTheme.blue800,
                      size: 20,
                    ),
                    SizedBox(width: 12.h),
                    Expanded(
                      child: Text(
                        "Once you start the exam, the timer will begin immediately. Make sure you're ready before clicking 'Start Exam'.",
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: appTheme.blue800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.v),

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
                          duration: exam.duration, courseId: exam.courseId,
                          passMark: exam.passCount,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "Start Exam",
                    style: theme.textTheme.labelMedium,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// ================= INFO ROW =================
  Widget _infoRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: appTheme.blue800,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  /// ================= RULE TEXT =================
  Widget _ruleText(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.v),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "• ",
            style: theme.textTheme.bodyMedium?.copyWith(
              color: appTheme.blue800,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
