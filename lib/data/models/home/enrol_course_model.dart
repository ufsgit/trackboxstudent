class EnrolCourseModel {
  int studentId;
  int courseId;
  DateTime enrollmentDate;
  DateTime expiryDate;
  int price;
  DateTime paymentDate;
  String paymentStatus;
  int lastAccessedContentId;
  String transactionId;
  int deleteStatus;
  String paymentMethod;

  EnrolCourseModel({
    required this.studentId,
    required this.courseId,
    required this.enrollmentDate,
    required this.expiryDate,
    required this.price,
    required this.paymentDate,
    required this.paymentStatus,
    required this.lastAccessedContentId,
    required this.transactionId,
    required this.deleteStatus,
    required this.paymentMethod,
  });

  factory EnrolCourseModel.fromJson(Map<String, dynamic> json) =>
      EnrolCourseModel(
        studentId: json["Student_ID"],
        courseId: json["Course_ID"],
        enrollmentDate: DateTime.parse(json["Enrollment_Date"]),
        expiryDate: DateTime.parse(json["Expiry_Date"]),
        price: json["Price"],
        paymentDate: DateTime.parse(json["Payment_Date"]),
        paymentStatus: json["Payment_Status"],
        lastAccessedContentId: json["LastAccessed_Content_ID"],
        transactionId: json["Transaction_Id"],
        deleteStatus: json["Delete_Status"],
        paymentMethod: json["Payment_Method"],
      );

  Map<String, dynamic> toJson() => {
        "Student_ID": studentId,
        "Course_ID": courseId,
        "Enrollment_Date":
            "${enrollmentDate.year.toString().padLeft(4, '0')}-${enrollmentDate.month.toString().padLeft(2, '0')}-${enrollmentDate.day.toString().padLeft(2, '0')}",
        "Expiry_Date":
            "${expiryDate.year.toString().padLeft(4, '0')}-${expiryDate.month.toString().padLeft(2, '0')}-${expiryDate.day.toString().padLeft(2, '0')}",
        "Price": price,
        "Payment_Date": paymentDate.toIso8601String(),
        "Payment_Status": paymentStatus,
        "LastAccessed_Content_ID": lastAccessedContentId,
        "Transaction_Id": transactionId,
        "Delete_Status": deleteStatus,
        "Payment_Method": paymentMethod,
      };
}
