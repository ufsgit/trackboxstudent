class VideoAttendanceModel {
  int? studentId;
  int? courseId;
  String? courseName;
  int? contentId;
  String? contentTitle;
  double? watchPercentage;
  String? date;
  String? status;

  VideoAttendanceModel({
    this.studentId,
    this.courseId,
    this.courseName,
    this.contentId,
    this.contentTitle,
    this.watchPercentage,
    this.date,
    this.status,
  });

  VideoAttendanceModel.fromJson(Map<String, dynamic> json) {
    studentId = json['student_id'];
    courseId = json['course_id'];
    courseName = json['course_name'];
    contentId = json['content_id'];
    contentTitle = json['content_title'];
    watchPercentage = json['watch_percentage']?.toDouble();
    date = json['date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['student_id'] = studentId;
    data['course_id'] = courseId;
    data['course_name'] = courseName;
    data['content_id'] = contentId;
    data['content_title'] = contentTitle;
    data['watch_percentage'] = watchPercentage;
    data['date'] = date;
    data['status'] = status;
    return data;
  }
}
