import '../../../core/app_export.dart';
import 'viewhierarchy3_item_model.dart';

/// This class defines the variables used in the [cart_checkout_screen],
/// and is typically used to hold data that is passed between different parts of the application.
// ignore_for_file: must_be_immutable

class CartCheckoutModel {
  Rx<List<Viewhierarchy3ItemModel>> viewhierarchy3ItemList = Rx([
    Viewhierarchy3ItemModel(
        text: "The complete OET Masterclass : Basic to Advanced".obs,
        text1: "54".obs,
        text2: "4.5".obs),
    Viewhierarchy3ItemModel(
        text: "The complete OET Masterclass : Basic to Advanced".obs,
        text1: "54".obs,
        text2: "4.5".obs),
    Viewhierarchy3ItemModel(
        text: "The complete OET Masterclass : Basic to Advanced".obs,
        text1: "54".obs,
        text2: "4.5".obs)
  ]);
}
