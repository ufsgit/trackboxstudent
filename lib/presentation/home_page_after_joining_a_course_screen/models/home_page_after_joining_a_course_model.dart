import '../../../core/app_export.dart';
import 'chipviewbookmar2_item_model.dart';
import 'popularcoursesgrid_item_model.dart';

/// This class defines the variables used in the [home_page_after_joining_a_course_screen],
/// and is typically used to hold data that is passed between different parts of the application.

// ignore_for_file: must_be_immutable
class HomePageAfterJoiningACourseModel {
  Rx<List<Chipviewbookmar2ItemModel>> chipviewbookmar2ItemList =
      Rx(List.generate(4, (index) => Chipviewbookmar2ItemModel()));

  Rx<List<PopularcoursesgridItemModel>> popularcoursesgridItemList = Rx([
    PopularcoursesgridItemModel(
        image1: ImageConstant.imgImage28.obs,
        text1: "OET Beginner special class and Perparation Tips".obs,
        image2: ImageConstant.imgBooks.obs,
        text2: "54".obs,
        image3: ImageConstant.imgClock.obs,
        text4: "₹ 5000".obs,
        image4: ImageConstant.imgStar.obs,
        text5: "4.5".obs),
    PopularcoursesgridItemModel(
        image1: ImageConstant.imgImage28.obs,
        text1: "OET Beginner special class and Perparation Tips".obs,
        image2: ImageConstant.imgBooks.obs,
        text2: "54".obs,
        image3: ImageConstant.imgClock.obs),
    PopularcoursesgridItemModel(
        image1: ImageConstant.imgImage28.obs,
        text1: "OET Beginner special class and Perparation Tips".obs,
        image2: ImageConstant.imgBooksBlueGray500.obs,
        text2: "54".obs,
        image3: ImageConstant.imgClockBlueGray500.obs),
    PopularcoursesgridItemModel(
        image1: ImageConstant.imgImage46.obs,
        text1: "OET Beginner special class and Perparation Tips".obs,
        image2: ImageConstant.imgBooksBlueGray500.obs,
        text2: "54".obs,
        image3: ImageConstant.imgClockBlueGray500.obs)
  ]);
}
