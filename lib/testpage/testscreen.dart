import 'dart:async';
import 'package:flutter/material.dart';
import '../core/app_export.dart';
import 'quastions_modal.dart';
import 'resultscreen.dart';
import 'examservieses.dart';

class TestScreen extends StatefulWidget {
  final int courseExamId; // ✅ FIXED (INT)
  final int duration; // in minutes
  final int courseId;
  final int passMark;

  const TestScreen({
    super.key,
    required this.courseExamId,
    required this.duration,
    required this.courseId,
    required this.passMark,
  });

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  int currentIndex = 0;
  // int selectedAnswer = -1; // Removed in favor of userAnswers
  Map<int, int> userAnswers = {}; // {questionIndex: selectedOptionIndex}
  // int score = 0; // Calculated on submit

  List<QuestionModel> questions = [];
  bool isLoading = true;
  String? errorMessage;

  Timer? _timer;
  int _timeLeft = 0; // in seconds

  @override
  void initState() {
    super.initState();
    _timeLeft = widget.duration * 60;
    _fetchQuestions();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() {
          _timeLeft--;
        });
      } else {
        _submitExam();
      }
    });
  }

  Future<void> _fetchQuestions() async {
    try {
      final service = ExamService(PrefUtils().getAuthToken());

      final fetchedQuestions = await service.fetchQuestionsByCourseExam(
        widget.courseExamId, // ✅ INT
      );

      if (fetchedQuestions.isEmpty) {
        throw Exception("No questions found for this exam.");
      }

      setState(() {
        questions = fetchedQuestions;
        isLoading = false;
      });

      _startTimer();
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = e.toString().replaceAll("Exception: ", "");
      });
    }
  }

  void _submitExam() {
    _timer?.cancel();

    int score = 0;
    for (int i = 0; i < questions.length; i++) {
      if (userAnswers.containsKey(i) &&
          userAnswers[i] == questions[i].correctAnswerIndex) {
        score++;
      }
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ResultScreen(
          score: score,
          total: questions.length,
          courseId: widget.courseId,
          examDataId: widget.courseExamId,
          passMark: widget.passMark,
        ),
      ),
    );
  }

  void previousQuestion() {
    print("Previous Button Clicked. Current Index: $currentIndex");
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
        print("Moved to Previous Question. New Index: $currentIndex");
      });
    }
  }

  void nextQuestion() {
    print("Next Button Clicked. Current Index: $currentIndex");
    if (currentIndex < questions.length - 1) {
      setState(() {
        currentIndex++;
        print("Moved to Next Question. New Index: $currentIndex");
      });
    } else {
      print("Last Question reached. Submitting Exam.");
      _submitExam();
    }
  }

  void skipQuestion() {
    print("Skip Button Clicked. Current Index: $currentIndex");
    if (currentIndex < questions.length - 1) {
      setState(() {
        currentIndex++;
        print("Question Skipped. New Index: $currentIndex");
      });
    } else {
      print("Last Question reached on Skip. Submitting Exam.");
      _submitExam();
    }
  }

  String get _formattedTime {
    final minutes = (_timeLeft ~/ 60).toString().padLeft(2, '0');
    final seconds = (_timeLeft % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Online Test",
          style: theme.textTheme.titleMedium,
        ),
        centerTitle: true,
        actions: [
          if (!isLoading && questions.isNotEmpty)
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.h),
              padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 6.v),
              decoration: BoxDecoration(
                color: _timeLeft < 60
                    ? Colors.red.withOpacity(0.1)
                    : appTheme.blue50,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: _timeLeft < 60 ? Colors.red : appTheme.blue800,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.timer_outlined,
                    size: 16,
                    color: _timeLeft < 60 ? Colors.red : appTheme.blue800,
                  ),
                  SizedBox(width: 4.h),
                  Text(
                    _formattedTime,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: _timeLeft < 60 ? Colors.red : appTheme.blue800,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(16.v),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              SizedBox(height: 16.v),
              Text(
                errorMessage!,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge,
              ),
              SizedBox(height: 16.v),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isLoading = true;
                    errorMessage = null;
                  });
                  _fetchQuestions();
                },
                child: const Text("Retry"),
              ),
            ],
          ),
        ),
      );
    }

    final question = questions[currentIndex];
    final selectedAnswer = userAnswers[currentIndex] ?? -1;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16.v),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Question ${currentIndex + 1} of ${questions.length}",
                style: theme.textTheme.labelLarge,
              ),
              SizedBox(height: 6.v),
              LinearProgressIndicator(
                value: (currentIndex + 1) / questions.length,
                minHeight: 6.v,
                backgroundColor: appTheme.gray200,
                valueColor: AlwaysStoppedAnimation(appTheme.blue800),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.v),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.v),
                  decoration: BoxDecoration(
                    color: appTheme.whiteA700,
                    borderRadius: BorderRadius.circular(12.v),
                    boxShadow: [
                      BoxShadow(
                        color: appTheme.gray5005e,
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    question.question,
                    style: theme.textTheme.titleMedium,
                  ),
                ),
                SizedBox(height: 20.v),
                ...List.generate(question.options.length, (index) {
                  final isSelected = selectedAnswer == index;

                  void toggleSelection() {
                    setState(() {
                      if (isSelected) {
                        userAnswers.remove(currentIndex);
                      } else {
                        userAnswers[currentIndex] = index;
                      }
                    });
                  }

                  return InkWell(
                    onTap: toggleSelection,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 12.v),
                      padding: EdgeInsets.all(14.v),
                      decoration: BoxDecoration(
                        color:
                            isSelected ? appTheme.blue50 : appTheme.whiteA700,
                        borderRadius: BorderRadius.circular(12.v),
                        border: Border.all(
                          color:
                              isSelected ? appTheme.blue800 : appTheme.gray200,
                        ),
                      ),
                      child: Row(
                        children: [
                          Radio<int>(
                            value: index,
                            groupValue: selectedAnswer,
                            onChanged: (value) {
                              setState(() {
                                userAnswers[currentIndex] = value!;
                              });
                            },
                          ),
                          SizedBox(width: 12.h),
                          Expanded(
                            child: Text(
                              question.options[index],
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.v),
          child: Row(
            children: [
              // Previous Button
              Expanded(
                child: OutlinedButton(
                  onPressed: currentIndex > 0 ? previousQuestion : null,
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 80.v),
                    side: BorderSide(
                        color: currentIndex > 0
                            ? appTheme.blue800
                            : appTheme.gray200),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Previous",
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: currentIndex > 0
                          ? appTheme.blue800
                          : appTheme.gray600,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 120.h),
              // Skip Button
              Expanded(
                child: OutlinedButton(
                  onPressed:
                      currentIndex < questions.length - 1 ? skipQuestion : null,
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12.v),
                    side: BorderSide(
                        color: currentIndex < questions.length - 1
                            ? appTheme.gray600
                            : appTheme.gray200),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Skip",
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: currentIndex < questions.length - 1
                          ? appTheme.gray600
                          : appTheme.gray200,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.h),
              // Next or Submit Button
              Expanded(
                child: ElevatedButton(
                  onPressed: currentIndex < questions.length - 1
                      ? nextQuestion
                      : _submitExam,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: currentIndex == questions.length - 1
                        ? Colors.green[700]
                        : appTheme.blue800,
                    padding: EdgeInsets.symmetric(vertical: 12.v),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    currentIndex == questions.length - 1 ? "Submit" : "Next",
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
