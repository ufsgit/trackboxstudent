import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;
import 'package:outline_gradient_button/outline_gradient_button.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_image.dart';
import '../../widgets/app_bar/appbar_leading_circleimage.dart';
import '../../widgets/app_bar/appbar_subtitle_four.dart';
import '../../widgets/app_bar/appbar_subtitle_two.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../../widgets/custom_outlined_button.dart';
import '../android_large_5_page/android_large_5_page.dart';
import '../home_page/home_page.dart';
import '../my_courses_page/my_courses_page.dart';
import 'controller/home_page_after_joining_a_course_controller.dart';
import 'models/chipviewbookmar2_item_model.dart';
import 'models/popularcoursesgrid_item_model.dart';
import 'widgets/chipviewbookmar2_item_widget.dart';
import 'widgets/popularcoursesgrid_item_widget.dart'; // ignore_for_file: must_be_immutable

class HomePageAfterJoiningACourseScreen
    extends GetWidget<HomePageAfterJoiningACourseController> {
  const HomePageAfterJoiningACourseScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              _buildMainStack(),
              SizedBox(height: 19.v),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 16.h),
                          child: Text(
                            "lbl_recently_played".tr,
                            style: CustomTextStyles.titleSmallPrimaryContainer,
                          ),
                        ),
                      ),
                      SizedBox(height: 2.v),
                      _buildRecentlyPlayedRow(),
                      SizedBox(height: 16.v),
                      CustomOutlinedButton(
                        text: "lbl_explore_courses".tr,
                        margin: EdgeInsets.symmetric(horizontal: 16.h),
                        rightIcon: Container(
                          margin: EdgeInsets.only(left: 4.h),
                          child: CustomImageView(
                            imagePath: ImageConstant.imgArrowright,
                            height: 15.v,
                            width: 20.h,
                          ),
                        ),
                        buttonStyle: CustomButtonStyles.outlineBlue,
                        decoration:
                            CustomButtonStyles.gradientBlueToBlueDecoration,
                        buttonTextStyle: CustomTextStyles.titleSmallWhiteA700,
                        onPressed: () {
                          onTapExplorecourses();
                        },
                      ),
                      SizedBox(height: 16.v),
                      _buildFindAMentorStack(),
                      SizedBox(height: 17.v),
                      _buildMockTestsColumn(),
                      SizedBox(height: 19.v),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 16.h),
                          child: Text(
                            "lbl_popular_courses".tr,
                            style: theme.textTheme.titleSmall,
                          ),
                        ),
                      ),
                      SizedBox(height: 6.v),
                      _buildPopularCoursesGrid()
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  /// Section Widget
  Widget _buildMainStack() {
    return SizedBox(
      height: 154.v,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgRectangle27,
            height: 154.v,
            width: 360.h,
            radius: BorderRadius.vertical(
              bottom: Radius.circular(12.h),
            ),
            alignment: Alignment.center,
          ),
          Align(
            alignment: Alignment.center,
            child: Card(
              clipBehavior: Clip.antiAlias,
              elevation: 0,
              margin: EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusStyle.customBorderBL12,
              ),
              child: Container(
                height: 154.v,
                width: double.maxFinite,
                decoration: AppDecoration.gradientBlueToBlue.copyWith(
                  borderRadius: BorderRadiusStyle.customBorderBL12,
                ),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgImage29,
                      height: 109.v,
                      width: 140.h,
                      alignment: Alignment.bottomLeft,
                    ),
                    CustomImageView(
                      imagePath: ImageConstant.imgEllipse13,
                      height: 60.v,
                      width: 360.h,
                      alignment: Alignment.bottomCenter,
                    ),
                    CustomImageView(
                      imagePath: ImageConstant.imgEllipse14,
                      height: 24.v,
                      width: 359.h,
                      alignment: Alignment.bottomCenter,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 11.h,
                          right: 16.h,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomAppBar(
                              height: 38.v,
                              leadingWidth: 52.h,
                              leading: AppbarLeadingCircleimage(
                                imagePath: ImageConstant.imgFrame2609093,
                                margin: EdgeInsets.only(
                                  left: 16.h,
                                  top: 1.v,
                                  bottom: 1.v,
                                ),
                              ),
                              title: Padding(
                                padding: EdgeInsets.only(left: 8.h),
                                child: Column(
                                  children: [
                                    AppbarSubtitleTwo(
                                      text: "lbl_hi_ajay".tr,
                                      margin: EdgeInsets.only(right: 79.h),
                                    ),
                                    SizedBox(height: 1.v),
                                    AppbarSubtitleFour(
                                      text: "msg_tuesday_23_april".tr,
                                    )
                                  ],
                                ),
                              ),
                              actions: [
                                GestureDetector(
                                  onTap: () {
                                    onTapColumnsearch();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      left: 16.h,
                                      right: 16.h,
                                      bottom: 2.v,
                                    ),
                                    decoration:
                                        AppDecoration.fillBlack.copyWith(
                                      borderRadius:
                                          BorderRadiusStyle.circleBorder18,
                                    ),
                                    child: Column(
                                      children: [
                                        SizedBox(height: 2.v),
                                        AppbarImage(
                                          imagePath:
                                              ImageConstant.imgSearchWhiteA700,
                                          margin: EdgeInsets.only(
                                            left: 2.h,
                                            right: 42.h,
                                          ),
                                        ),
                                        SizedBox(height: 2.v),
                                        AppbarImage(
                                          imagePath:
                                              ImageConstant.imgFrame2609305,
                                          margin: EdgeInsets.only(
                                            left: 42.h,
                                            right: 2.h,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 21.v),
                            Padding(
                              padding: EdgeInsets.only(right: 16.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  CustomImageView(
                                    imagePath: ImageConstant.imgImage30,
                                    height: 93.v,
                                    width: 101.h,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 28.v,
                                      bottom: 13.v,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "msg_hello_i_m_breff".tr,
                                          style: CustomTextStyles
                                              .titleSmallWhiteA700,
                                        ),
                                        SizedBox(height: 1.v),
                                        SizedBox(
                                          width: 120.h,
                                          child: Text(
                                            "msg_ask_all_your_career".tr,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: CustomTextStyles
                                                .bodySmallWhiteA700
                                                .copyWith(
                                              height: 1.60,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 49.v,
                                      bottom: 13.v,
                                    ),
                                    child: OutlineGradientButton(
                                      padding: EdgeInsets.only(
                                        left: 1.h,
                                        top: 1.v,
                                        right: 1.h,
                                        bottom: 1.v,
                                      ),
                                      strokeWidth: 1.h,
                                      gradient: LinearGradient(
                                        begin: Alignment(0.5, 0),
                                        end: Alignment(0.5, 1),
                                        colors: [
                                          appTheme.whiteA700,
                                          appTheme.gray50
                                        ],
                                      ),
                                      corners: Corners(
                                        topLeft: Radius.circular(14),
                                        topRight: Radius.circular(14),
                                        bottomLeft: Radius.circular(14),
                                        bottomRight: Radius.circular(14),
                                      ),
                                      child: CustomOutlinedButton(
                                        height: 28.v,
                                        width: 59.h,
                                        text: "lbl_ask".tr,
                                        buttonStyle: CustomButtonStyles.none,
                                        decoration: CustomButtonStyles
                                            .gradientBlueToSecondaryContainerDecoration,
                                        buttonTextStyle: CustomTextStyles
                                            .labelLargePrimaryContainer,
                                        onPressed: () {
                                          onTapAsk();
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildRecentlyPlayedRow() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.h),
      padding: EdgeInsets.all(3.h),
      decoration: AppDecoration.outlineIndigo5001.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder12,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Card(
            clipBehavior: Clip.antiAlias,
            elevation: 0,
            margin: EdgeInsets.all(0),
            color: appTheme.indigo5001,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusStyle.roundedBorder12,
            ),
            child: Container(
              height: 58.v,
              width: 76.h,
              decoration: AppDecoration.fillIndigo.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder12,
              ),
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgImage31,
                    height: 58.v,
                    width: 76.h,
                    radius: BorderRadius.circular(
                      10.h,
                    ),
                    alignment: Alignment.center,
                  ),
                  CustomImageView(
                    imagePath: ImageConstant.imgOverflowMenu,
                    height: 26.adaptSize,
                    width: 26.adaptSize,
                    radius: BorderRadius.circular(
                      1.h,
                    ),
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(
                      left: 22.h,
                      top: 13.v,
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 12.h,
              top: 2.v,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 156.h,
                  child: Text(
                    "msg_oet_beginner_special2".tr,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.labelLarge!.copyWith(
                      height: 1.50,
                    ),
                  ),
                ),
                SizedBox(height: 4.v),
                Text(
                  "lbl_20_45_35_12".tr,
                  style: CustomTextStyles.bodySmallBluegray500_1,
                )
              ],
            ),
          ),
          Container(
            height: 36.adaptSize,
            width: 36.adaptSize,
            margin: EdgeInsets.only(
              left: 26.h,
              top: 10.v,
              bottom: 10.v,
            ),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 36.adaptSize,
                    width: 36.adaptSize,
                    child: CircularProgressIndicator(
                      value: 0.5,
                      backgroundColor: appTheme.blueGray10001,
                      color: appTheme.blue600,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.v),
                    child: Text(
                      "lbl_35".tr,
                      style: CustomTextStyles.bodySmallBluegray80003,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildFindAMentorStack() {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      margin: EdgeInsets.all(0),
      color: appTheme.whiteA700,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: appTheme.indigo5001,
          width: 1.h,
        ),
        borderRadius: BorderRadiusStyle.roundedBorder12,
      ),
      child: Container(
        height: 114.v,
        width: 328.h,
        decoration: AppDecoration.outlineIndigo.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder12,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgFrame1171275740,
              height: 114.v,
              width: 190.h,
              alignment: Alignment.centerRight,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.h,
                  vertical: 16.v,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusStyle.roundedBorder12,
                  image: DecorationImage(
                    image: fs.Svg(
                      ImageConstant.imgGroup689,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "lbl_find_a_mentor2".tr,
                            style: theme.textTheme.titleSmall,
                          ),
                          TextSpan(
                            text: " ",
                          )
                        ],
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 2.v),
                    Text(
                      "msg_anywhere_anytime".tr,
                      style: CustomTextStyles.labelLargeBluegray500Medium,
                    ),
                    SizedBox(height: 9.v),
                    OutlineGradientButton(
                      padding: EdgeInsets.only(
                        left: 1.h,
                        top: 1.v,
                        right: 1.h,
                        bottom: 1.v,
                      ),
                      strokeWidth: 1.h,
                      gradient: LinearGradient(
                        begin: Alignment(0, 0.5),
                        end: Alignment(1, 0.5),
                        colors: [appTheme.blue60003, appTheme.blue80002],
                      ),
                      corners: Corners(
                        topLeft: Radius.circular(17),
                        topRight: Radius.circular(17),
                        bottomLeft: Radius.circular(17),
                        bottomRight: Radius.circular(17),
                      ),
                      child: CustomOutlinedButton(
                        height: 34.v,
                        width: 113.h,
                        text: "lbl_connect_now".tr,
                        buttonStyle: CustomButtonStyles.outlineBlue,
                        decoration:
                            CustomButtonStyles.gradientBlueToBlueTL17Decoration,
                        buttonTextStyle: CustomTextStyles.labelLargeGray10002,
                        onPressed: () {
                          onTapConnectnow();
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildMockTestsColumn() {
    return Padding(
      padding: EdgeInsets.only(left: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "lbl_mock_tests".tr,
            style: theme.textTheme.titleSmall,
          ),
          SizedBox(height: 8.v),
          Obx(
            () => Wrap(
              runSpacing: 8.v,
              spacing: 8.h,
              children: List<Widget>.generate(
                controller.homePageAfterJoiningACourseModelObj.value
                    .chipviewbookmar2ItemList.value.length,
                (index) {
                  Chipviewbookmar2ItemModel model = controller
                      .homePageAfterJoiningACourseModelObj
                      .value
                      .chipviewbookmar2ItemList
                      .value[index];
                  return Chipviewbookmar2ItemWidget(
                    model,
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildPopularCoursesGrid() {
    return Padding(
      padding: EdgeInsets.only(left: 16.h),
      child: Obx(
        () => GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: 246.v,
            crossAxisCount: 2,
            mainAxisSpacing: 0.h,
            crossAxisSpacing: 0.h,
          ),
          physics: NeverScrollableScrollPhysics(),
          itemCount: controller.homePageAfterJoiningACourseModelObj.value
              .popularcoursesgridItemList.value.length,
          itemBuilder: (context, index) {
            PopularcoursesgridItemModel model = controller
                .homePageAfterJoiningACourseModelObj
                .value
                .popularcoursesgridItemList
                .value[index];
            return PopularcoursesgridItemWidget(
              model,
            );
          },
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildBottomNavigationBar() {
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
      case BottomBarEnum.Mycourses:
        return AppRoutes.myCoursesPage;
      case BottomBarEnum.Mentors:
        return AppRoutes.androidLarge5Page;
      case BottomBarEnum.Profile:
        return "/";
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

  /// Navigates to the searchPageScreen when the action is triggered.
  onTapColumnsearch() {
    Get.toNamed(
      AppRoutes.searchPageScreen,
    );
  }

  /// Navigates to the breffScreen when the action is triggered.
  onTapAsk() {
    Get.toNamed(
      AppRoutes.breffScreen,
    );
  }

  /// Navigates to the searchPageScreen when the action is triggered.
  onTapExplorecourses() {
    Get.toNamed(
      AppRoutes.searchPageScreen,
    );
  }

  /// Navigates to the frame1000004938Screen when the action is triggered.
  onTapConnectnow() {
    Get.toNamed(
      AppRoutes.frame1000004938Screen,
    );
  }
}
