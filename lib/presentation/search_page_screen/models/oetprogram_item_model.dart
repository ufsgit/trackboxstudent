import '../../../core/app_export.dart';

/// This class is used in the [oetprogram_item_widget] screen.

// ignore_for_file: must_be_immutable
class OetprogramItemModel {
  OetprogramItemModel(
      {this.programTitle, this.programPrice, this.fortyFive, this.id}) {
    programTitle = programTitle ?? Rx("Comprehensive OET Preparation Program");
    programPrice = programPrice ?? Rx("₹ 5000");
    fortyFive = fortyFive ?? Rx("4.5");
    id = id ?? Rx("");
  }

  Rx<String>? programTitle;

  Rx<String>? programPrice;

  Rx<String>? fortyFive;

  Rx<String>? id;
}
