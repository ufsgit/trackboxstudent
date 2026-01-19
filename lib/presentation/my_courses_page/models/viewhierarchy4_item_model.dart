import '../../../core/app_export.dart';

/// This class is used in the [viewhierarchy4_item_widget] screen.

// ignore_for_file: must_be_immutable
class Viewhierarchy4ItemModel {
  Viewhierarchy4ItemModel({this.text, this.text1, this.id}) {
    text = text ?? Rx("OET Beginner special class and Perparation Tips");
    text1 = text1 ?? Rx("35%");
    id = id ?? Rx("");
  }

  Rx<String>? text;

  Rx<String>? text1;

  Rx<String>? id;
}
