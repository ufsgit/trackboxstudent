import '../../../core/app_export.dart';
import '../models/playing_course_model.dart';

/// A controller class for the PlayingCourseScreen.
///
/// This class manages the state of the PlayingCourseScreen, including the
/// current playingCourseModelObj
class PlayingCourseController extends GetxController {
  Rx<PlayingCourseModel> playingCourseModelObj = PlayingCourseModel().obs;
}
