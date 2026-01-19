

import 'dart:convert';

List<LiveClassModel> liveClassModelFromJson(String str) => List<LiveClassModel>.from(json.decode(str).map((x) => LiveClassModel.fromJson(x)));

String liveClassModelToJson(List<LiveClassModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LiveClassModel {
    int liveClassID;
    int courseId;
    String courseName;
    int teacherID;
    DateTime startTime;
    String liveLink;
    String firstName;
    String lastName;
    DateTime scheduledDateTime;
    int duration;

    LiveClassModel({
        required this.liveClassID,
        required this.courseId,
        required this.courseName,
        required this.teacherID,
        required this.startTime,
        required this.liveLink,
        required this.firstName,
        required this.lastName,
        required this.scheduledDateTime,
        required this.duration,
    });

    factory LiveClassModel.fromJson(Map<String, dynamic> json) => LiveClassModel(
        liveClassID: json["LiveClass_ID"],
        courseId: json["Course_ID"],
        courseName: json["Course_Name"],
        teacherID: json["Teacher_ID"],
        startTime: DateTime.parse(json["Start_Time"]),
        liveLink: json["Live_Link"],
        firstName: json["First_Name"],
        lastName: json["Last_Name"],
        scheduledDateTime: DateTime.parse(json["Scheduled_DateTime"]),
        duration: json["Duration"],
    );

    Map<String, dynamic> toJson() => {
        "LiveClass_ID": liveClassID,
        "Course_ID": courseId,
        "Course_Name": courseName,
        "Teacher_ID": teacherID,
        "Start_Time": startTime.toIso8601String(),
        "Live_Link": liveLink,
        "First_Name": firstName,
        "Last_Name": lastName,
        "Scheduled_DateTime": scheduledDateTime.toIso8601String(),
        "Duration": duration,
    };
}
