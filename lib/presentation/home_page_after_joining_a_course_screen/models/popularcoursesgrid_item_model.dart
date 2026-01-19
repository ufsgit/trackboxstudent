import '../../../core/app_export.dart';

/// This class is used in the [popularcoursesgrid_item_widget] screen.

// ignore_for_file: must_be_immutable
class PopularcoursesgridItemModel {
  PopularcoursesgridItemModel(
      {this.image1,
      this.text1,
      this.image2,
      this.text2,
      this.image3,
      this.text4,
      this.image4,
      this.text5,
      this.id}) {
    image1 = image1 ?? Rx(ImageConstant.imgImage28);
    text1 = text1 ?? Rx("OET Beginner special class and Perparation Tips");
    image2 = image2 ?? Rx(ImageConstant.imgBooks);
    text2 = text2 ?? Rx("54");
    image3 = image3 ?? Rx(ImageConstant.imgClock);
    text4 = text4 ?? Rx("₹ 5000");
    image4 = image4 ?? Rx(ImageConstant.imgStar);
    text5 = text5 ?? Rx("4.5");
    id = id ?? Rx("");
  }

  Rx<String>? image1;

  Rx<String>? text1;

  Rx<String>? image2;

  Rx<String>? text2;

  Rx<String>? image3;

  Rx<String>? text4;

  Rx<String>? image4;

  Rx<String>? text5;

  Rx<String>? id;
}
