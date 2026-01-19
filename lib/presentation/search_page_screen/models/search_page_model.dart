import '../../../core/app_export.dart';
import 'oetprogram_item_model.dart';

/// This class defines the variables used in the [search_page_screen],
/// and is typically used to hold data that is passed between different parts of the application.

// ignore_for_file: must_be_immutable
class SearchPageModel {
  Rx<List<OetprogramItemModel>> oetprogramItemList = Rx([
    OetprogramItemModel(
        programTitle: "Comprehensive OET Preparation Program".obs,
        programPrice: "₹ 5000".obs,
        fortyFive: "4.5".obs),
    OetprogramItemModel(
        programTitle: "Comprehensive OET Preparation Program".obs,
        programPrice: "₹ 5000".obs,
        fortyFive: "4.5".obs),
    OetprogramItemModel(
        programTitle: "Comprehensive OET Preparation Program".obs,
        programPrice: "₹ 5000".obs,
        fortyFive: "4.5".obs),
    OetprogramItemModel(
        programTitle: "Comprehensive OET Preparation Program".obs,
        programPrice: "₹ 5000".obs,
        fortyFive: "4.5".obs)
  ]);
}
