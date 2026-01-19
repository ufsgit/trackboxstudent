class StudentChatModel {
  int? studentId;
  int? teacherId;
  String? chatMessage;
  String? chatType;
  String? sentTime;
  bool? isStudent;
  String? filePath;
  String? courseId;
  double? fileSize;
  String? thumbUrl;
  String? senderName,profileUrl;

  StudentChatModel({
    this.studentId,
    this.teacherId,
    this.chatMessage,
    this.chatType,
    this.sentTime,
    this.isStudent,
    this.filePath,
    this.courseId,
    this.fileSize,
    this.thumbUrl,
    this.senderName,
    this.profileUrl,
  });

  factory StudentChatModel.fromMap(Map<String, dynamic> json) =>
      StudentChatModel(
        studentId: json["studentId"],
        teacherId: json['teacherId'],
        chatMessage: json['message'],
        chatType: json['chatType'],
        sentTime: json["sentTime"],
        isStudent: json['isStudent'],
        filePath: json['File_Path'],
        courseId: json["course_id"] ?? null, //hod change----
        fileSize: json["fileSize"],
        thumbUrl: json["thumbUrl"],
        senderName: json["senderName"],
        profileUrl: json["profileUrl"],
      );

  Map<String, dynamic> toMap() => {
        "studentId": studentId,
        "teacherId": teacherId,
        "message": chatMessage,
        'chatType': chatType,
        "sentTime": sentTime,
        "isStudent": isStudent,
        "File_Path": filePath,
        "course_id": courseId,
        "fileSize": fileSize??0.0,
        "thumbUrl": thumbUrl,
        "senderName": senderName,
        "profileUrl": profileUrl,
      };
}
