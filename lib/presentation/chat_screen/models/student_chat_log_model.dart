class StudentChatLogModel {
  int teacherId;
  String firstName;
  String lastName;
  String chatMessage;
  String profilePhotoPath;
  int unreadCount;
  DateTime sentTime;
  String filePath;

  StudentChatLogModel({
    required this.teacherId,
    required this.firstName,
    required this.lastName,
    required this.chatMessage,
    required this.profilePhotoPath,
    required this.unreadCount,
    required this.sentTime,
    required this.filePath,
  });

  factory StudentChatLogModel.fromJson(Map<String, dynamic> json) =>
      StudentChatLogModel(
        teacherId: json["teacher_id"] ?? 0,
        firstName: json['First_Name'] ?? '',
        lastName: json['Last_Name'] ?? '',
        chatMessage: json['message'] ?? "",
        profilePhotoPath:
            json['Profile_Photo_Path'] ?? 'assets/images/image_not_found.png',
        unreadCount: json['unread_count'] ?? 0,
        sentTime: DateTime.parse(json["timestamp"]).toLocal(),
        filePath: json['File_Path'] ?? '',
      );

  Map<String, dynamic> toMap() => {
        "teacher_id": teacherId,
        "First_Name": firstName,
        "Last_Name": firstName,
        "message": chatMessage,
        "Profile_Photo_Path": profilePhotoPath,
        "unread_count": unreadCount,
        "timestamp": sentTime.toIso8601String(),
        "File_Path": filePath,
      };
}
