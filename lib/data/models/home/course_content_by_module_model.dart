class CourseContentByModuleModel {
  List<Content>? contents;
  String? message;

  CourseContentByModuleModel({
    this.contents,
    this.message,
  });

  factory CourseContentByModuleModel.fromJson(Map<String, dynamic> json) {
    if (json['contents'] is List) {
      var contentsList = json['contents'] as List<dynamic>;
      return CourseContentByModuleModel(
        contents: contentsList.map((x) => Content.fromJson(x)).toList(),
      );
    } else if (json['contents'] is String) {
      return CourseContentByModuleModel(
        message: json['contents'],
      );
    } else {
      throw Exception('Expected contents to be a List or String');
    }
  }

  Map<String, dynamic> toJson() => {
        "contents": contents?.map((x) => x.toJson()).toList() ?? [],
        "message": message,
      };
}

class Content {
  dynamic file;
  List<Exam> exams;
  dynamic fileName;
  dynamic fileType;
  int contentId;
  String contentName;
  String contentThumbnailPath;
  String contentThumbnailName;
  int examTest;
  String? externalLink;

  Content({
    required this.file,
    required this.exams,
    required this.fileName,
    required this.fileType,
    required this.contentId,
    required this.contentName,
    required this.contentThumbnailPath,
    required this.contentThumbnailName,
    required this.examTest,
    this.externalLink,
  });

  factory Content.fromJson(Map<String, dynamic> json) {
    var examsList = json['exams'] as List<dynamic>? ?? [];
    return Content(
        file: json['file'] ?? "",
        exams: examsList.map((x) => Exam.fromJson(x)).toList(),
        fileName: json['file_name'] ?? "",
        fileType: json['file_type'] ?? "",
        contentId: json['Content_ID'] ?? 0,
        contentName: json['contentName'] ?? "",
        contentThumbnailPath: json['contentThumbnail_Path'] ?? "",
        contentThumbnailName: json['contentThumbnail_name'] ?? "",
        examTest: json["Is_Exam_Test"],
        externalLink: json['External_Link'],

    );
  }

  Map<String, dynamic> toJson() => {
        "file": file,
        "exams": exams.map((x) => x.toJson()).toList(),
        "file_name": fileName,
        "file_type": fileType,
        "Content_ID": contentId,
        "contentName": contentName,
        "contentThumbnail_Path": contentThumbnailPath,
        "contentThumbnail_name": contentThumbnailName,
        "Is_Exam_Test": examTest,
        "External_Link": externalLink,

  };
}

class Exam {
  int examId;
  String examName;
  String fileName;
  String fileType;
  dynamic questions;
  int timeLimit;
  int passingScore;
  String mainQuestion;
  int totalQuestions;
  String answerKeyName;
  String answerKeyPath;
  int isExamUnlocked;
  String supportingDocumentName;
  String supportingDocumentPath;
  int isQuestionUnlocked;
  int isQuestionMediaUnlocked;
  int isAnswerUnlocked;

  Exam({
    required this.examId,
    required this.examName,
    required this.fileName,
    required this.fileType,
    required this.questions,
    required this.timeLimit,
    required this.passingScore,
    required this.mainQuestion,
    required this.totalQuestions,
    required this.answerKeyName,
    required this.answerKeyPath,
    required this.isExamUnlocked,
    required this.supportingDocumentName,
    required this.supportingDocumentPath,
    required this.isQuestionMediaUnlocked,
    required this.isQuestionUnlocked,
    required this.isAnswerUnlocked,
  });

  factory Exam.fromJson(Map<String, dynamic> json) => Exam(
      examId: json["Exam_ID"] ?? 0,
      examName: json["examName"] ?? '',
      fileName: json["file_name"] ?? "",
      fileType: json["file_type"] ?? "",
      questions: json["questions"] ?? "",
      timeLimit: json["timeLimit"] ?? 0,
      passingScore: json["passingScore"] ?? 0,
      mainQuestion: json["Main_Question"] ?? "",
      totalQuestions: json["totalQuestions"] ?? 0,
      answerKeyName: json["Answer_Key_Name"] ?? "",
      answerKeyPath: json["Answer_Key_Path"] ?? "",
      isExamUnlocked: json["is_Exam_Unlocked"] ?? 0,
      supportingDocumentName: json["Supporting_Document_Name"] ?? "",
      supportingDocumentPath: json["Supporting_Document_Path"] ?? "",
      isQuestionMediaUnlocked: json["Is_Question_Media_Unlocked"] ?? 0,
      isQuestionUnlocked: json["Is_Question_Unlocked"] ?? 0,
      isAnswerUnlocked: json["Is_Answer_Unlocked"] ?? 0);

  Map<String, dynamic> toJson() => {
        "Exam_ID": examId,
        "examName": examName,
        "file_name": fileName,
        "file_type": fileType,
        "questions": questions,
        "timeLimit": timeLimit,
        "passingScore": passingScore,
        "Main_Question": mainQuestion,
        "totalQuestions": totalQuestions,
        "Answer_Key_Name": answerKeyName,
        "Answer_Key_Path": answerKeyPath,
        "is_Exam_Unlocked": isExamUnlocked,
        "Supporting_Document_Name": supportingDocumentName,
        "Supporting_Document_Path": supportingDocumentPath,
        "Is_Answer_Unlocked": isAnswerUnlocked
      };
}
