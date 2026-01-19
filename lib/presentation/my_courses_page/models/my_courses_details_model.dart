class MyCourseDetailsModel {
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
  String imagePath;
  int deleteStatus;
  int batchID;
  String paymentMethod;
  int certificateIssue;
  String course_completion_percentage;
  int total_content_count;
  String content_position;
  String batchStartDate;
  String batchName;

  String batchEndDate;

  MyCourseDetailsModel(
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
      required this.imagePath,
      required this.batchID,
      required this.certificateIssue,
      required this.course_completion_percentage,
      required this.total_content_count,
      required this.content_position,
      required this.batchStartDate,
      required this.batchEndDate,
      required this.batchName});

  factory MyCourseDetailsModel.fromJson(Map<String, dynamic> json) =>
      MyCourseDetailsModel(
          studentCourseId: json["StudentCourse_ID"],
          studentId: json["Student_ID"],
          courseId: json["Course_ID"],
          courseName: json["Course_Name"],
          enrollmentDate: DateTime.parse(json["Enrollment_Date"]),
          expiryDate: DateTime.parse(json["Expiry_Date"]),
          price: json["Price"],
          paymentDate: DateTime.parse(json["Payment_Date"]),
          paymentStatus: json["Payment_Status"],
          lastAccessedContentId: json["LastAccessed_Content_ID"].toString(),
          transactionId: json["Transaction_Id"],
          deleteStatus: json["Delete_Status"],
          batchID: json["Batch_ID"] ?? 0,
          paymentMethod: json["Payment_Method"],
          imagePath: json['Thumbnail_Path'],
          certificateIssue: json["Certificate_Issued"],
          course_completion_percentage:
              json["course_completion_percentage"] ?? "0",
          total_content_count: json["total_content_count"] ?? 0,
          content_position: json["content_position"] ?? "0",
          batchStartDate: json["Batch_start_Date"] ?? '',
          batchEndDate: json["Batch_End_Date"] ?? '',
          batchName: json["Batch_Name"] ?? '');

  Map<String, dynamic> toJson() => {
        "StudentCourse_ID": studentCourseId,
        "Student_ID": studentId,
        "Course_ID": courseId,
        "Course_Name": courseName,
        "Enrollment_Date": enrollmentDate.toIso8601String(),
        "Expiry_Date": expiryDate.toIso8601String(),
        "Batch_start_Date": batchStartDate,
        "Price": price,
        "Payment_Date": paymentDate.toIso8601String(),
        "Payment_Status": paymentStatus,
        "LastAccessed_Content_ID": lastAccessedContentId,
        "Transaction_Id": transactionId,
        "Delete_Status": deleteStatus,
        "Batch_ID": batchID,
        "Payment_Method": paymentMethod,
        "Thumbnail_Path": imagePath,
        "Certificate_Issued": certificateIssue,
        "course_completion_percentage": course_completion_percentage,
        "total_content_count": total_content_count,
        "content_position": content_position,
        "Batch_End_Date": batchEndDate
      };
}
