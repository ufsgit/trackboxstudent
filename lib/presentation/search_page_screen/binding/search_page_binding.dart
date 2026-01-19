import '../../../core/app_export.dart';
import '../controller/search_page_controller.dart';

/// A binding class for the SearchPageScreen.
///
/// This class ensures that the SearchPageController is created when the
/// SearchPageScreen is first loaded.
class SearchPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchPageController());
  }
}
