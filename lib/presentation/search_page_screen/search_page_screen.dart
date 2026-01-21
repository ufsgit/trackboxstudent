import 'package:anandhu_s_application4/testpage/mainexamstapbar.dart';
import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_iconbutton.dart';
import '../../widgets/app_bar/appbar_subtitle_one.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../../widgets/custom_search_view.dart';
import '../android_large_5_page/android_large_5_page.dart';
import '../home_page/home_page.dart';
import '../my_courses_page/my_courses_page.dart';
import 'controller/search_page_controller.dart';
import 'models/oetprogram_item_model.dart';
import 'widgets/oetprogram_item_widget.dart'; // ignore_for_file: must_be_immutable

class SearchPageScreen extends GetWidget<SearchPageController> {
  const SearchPageScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: appTheme.whiteA700,
        appBar: _buildAppBar(),
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              SizedBox(height: 16.v),
              Expanded(
                child: SingleChildScrollView(
                  child: _buildSearchPageContent(),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomNavigation(),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      leadingWidth: 40.h,
      leading: AppbarLeadingIconbutton(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.only(left: 16.h),
        onTap: () {
          onTapArrowleftone();
        },
      ),
      title: AppbarSubtitleOne(
        text: "msg_search_result_for".tr,
        margin: EdgeInsets.only(left: 8.h),
      ),
    );
  }

  /// Section Widget
  Widget _buildSearchPageContent() {
    return Container(
      margin: EdgeInsets.only(bottom: 5.v),
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: Column(
        children: [
          CustomSearchView(
            controller: controller.searchController,
            hintText: "msg_search_course_name".tr,
            contentPadding: EdgeInsets.symmetric(vertical: 11.v),
          ),
          SizedBox(height: 24.v),
          Obx(
            () => ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 24.v,
                );
              },
              itemCount: controller
                  .searchPageModelObj.value.oetprogramItemList.value.length,
              itemBuilder: (context, index) {
                OetprogramItemModel model = controller
                    .searchPageModelObj.value.oetprogramItemList.value[index];
                return OetprogramItemWidget(
                  model,
                  onTapOetprogram: () {
                    onTapOetprogram();
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildBottomNavigation() {
    return CustomBottomBar(
      onChanged: (BottomBarEnum type) {
        Get.toNamed(getCurrentRoute(type), id: 1);
      },
    );
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return AppRoutes.homePage;
      case BottomBarEnum.Connect:
        return AppRoutes.connectMentorsPage;
      case BottomBarEnum.Mentors:
        return AppRoutes.androidLarge5Page;
      case BottomBarEnum.Test:
        return AppRoutes.testTab;
      case BottomBarEnum.Profile:
        return AppRoutes.profileScreen;
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.homePage:
        return HomePage();
      case AppRoutes.myCoursesPage:
        return MyCoursesPage();
      case AppRoutes.androidLarge5Page:
        return AndroidLarge5Screen(
          isNotificationClick: false,
        );
      default:
        return DefaultWidget();
    }
  }

  /// Navigates to the previous screen.
  onTapArrowleftone() {
    Get.back();
  }

  /// Navigates to the courseDetailsPageScreen when the action is triggered.
  onTapOetprogram() {
    Get.toNamed(
      AppRoutes.courseDetailsPageScreen,
    );
  }
}
