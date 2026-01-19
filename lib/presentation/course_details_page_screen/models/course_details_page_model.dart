import 'dart:convert';

List<CourseDetailsListModel> courseDetailsListModelFromMap(String str) =>
    List<CourseDetailsListModel>.from(
        json.decode(str).map((x) => CourseDetailsListModel.fromMap(x)));

String courseDetailsListModelToMap(List<CourseDetailsListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class CourseDetailsListModel {
  int courseId;
  String courseName;
  int categoryId;
  int validity;
  String price;
  String thumbnailName;
  String thumbnailPath;
  int deleteStatus;
  String disableStatus;
  String thumbnailVideoPath;
  String thingsToLearn;

  String description;
  String liveClassEnabled;
  List<ScheduledTeacher> scheduledTeachers;
  List<int> sections;
  List<SectionName> sectionName;

  CourseDetailsListModel({
    required this.courseId,
    required this.courseName,
    required this.categoryId,
    required this.validity,
    required this.price,
    required this.thumbnailName,
    required this.thumbnailPath,
    required this.deleteStatus,
    required this.disableStatus,
    required this.description,
    required this.liveClassEnabled,
    required this.scheduledTeachers,
    required this.thumbnailVideoPath,
    required this.sections,
    required this.sectionName,
    required this.thingsToLearn,
  });

  factory CourseDetailsListModel.fromMap(Map<String, dynamic> json) =>
      CourseDetailsListModel(
        courseId: json["Course_ID"],
        courseName: json["Course_Name"],
        categoryId: json["Category_ID"],
        validity: json["Validity"],
        price: json["Price"],
        thumbnailName: json["Thumbnail_Name"],
        thumbnailPath: json["Thumbnail_Path"],
        thumbnailVideoPath: json["ThumbnailVideo_Path"],
        deleteStatus: json["Delete_Status"],
        disableStatus: json["Disable_Status"],
        description: json["Description"],
        liveClassEnabled: json["Live_Class_Enabled"],
        thingsToLearn: json['Things_To_Learn'],
        scheduledTeachers: json["scheduledTeachers"] != null
            ? List<ScheduledTeacher>.from(json["scheduledTeachers"]
                .map((x) => ScheduledTeacher.fromMap(x)))
            : [],
        sections: List<int>.from(json["Sections"].map((x) => x)),
        sectionName: List<SectionName>.from(
            json["Section_Name"].map((x) => SectionName.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "Course_ID": courseId,
        "Course_Name": courseName,
        "Category_ID": categoryId,
        "Validity": validity,
        "Price": price,
        "Thumbnail_Name": thumbnailName,
        "ThumbnailVideo_Path": thumbnailVideoPath,
        "Thumbnail_Path": thumbnailPath,
        "Delete_Status": deleteStatus,
        "Disable_Status": disableStatus,
        "Live_Class_Enabled": liveClassEnabled,
        "scheduledTeachers":
            List<dynamic>.from(scheduledTeachers.map((x) => x.toMap())),
        "Sections": List<dynamic>.from(sections.map((x) => x)),
        "Section_Name": List<dynamic>.from(sectionName.map((x) => x.toMap())),
      };
}

class ScheduledTeacher {
  int teacher;
  String endTime;
  String startTime;

  ScheduledTeacher({
    required this.teacher,
    required this.endTime,
    required this.startTime,
  });

  factory ScheduledTeacher.fromMap(Map<String, dynamic> json) =>
      ScheduledTeacher(
        teacher: json["Teacher"] ?? 0,
        endTime: json["endTime"] ?? '',
        startTime: json["startTime"] ?? '',
      );

  Map<String, dynamic> toMap() => {
        "Teacher": teacher,
        "endTime": endTime,
        "startTime": startTime,
      };
}

class SectionName {
  int sectionId;
  String sectionName;

  SectionName({
    required this.sectionId,
    required this.sectionName,
  });

  factory SectionName.fromMap(Map<String, dynamic> json) => SectionName(
        sectionId: json["Section_Id"],
        sectionName: json["Section_Name"],
      );

  Map<String, dynamic> toMap() => {
        "Section_Id": sectionId,
        "Section_Name": sectionName,
      };
}
