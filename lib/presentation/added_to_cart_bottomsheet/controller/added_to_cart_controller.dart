import '../../../core/app_export.dart';
import '../models/added_to_cart_model.dart';

/// A controller class for the AddedToCartBottomsheet.
///
/// This class manages the state of the AddedToCartBottomsheet, including the
/// current addedToCartModelObj
class AddedToCartController extends GetxController {
  Rx<AddedToCartModel> addedToCartModelObj = AddedToCartModel().obs;
}
