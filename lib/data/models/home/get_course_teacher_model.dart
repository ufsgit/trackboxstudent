class GetCourseTeacherModel {
  int courseTeacherId;
  int courseId;
  String courseName;

  GetCourseTeacherModel({
    required this.courseTeacherId,
    required this.courseId,
    required this.courseName,
  });

  factory GetCourseTeacherModel.fromJson(Map<String, dynamic> json) =>
      GetCourseTeacherModel(
        courseTeacherId: json["CourseTeacher_ID"],
        courseId: json["Course_ID"],
        courseName: json["Course_Name"],
      );

  Map<String, dynamic> toJson() => {
        "CourseTeacher_ID": courseTeacherId,
        "Course_ID": courseId,
        "Course_Name": courseName,
      };
}
