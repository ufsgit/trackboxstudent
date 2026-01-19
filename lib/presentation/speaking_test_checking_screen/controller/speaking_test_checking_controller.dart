import '../../../core/app_export.dart';
import '../models/speaking_test_checking_model.dart';

/// A controller class for the SpeakingTestCheckingScreen.
///
/// This class manages the state of the SpeakingTestCheckingScreen, including the
/// current speakingTestCheckingModelObj
class SpeakingTestCheckingController extends GetxController {
  Rx<SpeakingTestCheckingModel> speakingTestCheckingModelObj =
      SpeakingTestCheckingModel().obs;
}
