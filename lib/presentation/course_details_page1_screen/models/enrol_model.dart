class Checkenrolcoursemodel {
  int studentCourseId;

  Checkenrolcoursemodel({
    required this.studentCourseId,
  });

  factory Checkenrolcoursemodel.fromJson(Map<String, dynamic> json) =>
      Checkenrolcoursemodel(
        studentCourseId: json["StudentCourse_ID"],
      );

  Map<String, dynamic> toJson() => {
        "StudentCourse_ID": studentCourseId,
      };
}
