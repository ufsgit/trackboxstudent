import 'package:flutter/material.dart';
import 'exam_modal.dart';
import 'examservieses.dart';
import 'rulsscreen.dart';

class ExamsHomeScreen extends StatefulWidget {
  // final String studentId;
  final String courseId;
  final String token;

  const ExamsHomeScreen(
      {super.key, required this.courseId, required this.token});

  @override
  State<ExamsHomeScreen> createState() => _ExamsHomeScreenState();
}

class _ExamsHomeScreenState extends State<ExamsHomeScreen> {
  late Future<List<ExamModel>> future;

  @override
  void initState() {
    super.initState();
    future = ExamService(widget.token).fetchExamsByCourse(widget.courseId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text("Available Exams")),
      body: FutureBuilder<List<ExamModel>>(
        future: future,
        builder: (_, s) {
          if (!s.hasData)
            return const Center(child: CircularProgressIndicator());
          final data = s.data!;
          if (data.isEmpty) {
            return const Center(child: Text("No exams found for this course."));
          }
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final exam = data[index];
              return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(exam.examName),
                    subtitle: Text(
                        "Duration: ${exam.duration} mins | Qs: ${exam.questions}"),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RulesScreen(exam: exam),
                      ),
                    ),
                  ));
            },
          );
        },
      ),
    );
  }
}
