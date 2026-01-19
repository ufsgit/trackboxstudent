import '../../../core/app_export.dart';
import '../../../data/models/selectionPopupModel/selection_popup_model.dart';
import '../models/filter_bottom_sheet_model.dart';

/// A controller class for the FilterBottomSheetBottomsheet.
///
/// This class manages the state of the FilterBottomSheetBottomsheet, including the
/// current filterBottomSheetModelObj
class FilterBottomSheetController extends GetxController {
  Rx<FilterBottomSheetModel> filterBottomSheetModelObj =
      FilterBottomSheetModel().obs;

  SelectionPopupModel? selectedDropDownValue;

  SelectionPopupModel? selectedDropDownValue1;

  onSelected(dynamic value) {
    for (var element
        in filterBottomSheetModelObj.value.dropdownItemList.value) {
      element.isSelected = false;
      if (element.id == value.id) {
        element.isSelected = true;
      }
    }
    filterBottomSheetModelObj.value.dropdownItemList.refresh();
  }

  onSelected1(dynamic value) {
    for (var element
        in filterBottomSheetModelObj.value.dropdownItemList1.value) {
      element.isSelected = false;
      if (element.id == value.id) {
        element.isSelected = true;
      }
    }
    filterBottomSheetModelObj.value.dropdownItemList1.refresh();
  }
}
