import '../../../core/app_export.dart';

/// This class is used in the [viewhierarchy_item_widget] screen.

// ignore_for_file: must_be_immutable
class ViewhierarchyItemModel {
  ViewhierarchyItemModel(
      {this.text1, this.text2, this.text4, this.text5, this.id}) {
    text1 = text1 ?? Rx("OET Beginner special class and Perparation Tips");
    text2 = text2 ?? Rx("54");
    text4 = text4 ?? Rx("₹ 5000");
    text5 = text5 ?? Rx("4.5");
    id = id ?? Rx("");
  }

  Rx<String>? text1;

  Rx<String>? text2;

  Rx<String>? text4;

  Rx<String>? text5;

  Rx<String>? id;
}
