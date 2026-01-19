import 'dart:convert';

List<GoogleSignInModel> googleSignInModelFromJson(String str) =>
    List<GoogleSignInModel>.from(
        json.decode(str).map((x) => GoogleSignInModel.fromJson(x)));

String googleSignInModelToJson(List<GoogleSignInModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GoogleSignInModel {
  String firstName;
  String lastName;
  String email;
  String profilePhotoPath;
  int deleteStatus;
  String socialProvider;
  String socialID;
  String avatar;
  String deviceID;

  GoogleSignInModel(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.profilePhotoPath,
      required this.deleteStatus,
      required this.socialProvider,
      required this.socialID,
      required this.avatar,
      required this.deviceID});

  factory GoogleSignInModel.fromJson(Map<String, dynamic> json) =>
      GoogleSignInModel(
          firstName: json["First_Name"],
          lastName: json["Last_Name"],
          email: json["Email"],
          profilePhotoPath: json["Profile_Photo_Path"],
          deleteStatus: json["Delete_Status"],
          socialProvider: json["Social_Provider"],
          socialID: json["Social_ID"],
          avatar: json["Avatar"],
          deviceID: json["Device_ID"]);

  Map<String, dynamic> toJson() => {
        "First_Name": firstName,
        "Last_Name": lastName,
        "Email": email,
        "Profile_Photo_Path": profilePhotoPath,
        "Delete_Status": deleteStatus,
        "Social_Provider": socialProvider,
        "Social_ID": socialID,
        "Avatar": avatar,
        "Device_ID": deviceID,
      };
}
