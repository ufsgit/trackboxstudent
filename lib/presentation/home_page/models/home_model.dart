import '../../../core/app_export.dart';
import 'chipviewbookmar_item_model.dart';
import 'viewhierarchy_item_model.dart';

/// This class defines the variables used in the [home_page],
/// and is typically used to hold data that is passed between different parts of the application.

// ignore_for_file: must_be_immutable
class HomeModel {
  Rx<List<ChipviewbookmarItemModel>> chipviewbookmarItemList =
      Rx(List.generate(4, (index) => ChipviewbookmarItemModel()));

  Rx<List<ViewhierarchyItemModel>> viewhierarchyItemList = Rx([
    ViewhierarchyItemModel(
        text1: "OET Beginner special class and Perparation Tips".obs,
        text2: "54".obs,
        text4: "₹ 5000".obs,
        text5: "4.5".obs),
    ViewhierarchyItemModel(
        text1: "OET Beginner special class and Perparation Tips".obs,
        text2: "54".obs)
  ]);
}
