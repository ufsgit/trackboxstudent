import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:anandhu_s_application4/core/utils/common_utils.dart';
import 'package:anandhu_s_application4/core/utils/date_time_utils.dart';
import 'package:anandhu_s_application4/core/utils/extentions.dart';
import 'package:anandhu_s_application4/core/utils/firebase_utils.dart';
import 'package:anandhu_s_application4/core/utils/meet_utils.dart';
import 'package:anandhu_s_application4/http/http_urls.dart';
import 'package:anandhu_s_application4/http/socket_io.dart';
import 'package:anandhu_s_application4/presentation/android_large_5_page/widgets/handle_call_widget.dart';
import 'package:anandhu_s_application4/presentation/home_page/controller/home_controller.dart';
import 'package:anandhu_s_application4/presentation/home_page/models/home_model.dart';
import 'package:anandhu_s_application4/presentation/my_courses_page/controller/live_class_controller.dart';
import 'package:anandhu_s_application4/widgets/google_meet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:anandhu_s_application4/core/colors_res.dart';
import 'package:anandhu_s_application4/presentation/android_large_5_page/controller/call_chat_controller.dart';
import 'package:anandhu_s_application4/presentation/android_large_5_page/incoming_call_page.dart';
import 'package:anandhu_s_application4/presentation/android_large_5_page/widgets/chat_widget.dart';
import 'package:anandhu_s_application4/presentation/profile/controller/profile_controller.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

class CallLogScreen extends StatefulWidget {
  CallLogScreen({super.key});

  @override
  State<CallLogScreen> createState() => _CallLogScreenState();
}

class _CallLogScreenState extends State<CallLogScreen> {
  final CallandChatController callandChatController =
      Get.put<CallandChatController>(CallandChatController());
  final HomeController homeController =
      Get.put<HomeController>(HomeController(HomeModel().obs));
  bool isLoadingCallBtn = false;

