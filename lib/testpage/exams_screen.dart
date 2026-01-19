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
  late Future<Map<String, List<ExamModel>>> _groupedExamFuture;

  @override
  void initState() {
    super.initState();
    _groupedExamFuture = _loadExams();
  }

  Future<Map<String, List<ExamModel>>> _loadExams() {
    final service = ExamService(widget.token);
    return service.fetchExamsGroupedByCourse(widget.studentId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Available Exams")),
      body: FutureBuilder<Map<String, List<ExamModel>>>(
        future: _groupedExamFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No courses found'));
          }

          final groupedExams = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: groupedExams.length,
            itemBuilder: (context, index) {
              final courseName = groupedExams.keys.elementAt(index);
              final exams = groupedExams[courseName]!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    courseName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // ✅ Show empty exams message per course
                  if (exams.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        'No exams available for this course',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  else
                    ...exams.map(_buildExamCard).toList(),

                  const Divider(height: 24),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildExamCard(ExamModel exam) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(exam.examName),
        subtitle: Text("Duration: ${exam.duration} mins"),
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
