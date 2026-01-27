import 'package:flutter/material.dart';
import '../presentation/course_details_page1_screen/models/student_exam_result_model.dart';
import '../presentation/course_details_page1_screen/controller/exam_result_controller.dart';
import 'package:get/get.dart';

class ExamResultsScreen extends StatelessWidget {
  final int studentId;

  const ExamResultsScreen({super.key, required this.studentId});

  @override
  Widget build(BuildContext context) {
    final ExamResultController controller = Get.find<ExamResultController>();

    // Fetch exam results when widget builds
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getExamResultsByStudentId(studentId);
    });

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.errorMessage.value.isNotEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                controller.errorMessage.value,
                style: const TextStyle(fontSize: 16, color: Colors.red),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () =>
                    controller.getExamResultsByStudentId(studentId),
                child: const Text('Retry'),
              ),
            ],
          ),
        );
      }

      if (controller.studentExamResults.isEmpty) {
        return const Center(
          child: Text(
            "No completed exams yet",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        );
      }

      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: controller.studentExamResults.length,
        itemBuilder: (context, index) {
          final exam = controller.studentExamResults[index];
          final isPassed = exam.resultStatus == "Pass";

          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: InkWell(
              onTap: () {
                _showExamDetails(context, exam);
              },
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${exam.courseName} - ${exam.examName}",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Completed: ${exam.createdAt?.split('T')[0] ?? 'N/A'}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: isPassed
                                ? Colors.green.shade100
                                : Colors.red.shade100,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            exam.resultStatus ?? 'N/A',
                            style: TextStyle(
                              color: isPassed ? Colors.green : Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Score Section
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildScoreItem(
                            "Score",
                            "${exam.obtainedMark} / ${exam.totalMark}",
                            Icons.grade,
                            Colors.blue,
                          ),
                          _buildScoreItem(
                            "Percentage",
                            "${exam.percentage}%",
                            Icons.percent,
                            isPassed ? Colors.green : Colors.orange,
                          ),
                          // _buildScoreItem(
                          //   "Time",
                          //   "N/A",
                          //   Icons.timer,
                          //   Colors.purple,
                          // ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // // Result Summary
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     _buildDetailChip(
                    //       Icons.school,
                    //       "Course: ${exam.courseName}",
                    //       Colors.blue,
                    //     ),
                    //   ],
                    // ),
                    // const SizedBox(height: 12),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     _buildDetailChip(
                    //       Icons.person,
                    //       "${exam.firstName} ${exam.lastName}",
                    //       Colors.purple,
                    //     ),
                    //     _buildDetailChip(
                    //       Icons.assessment,
                    //       "${exam.examName}",
                    //       Colors.orange,
                    //     ),
                    //   ],
                    // ),
                    // const SizedBox(height: 12),

                    // Pass Mark Info
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Pass Mark: ${exam.passMark}",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "Tap for details",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue[700],
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }

  Widget _buildScoreItem(
      String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailChip(IconData icon, String text, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  void _showExamDetails(BuildContext context, StudentExamResultModel exam) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "${exam.courseName} - ${exam.examName}",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Exam Results",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 24),

                // Detailed Stats
                _buildDetailRow(
                    "Completion Date", exam.createdAt?.split('T')[0] ?? 'N/A'),
                _buildDetailRow(
                    "Student Name", "${exam.firstName} ${exam.lastName}"),
                _buildDetailRow("Course", exam.courseName ?? 'N/A'),
                _buildDetailRow("Exam Name", exam.examName ?? 'N/A',
                    color: Colors.blue),
                const Divider(height: 32),
                _buildDetailRow("Total Marks", exam.totalMark ?? 'N/A',
                    isBold: true),
                _buildDetailRow("Pass Mark", exam.passMark ?? 'N/A'),
                _buildDetailRow("Obtained Mark", exam.obtainedMark ?? 'N/A',
                    isBold: true, color: Colors.blue),
                _buildDetailRow("Percentage", "${exam.percentage}%",
                    isBold: true),
                _buildDetailRow("Status", exam.resultStatus ?? 'N/A',
                    color:
                        exam.resultStatus == "Pass" ? Colors.green : Colors.red,
                    isBold: true),

                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Close",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value,
      {Color? color, bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: color ?? Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
