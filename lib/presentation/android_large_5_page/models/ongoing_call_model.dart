class OnGoingCallsModel {
  int id;
  int teacherId;
  int studentId;
  String callStart; // Nullable String
  String callEnd;
  // int callDuration;
  String callType;
  String liveLink;
  String callerName;
  String profilePhotoPath;


  OnGoingCallsModel({
    required this.id,
    required this.teacherId,
    required this.studentId,
    required this.callStart,
    required this.callEnd,
    // required this.callDuration,
    required this.callType,
    required this.liveLink,
    required this.callerName,
    required this.profilePhotoPath,
  });

  factory OnGoingCallsModel.fromJson(Map<String, dynamic> json) =>
      OnGoingCallsModel(
          id: json["id"] ?? 0,
          teacherId: json["teacher_id"] ?? 0,
          studentId: json["student_id"] ?? 0,
          callStart: json["call_start"] ?? "",
          callEnd: json["call_end"] ?? "",
          // callDuration: json["call_duration"] ?? 0,
          callType: json["call_type"] ?? "",
          liveLink: json["Live_Link"] ?? "",
          callerName: json["First_Name"] ?? "",
          profilePhotoPath: json["Profile_Photo_Path"] ?? "");

  Map<String, dynamic> toJson() => {
        "id": id,
        "teacher_id": teacherId,
        "student_id": studentId,
        "call_start": callStart, // Nullable String
        "call_end": callEnd,
        // "call_duration": callDuration,
        "call_type": callType,
        "live_link": liveLink,
        "First_Name": callerName,
        "Profile_Photo_Path": profilePhotoPath,
      };
}
