import '../../../core/app_export.dart';
import '../controller/cart_checkout_controller.dart';

/// A binding class for the CartCheckoutScreen.
///
/// This class ensures that the CartCheckoutController is created when the
/// CartCheckoutScreen is first loaded.
class CartCheckoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CartCheckoutController());
  }
}
