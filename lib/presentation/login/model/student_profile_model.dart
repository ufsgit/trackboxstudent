import 'dart:convert';

List<StudentProfileModel> studentProfileModelFromJson(String str) =>
    List<StudentProfileModel>.from(
        json.decode(str).map((x) => StudentProfileModel.fromJson(x)));

String studentProfileModelToJson(List<StudentProfileModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StudentProfileModel {
  int studentId;
  String firstName;
  String lastName;
  String email;
  String profilePhotoPath;
  String profilePhotoName;
  String phoneNumber;
  int deleteStatus;
  String socialProvider;
  String socialID;
  String avatar;
  String countryCodeId;
  String countryCodeName;
  String gMeetLink;
  String? password;

  StudentProfileModel({
    required this.studentId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.profilePhotoPath,
    required this.profilePhotoName,
    required this.phoneNumber,
    required this.deleteStatus,
    required this.socialProvider,
    required this.socialID,
    required this.avatar,
    required this.countryCodeId,
    required this.countryCodeName,
    required this.gMeetLink,
    this.password,
  });

  factory StudentProfileModel.fromJson(Map<String, dynamic> json) =>
      StudentProfileModel(
          studentId: json["Student_ID"],
          firstName: json["First_Name"],
          lastName: json["Last_Name"],
          email: json["Email"],
          profilePhotoPath: json["Profile_Photo_Path"],
          profilePhotoName: json["Profile_Photo_Name"],
          phoneNumber: json["Phone_Number"],
          deleteStatus: json["Delete_Status"],
          socialProvider: json["Social_Provider"],
          socialID: json["Social_ID"],
          avatar: json["Avatar"],
          countryCodeId: json["Country_Code"] ?? '',
          gMeetLink: json["Live_Link"] ?? '',
          countryCodeName: json["Country_Code_Name"] ?? '');

  Map<String, dynamic> toJson() => {
        "Student_ID": studentId,
        "First_Name": firstName,
        "Last_Name": lastName,
        "Email": email,
        "Profile_Photo_Path": profilePhotoPath,
        "Profile_Photo_Name": profilePhotoName,
        "Phone_Number": phoneNumber,
        "Delete_Status": deleteStatus,
        "Social_Provider": socialProvider,
        "Social_ID": socialID,
        "Avatar": avatar,
        "Country_Code": countryCodeId,
        "Country_Code_Name": countryCodeName,
        "Live_Link": gMeetLink,
        if (password != null) "Password": password,
      };
}
