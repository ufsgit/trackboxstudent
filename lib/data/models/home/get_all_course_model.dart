class GetAllCourseModel {
  int courseId;
  String courseName;
  int categoryId;
  int validity;
  String price;
  int deleteStatus;
  int disableStatus;
  int liveClassEnabled;

  GetAllCourseModel({
    required this.courseId,
    required this.courseName,
    required this.categoryId,
    required this.validity,
    required this.price,
    required this.deleteStatus,
    required this.disableStatus,
    required this.liveClassEnabled,
  });

  factory GetAllCourseModel.fromJson(Map<String, dynamic> json) =>
      GetAllCourseModel(
        courseId: json["Course_ID"],
        courseName: json["Course_Name"],
        categoryId: json["Category_ID"],
        validity: json["Validity"],
        price: json["Price"],
        deleteStatus: json["Delete_Status"],
        disableStatus: json["Disable_Status"],
        liveClassEnabled: json["Live_Class_Enabled"],
      );

  Map<String, dynamic> toJson() => {
        "Course_ID": courseId,
        "Course_Name": courseName,
        "Category_ID": categoryId,
        "Validity": validity,
        "Price": price,
        "Delete_Status": deleteStatus,
        "Disable_Status": disableStatus,
        "Live_Class_Enabled": liveClassEnabled,
      };
}
