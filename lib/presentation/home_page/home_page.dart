import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:anandhu_s_application4/core/colors_res.dart';
import 'package:anandhu_s_application4/core/utils/extentions.dart';
import 'package:anandhu_s_application4/core/utils/firebase_utils.dart';
import 'package:anandhu_s_application4/core/utils/notification_service.dart';
import 'package:anandhu_s_application4/http/loader.dart';
import 'package:anandhu_s_application4/presentation/android_large_5_page/controller/call_chat_controller.dart';
import 'package:anandhu_s_application4/presentation/android_large_5_page/models/ongoing_call_model.dart';
import 'package:anandhu_s_application4/presentation/breff_screen/breff_screen.dart';
import 'package:anandhu_s_application4/presentation/breff_screen/controller/breff_controller.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/certificate_download_page.dart';
import 'package:anandhu_s_application4/presentation/explore_courses/controller/explore_course_controller.dart';
import 'package:anandhu_s_application4/core/utils/notification_permission_handler.dart';
import 'package:anandhu_s_application4/presentation/home_page/teacher_list_page.dart';
import 'package:anandhu_s_application4/presentation/home_page/widgets/carosel_widget.dart';
import 'package:anandhu_s_application4/presentation/home_page/widgets/dummy_image_list.dart';
import 'package:anandhu_s_application4/presentation/home_page/widgets/enrol_item_widget.dart';
import 'package:anandhu_s_application4/presentation/login/login_controller.dart';
import 'package:anandhu_s_application4/presentation/my_courses_page/controller/my_courses_controller.dart';
import 'package:anandhu_s_application4/presentation/my_courses_page/models/my_courses_details_model.dart';
import 'package:anandhu_s_application4/presentation/my_courses_page/models/my_courses_model.dart';
import 'package:anandhu_s_application4/presentation/onboarding/onboard_controller.dart';
import 'package:anandhu_s_application4/presentation/profile/controller/profile_controller.dart';
import 'package:anandhu_s_application4/presentation/profile/student_profile_screen.dart';
import 'package:anandhu_s_application4/presentation/splash_screen/splashscreen1.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_callkit_incoming_yoer/entities/android_params.dart';
import 'package:flutter_callkit_incoming_yoer/entities/call_kit_params.dart';
import 'package:flutter_callkit_incoming_yoer/entities/ios_params.dart';
import 'package:flutter_callkit_incoming_yoer/flutter_callkit_incoming.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../core/app_export.dart';
import '../../http/http_urls.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_subtitle_two.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_outlined_button.dart';
import '../android_large_5_page/incoming_call_page.dart';
// import '../exam_details_screen/live_call_screen.dart';
import '../onboarding/course_list_model.dart';
import 'controller/home_controller.dart';
import 'models/home_model.dart';
import 'widgets/viewhierarchy_item_widget.dart';

