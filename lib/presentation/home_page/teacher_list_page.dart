import 'dart:developer';

import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:anandhu_s_application4/core/colors_res.dart';
import 'package:anandhu_s_application4/core/utils/common_utils.dart';
import 'package:anandhu_s_application4/core/utils/extentions.dart';
import 'package:anandhu_s_application4/core/utils/meet_utils.dart';
import 'package:anandhu_s_application4/http/http_urls.dart';
import 'package:anandhu_s_application4/http/socket_io.dart';
import 'package:anandhu_s_application4/presentation/android_large_5_page/controller/call_chat_controller.dart';
import 'package:anandhu_s_application4/presentation/android_large_5_page/incoming_call_page.dart';
import 'package:anandhu_s_application4/presentation/android_large_5_page/widgets/handle_call_widget.dart';
import 'package:anandhu_s_application4/presentation/chat_screen/chat_firebase_screen.dart';
import 'package:anandhu_s_application4/presentation/chat_screen/controller/chat_firebase_controller.dart';
import 'package:anandhu_s_application4/presentation/chat_screen/controller/chat_map_controller.dart';
import 'package:anandhu_s_application4/presentation/home_page/controller/home_controller.dart';
import 'package:anandhu_s_application4/presentation/home_page/models/home_model.dart';
import 'package:anandhu_s_application4/presentation/home_page/widgets/teacher_widget.dart';
import 'package:anandhu_s_application4/presentation/home_page_container_screen/controller/home_page_container_controller.dart';
import 'package:anandhu_s_application4/presentation/profile/controller/profile_controller.dart';
import 'package:anandhu_s_application4/widgets/google_meet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeacherScreen extends StatefulWidget {
  final bool? isBottomBar;
  TeacherScreen({super.key, required this.isBottomBar});

  @override
  State<TeacherScreen> createState() => _TeacherScreenState();
}

