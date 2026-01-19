import '../../../core/app_export.dart';
import 'viewhierarchy4_item_model.dart';

/// This class defines the variables used in the [my_courses_page],
/// and is typically used to hold data that is passed between different parts of the application.

// ignore_for_file: must_be_immutable
class MyCoursesModel {
  Rx<List<Viewhierarchy4ItemModel>> viewhierarchy4ItemList = Rx([
    Viewhierarchy4ItemModel(
        text: "OET Beginner special class and Perparation Tips".obs,
        text1: "35%".obs),
    Viewhierarchy4ItemModel(
        text: "OET Beginner special class and Perparation Tips".obs,
        text1: "35%".obs)
  ]);
}
