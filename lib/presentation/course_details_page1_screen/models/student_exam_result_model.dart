class StudentExamResultModel {
  int? examResultMasterId;
  int? studentId;
  int? courseId;
  int? examDataId;
  String? totalMark;
  String? passMark;
  String? obtainedMark;
  String? createdAt;
  String? updatedAt;
  String? firstName;
  String? lastName;
  String? courseName;
  String? examName;
  String? resultStatus;
  String? percentage;

  StudentExamResultModel({
    this.examResultMasterId,
    this.studentId,
    this.courseId,
    this.examDataId,
    this.totalMark,
    this.passMark,
    this.obtainedMark,
    this.createdAt,
    this.updatedAt,
    this.firstName,
    this.lastName,
    this.courseName,
    this.examName,
    this.resultStatus,
    this.percentage,
  });

  factory StudentExamResultModel.fromJson(Map<String, dynamic> json) {
    return StudentExamResultModel(
      examResultMasterId: json['exam_result_master_id'] ?? 0,
      studentId: json['student_id'] ?? 0,
      courseId: json['course_id'] ?? 0,
      examDataId: json['exam_data_id'] ?? 0,
      totalMark: json['total_mark'] ?? '',
      passMark: json['pass_mark'] ?? '',
      obtainedMark: json['obtained_mark'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      firstName: json['First_Name'] ?? '',
      lastName: json['Last_Name'] ?? '',
      courseName: json['Course_Name'] ?? '',
      examName: json['exam_name'] ?? '',
      resultStatus: json['result_status'] ?? '',
      percentage: json['percentage'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['exam_result_master_id'] = examResultMasterId;
    data['student_id'] = studentId;
    data['course_id'] = courseId;
    data['exam_data_id'] = examDataId;
    data['total_mark'] = totalMark;
    data['pass_mark'] = passMark;
    data['obtained_mark'] = obtainedMark;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['First_Name'] = firstName;
    data['Last_Name'] = lastName;
    data['Course_Name'] = courseName;
    data['exam_name'] = examName;
    data['result_status'] = resultStatus;
    data['percentage'] = percentage;
    return data;
  }
}
