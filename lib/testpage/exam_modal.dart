class ExamModel {
  final int courseExamId; // ✅ INT (FIXED)
  final String examDataId; // exam master id (string or int → string)
  final int courseId;
  final int duration;
  final int questions;
  final int passCount;

  ExamModel({
    required this.courseExamId,
    required this.examDataId,
    required this.courseId,
    required this.duration,
    required this.questions,
    required this.passCount,
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) {
    return ExamModel(
      courseExamId: int.parse(json['course_exam_id'].toString()), // ✅ INT
      examDataId: json['exam_data_id'].toString(),
      courseId: int.parse(json['Course_ID'].toString()),
      duration: int.parse(json['duration'].toString()),
      questions: int.parse(json['questions'].toString()),
      passCount: int.parse(json['passcount'].toString()),
    );
  }
}
