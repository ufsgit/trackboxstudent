class EditTeacherModel {
  String userId;
  String username;
  String password;
  String email;
  String phoneNumber;

  EditTeacherModel({
    required this.userId,
    required this.username,
    required this.password,
    required this.email,
    required this.phoneNumber,
  });

  factory EditTeacherModel.fromJson(Map<String, dynamic> json) =>
      EditTeacherModel(
        userId: json["User_ID"],
        username: json["Username"],
        password: json["Password"],
        email: json["Email"],
        phoneNumber: json["PhoneNumber"],
      );

  Map<String, dynamic> toJson() => {
        "User_ID": userId,
        "Username": username,
        "Password": password,
        "Email": email,
        "PhoneNumber": phoneNumber,
      };
}
