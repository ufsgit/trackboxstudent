class TeacherModel {
  int userId;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  int isBatch;
  int isOneonOne;
  int? userTypeId;
  int? userActiveStatus;
  int? courseId;
  String? courseName;
  String profilePhotoPath;
  String? startTime;
  String endTime;
  int? batchId;
  int? slotId;

  TeacherModel(
      {required this.userId,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.phoneNumber,
      required this.userTypeId,
      required this.userActiveStatus,
      required this.courseId,
      required this.courseName,
      required this.batchId,
      required this.slotId,
      required this.startTime,
      required this.endTime,
      required this.isBatch,
      required this.isOneonOne,
      required this.profilePhotoPath});

  factory TeacherModel.fromJson(Map<String, dynamic> json) => TeacherModel(
      userId: json["User_ID"] ?? 0,
      firstName: json["First_Name"] ?? "",
      lastName: json["Last_Name"] ?? "",
      email: json["Email"] ?? "",
      phoneNumber: json["PhoneNumber"] ?? 0,
      userTypeId: json["User_Type_Id"] ?? 2,
      userActiveStatus: json["User_Active_Status"] ?? 0,
      courseId: json["courseId"],
      courseName: json["Course_Name"],
      batchId: json["Batch_ID"],
      slotId: json["Slot_Id"]??0,
      startTime: json["start_time"] ?? '',
      endTime: json["end_time"] ?? '',
      isBatch: json["has_batch_wise"],
      isOneonOne: json["has_slot_wise"],
      profilePhotoPath: json["Profile_Photo_Path"] ?? "");

  Map<String, dynamic> toJson() => {
        "User_ID": userId,
        "First_Name": firstName,
        "Last_Name": lastName,
        "Email": email,
        "PhoneNumber": phoneNumber,
        "User_Type_Id": userTypeId,
        "User_Active_Status": userActiveStatus,
        "courseId": courseId,
        "Course_Name": courseName,
        "Batch_ID": batchId,
        "Slot_Id": slotId??0,
        "Profile_Photo_Path": profilePhotoPath,
        "end_time": endTime,
        "start_time": startTime,
      };
}

class PurpleTeacherModel {
  int fieldCount;
  int affectedRows;
  int insertId;
  String info;
  int serverStatus;
  int warningStatus;
  int changedRows;

  PurpleTeacherModel({
    required this.fieldCount,
    required this.affectedRows,
    required this.insertId,
    required this.info,
    required this.serverStatus,
    required this.warningStatus,
    required this.changedRows,
  });

  factory PurpleTeacherModel.fromJson(Map<String, dynamic> json) =>
      PurpleTeacherModel(
        fieldCount: json["fieldCount"],
        affectedRows: json["affectedRows"],
        insertId: json["insertId"],
        info: json["info"],
        serverStatus: json["serverStatus"],
        warningStatus: json["warningStatus"],
        changedRows: json["changedRows"],
      );

  Map<String, dynamic> toJson() => {
        "fieldCount": fieldCount,
        "affectedRows": affectedRows,
        "insertId": insertId,
        "info": info,
        "serverStatus": serverStatus,
        "warningStatus": warningStatus,
        "changedRows": changedRows,
      };
}
