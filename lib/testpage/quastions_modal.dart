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

  /// 🔥 Backend → Frontend mapping
  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    final String correctAnswer =
        json['correct_answer']; // "option1" | "option2"...

    /// ✅ EXPLICIT STRING CONVERSION (FIX)
    final List<String> options = [
      json['option1'].toString(),
      json['option2'].toString(),
      json['option3'].toString(),
      json['option4'].toString(),
    ];

    return QuestionModel(
      questionId: json['question_id'] as int,
      question: json['question_name'].toString(),
      options: options,
      correctAnswerIndex: _getCorrectIndex(correctAnswer),
    );
  }

  /// Convert backend correct_answer → index
  static int _getCorrectIndex(String answer) {
    switch (answer) {
      case 'option1':
        return 0;
      case 'option2':
        return 1;
      case 'option3':
        return 2;
      case 'option4':
        return 3;
      default:
        return -1;
    }
  }
}

List<QuestionModel> questions = [
  QuestionModel(
    questionId: 1,
    question: "What is Flutter?",
    options: [
      "Programming Language",
      "SDK",
      "Framework",
      "Database",
    ],
    correctAnswerIndex: 2,
  ),
  QuestionModel(
    questionId: 2,
    question: "Flutter is developed by?",
    options: [
      "Google",
      "Microsoft",
      "Facebook",
      "Amazon",
    ],
    correctAnswerIndex: 0,
  ),
];
