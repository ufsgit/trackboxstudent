import 'package:intl/intl.dart';

class CurrentCallModel {
  String? callerId,callId,liveLink;
  String? callerName;
  String? profileImg;
  bool? isVideo;
  String? type;

  CurrentCallModel({
    this.liveLink,
    this.callerId,
    this.callId,
    this.callerName,
    this.profileImg,
    this.isVideo,
    this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'liveLink': liveLink,
      'callerId': callerId,
      'callId': callId,
      'callerName': callerName,
      'profileImg': profileImg,
      'isVideo': isVideo,
      'type': type,
    };
  }

  factory CurrentCallModel.fromMap(Map<String, dynamic> map) {
    return CurrentCallModel(
      liveLink: map['liveLink'],
      callerId: map['callerId'] ?? '',
      callId: map['callId'],
      callerName: map['callerName'],
      profileImg: map['profileImg'],
      isVideo: map['isVideo'],
      type: map['type'],
    );
  }

}
