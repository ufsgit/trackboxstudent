import '../../../core/app_export.dart';
import '../models/cart_checkout_model.dart';

/// A controller class for the CartCheckoutScreen.
///
/// This class manages the state of the CartCheckoutScreen, including the
/// current cartCheckoutModelObj
class CartCheckoutController extends GetxController {
  Rx<CartCheckoutModel> cartCheckoutModelObj = CartCheckoutModel().obs;
}
