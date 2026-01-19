import 'dart:async';
import 'package:anandhu_s_application4/core/colors_res.dart';
import 'package:anandhu_s_application4/http/loader.dart';
import 'package:anandhu_s_application4/presentation/android_large_5_page/controller/call_chat_controller.dart';
import 'package:anandhu_s_application4/presentation/exam_details_screen/controller/live_class_joining_controller.dart';
import 'package:anandhu_s_application4/presentation/exam_details_screen/models/live_class_joining_model.dart';
import 'package:anandhu_s_application4/presentation/exam_details_screen/live_call_screen.dart';
import 'package:anandhu_s_application4/presentation/home_page_container_screen/controller/home_page_container_controller.dart';
import 'package:anandhu_s_application4/presentation/login/login_controller.dart';
import 'package:anandhu_s_application4/presentation/my_courses_page/controller/live_class_controller.dart';
import 'package:anandhu_s_application4/presentation/onboarding/onboard_controller.dart';
import 'package:anandhu_s_application4/theme/custom_button_style.dart';
import 'package:anandhu_s_application4/widgets/custom_outlined_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_iconbutton.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_search_view.dart';
import 'controller/my_courses_controller.dart';
import 'models/my_courses_details_model.dart';
import 'models/my_courses_model.dart';
import 'widgets/viewhierarchy4_item_widget.dart';

// ignore_for_file: must_be_immutable
class MyCoursesPage extends StatefulWidget {
  MyCoursesPage({Key? key})
      : super(
          key: key,
        );

  @override
  State<MyCoursesPage> createState() => _MyCoursesPageState();
}

class _MyCoursesPageState extends State<MyCoursesPage> {
  MyCoursesController controller =
      Get.put(MyCoursesController(MyCoursesModel().obs));

