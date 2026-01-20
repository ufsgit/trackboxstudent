import 'package:flutter/material.dart';
import 'exam_modal.dart';
import 'examservieses.dart';
import 'rulsscreen.dart';

class ExamsHomeScreen extends StatefulWidget {
  final String studentId;
  final String token;

  const ExamsHomeScreen({
    super.key,
    required this.studentId,
    required this.token,
  });

  @override
  State<ExamsHomeScreen> createState() => _ExamsHomeScreenState();
}

class _ExamsHomeScreenState extends State<ExamsHomeScreen> {
  late Future<Map<String, List<ExamModel>>> _examFuture;

  @override
  void initState() {
    super.initState();
    _examFuture = _loadData();
  }

  Future<Map<String, List<ExamModel>>> _loadData() {
    return ExamService(widget.token)
        .fetchExamsGroupedByCourse(widget.studentId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Available Exams")),
      body: FutureBuilder<Map<String, List<ExamModel>>>(
        future: _examFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No courses found"));
          }

          final data = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final courseName = data.keys.elementAt(index);
              final exams = data[courseName]!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    courseName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (exams.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        "No exams for this course",
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  else
                    ...exams.map(_examCard).toList(),
                  const Divider(height: 32),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _examCard(ExamModel exam) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text("Course Exam ID: ${exam.courseExamId}"), // ✅ INT ID
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Duration: ${exam.duration} mins"),
            Text("Questions: ${exam.questions}"),
            Text("Pass Count: ${exam.passCount}"),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => RulesScreen(exam: exam),
            ),
          );
        },
      ),
    );
  }
}
