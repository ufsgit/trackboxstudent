// To parse this JSON data, do
//
//     final specificCourseDetailsModel = specificCourseDetailsModelFromJson(jsonString);

import 'dart:convert';

List<SpecificExamDetailsModel> SpecificExamDetailsModelFromJson(String str) => List<SpecificExamDetailsModel>.from(json.decode(str).map((x) => SpecificExamDetailsModel.fromJson(x)));

String SpecificExamDetailsModelToJson(List<SpecificExamDetailsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SpecificExamDetailsModel {
    ExamDetails examDetails;

    SpecificExamDetailsModel({
        required this.examDetails,
    });

    factory SpecificExamDetailsModel.fromJson(Map<String, dynamic> json) => SpecificExamDetailsModel(
        examDetails: ExamDetails.fromJson(json["examDetails"]),
    );

    Map<String, dynamic> toJson() => {
        "examDetails": examDetails.toJson(),
    };
}

class ExamDetails {
    int examId;
    String examName;
    String fileName;
    String fileType;
    List<Question> questions;
    int timeLimit;
    int passingScore;
    String mainQuestion;
    int totalQuestions;
    String answerKeyName;
    String answerKeyPath;
    String supportingDocumentName;
    String supportingDocumentPath;

    ExamDetails({
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
        required this.supportingDocumentName,
        required this.supportingDocumentPath,
    });

    factory ExamDetails.fromJson(Map<String, dynamic> json) => ExamDetails(
        examId: json["Exam_ID"],
        examName: json["examName"],
        fileName: json["file_name"],
        fileType: json["file_type"],
        questions:json["questions"]==null?[]: List<Question>.from(json["questions"].map((x) => Question.fromJson(x))),
        timeLimit: json["timeLimit"],
        passingScore: json["passingScore"],
        mainQuestion: json["Main_Question"],
        totalQuestions: json["totalQuestions"],
        answerKeyName: json["Answer_Key_Name"],
        answerKeyPath: json["Answer_Key_Path"],
        supportingDocumentName: json["Supporting_Document_Name"],
        supportingDocumentPath: json["Supporting_Document_Path"],
    );

    Map<String, dynamic> toJson() => {
        "Exam_ID": examId,
        "examName": examName,
        "file_name": fileName,
        "file_type": fileType,
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
        "timeLimit": timeLimit,
        "passingScore": passingScore,
        "Main_Question": mainQuestion,
        "totalQuestions": totalQuestions,
        "Answer_Key_Name": answerKeyName,
        "Answer_Key_Path": answerKeyPath,
        "Supporting_Document_Name": supportingDocumentName,
        "Supporting_Document_Path": supportingDocumentPath,
    };
}

class Question {
    int questionId;
    String questionText;
    List<String> answerOptions;
    String correctAnswer;
    String answerMediaName;

    Question({
        required this.questionId,
        required this.questionText,
        required this.answerOptions,
        required this.correctAnswer,
        required this.answerMediaName,
    });

    factory Question.fromJson(Map<String, dynamic> json) => Question(
        questionId: json["Question_ID"],
        questionText: json["questionText"],
        answerOptions: List<String>.from(json["answerOptions"].map((x) => x)),
        correctAnswer: json["correctAnswer"],
        answerMediaName: json["Answer_Media_Name"],
    );

    Map<String, dynamic> toJson() => {
        "Question_ID": questionId,
        "questionText": questionText,
        "answerOptions": List<dynamic>.from(answerOptions.map((x) => x)),
        "correctAnswer": correctAnswer,
        "Answer_Media_Name": answerMediaName,
    };
}
