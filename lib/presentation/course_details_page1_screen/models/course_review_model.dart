
import 'dart:convert';

List<CourseReviewModel> courseReviewModelFromJson(String str) => List<CourseReviewModel>.from(json.decode(str).map((x) => CourseReviewModel.fromJson(x)));

String courseReviewModelToJson(List<CourseReviewModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CourseReviewModel {
    int reviewId;
    int studentId;
    int courseId;
    int rating;
    String comments;
    DateTime createdAt;
    int deleteStatus;
    String firstName;
    String reviewImgPath;

    CourseReviewModel({
        required this.reviewId,
        required this.studentId,
        required this.courseId,
        required this.rating,
        required this.comments,
        required this.createdAt,
        required this.deleteStatus,
        required this.firstName,
        required this.reviewImgPath,
    });

    factory CourseReviewModel.fromJson(Map<String, dynamic> json) => CourseReviewModel(
        reviewId: json["Review_Id"],
        studentId: json["Student_ID"],
        courseId: json["Course_ID"],
        rating: json["Rating"],
        comments: json["Comments"],
        createdAt: DateTime.parse(json["Created_At"]),
        deleteStatus: json["Delete_Status"],
        firstName: json["First_Name"],

        reviewImgPath: json['Profile_Photo_Path']??"",
    );

    Map<String, dynamic> toJson() => {
        "Review_Id": reviewId,
        "Student_ID": studentId,
        "Course_ID": courseId,
        "Rating": rating,
        "Comments": comments,
        "Created_At": createdAt.toIso8601String(),
        "Delete_Status": deleteStatus,
        "First_Name": firstName,

        'Profile_Photo_Path':reviewImgPath,

    };
}
