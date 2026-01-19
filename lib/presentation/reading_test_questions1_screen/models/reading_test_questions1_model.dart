import '../../../core/app_export.dart';

/// This class defines the variables used in the [reading_test_questions1_screen],
/// and is typically used to hold data that is passed between different parts of the application.

// ignore_for_file: must_be_immutable
class ReadingTestQuestions1Model {
  Rx<List<String>> radioList = Rx([
    "msg_the_importance_of",
    "msg_the_role_of_effective",
    "msg_documentation_requirements",
    "msg_strategies_for_managing"
  ]);

  Rx<List<String>> radioList1 =
      Rx(["msg_to_assert_authority", "msg_to_minimize_patient"]);
}
