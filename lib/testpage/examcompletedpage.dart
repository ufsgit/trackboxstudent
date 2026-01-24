import 'package:flutter/material.dart';

class ExamResultsScreen extends StatelessWidget {
  const ExamResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Enhanced dummy data with user participation details (replace with API later)
    final completedExams = [
      {
        "title": "Flutter Basics",
        "score": 18,
        "totalQuestions": 20,
        "status": "Passed",
        "percentage": 90.0,
        "correctAnswers": 18,
        "incorrectAnswers": 2,
        "skippedQuestions": 0,
        "timeTaken": "25 mins",
        "completedDate": "2026-01-20",
        "attemptNumber": 1,
        "passingScore": 70,
      },
      {
        "title": "Dart Fundamentals",
        "score": 12,
        "totalQuestions": 20,
        "status": "Failed",
        "percentage": 60.0,
        "correctAnswers": 12,
        "incorrectAnswers": 6,
        "skippedQuestions": 2,
        "timeTaken": "30 mins",
        "completedDate": "2026-01-19",
        "attemptNumber": 2,
        "passingScore": 70,
      },
      {
        "title": "Advanced Flutter",
        "score": 16,
        "totalQuestions": 20,
        "status": "Passed",
        "percentage": 80.0,
        "correctAnswers": 16,
        "incorrectAnswers": 3,
        "skippedQuestions": 1,
        "timeTaken": "28 mins",
        "completedDate": "2026-01-22",
        "attemptNumber": 1,
        "passingScore": 70,
      },
    ];

    if (completedExams.isEmpty) {
      return const Center(
        child: Text(
          "No completed exams yet",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: completedExams.length,
      itemBuilder: (context, index) {
        final exam = completedExams[index];
        final isPassed = exam["status"] == "Passed";

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
                              exam["title"]!.toString(),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Completed: ${exam["completedDate"]}",
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
                          exam["status"]!.toString(),
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
                          "${exam["score"]} / ${exam["totalQuestions"]}",
                          Icons.grade,
                          Colors.blue,
                        ),
                        _buildScoreItem(
                          "Percentage",
                          "${exam["percentage"]}%",
                          Icons.percent,
                          isPassed ? Colors.green : Colors.orange,
                        ),
                        _buildScoreItem(
                          "Time",
                          exam["timeTaken"]!.toString(),
                          Icons.timer,
                          Colors.purple,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Participation Details
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildDetailChip(
                        Icons.check_circle,
                        "Correct: ${exam["correctAnswers"]}",
                        Colors.green,
                      ),
                      _buildDetailChip(
                        Icons.cancel,
                        "Wrong: ${exam["incorrectAnswers"]}",
                        Colors.red,
                      ),
                      _buildDetailChip(
                        Icons.remove_circle,
                        "Skipped: ${exam["skippedQuestions"]}",
                        Colors.orange,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Attempt Number
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Attempt #${exam["attemptNumber"]}",
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

  void _showExamDetails(BuildContext context, Map<String, dynamic> exam) {
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
                  exam["title"]!.toString(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Exam Results - Attempt #${exam["attemptNumber"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 24),

                // Detailed Stats
                _buildDetailRow(
                    "Completion Date", exam["completedDate"]!.toString()),
                _buildDetailRow("Time Taken", exam["timeTaken"]!.toString()),
                _buildDetailRow(
                    "Total Questions", exam["totalQuestions"].toString()),
                _buildDetailRow(
                    "Correct Answers", exam["correctAnswers"].toString(),
                    color: Colors.green),
                _buildDetailRow(
                    "Incorrect Answers", exam["incorrectAnswers"].toString(),
                    color: Colors.red),
                _buildDetailRow(
                    "Skipped Questions", exam["skippedQuestions"].toString(),
                    color: Colors.orange),
                const Divider(height: 32),
                _buildDetailRow("Your Score",
                    "${exam["score"]} / ${exam["totalQuestions"]}",
                    isBold: true),
                _buildDetailRow("Percentage", "${exam["percentage"]}%",
                    isBold: true),
                _buildDetailRow("Passing Score", "${exam["passingScore"]}%"),
                _buildDetailRow("Status", exam["status"]!.toString(),
                    color:
                        exam["status"] == "Passed" ? Colors.green : Colors.red,
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
                    child: const Text("Close"),
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
