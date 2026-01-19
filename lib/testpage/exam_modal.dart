class ExamModel {
  final int courseExamId; // 🔥 VERY IMPORTANT
  final int examId;
  final String examName;
  final String courseName;
  final int duration;
  final int questions;
  final int passCount;

  ExamModel({
    required this.courseExamId,
    required this.examId,
    required this.examName,
    required this.courseName,
    required this.duration,
    required this.questions,
    required this.passCount,
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) {
    return ExamModel(
      courseExamId: json['course_exam_id'] ?? 0,
      examId: json['exam_id'] ?? 0,
      examName: json['exam_name'] ?? '',
      courseName: json['course_name'] ?? '',
      duration: json['duration'] ?? 0,
      questions: json['questions'] ?? 0,
      passCount: json['pass_mark'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'course_exam_id': courseExamId,
      'exam_id': examId,
      'exam_name': examName,
      'course_name': courseName,
      'duration': duration,
      'questions': questions,
      'pass_mark': passCount,
    };
  }
}
