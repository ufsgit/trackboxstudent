class QuestionModel {
  final int questionId;
  final String question;
  final List<String> options;
  final int correctAnswerIndex;

  QuestionModel({
    required this.questionId,
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    final options = [
      json['option1'].toString(),
      json['option2'].toString(),
      json['option3'].toString(),
      json['option4'].toString(),
    ];

    return QuestionModel(
      questionId: int.parse(json['question_id'].toString()),
      question: json['question_name'].toString(),
      options: options,
      correctAnswerIndex: options.indexOf(json['correct_answer'].toString()),
    );
  }
}
