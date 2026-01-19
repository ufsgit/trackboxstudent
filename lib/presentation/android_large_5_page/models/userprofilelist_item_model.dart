import '../../../core/app_export.dart';

/// This class is used in the [userprofilelist_item_widget] screen.
// ignore_for_file: must_be_immutable

class UserprofilelistItemModel {
  UserprofilelistItemModel(
      {this.userImage,
      this.username,
      this.description,
      this.date,
      this.count,
      this.id}) {
    userImage = userImage ?? Rx(ImageConstant.imgImage2842x42);
    username = username ?? Rx("Arathy Krishnan");
    description = description ?? Rx("keep working on those presentation");
    date = date ?? Rx("Today");
    count = count ?? Rx("2");
    id = id ?? Rx("");
  }

  Rx<String>? userImage;

  Rx<String>? username;

  Rx<String>? description;

  Rx<String>? date;

  Rx<String>? count;

  Rx<String>? id;
}
