import 'dart:convert';

List<LiveClassJoiningModel> liveClassModelFromJson(String str) =>
    List<LiveClassJoiningModel>.from(
        json.decode(str).map((x) => LiveClassJoiningModel.fromJson(x)));

String liveClassModelToJson(List<LiveClassJoiningModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LiveClassJoiningModel {
  int studentID;
  int liveClassID;
  DateTime startTime;
  DateTime? endTime;
  int duration;

  LiveClassJoiningModel({
    required this.liveClassID,
    required this.studentID,
    required this.startTime,
    required this.endTime,
    required this.duration,
  });

  factory LiveClassJoiningModel.fromJson(Map<String, dynamic> json) =>
      LiveClassJoiningModel(
        studentID: json["Student_ID"],
        liveClassID: json["LiveClass_ID"],
        startTime: DateTime.parse(json["Start_Time"]),
        endTime: DateTime.parse(json["End_Time"]),
        duration: json["Attendance_Duration"],
      );

  Map<String, dynamic> toJson() => {
        "Student_ID": studentID,
        "LiveClass_ID": liveClassID,
        "Start_Time": startTime.toIso8601String(),
        "End_Time": endTime != null ? endTime!.toIso8601String() : '',
        "Attendance_Duration": duration,
      };
}