  OnboardingController obController = Get.put(OnboardingController());
  final LoginController logOutController = Get.put(LoginController());
  LiveClassController liveController = Get.put(LiveClassController());
  final HomePageContainerController controllers =
      Get.find<HomePageContainerController>();
  LiveClassJoiningController liveJoiningController =
      Get.put(LiveClassJoiningController());
  CallandChatController callandChatController =
      Get.put(CallandChatController());
  List<String> categoryList = ['Category1', 'Category2', 'Category3'];
  bool isLoading = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getMyCourse();
    });
    super.initState();
  }

  Future<void> getMyCourse() async {
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await controller.getMyCourses();
      });
    } finally {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: appTheme.whiteA700,
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 20.v),
            child: Container(
              margin: EdgeInsets.only(bottom: 5.v),
              padding: EdgeInsets.symmetric(horizontal: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            controllers.setTemporaryPage(AppRoutes.homePage);
                          },
                          icon: Icon(CupertinoIcons.back)),
                      Text(
                        "lbl_my_courses2".tr,
                        style: CustomTextStyles.titleMediumBluegray8000118,
                      ),
                    ],
                  ),
                  SizedBox(height: 23.v),
                  CustomSearchView(
                    controller: controller.searchController,
                    hintText: "lbl_search_courses".tr,
                    onChanged: (value) {
                      controller.searchCourses(value);
                    },
                    suffix: SizedBox(),
                  ),
                  SizedBox(height: 22.v),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text(
                            "lbl_ongoing".tr,
                            style: theme.textTheme.labelLarge,
                          ),
                          SizedBox(height: 7.v),
                          CustomImageView(
                            imagePath: ImageConstant.imgLine266,
                            height: 1.v,
                            width: 24.h,
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10.v),
                  isLoading
                      ? SizedBox(
                          height: Get.height / 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                  child: CircularProgressIndicator(
                                color: ColorResources.colorBlue500,
                              )),
                            ],
                          ),
                        )
                      : Obx(
                          () {
                            return controller.myCourseList.isEmpty
                                ? Text(
                                    "Courses List is Empty!",
                                    style: CustomTextStyles.bodySmallBlack900,
                                  )
                                : (controller.myCourseList.isNotEmpty &&
                                        controller.isSearchEmpty == true)
                                    ? Text(
                                        "Searched course not found!",
                                        style:
                                            CustomTextStyles.bodySmallBlack900,
                                      )
                                    : _buildViewhierarchy();
                          },
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLiveCourseNowCard() {
    return Container(
      padding: EdgeInsets.all(12.h),
      margin: EdgeInsets.symmetric(horizontal: 12.v),
      decoration: AppDecoration.outlineIndigo5001.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 20.h,
                width: 50.v,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.v),
                    color: ColorResources.colorLiveButton),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      'LIVE',
                      style: GoogleFonts.plusJakartaSans(
                        color: ColorResources.colorwhite,
                        fontSize: 14.fSize,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 8.v),
                    Container(
                      height: 2.h,
                      width: 2.v,
                      padding: EdgeInsets.only(left: 4.v),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: ColorResources.colorwhite,
                            spreadRadius: 3,
                            blurRadius: 2,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 12.h),
                child: Text(
                  '${liveController.liveNowCourseList[0].firstName} ${liveController.liveNowCourseList[0].lastName}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    color: ColorResources.colorgrey500,
                    fontSize: 14.fSize,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 15.v),
          Text(
            liveController.liveNowCourseList[0].courseName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.plusJakartaSans(
              color: ColorResources.colorBlack,
              fontSize: 16.fSize,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 13.v),
          CustomOutlinedButton(
            onPressed: () async {
              // await callandChatController.startStudentLiveClass(
              //     passDuration: false,
              //     endTime: null,
              //     liveClassId: liveController.liveNowCourseList[0].liveClassID
              //         .toString(),
              //     startTime: DateTime.now());
              // Get.to(() => LiveCallScreen(
              //       liveLink: liveController.liveNowCourseList[0].liveLink,
              //       callId: liveController.liveNowCourseList[0].liveClassID,
              //       teacherId: liveController.liveNowCourseList[0].teacherID
              //           .toString(),
              //       teacherName: liveController.liveNowCourseList[0].firstName
              //           .toString(),
              //     ));
            },
            text: "Join Now",
            buttonStyle: CustomButtonStyles.none,
            decoration: CustomButtonStyles.gradientBlueToBlueDecoration,
            buttonTextStyle: CustomTextStyles.titleSmallWhiteA700,
          ),
          SizedBox(height: 15.v),
        ],
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

  Widget _buildViewhierarchy() {
    return GetBuilder<MyCoursesController>(
      builder: (myCourseData) {
        var displayList = myCourseData.searchController.text.isEmpty
            ? myCourseData.myCourseList
            : myCourseData.myCourseSearchList;

        if (displayList.isEmpty) {
          return Center(
            child: Text(
              myCourseData.searchController.text.isEmpty
                  ? "Courses List is Empty!"
                  : "Searched course not found!",
              style: CustomTextStyles.bodySmallBlack900,
            ),
          );
        }

        return ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) {
            return SizedBox(height: 24.v);
          },
          itemCount: displayList.length,
          itemBuilder: (context, index) {
            return Viewhierarchy4ItemWidget(
              displayList[index],
            );
          },
        );
      },
    );
  }

  //logout dialog box
  void showLogoutDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text(
            'Logout',
            style: TextStyle(
                fontSize: 18.v,
                fontWeight: FontWeight.w700,
                color: Color(0xff283B52)),
          ),
          content: Text(
            'Are you sure you want to log out?',
            style: GoogleFonts.plusJakartaSans(),
          ),
          actions: [
            TextButton(
              child: Text(
                'No',
                style: GoogleFonts.plusJakartaSans(
                  color: ColorResources.colorgrey700,
                ),
              ),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              child: Text(
                'Yes',
                style: GoogleFonts.plusJakartaSans(
                  color: Color(0xffEB4141),
                ),
              ),
              onPressed: () {
                Get.back();
                logOutController.logout();
              },
            ),
          ],
        );
      },
    );
  }

  /// Navigates to the previous screen.
  onTapArrowleftone() {
    Get.back();
  }

  /// Navigates to the androidLarge7Screen when the action is triggered.
  onTapTxtPassageone() {
    Get.toNamed(
      AppRoutes.androidLarge7Screen,
    );
  }
}