class _TeacherScreenState extends State<TeacherScreen> {
  HomeController controller = Get.put(HomeController(HomeModel().obs));
  ChatController chController = Get.put(ChatController());
  ChatFireBaseController chatController = Get.put(ChatFireBaseController());
  final HomePageContainerController controllers =
      Get.find<HomePageContainerController>();
  final CallandChatController callandChatController =
      Get.find<CallandChatController>();
  final ProfileController profileController = Get.put(ProfileController());
  @override
  void initState() {
    print('dfsfgsfg');
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getTeacherList();
    });
  }

  String formatTimeToAMPM(String time) {
    try {
      final timeParts = time.split(':');
      int hour = int.parse(timeParts[0]);
      final minutes = timeParts[1];

      String period = hour >= 12 ? 'PM' : 'AM';

      // Convert to 12-hour format
      if (hour > 12) {
        hour -= 12;
      } else if (hour == 0) {
        hour = 12;
      }

      // Ensure hour is always 2 digits
      String hourString = hour.toString().padLeft(2, '0');

      return '$hourString:$minutes $period';
    } catch (e) {
      return time; // Return original time if parsing fails
    }
  }

  @override
  Widget build(BuildContext context) {
    print(
        'chat back button =============${chController.chatHistoryList.length}');
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorResources.colorwhite,
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 16.v,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.v),
              child: SizedBox(
                  child: widget.isBottomBar == false
                      ? Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: Icon(CupertinoIcons.back)),
                            Text(
                              'Faculty',
                              style: TextStyle(
                                  fontSize: 18.v,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff283B52)),
                            )
                          ],
                        )
                      : Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  controllers
                                      .setTemporaryPage(AppRoutes.homePage);
                                },
                                icon: Icon(CupertinoIcons.back)),
                            Text(
                              'Faculty',
                              style: TextStyle(
                                  fontSize: 18.v,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff283B52)),
                            )
                          ],
                        )),
            ),
            SizedBox(
              height: 16.h,
            ),
            Container(
              child: Obx(() {
                return controller.teacherList.isNotEmpty
                    ? ListView.builder(
                        itemCount: controller.teacherList.length,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          Color bannerColor = controller
                                      .teacherList[index].userTypeId !=
                                  2
                              ? const Color.fromARGB(
                                  255, 255, 24, 24) // Red for HOD
                              : controller.teacherList[index].isBatch == 1 &&
                                      controller.teacherList[index].isOneonOne ==
                                          1
                                  ? const Color.fromARGB(255, 0, 185,
                                      218) // Green for Batch and One to One
                                  : controller.teacherList[index].isBatch == 1 &&
                                          controller.teacherList[index].isOneonOne ==
                                              0
                                      ? ColorResources
                                          .colorgrey600 // Grey for Batch
                                      : controller.teacherList[index].isBatch == 0 &&
                                              controller.teacherList[index]
                                                      .isOneonOne ==
                                                  1
                                          ? const Color.fromARGB(
                                              255, 0, 133, 60) // Green for One to One
                                          : const Color.fromARGB(255, 0, 0, 0);

                          String bannerText = controller
                                      .teacherList[index].userTypeId !=
                                  2
                              ? 'HOD'
                              : controller.teacherList[index].isBatch == 1 &&
                                      controller
                                              .teacherList[index].isOneonOne ==
                                          0
                                  ? 'Live'
                                  : controller.teacherList[index].isBatch ==
                                              0 &&
                                          controller.teacherList[index]
                                                  .isOneonOne ==
                                              1
                                      ? 'One to One'
                                      : controller.teacherList[index].isBatch ==
                                                  1 &&
                                              controller.teacherList[index]
                                                      .isOneonOne ==
                                                  1
                                          ? 'Batch and One to One'
                                          : 'Unknown';

                          log(controller.teacherList[index].profilePhotoPath);
                          return Column(
                            children: [
                              TeacherWidget(
                                  timeSlots: controller
                                              .teacherList[index].userTypeId !=
                                          2
                                      ? 'Available at : 24 x 7'
                                      : 'Available at : ${controller.teacherList[index].startTime.toString()}${controller.teacherList[index].endTime.toString()}',
                                  bannerTextColor:
                                      controller.teacherList[index].batchId !=
                                              null
                                          ? ColorResources.colorwhite
                                          : controller.teacherList[index]
                                                      .userTypeId ==
                                                  2
                                              ? ColorResources.colorwhite
                                              : ColorResources.colorwhite,
                                  bannerText: bannerText,
                                  bannerColor: bannerColor,
                                  isBatch:
                                      controller.teacherList[index].batchId !=
                                              null
                                          ? true
                                          : false,
                                  name: controller
                                              .teacherList[index].userTypeId ==
                                          2
                                      ? '${controller.teacherList[index].firstName} ${controller.teacherList[index].lastName}'
                                      : '${controller.teacherList[index].courseName}',
                                  image: controller.teacherList[index]
                                              .profilePhotoPath !=
                                          ""
                                      ? controller.teacherList[index].userTypeId == 3
                                          ? "assets/images/track_box_logo.png"
                                          : '${HttpUrls.imgBaseUrl}${controller.teacherList[index].profilePhotoPath}'
                                      : 'assets/images/default_profile.jpg',
                                  onTapVideo: PrefUtils().getGmeetLink().isNotEmpty
                                      ? () async {
                                          await handleTeacherCall(
                                              teacherId: controller
                                                  .teacherList[index].userId
                                                  .toString(),
                                              teacherName: controller
                                                  .teacherList[index].firstName
                                                  .toString(),
                                              callId: '',
                                              isVideo: true,
                                              profileImageUrl: controller
                                                  .teacherList[index]
                                                  .profilePhotoPath
                                                  .toString(),
                                              liveLink:
                                                  PrefUtils().getGmeetLink(),
                                              homeController: controller,
                                              callandChatController:
                                                  callandChatController,
                                              safeBack: safeBack,
                                              isIncomingCall: false);
                                          setState(() {});
                                          MeetCallTracker(
                                            onCallEnded: () {},
                                          ).startMeetCall(
                                              meetCode:
                                                  PrefUtils().getGmeetLink());

                                          // final CallandChatController
                                          //     callandChatController =
                                          //     Get.find<CallandChatController>();
                                          // if (!await isCallExist(
                                          //     context, callandChatController)) {
                                          //   Get.to(() => IncomingCallPage(
                                          //         liveLink: "",
                                          //         callId: "",
                                          //         video: true,
                                          //         teacherId: controller
                                          //             .teacherList[index].userId,
                                          //         // isIncomingCall: true,
                                          //         profileImageUrl: controller
                                          //             .teacherList[index]
                                          //             .profilePhotoPath,
                                          //         teacherName: controller
                                          //             .teacherList[index].firstName,
                                          //       ))?.then((value) {});
                                          // }
                                        }
                                      : () {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'Create a google meet link to initiate call')));
                                        },
                                  onTapAudio: PrefUtils().getGmeetLink().isNotEmpty
                                      ? () async {
                                          await handleTeacherCall(
                                              teacherId: controller
                                                  .teacherList[index].userId
                                                  .toString(),
                                              teacherName: controller
                                                  .teacherList[index].firstName
                                                  .toString(),
                                              callId: '',
                                              isVideo: true,
                                              profileImageUrl: controller
                                                  .teacherList[index]
                                                  .profilePhotoPath
                                                  .toString(),
                                              liveLink:
                                                  PrefUtils().getGmeetLink(),
                                              homeController: controller,
                                              callandChatController:
                                                  callandChatController,
                                              safeBack: safeBack,
                                              isIncomingCall: false);
                                          setState(() {});
                                          MeetCallTracker(
                                            onCallEnded: () {},
                                          ).startMeetCall(
                                              meetCode:
                                                  PrefUtils().getGmeetLink());

                                          // Get.to(() => IncomingCallPage(
                                          //       liveLink: "",
                                          //       callId: "",
                                          //       video: false,
                                          //       teacherId: controller
                                          //           .teacherList[index].userId,
                                          //       // isIncomingCall: true,
                                          //       profileImageUrl: controller
                                          //           .teacherList[index]
                                          //           .profilePhotoPath,
                                          //       teacherName: controller
                                          //           .teacherList[index].firstName,
                                          //     ))?.then((value) {});
                                        }
                                      : () {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'Create a google meet link to initiate call')));
                                        },
                                  tileOnTap: controller.teacherList[index].userTypeId == 2
                                      ? () async {
                                          print(controller.teacherList[index]
                                              .profilePhotoPath);
                                          SharedPreferences preferences =
                                              await SharedPreferences
                                                  .getInstance();
                                          String studentId =
                                              preferences.getString(
                                                      'breffini_student_id') ??
                                                  '';
                                          await ChatSocket.joinConversationRoom(
                                              studentId,
                                              controller
                                                  .teacherList[index].userId,
                                              'teacher_student');
                                          // await chatController.fetchMessages(
                                          //     controller
                                          //         .teacherList[index].userId
                                          //         .toString());
                                          await Get.to(() => ChatFireBaseScreen(
                                              courseId: 0,
                                              isHod: false,
                                              teacherName:
                                                  '${controller.teacherList[index].firstName} ${controller.teacherList[index].lastName}',
                                              profileUrl:
                                                  '${HttpUrls.imgBaseUrl}${controller.teacherList[index].profilePhotoPath}',
                                              teacherId: controller
                                                  .teacherList[index].userId));
                                        }
                                      : () async {
                                          SharedPreferences preferences =
                                              await SharedPreferences
                                                  .getInstance();
                                          String studentId =
                                              preferences.getString(
                                                      'breffini_student_id') ??
                                                  '';
                                          await ChatSocket.joinConversationRoom(
                                              studentId,
                                              controller
                                                  .teacherList[index].userId,
                                              'hod_student');
                                          await Get.to(() => ChatFireBaseScreen(
                                                courseId: controller
                                                    .teacherList[index]
                                                    .courseId!,
                                                isHod: true,
                                                profileUrl:
                                                    '${HttpUrls.imgBaseUrl}${controller.teacherList[index].profilePhotoPath}',
                                                teacherId: controller
                                                    .teacherList[index].userId,
                                                teacherName: 'HOD',
                                              ));
                                        }),
                              SizedBox(
                                height: 16.h,
                              ),
                              // Divider(
                              //   height: 8.h,
                              //   color: ColorResources.colorgrey400,
                              // ),
                              // SizedBox(
                              //   height: 4.h,
                              // ),
                            ],
                          );
                        },
                      )
                    : SizedBox(
                        height: Get.height / 1.5,
                        child: Center(
                            child: Text(
                          'No mentors available',
                          style: GoogleFonts.plusJakartaSans(
                            color: ColorResources.colorgrey600,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        )));
              }),
            )
          ],
        )),
      ),
    );
  }
}
