class GetChatCallModel {
  int id;
  int teacherId;
  int studentId;
  DateTime callStart;
  DateTime callEnd;
  int callDuration;
  String callType;

  GetChatCallModel({
    required this.id,
    required this.teacherId,
    required this.studentId,
    required this.callStart,
    required this.callEnd,
    required this.callDuration,
    required this.callType,
  });

  factory GetChatCallModel.fromJson(Map<String, dynamic> json) =>
      GetChatCallModel(
        id: json["id"],
        teacherId: json["teacher_id"],
        studentId: json["student_id"],
        callStart: DateTime.parse(json["call_start"]).toLocal(),
        callEnd: DateTime.parse(json["call_end"]).toLocal(),
        callDuration: json["call_duration"],
        callType: json["call_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "teacher_id": teacherId,
        "student_id": studentId,
        "call_start": callStart.toIso8601String(),
        "call_end": callEnd.toIso8601String(),
        "call_duration": callDuration,
        "call_type": callType,
      };
}
