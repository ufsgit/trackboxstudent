import '../../../core/app_export.dart';
import 'viewhierarchy2_item_model.dart';

/// This class defines the variables used in the [course_details_page1_screen],
/// and is typically used to hold data that is passed between different parts of the application.
// ignore_for_file: must_be_immutable

class CourseDetailsPage1Model {
  Rx<List<Viewhierarchy2ItemModel>> viewhierarchy2ItemList = Rx([
    Viewhierarchy2ItemModel(
        text: "1".obs,
        text1: "Introduction to OET Writing".obs,
        text2: "15:04 mins".obs,
        text3: "3 tests".obs,
        text4: "8 materials".obs)
  ]);
}
