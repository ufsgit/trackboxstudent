import 'dart:convert';

List<ProfileDetailsModel> profileDetailsModelFromJson(String str) =>
    List<ProfileDetailsModel>.from(
        json.decode(str).map((x) => ProfileDetailsModel.fromJson(x)));

String profileDetailsModelToJson(List<ProfileDetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProfileDetailsModel {
  int studentId;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String socialProvider;
  String socialId;
  int deleteStatus;
  dynamic occupationId;
  String otp;
  String profilePhotoPath;
  String profilePhotoName;
  String avatar;
  String gmeetLink;

  int? courseId;

  ProfileDetailsModel(
      {required this.studentId,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.phoneNumber,
      required this.socialProvider,
      required this.socialId,
      required this.deleteStatus,
      required this.occupationId,
      required this.otp,
      required this.profilePhotoPath,
      required this.profilePhotoName,
      required this.avatar,
      required this.gmeetLink,
      this.courseId});

  factory ProfileDetailsModel.fromJson(Map<String, dynamic> json) =>
      ProfileDetailsModel(
          studentId: json["Student_ID"] ?? 0,
          firstName: json["First_Name"] ?? '',
          lastName: json["Last_Name"] ?? '',
          email: json["Email"] ?? '',
          phoneNumber: json["Phone_Number"] ?? '',
          socialProvider: json["Social_Provider"] ?? '',
          socialId: json["Social_ID"] ?? '',
          deleteStatus: json["Delete_Status"] ?? 0,
          occupationId: json["Occupation_Id"] ?? 0,
          otp: json["OTP"] ?? 0,
          profilePhotoPath: json["Profile_Photo_Path"] ?? "",
          profilePhotoName: json["Profile_Photo_Name"] ?? '',
          avatar: json["Avatar"] ?? '',
          courseId: json["Course_ID"] ?? 0,
          gmeetLink: json["Live_Link"] ?? "");

  Map<String, dynamic> toJson() => {
        "Student_ID": studentId,
        "First_Name": firstName,
        "Last_Name": lastName,
        "Email": email,
        "Phone_Number": phoneNumber,
        "Social_Provider": socialProvider,
        "Social_ID": socialId,
        "Delete_Status": deleteStatus,
        "Occupation_Id": occupationId,
        "OTP": otp,
        "Profile_Photo_Path": profilePhotoPath,
        "Profile_Photo_Name": profilePhotoName,
        "Avatar": avatar,
        "Course_ID": courseId,
        "Live_Link": gmeetLink,
      };
}
