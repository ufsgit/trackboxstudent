import '../../../core/app_export.dart';

/// This class defines the variables used in the [listening_test_ongoing_screen],
/// and is typically used to hold data that is passed between different parts of the application.

// ignore_for_file: must_be_immutable
class ListeningTestOngoingModel {
  Rx<List<String>> radioList = Rx([
    "msg_it_significantly",
    "msg_it_increases_blood",
    "msg_it_has_no_effect",
    "msg_it_varies_depending"
  ]);
}
