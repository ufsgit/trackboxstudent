import '../../../core/app_export.dart';
import 'userprofilelist_item_model.dart';

/// This class defines the variables used in the [android_large_5_page],
/// and is typically used to hold data that is passed between different parts of the application.
// ignore_for_file: must_be_immutable

class AndroidLarge5Model {
  Rx<List<UserprofilelistItemModel>> userprofilelistItemList = Rx([
    UserprofilelistItemModel(
        userImage: ImageConstant.imgImage2842x42.obs,
        username: "Arathy Krishnan".obs,
        description: "keep working on those presentation".obs,
        date: "Today".obs,
        count: "2".obs)
  ]);
}
