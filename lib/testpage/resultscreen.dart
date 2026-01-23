import 'package:flutter/material.dart';
import '../core/app_export.dart';
import '../presentation/course_details_page1_screen/controller/exam_result_controller.dart';

class ResultScreen extends StatefulWidget {
  final int score;
  final int total;
  final int courseId;
  final int examDataId;
  final int passMark;

  const ResultScreen({
    super.key,
    required this.score,
    required this.total,
    required this.courseId,
    required this.examDataId,
    required this.passMark,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final ExamResultController _controller = Get.find<ExamResultController>();
  bool _isSaving = false;

  Future<void> _handleSaveAndExit() async {
    setState(() {
      _isSaving = true;
    });

    final success = await _controller.saveExamResult(
      courseId: widget.courseId,
      examDataId: widget.examDataId,
      totalMark: widget.total
          .toString(), // Assuming 100 for now, or derive from questions
      passMark: widget.passMark.toString(),
      obtainedMark: widget.score.toString(),
    );

    setState(() {
      _isSaving = false;
    });

    if (success) {
      Get.snackbar(
        "Success",
        "Exam result saved successfully",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      // Determine where to go back to. usually home or exams list.
      Navigator.popUntil(context, (route) => route.isFirst);
    } else {
      Get.snackbar(
        "Error",
        "Failed to save exam result. Please try again.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double percentage = (widget.score / widget.total) * 100;
    final bool isPassed = percentage >= 50;

    return Scaffold(
      backgroundColor: appTheme.gray10002,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Result",
          style: theme.textTheme.titleMedium,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.v),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// 🎉 RESULT ICON
            Container(
              height: 110.v,
              width: 110.v,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isPassed
                    ? appTheme.greenA700.withOpacity(0.15)
                    : appTheme.red400.withOpacity(0.15),
              ),
              child: Icon(
                isPassed ? Icons.check_circle : Icons.cancel,
                size: 70.v,
                color: isPassed ? appTheme.greenA700 : appTheme.red400,
              ),
            ),

            SizedBox(height: 20.v),

            /// 📝 TITLE
            Text(
              isPassed ? "Test Completed 🎉" : "Test Finished",
              style: theme.textTheme.headlineSmall,
            ),

            SizedBox(height: 8.v),

            Text(
              isPassed ? "Congratulations!" : "Better luck next time",
              style: theme.textTheme.bodyMedium,
            ),

            SizedBox(height: 30.v),

            /// 📊 SCORE CARD
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.v),
              decoration: BoxDecoration(
                color: appTheme.whiteA700,
                borderRadius: BorderRadius.circular(14.v),
                boxShadow: [
                  BoxShadow(
                    color: appTheme.gray5005e,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _resultRow(
                    title: "Total Questions",
                    value: widget.total.toString(),
                  ),
                  SizedBox(height: 10.v),
                  _resultRow(
                    title: "Correct Answers",
                    value: widget.score.toString(),
                  ),
                  SizedBox(height: 10.v),
                  Divider(color: appTheme.indigo50),
                  SizedBox(height: 10.v),
                  _resultRow(
                    title: "Score",
                    value: "${widget.score} / ${widget.total}",
                    isBold: true,
                  ),
                  SizedBox(height: 10.v),
                  _resultRow(
                    title: "Percentage",
                    value: "${percentage.toStringAsFixed(1)}%",
                    isBold: true,
                  ),
                ],
              ),
            ),

            SizedBox(height: 30.v),

            /// 🔘 BACK TO HOME
            SizedBox(
              width: double.infinity,
              height: 48.v,
              child: ElevatedButton(
                onPressed: _isSaving ? null : _handleSaveAndExit,
                child: _isSaving
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        "Back to Home",
                        style: theme.textTheme.labelMedium,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 RESULT ROW WIDGET
  Widget _resultRow({
    required String title,
    required String value,
    bool isBold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: theme.textTheme.bodyMedium,
        ),
        Text(
          value,
          style:
              isBold ? theme.textTheme.titleSmall : theme.textTheme.bodyMedium,
        ),
      ],
    );
  }
}
