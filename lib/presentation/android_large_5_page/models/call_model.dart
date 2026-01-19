class CallAndChatHistoryModel {
  int id;
  int userId; // Changed from teacherId to userId to match the API response
  String firstName;
  String profilePhotoPath; // Added to match the response
  int studentId, teacherId;
  String callStart;
  String callEnd;
  String callDuration;
  String callType;
  int isStudentCalled;
  bool isConnected, isRinged, isRejected, isFinished;
  String liveLink;

  CallAndChatHistoryModel(
      {required this.id,
      required this.userId,
      required this.firstName,
      required this.profilePhotoPath,
      required this.studentId,
      required this.teacherId,
      required this.callStart,
      required this.callEnd,
      required this.callDuration,
      required this.callType,
      required this.isStudentCalled,
      required this.isConnected,
      required this.isRinged,
      required this.isRejected,
      required this.isFinished,
      required this.liveLink});

  factory CallAndChatHistoryModel.fromJson(Map<String, dynamic> json) =>
      CallAndChatHistoryModel(
        id: json["id"] ?? 0,
        userId: json["User_ID"] ?? 0,
        firstName: json["First_Name"] ?? "",
        profilePhotoPath: json["Profile_Photo_Path"] ?? "", // Added
        studentId: json["student_id"] ?? 0,
        teacherId: json["teacher_id"] ?? 0,
        callStart: json["call_start"] ?? "",
        callEnd: json["call_end"] ?? "",
        callDuration: json["call_duration"] ?? "0.0",
        callType: json["call_type"] ?? "",
        isStudentCalled: json["Is_Student_Called"],
        isConnected: json["Call_Connected"] == 1,
        isRinged: json["Call_Ringed"] == 1,
        isRejected: json["Call_Rejected"] == 1,
        isFinished: json["Is_Finished"] == 1,
        liveLink: json["Live_Link"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "User_ID": userId, // Updated to match the API response
        "First_Name": firstName,
        "Profile_Photo_Path": profilePhotoPath, // Added
        "student_id": studentId,
        "teacher_id": teacherId,
        "call_start": callStart,
        "call_end": callEnd,
        "call_duration": callDuration,
        "call_type": callType,
        "Is_Student_Called": isStudentCalled,
        "Call_Connected": isConnected ? 1 : 0,
        "Call_Ringed": isRinged ? 1 : 0,
        "Call_Rejected": isRejected ? 1 : 0,
        "Is_Finished": isFinished ? 1 : 0,
        "Live_Link": liveLink,
      };
}
