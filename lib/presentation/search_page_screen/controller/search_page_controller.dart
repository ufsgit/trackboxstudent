import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/search_page_model.dart';

/// A controller class for the SearchPageScreen.
///
/// This class manages the state of the SearchPageScreen, including the
/// current searchPageModelObj
class SearchPageController extends GetxController {
  TextEditingController searchController = TextEditingController();

  Rx<SearchPageModel> searchPageModelObj = SearchPageModel().obs;

  @override
  void onClose() {
    super.onClose();
    searchController.dispose();
  }
}