// ignore_for_file: must_be_immutable
class HomePage extends StatefulWidget {
  HomePage({Key? key})
      : super(
          key: key,
        );

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AndroidNotificationChannel? channel;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
      //     AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
      // try {
      //   requestNotificationPermission();
      // } catch (_) {
      //   print(_);
      // }
      controller.initFn();
      getMyCourse();
      // clearOldCallsFromFirebase();
      // getCurrentCall([]);
    });
  }

  // clearOldCallsFromFirebase() async {//this function must be called before  FirebaseUtils.listenCalls()
  //   // deleting calls which is started from teacher and teacher not ended or app closed (which is not delete from firebase )
  //
  //   var calls = await FlutterCallkitIncoming.activeCalls();
  //
  //
  //   // Check if there are no calls or if none of the calls are accepted
  //   if (calls is List && calls.isNotEmpty && calls[0].length > 0) {
  //     // bool hasAcceptedCall = calls.any((call) => call["accepted"] == true);
  //     for (var call in calls) {
  //
  //       if(!call["accepted"]){
  //         var payload = calls[0]["extra"];
  //         String callId = payload!['id'] ?? '';
  //
  //         await FirebaseUtils.deleteCall(callId);
  //
  //       }
  //     }
  //
  //   } else {
  //     // If there are no calls, delete all inactive calls
  //     await FirebaseUtils.deleteStudentInactiveCalls();
  //   }
  //   Get.put(CallandChatController()).listenIncomingCallNotification();
  //
  //
  // }

  // Future getCurrentCall(List<OnGoingCallsModel> callList) async {
  //
  //   //check current call from pushkit if possible
  //   var calls = await FlutterCallkitIncoming.activeCalls();
  //   if (calls is List) {
  //     if (calls.isNotEmpty) {
  //       print('DATA: $calls');
  //       // _currentUuid = calls[0]['id'];
  //       if (calls[0].length >0) {
  //         bool isAccepted=calls[0]["accepted"];
  //         var payload = calls[0]["extra"];
  //         String callId = payload!['id'] ?? '';
  //         String type = payload!['type'] ?? '';
  //         if(isAccepted){
  //           List<OnGoingCallsModel> callList=await Get.find<CallandChatController>().getOngoingCallsApi(callId);
  //
  //           String liveLink = payload!['Live_Link'] ?? '';
  //
  //           if(type=="new_live"){
  //
  //             String profileImgUrl = payload!.containsKey("Profile_Photo_Img")
  //                 ? payload!['Profile_Photo_Img'] ?? ""
  //                 : "";
  //             String callerName = payload.containsKey("Teacher_Name")
  //                 ? payload['Teacher_Name']
  //                 : "";
  //             String teacherId = payload!['Teacher_Id'] ?? "0";
  //             Get.to(() =>
  //                 VideoScreen(
  //                   liveLink: liveLink,
  //                   callId: int.parse(callId),
  //                   teacherId: teacherId,
  //                   // isIncomingCall: true,
  //                   profileImageUrl: profileImgUrl,
  //                   teacherName: callerName,
  //                 ));
  //
  //           }else {
  //             if (callList.any((value) => value.id.toString() == callId)) {
  //               if (!liveLink.isNullOrEmpty()) {
  //                 // String callType = payload!['call_type'] ?? '';
  //                 // int callerId = int.parse(payload!['sender_id'] ?? "0");
  //                 // String profileImgUrl = payload!.containsKey(
  //                 //     "Profile_Photo_Img")
  //                 //     ? payload!['Profile_Photo_Img'] ?? ""
  //                 //     : "";
  //                 // String callerName = payload!.containsKey("Caller_Name")
  //                 //     ? payload!['Caller_Name'] ?? ""
  //                 //     : "";
  //                 String callId = payload!['id'] ?? '';
  //                 String callType = payload!['call_type'] ?? '';
  //                 int callerId = int.parse(payload!['teacher_id'] ?? "0");
  //                 String profileImgUrl = payload!.containsKey("profile_url")
  //                     ? payload!['profile_url'] ?? ""
  //                     : "";
  //                 String callerName = payload!.containsKey("teacher_name")
  //                     ? payload!['teacher_name'] ?? ""
  //                     : "";
  //                 Get.to(() =>
  //                     IncomingCallPage(
  //                       liveLink: liveLink,
  //                       callId: callId,
  //                       video: callType == 'Video',
  //                       teacherId: callerId,
  //                       // isIncomingCall: true,
  //                       profileImageUrl: profileImgUrl,
  //                       teacherName: callerName,
  //                     ));
  //               }
  //             }
  //           }
  //         }
  //
  //
  //       }
  //
  //     } else {
  //       // _currentUuid = "";
  //     }
  //   }
  // }
  Future<void> requestNotificationPermission() async {
    try {
      var status = await Permission.notification.status;

      // Only request permission if it hasn't been granted yet
      if (!status.isGranted) {
        status = await Permission.notification.request();
      }

      // Check if permission was granted
      if (status.isGranted) {
        print("Notification permission granted.");
      } else {
        print("Notification permission denied.");
      }
    } catch (e) {
      print("Error requesting notification permission: $e");
    }
  }

  Future<void> getMyCourse() async {
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await myCoursesController.getMyCourses();
      });
    } finally {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  HomeController controller = Get.put(HomeController(HomeModel().obs));

  final ProfileController profileController = Get.find<ProfileController>();
  final BreffController breffController =
      Get.put<BreffController>(BreffController());
  OnboardingController obController = Get.put(OnboardingController());
  ExploreCourseController exController = Get.put(ExploreCourseController());
  final LoginController lgController = Get.put(LoginController());
  MyCoursesController myCoursesController =
      Get.put(MyCoursesController(MyCoursesModel().obs));
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NotificationPermissionHandler(
          onPermissionChanged: (isGranted) {
            setState(() {});
          },
          child: Container(
            width: double.maxFinite,
            decoration: AppDecoration.fillGray,
            child: Obx(
              () => ShimmerLoading(
                isLoading: obController.isCourseLoading.value ||
                    profileController.isLoading.value,
                child: Column(
                  children: [
                    _buildImageStack(),
                    SizedBox(height: 16.v),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            // CustomOutlinedButton(
                            //   onPressed: () {
                            //     // Loader.showLoader();
                            //     // await exController.getAllExploreCourses();
                            //     // Loader.stopLoader();

                            //     // Get.to(() => CertificateDownloadPage(
                            //     //       'Sanjay Vkp',
                            //     //       'Oet course',
                            //     //     ));
                            //     Get.toNamed(AppRoutes.exploreCoursesPage);
                            //   },
                            //   text: "lbl_explore_courses".tr,
                            //   margin: EdgeInsets.symmetric(horizontal: 16.h),
                            //   rightIcon: Container(
                            //     margin: EdgeInsets.only(left: 4.h),
                            //     child: CustomImageView(
                            //       imagePath: ImageConstant.imgArrowright,
                            //       height: 15.v,
                            //       width: 20.h,
                            //     ),
                            //   ),
                            //   buttonStyle: CustomButtonStyles.none,
                            //   decoration: CustomButtonStyles
                            //       .gradientBlueToBlueDecoration,
                            //   buttonTextStyle:
                            //       CustomTextStyles.titleSmallWhiteA700,
                            // ),
                            SizedBox(height: 16.v),
                            // _buildExploreCoursesStack(),
                            CaroselWidget(
                              height: 115,
                              items: [
                                CarouselItem(
                                    imageUrl: 'assets/images/carosel_1.png',
                                    title: '',
                                    description: ''),
                                CarouselItem(
                                    imageUrl: 'assets/images/carosel_2.png',
                                    title: '',
                                    description: ''),
                                CarouselItem(
                                    imageUrl: 'assets/images/carosel_3.png',
                                    title: '',
                                    description: ''),
                              ],
                            ),
                            // SizedBox(height: 17.v),
                            // _buildMockTestsColumn(),
                            SizedBox(height: 19.v),
                            if (profileController.studentIdsss.isEmpty)
                              GetBuilder<OnboardingController>(
                                  init: OnboardingController(),
                                  builder: (popularCourseData) {
                                    return _buildPopularCoursesColumn(
                                        title: "lbl_popular_courses".tr,
                                        courseListData: popularCourseData
                                            .popularCourseList);
                                  }),
                            SizedBox(height: 17.v),
                            if (profileController.studentIdsss.isEmpty)
                              GetBuilder<OnboardingController>(
                                  init: OnboardingController(),
                                  builder: (recommendedCourseData) {
                                    print('rebuild recomented');
                                    return _buildPopularCoursesColumn(
                                        title: "msg_recommended_courses".tr,
                                        courseListData: recommendedCourseData
                                            .recommendedCourseList);
                                  }),
                            if (profileController.studentIdsss.isNotEmpty)
                              GetBuilder<MyCoursesController>(
                                  init:
                                      MyCoursesController(MyCoursesModel().obs),
                                  builder: (recommendedCourseData) {
                                    print('rebuild recomented');
                                    return buildEnrolCourse(
                                        title: "Enrolled Courses",
                                        courseListData:
                                            recommendedCourseData.myCourseList);
                                  }),
                            SizedBox(height: 16.v),
                            // InkWell(
                            //   onTap: () {
                            //     // Get.to(() => CourseCategoryDetailsScreen());
                            //   },
                            //   child: dummyColumn(
                            //     title: 'Orientation Classes',
                            //     images: orientationImagesList,
                            //   ),
                            // ),
                            // dummyColumn(
                            //   title: "Training Classes",
                            //   images: quizImages,
                            // ),
                            // dummyColumn(
                            //   title: "Quiz Time",
                            //   images: trainingImages,
                            // ),
                            // dummyColumn(title: 'Orientation Classes',),
                            // SizedBox(height: 17.v),
                            // dummyColumn(title: 'Training Classes'),

                            // SizedBox(height: 17.v),
                            // dummyColumn(title: 'Quiz Time'),

                            // Align(
                            //   alignment: Alignment.centerLeft,
                            //   child: Padding(
                            //     padding: EdgeInsets.only(left: 16.h),
                            //     child: Text(
                            //       "msg_recommended_courses".tr,
                            //       style: theme.textTheme.titleSmall,
                            //     ),
                            //   ),
                            // ),
                            // SizedBox(height: 8.v),
                            // _buildRecommendedCoursesRow()
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildImageStack() {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomImageView(
          imagePath: 'assets/images/home_appbar_bg.png',
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
              // height: 154.v,
              width: double.maxFinite,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/home_appbar_bg.png'))),

              // AppDecoration.gradientBlueToBlue.copyWith(
              //   borderRadius: BorderRadiusStyle.customBorderBL12,
              // ),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff0B4BA8).withOpacity(0.1),

                  //           gradient: LinearGradient(colors:  [Color(0xffFFFFFF).withOpacity(0.5),

                  // Color.fromARGB(255, 86, 141, 217).withOpacity(0.7),
                  // //  Color(0xff1580E3),
                  // // Color(0xffFFFFFF),

                  // ])
                ),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    // CustomImageView(
                    //   imagePath: ImageConstant.imgImage29,
                    //   height: 109.v,
                    //   width: 140.h,
                    //   alignment: Alignment.bottomLeft,
                    // ),
                    // CustomImageView(
                    //   imagePath: ImageConstant.imgEllipse13,
                    //   height: 60.v,
                    //   width: 360.h,
                    //   alignment: Alignment.bottomCenter,
                    // ),
                    // CustomImageView(
                    //   imagePath: ImageConstant.imgEllipse14,
                    //   height: 24.v,
                    //   width: 359.h,
                    //   alignment: Alignment.bottomCenter,
                    // ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(
                            // left: 11.h,
                            // right: 16.h,
                            ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GetBuilder<HomeController>(
                                id: 'profile_name',
                                init: controller,
                                builder: (context) {
                                  return Padding(
                                    padding:
                                        EdgeInsets.only(left: 10.v, top: 5.v),
                                    child: CustomAppBar(
                                      height: 40.v,
                                      leadingWidth: 40.h,
                                      leading: Container(
                                        height: 10,
                                        width: 10,
                                        decoration: BoxDecoration(
                                          color: ColorResources.colorBlue100,
                                          border: Border.all(),
                                          shape: BoxShape.circle,
                                          // image: DecorationImage(
                                          //     fit: BoxFit.cover,
                                          //     image: NetworkImage(
                                          //         '${HttpUrls.imgBaseUrl}${profileController.profileData?.profilePhotoPath}'))
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(40.v / 2),
                                          child: GetBuilder<ProfileController>(
                                              init: ProfileController(),
                                              id: 'profile_name',
                                              builder: (pController) {
                                                return InkWell(
                                                  onTap: () {
                                                    log(pController.profileData!
                                                        .profilePhotoPath);
                                                    log('${HttpUrls.imgBaseUrl}${pController.profileData?.profilePhotoPath}');
                                                    Get.to(() =>
                                                        StudentProfileScreen(
                                                          isHomePage: true,
                                                        ));
                                                  },
                                                  child: pController.profileData
                                                              ?.profilePhotoPath !=
                                                          null
                                                      ? CachedNetworkImage(
                                                          imageUrl:
                                                              '${HttpUrls.imgBaseUrl}${pController.profileData?.profilePhotoPath}',
                                                          height: 10.v,
                                                          width: 10.v,
                                                          fit: BoxFit.cover,
                                                          placeholder:
                                                              (BuildContext
                                                                      context,
                                                                  String url) {
                                                            return Center(
                                                              child: Transform
                                                                  .scale(
                                                                scale: 0.6,
                                                                child:
                                                                    CircularProgressIndicator(
                                                                  strokeWidth:
                                                                      3,
                                                                  color:
                                                                      darkbluesix,
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          errorWidget:
                                                              (BuildContext
                                                                      context,
                                                                  String url,
                                                                  dynamic
                                                                      error) {
                                                            return Center(
                                                              child: Icon(
                                                                Icons
                                                                    .person_rounded,
                                                                color: ColorResources
                                                                    .colorBlue300,
                                                                size: 18.v,
                                                              ),
                                                            );
                                                          },
                                                        )
                                                      : Image.asset(
                                                          height: 10.v,
                                                          width: 10.v,
                                                          '${ImageConstant.defaultProfile}',
                                                          fit: BoxFit.fill,
                                                        ),
                                                );
                                              }),
                                        ),
                                      ),
                                      title: Padding(
                                        padding: EdgeInsets.only(left: 8.h),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            GetBuilder<ProfileController>(
                                                init: ProfileController(),
                                                id: 'profile_name',
                                                builder: (profileData) {
                                                  return AppbarSubtitleTwo(
                                                    text: profileData
                                                                .profileData
                                                                ?.firstName !=
                                                            null
                                                        ? '${profileData.profileData?.firstName} ${profileData.profileData?.lastName}'
                                                        : '',
                                                    margin: EdgeInsets.only(
                                                        right: 79.h),
                                                  );
                                                }),
                                            SizedBox(height: 1.v),
                                            // AppbarSubtitleFour(
                                            //   text: DateTime.now()
                                            //       .formatCurrentDate()
                                            //       .tr,
                                            //   // text: "msg_tuesday_23_april".tr,
                                            // )
                                            // AppbarSubtitleFour(
                                            //   text: DateTime.now()
                                            //       .formatCurrentDate()
                                            //       .tr,
                                            //   // text: "msg_tuesday_23_april".tr,
                                            // )
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        Container(
                                          margin: EdgeInsets.only(
                                            left: 16.h,
                                            right: 16.h,
                                            bottom: 2.v,
                                          ),
                                          decoration:
                                              AppDecoration.fillBlack.copyWith(
                                            borderRadius: BorderRadiusStyle
                                                .circleBorder18,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              // AppbarImage(
                                              //   onTap: () async {
                                              //     print('click');
                                              //     Loader.showLoader();
                                              //     await exController
                                              //         .getAllExploreCourses();
                                              //     Loader.stopLoader();
                                              //     Get.toNamed(AppRoutes
                                              //         .exploreCoursesPage);
                                              //   },
                                              //   imagePath: ImageConstant
                                              //       .imgSearchWhiteA700,
                                              //   margin: EdgeInsets.only(
                                              //     left: 2.h,
                                              //     top: 2.v,
                                              //     bottom: 2.v,
                                              //   ),
                                              // ),
                                              // Padding(
                                              //   padding: EdgeInsets.fromLTRB(
                                              //       2.h, 2.v, 8.h, 2.v),
                                              //   child: InkWell(
                                              //     onTap: () {
                                              //       showLogoutDialog();
                                              //     },
                                              //     child: Icon(
                                              //       Icons.logout,
                                              //       color: ColorResources
                                              //           .colorgrey200
                                              //           .withOpacity(0.9),
                                              //       size: 20.adaptSize,
                                              //     ),
                                              //   ),
                                              // ),
                                              // AppbarImage(
                                              //   imagePath: ImageConstant
                                              //       .imgFrame2609305,
                                              //   margin: EdgeInsets.fromLTRB(
                                              //       8.h, 2.v, 2.h, 2.v),
                                              // )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }),
                            SizedBox(height: 21.v),
                            Stack(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ////change it with avathar
                                GestureDetector(
                                  onTap: () => Get.to(
                                      () => BreffScreen(isLoginButton: false)),
                                  child: SizedBox(
                                    height: 130.h,
                                    width: Get.width,
                                    child: CustomImageView(
                                      // imagePath: ImageConstant.breffImage,
                                      imagePath:
                                          PrefUtils().getBreffGenderData() ==
                                                  "Male"
                                              ? ImageConstant.breffImageNew
                                              : ImageConstant.breffiniImageNew,
                                      // : (profileController.profileData
                                      //                 ?.avatar ==
                                      //             'Male' ||
                                      //         profileController
                                      //                 .profileData
                                      //                 ?.avatar ==
                                      //             'male')
                                      //     ? ImageConstant.breffImage
                                      //     : ImageConstant.breffiniImage,
                                      //  height: 145.v,
                                      // width: 101.h,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 16,
                                  bottom: 16,
                                  child: Container(
                                    width: 214.h,
                                    margin: EdgeInsets.only(
                                        // top: 28.v,
                                        // bottom: 13.v,
                                        ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Text(
                                            //   PrefUtils().getBreffGenderData() ==
                                            //           "Male"
                                            //       ? "Hello, i'm AI".tr
                                            //       : "Hello, i'm AI".tr,
                                            //   // "Your study partner in\ngame",
                                            //   // : (profileController
                                            //   //                 .profileData
                                            //   //                 ?.avatar ==
                                            //   //             'Male' ||
                                            //   //         profileController
                                            //   //                 .profileData
                                            //   //                 ?.avatar ==
                                            //   //             'male')
                                            //   //     ? "msg_hello_i_m_breff".tr
                                            //   //     : "Hello, I'm Breffini",
                                            //   style: CustomTextStyles
                                            //       .titleSmallWhiteA700,
                                            // ),
                                            // SizedBox(height: 1.v),
                                            // SizedBox(
                                            //   width: 120.h,
                                            //   child: Text(
                                            //     'Your study partner in game',
                                            //     maxLines: 2,
                                            //     overflow: TextOverflow.ellipsis,
                                            //     style: CustomTextStyles
                                            //         .bodySmallWhiteA700
                                            //         .copyWith(
                                            //       height: 1.60,
                                            //     ),
                                            //   ),
                                            // )
                                          ],
                                        ),
                                        // OutlineGradientButton(
                                        //   padding: EdgeInsets.only(
                                        //     left: 1.h,
                                        //     top: 1.v,
                                        //     right: 1.h,
                                        //     bottom: 1.v,
                                        //   ),
                                        //   strokeWidth: 1.h,
                                        //   gradient: LinearGradient(
                                        //     begin: Alignment(0.5, 0),
                                        //     end: Alignment(0.5, 1),
                                        //     colors: [
                                        //       appTheme.whiteA700,
                                        //       appTheme.gray50
                                        //     ],
                                        //   ),
                                        // corners: Corners(
                                        //   topLeft: Radius.circular(18.v),
                                        //   topRight: Radius.circular(18.v),
                                        //   bottomLeft: Radius.circular(18.v),
                                        //   bottomRight: Radius.circular(18.v),
                                        // ),
                                        // child: CustomOutlinedButton(
                                        //   onPressed: () {
                                        //     // Get.to(()=> GeminiChatScreen());
                                        //     Get.to(() => BreffScreen(
                                        //         isLoginButton: false));
                                        //   },
                                        //   height: 28.v,
                                        //   width: 59.h,
                                        //   text: "lbl_ask".tr,
                                        //   buttonStyle:
                                        //       CustomButtonStyles.none,
                                        //   decoration: CustomButtonStyles
                                        //       .gradientBlueToSecondaryContainerDecoration,
                                        //   buttonTextStyle: CustomTextStyles
                                        //       .labelLargePrimaryContainer,
                                        // ),
                                        // )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  //alert box logout
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
                lgController.logout();
              },
            ),
          ],
        );
      },
    );
  }

  /// Section Widget
  Widget _buildExploreCoursesStack() {
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
              imagePath: ImageConstant.imgConnectNow,
              height: 114.v,
              width: Get.width,
              alignment: Alignment.centerRight,
              fit: BoxFit.fill,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.h,
                  // vertical: 16.v,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusStyle.roundedBorder12,
                  // image: DecorationImage(
                  //   image: fs.Svg(
                  //     ImageConstant.imgGroup689,
                  //   ),
                  //   fit: BoxFit.cover,
                  // ),
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
                        topLeft: Radius.circular(17.v),
                        topRight: Radius.circular(17.v),
                        bottomLeft: Radius.circular(17.v),
                        bottomRight: Radius.circular(17.v),
                      ),
                      child: Container(
                        height: 28,
                        width: 126,
                        decoration: CustomButtonStyles.gradientConnectNow,
                        child: InkWell(
                          onTap: () {
                            Get.to(() => TeacherScreen(
                                  isBottomBar: false,
                                ));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset('assets/images/glitter.svg'),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "lbl_connect_now".tr,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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
      padding: EdgeInsets.only(left: 0.v),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "lbl_mock_tests".tr,
            style: theme.textTheme.titleSmall,
          ),
          SizedBox(height: 8.v),
          // Obx(
          //   () => Wrap(
          //     runSpacing: 8.v,
          //     spacing: 8.v,
          //     children: List<Widget>.generate(
          //       controller
          //           .homeModelObj.value.chipviewbookmarItemList.value.length,
          //       (index) {
          //         ChipviewbookmarItemModel model = controller
          //             .homeModelObj.value.chipviewbookmarItemList.value[index];
          //         return ChipviewbookmarItemWidget(
          //           model,
          //         );
          //       },
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildPopularCoursesColumn(
      {required String title, required List<CourseListModel> courseListData}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: GetBuilder<OnboardingController>(
          init: OnboardingController(),
          builder: (data) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium,
                ),
                SizedBox(height: 6.v),
                SizedBox(
                  height: 245.v,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 16.h,
                      );
                    },
                    itemCount: courseListData.length,
                    itemBuilder: (context, index) {
                      CourseListModel model = courseListData[index];
                      return ViewhierarchyItemWidget(
                        model,
                      );
                    },
                  ),
                ),
              ],
            );
          }),
    );
  }

  /// Section Widget
  Widget buildEnrolCourse(
      {required String title,
      required RxList<MyCourseDetailsModel> courseListData}) {
    return GetBuilder<MyCoursesController>(
        init: MyCoursesController(MyCoursesModel().obs),
        builder: (data) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium,
                ),
                SizedBox(height: 6.v),
                SizedBox(
                  height: 245.v,
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 16,
                      );
                    },
                    scrollDirection: Axis.horizontal,
                    itemCount: courseListData.length,
                    itemBuilder: (context, index) {
                      MyCourseDetailsModel model = courseListData[index];
                      return EnrolItemWidget(
                        model,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget dummyColumn({
    required String title,
    required List<String>
        images, // Changed from a single image URL to a list of image URLs
  }) {
    return Padding(
      padding: EdgeInsets.only(left: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium,
          ),
          SizedBox(height: 6.v),
          SizedBox(
            height: 245.v,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: 16.h,
                );
              },
              itemCount: images.length, // Use the length of the images list
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(3.v),
                  decoration: AppDecoration.outlineIndigo5001.copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorder12,
                  ),
                  width: 180.v,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 105.v,
                          width: 180.v,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2.h),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: images[index],
                            fit: BoxFit.contain,
                            placeholder: (BuildContext context, String url) {
                              return Center(
                                  child: CircularProgressIndicator(
                                color: ColorResources.colorBlue500,
                              ));
                            },
                            errorWidget: (BuildContext context, String url,
                                dynamic error) {
                              return Center(
                                child: Icon(
                                  Icons.image_not_supported_outlined,
                                  color: ColorResources.colorBlue100,
                                  size: 40,
                                ),
                              );
                            },
                          )),
                      SizedBox(height: 17.v),
                      Container(
                        width: 145.v,
                        margin: EdgeInsets.only(left: 4.h),
                        child: Text(
                          orientationTitles[index],
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleSmall!.copyWith(
                            height: 1.43,
                          ),
                        ),
                      ),
                      SizedBox(height: 2.v),
                      Padding(
                        padding: EdgeInsets.only(left: 4.h),
                        child: Row(
                          children: [
                            CustomImageView(
                              imagePath: ImageConstant.imgBooks,
                              height: 12.adaptSize,
                              width: 12.adaptSize,
                              margin: EdgeInsets.only(
                                top: 1.v,
                                bottom: 2.v,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 2.h),
                              child: Text(
                                '2',
                                style: CustomTextStyles.labelLargeBluegray500_1,
                              ),
                            ),
                            CustomImageView(
                              imagePath: ImageConstant.imgClock,
                              height: 12.adaptSize,
                              width: 12.adaptSize,
                              margin: EdgeInsets.only(
                                left: 18.h,
                                top: 1.v,
                                bottom: 2.v,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 2.h),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "20",
                                      style: CustomTextStyles
                                          .labelLargeBluegray500,
                                    ),
                                    TextSpan(
                                      text: 'Hrs',
                                      style: CustomTextStyles
                                          .bodySmallBluegray50012,
                                    )
                                  ],
                                ),
                                textAlign: TextAlign.left,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 13.v),
                      Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '₹100',
                              style: theme.textTheme.titleSmall,
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomImageView(
                                    imagePath: ImageConstant.imgStar,
                                    height: 16.adaptSize,
                                    width: 16.adaptSize,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 2.v),
                                    child: Text(
                                      '3.3',
                                      style: CustomTextStyles.labelLarge_1,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Container(
  //       padding: EdgeInsets.all(3.v),
  //       decoration: AppDecoration.outlineIndigo5001.copyWith(
  //         borderRadius: BorderRadiusStyle.roundedBorder12,
  //       ),
  //       width: 180.v,
  //       child: Column(
  //         // mainAxisSize: MainAxisSize.min,
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Container(
  //             height: 105.v,
  //             width: 180.v,
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(2.h),
  //               // image: DecorationImage(
  //               //     fit: BoxFit.contain,
  //               //     image: NetworkImage(
  //               //         '${HttpUrls.imgBaseUrl}${viewhierarchyItemModelObj.courseThumbnailPath}'))
  //             ),
  //             child:

  //                 // Image(
  //                 //     image: NetworkImage(
  //                 //         'https://media.edutopia.org/styles/responsive_2880px_original/s3/masters/2018-02/stock-photo-students-working-together-in-class-117350691.jpg'))

  //                 Image.network(
  //               '${HttpUrls.imgBaseUrl}${viewhierarchyItemModelObj.courseThumbnailPath}',
  //               fit: BoxFit.contain,
  //               errorBuilder: (BuildContext context, Object error,
  //                   StackTrace? stackTrace) {
  //                 return Center(
  //                   child: Icon(Icons.image_not_supported_outlined,
  //                       color: ColorResources.colorBlue100, size: 40),
  //                 );
  //               },
  //               loadingBuilder: (BuildContext context, Widget child,
  //                   ImageChunkEvent? loadingProgress) {
  //                 if (loadingProgress == null) {
  //                   return child;
  //                 } else {
  //                   return Center(
  //                     // child: SpinKitFadingCircle(
  //                     //   color: darkbluesix,
  //                     //   size: 40.0,
  //                     // ),
  //                     child: CircularProgressIndicator(
  //                       strokeWidth: 3,
  //                       color: darkbluesix,
  //                       value: loadingProgress.expectedTotalBytes != null
  //                           ? loadingProgress.cumulativeBytesLoaded /
  //                               (loadingProgress.expectedTotalBytes ?? 1)
  //                           : null,
  //                     ),
  //                   );
  //                 }
  //               },
  //             ),
  //           ),

  //           // CustomImageView(
  //           //   imagePath: '${HttpUrls.imgBaseUrl}${viewhierarchyItemModelObj.courseThumbnailPath}',
  //           //   height: 105.v,
  //           //   width: 180.h,
  //           //   fit: BoxFit.cover,
  //           //   radius: BorderRadius.circular(
  //           //     2.h,
  //           //   ),
  //           // ),
  //           SizedBox(height: 17.v),
  //           Container(
  //             width: 145.v,
  //             margin: EdgeInsets.only(left: 4.h),
  //             child: Text(
  //               viewhierarchyItemModelObj.courseName ?? '',
  //               maxLines: 3,
  //               overflow: TextOverflow.ellipsis,
  //               style: theme.textTheme.titleSmall!.copyWith(
  //                 height: 1.43,
  //               ),
  //             ),
  //           ),
  //           SizedBox(height: 2.v),
  //           Padding(
  //             padding: EdgeInsets.only(left: 4.h),
  //             child: Row(
  //               children: [
  //                 CustomImageView(
  //                   imagePath: ImageConstant.imgBooks,
  //                   height: 12.adaptSize,
  //                   width: 12.adaptSize,
  //                   margin: EdgeInsets.only(
  //                     top: 1.v,
  //                     bottom: 2.v,
  //                   ),
  //                 ),
  //                 Padding(
  //                   padding: EdgeInsets.only(left: 2.h),
  //                   child: Text(
  //                     '${viewhierarchyItemModelObj.liveClassEnabled ?? ''}',
  //                     style: CustomTextStyles.labelLargeBluegray500_1,
  //                   ),
  //                 ),
  //                 CustomImageView(
  //                   imagePath: ImageConstant.imgClock,
  //                   height: 12.adaptSize,
  //                   width: 12.adaptSize,
  //                   margin: EdgeInsets.only(
  //                     left: 18.h,
  //                     top: 1.v,
  //                     bottom: 2.v,
  //                   ),
  //                 ),
  //                 Padding(
  //                   padding: EdgeInsets.only(left: 2.h),
  //                   child: RichText(
  //                     text: TextSpan(
  //                       children: [
  //                         TextSpan(
  //                           text: "${viewhierarchyItemModelObj.validity}".tr,
  //                           style: CustomTextStyles.labelLargeBluegray500,
  //                         ),
  //                         TextSpan(
  //                           text: "lbl_hrs".tr,
  //                           style: CustomTextStyles.bodySmallBluegray50012,
  //                         )
  //                       ],
  //                     ),
  //                     textAlign: TextAlign.left,
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //           SizedBox(height: 13.v),
  //           Align(
  //             alignment: Alignment.center,
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text(
  //                   '₹ ${viewhierarchyItemModelObj.price}',
  //                   style: theme.textTheme.titleSmall,
  //                 ),
  //                 Container(
  //                   // width: 37.h,
  //                   // margin: EdgeInsets.only(left: 82.v),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       CustomImageView(
  //                         imagePath: ImageConstant.imgStar,
  //                         height: 16.adaptSize,
  //                         width: 16.adaptSize,
  //                       ),
  //                       Padding(
  //                         padding: EdgeInsets.only(left: 2.v),
  //                         child: Text(
  //                           '${double.parse(viewhierarchyItemModelObj.averageRating ?? '0.0').toStringAsFixed(1)}',
  //                           style: CustomTextStyles.labelLarge_1,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //           // SizedBox(height: 4.v)
  //         ],
  //       ),
  //     ),

  /// Section Widget
  Widget _buildRecommendedCoursesRow() {
    return Padding(
      padding: EdgeInsets.only(left: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: _buildAdditionalCoursesColumn(
              price: "msg_oet_beginner_special".tr,
              fiftyfourOne: "lbl_54".tr,
              hrsCounter: "lbl_48_hrs".tr,
              price1: "lbl_5000".tr,
              p45One: "lbl_4_5".tr,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 16.h),
              child: _buildAdditionalCoursesColumn(
                price: "msg_oet_beginner_special".tr,
                fiftyfourOne: "lbl_54".tr,
                hrsCounter: "lbl_48_hrs".tr,
                price1: "lbl_5000".tr,
                p45One: "lbl_4_5".tr,
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildAdditionalCoursesColumn({
    required String price,
    required String fiftyfourOne,
    required String hrsCounter,
    required String price1,
    required String p45One,
  }) {
    return Container(
      padding: EdgeInsets.all(3.h),
      decoration: AppDecoration.outlineIndigo5001.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgImage28,
            height: 105.v,
            width: 180.h,
            radius: BorderRadius.circular(
              10.h,
            ),
          ),
          SizedBox(height: 17.v),
          SizedBox(
            width: 172.h,
            child: Text(
              price,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleSmall!.copyWith(
                color: appTheme.blueGray80003,
                height: 1.43,
              ),
            ),
          ),
          SizedBox(height: 2.v),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 4.h),
              child: Row(
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgBooks,
                    height: 12.adaptSize,
                    width: 12.adaptSize,
                    margin: EdgeInsets.symmetric(vertical: 2.v),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 2.h),
                    child: Text(
                      fiftyfourOne,
                      style: CustomTextStyles.labelLargeBluegray500_1.copyWith(
                        color: appTheme.blueGray500,
                      ),
                    ),
                  ),
                  CustomImageView(
                    imagePath: ImageConstant.imgClock,
                    height: 12.adaptSize,
                    width: 12.adaptSize,
                    margin: EdgeInsets.only(
                      left: 18.h,
                      top: 2.v,
                      bottom: 2.v,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 2.h),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "lbl_48".tr,
                            style: CustomTextStyles.labelLargeBluegray500,
                          ),
                          TextSpan(
                            text: "lbl_hrs".tr,
                            style: CustomTextStyles.bodySmallBluegray50012,
                          )
                        ],
                      ),
                      textAlign: TextAlign.left,
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 12.v),
          Container(
            width: 170.h,
            margin: EdgeInsets.only(
              left: 4.h,
              right: 6.h,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  price1,
                  style: theme.textTheme.titleSmall!.copyWith(
                    color: appTheme.blueGray80003,
                  ),
                ),
                Spacer(),
                CustomImageView(
                  imagePath: ImageConstant.imgStar,
                  height: 16.adaptSize,
                  width: 16.adaptSize,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 2.h),
                  child: Text(
                    p45One,
                    style: CustomTextStyles.labelLarge_1.copyWith(
                      color: appTheme.blueGray80003,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 4.v)
        ],
      ),
    );
  }
}
