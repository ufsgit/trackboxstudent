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
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => RulesScreen(exam: exam),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        // Leading icon
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.assignment_rounded,
                            color: Colors.blue,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 16),

                        // Title + subtitle
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                exam.examName,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Icon(
                                    Icons.timer_outlined,
                                    size: 14,
                                    color: Colors.blueAccent,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    "${exam.duration} mins",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Icon(
                                    Icons.help_outline_rounded,
                                    size: 14,
                                    color: Colors.orangeAccent,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    "${exam.questions} questions",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Arrow
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 16,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
