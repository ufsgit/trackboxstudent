import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:intl/intl.dart';

class ChatMessageModel {
  String? studentId;
  String? userId;
  String? chatMessage;
  DateTime sentTime;
  bool? isStudent;
  String? filePath;
  bool? isPlaying;
  RxDouble? progress;
  String? docId;
  String? thumbUrl;
  double? fileSize;
  String? senderName;

  ChatMessageModel({
    this.studentId,
    this.userId,
    this.chatMessage,
    required this.sentTime,
    this.isStudent,
    this.filePath,
    this.progress,
    this.fileSize,
    this.docId,
    this.thumbUrl,
    this.senderName,
  });

  Map<String, dynamic> toMap() {
    return {
      'studentId': studentId,
      'teacherId': userId,
      'chatMessage': chatMessage,
      'sentTime': sentTime.toIso8601String(),
      'isStudent': isStudent,
      'filePath': filePath,
      'fileSize': fileSize ?? 0.0,
      'thumbUrl': thumbUrl,
      'senderName': senderName,
    };
  }

  factory ChatMessageModel.fromMap(
      Map<String, dynamic> map, String documentId) {
    return ChatMessageModel(
      studentId: map['studentId'],
      userId: map['teacherId'] ?? '',
      chatMessage: map['chatMessage'],
      sentTime: DateTime.parse(map['sentTime']).toLocal(),
      isStudent: map['isStudent'],
      filePath: map['filePath'],
      fileSize: map['fileSize'] ?? 0.0,
      progress: (0.0).obs,
      docId: documentId,
      thumbUrl: map['thumbUrl'] ?? "",
      senderName: map['senderName'] ?? "",
    );
  }

  String get formattedTime {
    return DateFormat('hh:mm a').format(sentTime!);
  }
}
