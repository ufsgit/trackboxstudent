class ExamResultModel {
  int studentExamId;
  int studentId;
  int examId;
  dynamic contentId;
  int batchId;
  int courseId;
  String listening;
  String reading;
  String writing;
  String speaking;
  String overallScore;
  String cefrLevel;
  int deleteStatus;
  dynamic resultDate;
  String contentName;

  ExamResultModel({
    required this.studentExamId,
    required this.studentId,
    required this.examId,
    required this.contentId,
    required this.batchId,
    required this.courseId,
    required this.listening,
    required this.reading,
    required this.writing,
    required this.speaking,
    required this.overallScore,
    required this.cefrLevel,
    required this.deleteStatus,
    required this.resultDate,
    required this.contentName,
  });

  factory ExamResultModel.fromJson(Map<String, dynamic> json) =>
      ExamResultModel(
        studentExamId: json["StudentExam_ID"] ?? 0,
        studentId: json["Student_ID"] ?? 0,
        examId: json["Exam_ID"] ?? 0,
        contentId: json["Content_Id"],
        batchId: json["Batch_Id"] ?? 0,
        courseId: json["Course_Id"] ?? 0,
        listening: json["Listening"] ?? '',
        reading: json["Reading"] ?? '',
        writing: json["Writing"] ?? '',
        speaking: json["Speaking"] ?? '',
        overallScore: json["Overall_Score"] ?? '',
        cefrLevel: json["CEFR_level"] ?? '',
        deleteStatus: json["Delete_Status"],
        resultDate: json["Result_Date"] ?? 'August 01 2024',
        contentName: json["Content_Name"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "StudentExam_ID": studentExamId,
        "Student_ID": studentId,
        "Exam_ID": examId,
        "Content_Id": contentId,
        "Batch_Id": batchId,
        "Course_Id": courseId,
        "Listening": listening,
        "Reading": reading,
        "Writing": writing,
        "Speaking": speaking,
        "Overall_Score": overallScore,
        "CEFR_level": cefrLevel,
        "Delete_Status": deleteStatus,
        "Result_Date": resultDate,
        "Content_Name": contentName,
      };
}
