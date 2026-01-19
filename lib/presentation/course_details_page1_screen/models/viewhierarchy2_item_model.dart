import '../../../core/app_export.dart';

/// This class is used in the [viewhierarchy2_item_widget] screen.
// ignore_for_file: must_be_immutable
class Viewhierarchy2ItemModel {
  Viewhierarchy2ItemModel(
      {this.text, this.text1, this.text2, this.text3, this.text4, this.id}) {
    text = text ?? Rx("1");
    text1 = text1 ?? Rx("Introduction to OET Writing");
    text2 = text2 ?? Rx("15:04 mins");
    text3 = text3 ?? Rx("3 tests");
    text4 = text4 ?? Rx("8 materials");
    id = id ?? Rx("");
  }

  Rx<String>? text;

  Rx<String>? text1;

  Rx<String>? text2;

  Rx<String>? text3;

  Rx<String>? text4;

  Rx<String>? id;
}
