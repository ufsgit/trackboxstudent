import 'package:flutter/material.dart';

class ExamResultsScreen extends StatelessWidget {
  const ExamResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data (replace with API later)
    final completedExams = [
      {
        "title": "Flutter Basics",
        "score": "18 / 20",
        "status": "Passed",
      },
      {
        "title": "Dart Fundamentals",
        "score": "12 / 20",
        "status": "Failed",
      },
    ];

    if (completedExams.isEmpty) {
      return const Center(
        child: Text("No completed exams yet"),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: completedExams.length,
      itemBuilder: (context, index) {
        final exam = completedExams[index];

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exam["title"]!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text("Score: ${exam["score"]}"),
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: exam["status"] == "Passed"
                        ? Colors.green.shade100
                        : Colors.red.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    exam["status"]!,
                    style: TextStyle(
                      color: exam["status"] == "Passed"
                          ? Colors.green
                          : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
