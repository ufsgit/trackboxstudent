class ExamModel {
  final int courseExamId;
  final String examDataId;
  final int courseId;
  final int duration;
  final int questions;
  final int passCount;
  final String examName;
  final String courseName;

  ExamModel({
    required this.courseExamId,
    required this.examDataId,
    required this.courseId,
    required this.duration,
    required this.questions,
    required this.passCount,
    required this.examName,
    required this.courseName,
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) {
    return ExamModel(
      courseExamId: int.tryParse(json['course_exam_id'].toString()) ?? 0,
      examDataId: json['exam_data_id'].toString(),
      courseId: int.tryParse(json['Course_ID'].toString()) ?? 0,
      duration: int.tryParse(json['duration'].toString()) ?? 0,
      questions: int.tryParse(json['questions'].toString()) ?? 0,
      passCount: int.tryParse(json['passcount'].toString()) ?? 0,
      examName: json['exam_name'] ?? 'Exam',
      courseName: json['course_name'] ?? 'Course',
    );
  }
}
