class CourseListModel {
  int? courseID;
  String? courseName;
  int? categoryID;
  int? validity;
  String? price;
  int? deleteStatus;
  int? disableStatus;
  int? liveClassEnabled;
  String? courseThumbnailPath;
  String? averageRating;
  String? thumbnailName;

  CourseListModel({
    this.courseID,
    this.courseName,
    this.categoryID,
    this.validity,
    this.price,
    this.deleteStatus,
    this.disableStatus,
    this.liveClassEnabled,
    this.courseThumbnailPath,
    this.averageRating,
    this.thumbnailName,

  });

  CourseListModel.fromJson(Map<String, dynamic> json) {
    courseID = json['Course_ID'];
    courseName = json['Course_Name'];
    categoryID = json['Category_ID'];
    validity = json['Validity'];
    price = json['Price'];
    deleteStatus = json['Delete_Status'];
    disableStatus = json['Disable_Status'];
    liveClassEnabled = json['Live_Class_Enabled'];
    courseThumbnailPath = json['Thumbnail_Path'] ?? '';
    averageRating=json['AverageRating']??'0.0';
    thumbnailName=json['Thumbnail_Name']??'';

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Course_ID'] = this.courseID;
    data['Course_Name'] = this.courseName;
    data['Category_ID'] = this.categoryID;
    data['Validity'] = this.validity;
    data['Price'] = this.price;
    data['Delete_Status'] = this.deleteStatus;
    data['Disable_Status'] = this.disableStatus;
    data['Live_Class_Enabled'] = this.liveClassEnabled;
    data['Thumbnail_Path'] = this.courseThumbnailPath;
    return data;
  }
}
