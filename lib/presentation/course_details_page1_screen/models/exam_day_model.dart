class ExamDayModel {
  int daysId;
  String dayName;
  int isExamDayUnlocked;

  ExamDayModel({
    required this.daysId,
    required this.dayName,
    required this.isExamDayUnlocked,
  });

  factory ExamDayModel.fromJson(Map<String, dynamic> json) => ExamDayModel(
        daysId: json["Days_Id"],
        dayName: json["Day_Name"],
        isExamDayUnlocked: json["Is_Exam_Day_Unlocked"],
      );

  Map<String, dynamic> toJson() => {
        "Days_Id": daysId,
        "Day_Name": dayName,
        "Is_Exam_Day_Unlocked": isExamDayUnlocked,
      };
}
