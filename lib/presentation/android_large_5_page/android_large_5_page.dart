import 'dart:developer';
import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:anandhu_s_application4/core/colors_res.dart';
import 'package:anandhu_s_application4/http/socket_io.dart';
import 'package:anandhu_s_application4/presentation/android_large_5_page/chat_log_screen.dart';
import 'package:anandhu_s_application4/presentation/android_large_5_page/controller/android_large_5_controller.dart';
import 'package:anandhu_s_application4/presentation/android_large_5_page/controller/call_chat_controller.dart';
import 'package:anandhu_s_application4/presentation/android_large_5_page/models/android_large_5_model.dart';
import 'package:anandhu_s_application4/presentation/home_page/controller/home_controller.dart';
import 'package:anandhu_s_application4/presentation/home_page/models/home_model.dart';
import 'package:anandhu_s_application4/presentation/login/login_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:anandhu_s_application4/widgets/app_bar/appbar_leading_iconbutton.dart';
import 'package:anandhu_s_application4/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home_page_container_screen/controller/home_page_container_controller.dart';

class AndroidLarge5Screen extends StatefulWidget {
  final int? initialTabIndex;
  final bool isNotificationClick;

  AndroidLarge5Screen({
    Key? key,
    this.initialTabIndex,
    required this.isNotificationClick,
  }) : super(key: key);

  @override
  _AndroidLarge5ScreenState createState() => _AndroidLarge5ScreenState();
}

class _AndroidLarge5ScreenState extends State<AndroidLarge5Screen> {
  AndroidLarge5Controller controller =
      Get.put(AndroidLarge5Controller(AndroidLarge5Model().obs));
  CallandChatController callandChatController =
      Get.put(CallandChatController());
  final HomePageContainerController controllers =
      Get.find<HomePageContainerController>();
  final LoginController lgOutController = Get.put(LoginController());
  HomeController hodController = Get.put(HomeController(HomeModel().obs));

  bool _isInfoVisible = false;

  void _toggleInfoBox() {
    setState(() {
      _isInfoVisible = !_isInfoVisible;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    log('mentors screen disposedf =======================');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PopScope(
        onPopInvoked: (didPop) async {
          if (didPop) {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            String studentId =
                preferences.getString('breffini_student_id') ?? '';
            ChatSocket.leaveChatLogHistory(studentId, "teacher_student");

            return;
          }
        },
        child: GestureDetector(
          onTap: () {
            setState(() {
              _isInfoVisible = false;
            });
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: appTheme.whiteA700,
            body: Stack(
              children: [
                SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    children: [
                      SizedBox(height: 18.v),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.h),
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  if (Get.currentRoute ==
                                      "/home_page_container_screen") {
                                    Get.back();
                                  } else {
                                    controllers
                                        .setTemporaryPage(AppRoutes.homePage);
                                  }
                                },
                                icon: Icon(CupertinoIcons.back)),
                            Text(
                              'Chat',
                              style: CustomTextStyles.titleMediumBluegray80001,
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: ChatLogScreen(),
                      ),
                    ],
                  ),
                ),
                if (_isInfoVisible)
                  Positioned(
                    top: 200,
                    left: 60,
                    child: Container(
                      width: 230,
                      height: 150.h,
                      child: Material(
                        elevation: 4,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Your Course mentor',
                                style: TextStyle(
                                    fontSize: 14.v,
                                    fontWeight: FontWeight.w700,
                                    color: ColorResources.colorgrey700),
                              ),
                              SizedBox(height: 8.v),
                              Expanded(
                                child: Text(
                                  "Course mentors are experts assigned to guide you through the course and are available during scheduled sessions to support your learning.",
                                  style: TextStyle(
                                      fontSize: 12.v,
                                      fontWeight: FontWeight.w500,
                                      color: ColorResources.colorgrey600),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      leadingWidth: double.maxFinite,
      leading: AppbarLeadingIconbutton(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.only(left: 16.h, right: 320.h, top: 8.h),
        onTap: onTapArrowleftone,
      ),
    );
  }

  onTapArrowleftone() {
    Get.back();
  }

  onTapTxtPassageone() {
    Get.toNamed(
      AppRoutes.androidLarge7Screen,
    );
  }

  onTapUserprofile() {
    Get.toNamed(
      AppRoutes.chatScreen,
    );
  }
}
