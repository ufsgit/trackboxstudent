import 'package:flutter/material.dart';
import 'exam_modal.dart';
import 'examservieses.dart';
import 'rulsscreen.dart';

class ExamsHomeScreen extends StatefulWidget {
  final String studentId;
  final String token;

  const ExamsHomeScreen(
      {super.key, required this.studentId, required this.token});

  @override
  State<ExamsHomeScreen> createState() => _ExamsHomeScreenState();
}

class _ExamsHomeScreenState extends State<ExamsHomeScreen> {
  late Future<Map<String, List<ExamModel>>> future;

  @override
  void initState() {
    super.initState();
    future =
        ExamService(widget.token).fetchExamsGroupedByCourse(widget.studentId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Available Exams")),
      body: FutureBuilder(
        future: future,
        builder: (_, s) {
          if (!s.hasData)
            return const Center(child: CircularProgressIndicator());
          final data = s.data!;
          return ListView(
            children: data.entries.map((e) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: e.value.map((exam) {
                  return ListTile(
                    title: Text("Course Exam ID: ${exam.courseExamId}"),
                    subtitle: Text("Duration: ${exam.duration} mins"),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RulesScreen(exam: exam),
                      ),
                    ),
                  );
                }).toList(),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