  final ProfileController profileController = Get.find<ProfileController>();
  @override
  void initState() {
    callandChatController.getOngoingCalls();
    // for (int i = 0; i < 100; i++) {
    //   print('API Call ${i + 1} completed');
    //   callandChatController.getOngoingCalls();
    // }
    // callandChatController.getChatAndCallHistory('call', 'student');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorResources.colorgrey200,
        body: Obx(() {
          // if (callandChatController.isLoading.value) {
          //   // Display a loading indicator while data is being fetched
          //   return Center(
          //     child: Lottie.asset('assets/lottie/briffni_logo.json',
          //         width: 70, height: 70),
          //   );
          // }
          if (callandChatController.callandChatList.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/images/ic_no_calls_logo.svg',
                      width: 70, height: 60),
                  SizedBox(height: 16),
                  Text(
                    'No calls',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: ColorResources.colorgrey500,
                      fontFamily: 'Plus Jakarta Sans',
                    ),
                  ),
                ],
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Obx(() {
                  //   return ListView.builder(
                  //     itemCount: callandChatController.onGoingCallsList.length,
                  //     shrinkWrap: true,
                  //     physics: const ClampingScrollPhysics(),
                  //     itemBuilder: (context, index) {
                  //       var filteredModel =
                  //           callandChatController.onGoingCallsList[index];
                  //       return Column(
                  //         children: [
                  //           InkWell(
                  //               onTap: () {
                  //                 // if(!callandChatController.currentCallModel.value.callId.isNullOrEmpty()) {
                  //                 //   showBusySnackBar(context);
                  //                 // }else {
                  //                   Get.to(() =>
                  //                       IncomingCallPage(
                  //                         liveLink: filteredModel.liveLink,
                  //                         callId: filteredModel.id.toString(),
                  //                         video:
                  //                         filteredModel.callType == 'Video',
                  //                         teacherId: filteredModel.teacherId,
                  //                         // isIncomingCall: true,
                  //                         profileImageUrl:
                  //                         filteredModel.profilePhotoPath,
                  //                         teacherName: filteredModel.callerName,
                  //                       ))?.then((value) {
                  //                     setState(() {});
                  //                   });
                  //                 // }
                  //               },
                  //               child: incomingCallWidget(
                  //                 callIcon: filteredModel.callType == 'Video'
                  //                     ? Icons.videocam
                  //                     : Icons.call,
                  //                 name: filteredModel.callerName,
                  //                 subTitle: callandChatController
                  //                             .currentCallModel.value.callId ==
                  //                         filteredModel.id.toString()
                  //                     ? 'In ${filteredModel.callType} Call'
                  //                     : 'Incoming ${filteredModel.callType} Call',
                  //                 count: '0',
                  //                 image: !filteredModel.profilePhotoPath
                  //                         .isNullOrEmpty()
                  //                     ? (HttpUrls.imgBaseUrl +
                  //                         filteredModel.profilePhotoPath)
                  //                     : "assets/images/default_profile.jpg",
                  //                 isOngoingCall: callandChatController
                  //                         .currentCallModel.value.callId ==
                  //                     filteredModel.id.toString(),
                  //                 date: 'Today',
                  //               )),
                  //           SizedBox(height: 4.h),
                  //           Divider(
                  //             height: 8.h,
                  //             color: ColorResources.colorgrey300,
                  //           ),
                  //           SizedBox(height: 4.h),
                  //         ],
                  //       );
                  //     },
                  //   );
                  // }),
                  Obx(() {
                    return ListView.builder(
                      itemCount: callandChatController.callandChatList.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.all(16),
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        var filteredModel =
                            callandChatController.callandChatList[index];
                        return Column(
                          children: [
                            (!filteredModel.isFinished &&
                                    !filteredModel.liveLink.isNullOrEmpty() &&
                                    filteredModel.isStudentCalled == 0)
                                ? InkWell(
                                    onTap: () async {
                                      await handleTeacherCall(
                                          teacherId: filteredModel.teacherId
                                              .toString(),
                                          teacherName: filteredModel.firstName,
                                          callId: filteredModel.id.toString(),
                                          isVideo: true,
                                          profileImageUrl:
                                              filteredModel.profilePhotoPath,
                                          liveLink: filteredModel.liveLink,
                                          homeController: homeController,
                                          callandChatController:
                                              callandChatController,
                                          safeBack: safeBack,
                                          isIncomingCall: true);
                                      setState(() {});

                                      MeetCallTracker(
                                        onCallEnded: () {},
                                      ).startMeetCall(
                                          meetCode: filteredModel.liveLink);
                                    },
                                    // onTap: isLoadingCallBtn
                                    //     ? null
                                    //     : () async {
                                    //         if (!await isCallExist(context,
                                    //             callandChatController)) {
                                    //           setState(() =>
                                    //               isLoadingCallBtn = true);

                                    //           Future.delayed(const Duration(
                                    //                   seconds: 2))
                                    //               .then((value) {
                                    //             setState(() =>
                                    //                 isLoadingCallBtn = false);

                                    //             Get.to(() => IncomingCallPage(
                                    //                   liveLink: filteredModel
                                    //                       .liveLink,
                                    //                   callId: filteredModel.id
                                    //                       .toString(),
                                    //                   video: filteredModel
                                    //                           .callType ==
                                    //                       'Video',
                                    //                   teacherId: filteredModel
                                    //                       .teacherId,
                                    //                   // isIncomingCall: true,
                                    //                   profileImageUrl:
                                    //                       filteredModel
                                    //                           .profilePhotoPath,
                                    //                   teacherName: filteredModel
                                    //                       .firstName,
                                    //                 ))?.then((value) {
                                    //               Future.delayed(
                                    //                   Duration(seconds: 2), () {
                                    //                 ChatSocket
                                    //                     .emitOngoingCalls();
                                    //               });
                                    //             });
                                    //             // }
                                    //           });
                                    //         }
                                    //       },
                                    child: incomingCallWidget(
                                      callIcon: isLoadingCallBtn
                                          ? const SizedBox(
                                              width: 20,
                                              height: 20,
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                                strokeWidth: 2,
                                              ),
                                            )
                                          : filteredModel.callType == 'Video'
                                              ? Icon(
                                                  Icons.videocam,
                                                  color:
                                                      ColorResources.colorwhite,
                                                  size: 20,
                                                )
                                              : Icon(
                                                  Icons.call,
                                                  color:
                                                      ColorResources.colorwhite,
                                                  size: 20,
                                                ),
                                      name: filteredModel.firstName,
                                      subTitle: callandChatController
                                                  .currentCallModel
                                                  .value
                                                  .callId ==
                                              filteredModel.id.toString()
                                          ? 'In ${filteredModel.callType} Call'
                                          : 'Incoming ${filteredModel.callType} Call',
                                      count: '0',
                                      image: !filteredModel.profilePhotoPath
                                              .isNullOrEmpty()
                                          ? (HttpUrls.imgBaseUrl +
                                              filteredModel.profilePhotoPath)
                                          : "assets/images/default_profile.jpg",
                                      isOngoingCall: callandChatController
                                              .currentCallModel.value.callId ==
                                          filteredModel.id.toString(),
                                      date: 'Today',
                                    ))
                                : InkWell(
                                    onTap: PrefUtils().getGmeetLink().isNotEmpty
                                        ? () async {
                                            await handleTeacherCall(
                                                teacherId: filteredModel
                                                    .teacherId
                                                    .toString(),
                                                teacherName:
                                                    filteredModel.firstName,
                                                callId: '',
                                                isVideo: true,
                                                profileImageUrl: filteredModel
                                                    .profilePhotoPath,
                                                liveLink:
                                                    PrefUtils().getGmeetLink(),
                                                homeController: homeController,
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

                                            // if (!await isCallExist(
                                            //     context, callandChatController)) {
                                            //   Get.to(() => IncomingCallPage(
                                            //         liveLink: "",
                                            //         callId: "",
                                            //         video: filteredModel.callType ==
                                            //             "Video",
                                            //         teacherId:
                                            //             filteredModel.teacherId,
                                            //         // isIncomingCall: true,
                                            //         profileImageUrl: filteredModel
                                            //             .profilePhotoPath,
                                            //         teacherName:
                                            //             filteredModel.firstName,
                                            //       ))?.then((value) {
                                            //     //call list not update (case when call from student and reject by staff..student call list not update)
                                            //     Future.delayed(Duration(seconds: 2),
                                            //         () {
                                            //       ChatSocket.emitOngoingCalls();
                                            //     });
                                            //   });
                                            // }
                                          }
                                        : () {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        'Create a google meet link to initiate call')));
                                          },
                                    child: callHistoryWidget(
                                      color: filteredModel.isStudentCalled == 1
                                          ? const Color.fromARGB(
                                              255, 0, 122, 20)
                                          : const Color.fromARGB(
                                              255, 255, 0, 0),
                                      date: formatDateinDdMmYy(
                                          filteredModel.callEnd),
                                      time: formatTimeinAmPm(
                                          filteredModel.callEnd),
                                      callIcon: filteredModel.isStudentCalled ==
                                              1
                                          ? Material(
                                              elevation: 0,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                              color: Colors.white,
                                              child: const Padding(
                                                padding: EdgeInsets.all(4.0),
                                                child: Icon(
                                                  Icons.call_made_rounded,
                                                  color: Colors.green,
                                                ),
                                              ))
                                          : Material(
                                              elevation: 0,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                              color: Colors.white,
                                              child: const Padding(
                                                padding: EdgeInsets.all(4.0),
                                                child: Icon(
                                                  Icons.call_received_rounded,
                                                  color: Colors.red,
                                                ),
                                              )),
                                      name: filteredModel.firstName.toString(),
                                      callType: callandChatController
                                          .callandChatList[index].callType,
                                      subTitle:
                                          (callandChatController
                                                      .callandChatList[index]
                                                      .isRejected &&
                                                  callandChatController
                                                      .callandChatList[index]
                                                      .isRinged &&
                                                  callandChatController
                                                          .callandChatList[
                                                              index]
                                                          .isStudentCalled ==
                                                      0)
                                              ? "Rejected"
                                              : (!callandChatController
                                                          .callandChatList[
                                                              index]
                                                          .isConnected &&
                                                      callandChatController
                                                          .callandChatList[
                                                              index]
                                                          .isRinged &&
                                                      callandChatController
                                                              .callandChatList[
                                                                  index]
                                                              .isStudentCalled ==
                                                          1)
                                                  ? "Not Answered"
                                                  : (callandChatController
                                                              .callandChatList[
                                                                  index]
                                                              .isRinged &&
                                                          !callandChatController
                                                              .callandChatList[
                                                                  index]
                                                              .isConnected &&
                                                          !callandChatController
                                                              .callandChatList[
                                                                  index]
                                                              .isRejected &&
                                                          callandChatController
                                                                  .callandChatList[
                                                                      index]
                                                                  .isStudentCalled ==
                                                              0)
                                                      ? "Missed Call"
                                                      : formatDuration(double.parse(
                                                          callandChatController
                                                                  .callandChatList[
                                                                      index]
                                                                  .callDuration ??
                                                              "0.0")),
                                      image: !filteredModel.profilePhotoPath
                                              .isNullOrEmpty()
                                          ? (HttpUrls.imgBaseUrl +
                                              filteredModel.profilePhotoPath)
                                          : "assets/images/default_profile.jpg",
                                    ),
                                  ),
                            SizedBox(height: 4.h),
                            Divider(
                              height: 8.h,
                              color: ColorResources.colorgrey300,
                            ),
                            SizedBox(height: 4.h),
                          ],
                        );
                      },
                    );
                  }),
                ],
              ),
            );
          }
        }),
      ),
    );
  }

  Widget incomingCallWidget(
      {required String name,
      required String subTitle,
      required String count,
      required String image,
      Widget? callIcon,
      required bool isOngoingCall,
      void Function()? onTap,
      required String date}) {
    return SizedBox(
      height: 60.h,
      child: ListTile(
        contentPadding: const EdgeInsets.all(0),
        // tileColor: ColorResources.colorBlack,
        leading: CircleAvatar(
          backgroundImage: image.contains("assets")
              ? AssetImage(image)
              : NetworkImage(image),
          radius: 23,
        ),
        title: Text(
          name,
          style: GoogleFonts.plusJakartaSans(
            color: ColorResources.colorBlack,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),

        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            subTitle,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.plusJakartaSans(
              color: ColorResources.colorgrey600,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Text(
            //   date,
            //   style: GoogleFonts.plusJakartaSans(
            //     color: ColorResources.colorgrey600,
            //     fontSize: 12.sp,
            //     fontWeight: FontWeight.w500,
            //   ),
            // ),

            isOngoingCall
                ? Obx(() {
                    return Container(
                      height: 35,
                      // width: 35,
                      decoration: BoxDecoration(
                          // color: Colors.red,
                          borderRadius: BorderRadius.circular(100)),
                      child: Text(
                        callandChatController.audioCallFormatedTime.value,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.green,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  })
                : Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(100)),
                    child: IconButton(onPressed: onTap, icon: callIcon!),
                  ),
          ],
        ),
      ),
    );
  }

  Widget callHistoryWidget(
      {required String name,
      required String subTitle,
      required String image,
      required String date,
      required String time,
      Widget? callIcon,
      String? callType,
      Color? color}) {
    return SizedBox(
      height: 60.h,
      child: ListTile(
        contentPadding: const EdgeInsets.all(0),

        // tileColor: ColorResources.colorBlack,
        leading: CircleAvatar(
          backgroundImage: image.contains("assets")
              ? AssetImage(image)
              : NetworkImage(image),
          radius: 23,
        ),
        title: Text(
          name,
          style: GoogleFonts.plusJakartaSans(
            color: ColorResources.colorBlack,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),

        subtitle: Row(
          children: [
            callType == "Video"
                ? Icon(
                    Icons.video_call,
                    color: ColorResources.colorgrey600,
                    size: 15,
                  )
                : Icon(
                    Icons.call,
                    color: ColorResources.colorgrey600,
                    size: 15,
                  ),
            const SizedBox(
              width: 5,
            ),
            Text(
              subTitle,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.plusJakartaSans(
                color: ColorResources.colorgrey600,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  time,
                  style: GoogleFonts.plusJakartaSans(
                    color: ColorResources.colorgrey600,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  date,
                  style: GoogleFonts.plusJakartaSans(
                    color: ColorResources.colorgrey600,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 7,
            ),
            callIcon ?? SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
