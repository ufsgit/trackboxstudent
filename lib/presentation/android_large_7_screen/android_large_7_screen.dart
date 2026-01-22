import 'package:anandhu_s_application4/core/colors_res.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_iconbutton.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../../widgets/custom_search_view.dart';
import '../../widgets/custom_text_form_field.dart';
import '../android_large_5_page/android_large_5_page.dart';
import '../home_page/home_page.dart';
import '../my_courses_page/my_courses_page.dart';
import 'controller/android_large_7_controller.dart'; // ignore_for_file: must_be_immutable

class AndroidLarge7Screen extends GetWidget<AndroidLarge7Controller> {
  const AndroidLarge7Screen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: appTheme.whiteA700,
        appBar: AppBar(
          titleSpacing: 0,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                  color: ColorResources.colorBlue100,
                  borderRadius: BorderRadius.circular(100)),
              child: IconButton(
                padding: EdgeInsets.all(0),
                constraints: BoxConstraints(),
                onPressed: () {
                  onTapArrowleftone();
                },
                icon: Icon(
                  CupertinoIcons.back,
                  color: ColorResources.colorBlack.withOpacity(.8),
                ),
              ),
            ),
          ),
        ),
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              SizedBox(height: 18.v),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 16.h),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "lbl_mentors2".tr,
                          style: CustomTextStyles.titleMediumBluegray80001,
                        ),
                        TextSpan(
                          text: "lbl_1_1_chat".tr,
                          style: CustomTextStyles.titleMediumBluegray80001,
                        )
                      ],
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              SizedBox(height: 17.v),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.h),
                child: CustomSearchView(
                  controller: controller.searchController,
                  hintText: "lbl_search_mentor".tr,
                ),
              ),
              SizedBox(height: 16.v),
              _buildMentorSection(),
              SizedBox(height: 23.v),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 16.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 9.v),
                          child: Text(
                            "lbl_chats".tr,
                            style: CustomTextStyles.labelLargeOnError,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 24.h),
                        child: Column(
                          children: [
                            Text(
                              "lbl_calls".tr,
                              style: theme.textTheme.labelLarge,
                            ),
                            SizedBox(height: 8.v),
                            CustomImageView(
                              imagePath: ImageConstant.imgLine266,
                              height: 1.v,
                              width: 24.h,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 22.v),
              _buildChatSection(),
              SizedBox(height: 10.v),
              _buildChatSection(),
              Spacer(),
              Container(
                height: 104.v,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0.53, 0.28),
                    end: Alignment(0.53, 0),
                    colors: [
                      appTheme.whiteA700,
                      appTheme.whiteA700.withOpacity(0)
                    ],
                  ),
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
      leadingWidth: double.maxFinite,
      leading: AppbarLeadingIconbutton(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.only(
          left: 16.h,
          right: 320.h,
        ),
        onTap: () {
          onTapArrowleftone();
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildMentorSection() {
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
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.h,
                  vertical: 16.v,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusStyle.roundedBorder12,
                  image: DecorationImage(
                    image: AssetImage(
                      ImageConstant.imgGroup736,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 37.v,
                      width: 115.h,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "lbl_find_a_mentor2".tr,
                                    style: theme.textTheme.titleMedium,
                                  ),
                                  TextSpan(
                                    text: " ",
                                  )
                                ],
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              "msg_anywhere_anytime".tr,
                              style:
                                  CustomTextStyles.labelLargeBluegray500Medium,
                            ),
                          ),
                          CustomImageView(
                            imagePath: ImageConstant.imgFrame2147223504,
                            height: 18.adaptSize,
                            width: 18.adaptSize,
                            alignment: Alignment.topRight,
                            margin: EdgeInsets.only(
                              top: 4.v,
                              right: 20.h,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 9.v),
                    SizedBox(
                      width: 110.h,
                      height: 28.v,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'Connect now',
                          style: TextStyle(
                              color: ColorResources.colorwhite, fontSize: 10),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: ColorResources.colorBlue600),
                      ),
                    ),
                    // Expanded(
                    //   child: OutlineGradientButton(
                    //     padding: EdgeInsets.only(
                    //       left: 1.h,
                    //       top: 1.v,
                    //       right: 1.h,
                    //       bottom: 1.v,
                    //     ),
                    //     strokeWidth: 1.h,
                    //     gradient: LinearGradient(
                    //       begin: Alignment(0, 0.5),
                    //       end: Alignment(1, 0.5),
                    //       colors: [appTheme.blue60003, appTheme.blue80002],
                    //     ),
                    //     corners: Corners(
                    //       topLeft: Radius.circular(17),
                    //       topRight: Radius.circular(17),
                    //       bottomLeft: Radius.circular(17),
                    //       bottomRight: Radius.circular(17),
                    //     ),
                    //     child: CustomOutlinedButton(
                    //       height: 28.v,
                    //       width: 100.h,
                    //       text: "lbl_connect_now".tr,
                    //       buttonStyle: CustomButtonStyles.none,
                    //       decoration: CustomButtonStyles
                    //           .gradientBlueToBlueTL17Decoration,
                    //       buttonTextStyle: CustomTextStyles.labelLargeGray10002,
                    //     ),
                    //   ),
                    // )
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
  Widget _buildChatSection() {
    return Padding(
      padding: EdgeInsets.only(left: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgImage2842x42,
            height: 42.adaptSize,
            width: 42.adaptSize,
            radius: BorderRadius.circular(
              21.h,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              // left: 12.h,
              top: 3.v,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "lbl_arathy_krishnan".tr,
                  style: theme.textTheme.titleMedium,
                ),
                SizedBox(height: 4.v),
                Row(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgPhoneoutgoing,
                      height: 14.adaptSize,
                      width: 14.adaptSize,
                      margin: EdgeInsets.only(bottom: 1.v),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4.h),
                      child: Text(
                        "lbl_12_24_mins".tr,
                        style: CustomTextStyles.labelLargeBluegray500Medium,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Spacer(
            flex: 150,
          ),
          Padding(
            padding: EdgeInsets.only(top: 3.v, bottom: 22.v, right: 20),
            child: Text(
              "lbl_today".tr,
              style: CustomTextStyles.labelLargeBluegray500Medium,
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(right: 8),
          //   child: Container(
          //     height: 18.adaptSize,
          //     width: 18.adaptSize,
          //     margin: EdgeInsets.only(top: 24.v),
          //     child: Stack(
          //       alignment: Alignment.center,
          //       children: [
          //         Align(
          //           alignment: Alignment.center,
          //           child: Container(
          //             height: 18.adaptSize,
          //             width: 18.adaptSize,
          //             decoration: BoxDecoration(
          //               color: appTheme.blue800,
          //               borderRadius: BorderRadius.circular(
          //                 9.h,
          //               ),
          //             ),
          //           ),
          //         ),
          //         Align(
          //           alignment: Alignment.center,
          //           child: Text(
          //             "lbl_2".tr,
          //             style: theme.textTheme.labelMedium,
          //           ),
          //         )
          //       ],
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildCallSection() {
    return Padding(
      padding: EdgeInsets.only(left: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 62.v,
            width: 328.h,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                CustomTextFormField(
                  width: 328.h,
                  controller: controller.timeController,
                  hintText: "lbl_12_24_mins".tr,
                  hintStyle: CustomTextStyles.labelLargeBluegray500Medium,
                  textInputAction: TextInputAction.done,
                  alignment: Alignment.bottomCenter,
                  prefix: Container(
                    margin: EdgeInsets.fromLTRB(30.h, 1.v, 4.h, 12.v),
                    child: CustomImageView(
                      imagePath: ImageConstant.imgPhoneoutgoing,
                      height: 14.adaptSize,
                      width: 14.adaptSize,
                    ),
                  ),
                  prefixConstraints: BoxConstraints(
                    maxHeight: 26.v,
                  ),
                  contentPadding: EdgeInsets.only(right: 30.h),
                  borderDecoration: TextFormFieldStyleHelper.underLineIndigo,
                  filled: false,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Divider(
                        color: appTheme.indigo5001,
                      ),
                      SizedBox(height: 9.v),
                      SizedBox(
                        width: 328.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card(
                              clipBehavior: Clip.antiAlias,
                              elevation: 0,
                              margin: EdgeInsets.all(0),
                              color: appTheme.indigo5001,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusStyle.circleBorder21,
                              ),
                              child: Container(
                                height: 42.adaptSize,
                                width: 42.adaptSize,
                                decoration: AppDecoration.fillIndigo.copyWith(
                                  borderRadius:
                                      BorderRadiusStyle.circleBorder21,
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    CustomImageView(
                                      imagePath: ImageConstant.imgImage281,
                                      height: 42.adaptSize,
                                      width: 42.adaptSize,
                                      radius: BorderRadius.circular(
                                        21.h,
                                      ),
                                      alignment: Alignment.center,
                                    ),
                                    CustomImageView(
                                      imagePath: ImageConstant.imgImage89,
                                      height: 42.adaptSize,
                                      width: 42.adaptSize,
                                      radius: BorderRadius.circular(
                                        21.h,
                                      ),
                                      alignment: Alignment.center,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 12.h,
                                top: 3.v,
                                bottom: 20.v,
                              ),
                              child: Text(
                                "lbl_arathy_krishnan".tr,
                                style: theme.textTheme.titleSmall,
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 3.v,
                                bottom: 22.v,
                              ),
                              child: Text(
                                "lbl_24_03_2024".tr,
                                style: CustomTextStyles
                                    .labelLargeBluegray500Medium,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 18.adaptSize,
            width: 18.adaptSize,
            margin: EdgeInsets.only(
              left: 47.h,
              top: 34.v,
              bottom: 10.v,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 18.adaptSize,
                    width: 18.adaptSize,
                    decoration: BoxDecoration(
                      color: appTheme.blue800,
                      borderRadius: BorderRadius.circular(
                        9.h,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "lbl_2".tr,
                    style: theme.textTheme.labelMedium,
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
  Widget _buildBottomNavigation() {
    return CustomBottomBar(
      onChanged: (BottomBarEnum type) {
        print(type);
        Get.toNamed(getCurrentRoute(type), id: 1);
        controller.update();
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
}
