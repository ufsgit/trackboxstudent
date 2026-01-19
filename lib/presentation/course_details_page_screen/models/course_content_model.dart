import 'dart:convert';

List<CourseDetailsContentListModel> courseDetailsContentListModelFromMap(
        String str) =>
    List<CourseDetailsContentListModel>.from(
        json.decode(str).map((x) => CourseDetailsContentListModel.fromMap(x)));

String courseDetailsContentListModelToMap(
        List<CourseDetailsContentListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class CourseDetailsContentListModel {
  int sectionId;
  String sectionName;
  List<Content> contents;

  CourseDetailsContentListModel({
    required this.sectionId,
    required this.sectionName,
    required this.contents,
  });

  factory CourseDetailsContentListModel.fromMap(Map<String, dynamic> json) =>
      CourseDetailsContentListModel(
        sectionId: json["sectionId"],
        sectionName: json['section_name'],
        contents:
            List<Content>.from(json["contents"].map((x) => Content.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "sectionId": sectionId,
        "contents": List<dynamic>.from(contents.map((x) => x.toMap())),
      };
}

class Content {
  String? file;
  List<Exam>? exams;
  String? fileName;
  String? fileType;
  int sectionId;
  int contentId;
  String contentName;
  String contentThumbnailPath;

  Content({
    required this.file,
    required this.exams,
    required this.fileName,
    required this.fileType,
    required this.sectionId,
    required this.contentId,
    required this.contentName,
    required this.contentThumbnailPath,
  });

  factory Content.fromMap(Map<String, dynamic> json) => Content(
        file: json["file"],
        contentThumbnailPath: json['contentThumbnail_Path'] ?? "",
        exams: json["exams"] == null
            ? []
            : List<Exam>.from(json["exams"]!.map((x) => Exam.fromMap(x))),
        fileName: json["file_name"],
        fileType: json["file_type"],
        sectionId: json["sectionId"],
        contentId: json["Content_ID"],
        contentName: json["contentName"],
      );

  Map<String, dynamic> toMap() => {
        "file": file,
        "exams": exams == null
            ? []
            : List<dynamic>.from(exams!.map((x) => x.toMap())),
        "file_name": fileName,
        "file_type": fileType,
        "sectionId": sectionId,
        "Content_ID": contentId,
        "contentName": contentName,
      };
}

class Exam {
  int examId;
  String examName;
  String fileName;
  String fileType;
  List<Question> questions;
  int timeLimit;
  int passingScore;
  String mainQuestion;
  int totalQuestions;

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
  });

  factory Exam.fromMap(Map<String, dynamic> json) => Exam(
        examId: json["Exam_ID"],
        examName: json["examName"],
        fileName: json["file_name"],
        fileType: json["file_type"],
        questions: json["questions"] == null
            ? []
            : List<Question>.from(
                json["questions"].map((x) => Question.fromMap(x))),
        timeLimit: json["timeLimit"],
        passingScore: json["passingScore"],
        mainQuestion: json["Main_Question"],
        totalQuestions: json["totalQuestions"],
      );

  Map<String, dynamic> toMap() => {
        "Exam_ID": examId,
        "examName": examName,
        "file_name": fileName,
        "file_type": fileType,
        "questions": List<dynamic>.from(questions.map((x) => x.toMap())),
        "timeLimit": timeLimit,
        "passingScore": passingScore,
        "Main_Question": mainQuestion,
        "totalQuestions": totalQuestions,
      };
}

class Question {
  int questionId;
  String questionText;
  List<String> answerOptions;
  String correctAnswer;
  AnswerMediaName answerMediaName;

  Question({
    required this.questionId,
    required this.questionText,
    required this.answerOptions,
    required this.correctAnswer,
    required this.answerMediaName,
  });

  factory Question.fromMap(Map<String, dynamic> json) => Question(
        questionId: json["Question_ID"],
        questionText: json["questionText"],
        answerOptions: List<String>.from(json["answerOptions"].map((x) => x)),
        correctAnswer: json["correctAnswer"],
        answerMediaName: answerMediaNameValues.map[json["Answer_Media_Name"]]!,
      );

  Map<String, dynamic> toMap() => {
        "Question_ID": questionId,
        "questionText": questionText,
        "answerOptions": List<dynamic>.from(answerOptions.map((x) => x)),
        "correctAnswer": correctAnswer,
        "Answer_Media_Name": answerMediaNameValues.reverse[answerMediaName],
      };
}

enum AnswerMediaName { AUDIO, MULTIPLE_CHOICE, TEXT }

final answerMediaNameValues = EnumValues({
  "Audio": AnswerMediaName.AUDIO,
  "Multiple Choice": AnswerMediaName.MULTIPLE_CHOICE,
  "text": AnswerMediaName.TEXT
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
