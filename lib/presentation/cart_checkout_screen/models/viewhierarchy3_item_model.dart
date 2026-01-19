import '../../../core/app_export.dart';

/// This class is used in the [viewhierarchy3_item_widget] screen.
// ignore_for_file: must_be_immutable

class Viewhierarchy3ItemModel {
  Viewhierarchy3ItemModel({this.text, this.text1, this.text2, this.id}) {
    text = text ?? Rx("The complete OET Masterclass : Basic to Advanced");
    text1 = text1 ?? Rx("54");
    text2 = text2 ?? Rx("4.5");
    id = id ?? Rx("");
  }

  Rx<String>? text;

  Rx<String>? text1;

  Rx<String>? text2;

  Rx<String>? id;
}
