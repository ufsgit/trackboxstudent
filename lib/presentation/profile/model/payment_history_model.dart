class PaymentHistoryModel {
  int studentCourseId;
  int studentId;
  int courseId;
  String courseName;
  DateTime enrollmentDate;
  DateTime expiryDate;
  int price;
  DateTime paymentDate;
  String paymentStatus;
  String lastAccessedContentId;
  String transactionId;
  int deleteStatus;
  String paymentMethod;
  String thumbanailPath;

  PaymentHistoryModel(
      {required this.studentCourseId,
      required this.studentId,
      required this.courseId,
      required this.courseName,
      required this.enrollmentDate,
      required this.expiryDate,
      required this.price,
      required this.paymentDate,
      required this.paymentStatus,
      required this.lastAccessedContentId,
      required this.transactionId,
      required this.deleteStatus,
      required this.paymentMethod,
      required this.thumbanailPath});

  factory PaymentHistoryModel.fromJson(Map<String, dynamic> json) =>
      PaymentHistoryModel(
        studentCourseId: json["StudentCourse_ID"],
        studentId: json["Student_ID"],
        courseId: json["Course_ID"],
        courseName: json["Course_Name"],
        enrollmentDate: DateTime.parse(json["Enrollment_Date"]),
        expiryDate: DateTime.parse(json["Expiry_Date"]),
        price: json["Price"],
        paymentDate: DateTime.parse(json["Payment_Date"]),
        paymentStatus: json["Payment_Status"],
        lastAccessedContentId: json["LastAccessed_Content_ID"],
        transactionId: json["Transaction_Id"],
        deleteStatus: json["Delete_Status"],
        paymentMethod: json["Payment_Method"],
        thumbanailPath: json["Thumbnail_Path"],
      );

  Map<String, dynamic> toJson() => {
        "StudentCourse_ID": studentCourseId,
        "Student_ID": studentId,
        "Course_ID": courseId,
        "Course_Name": courseName,
        "Enrollment_Date": enrollmentDate.toIso8601String(),
        "Expiry_Date": expiryDate.toIso8601String(),
        "Price": price,
        "Payment_Date": paymentDate.toIso8601String(),
        "Payment_Status": paymentStatus,
        "LastAccessed_Content_ID": lastAccessedContentId,
        "Transaction_Id": transactionId,
        "Delete_Status": deleteStatus,
        "Payment_Method": paymentMethod,
        "Thumbnail_Path": thumbanailPath
      };
}
