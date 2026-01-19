import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:anandhu_s_application4/core/colors_res.dart';
import 'package:anandhu_s_application4/core/utils/common_utils.dart';
import 'package:anandhu_s_application4/core/utils/extentions.dart';
import 'package:anandhu_s_application4/core/utils/meet_utils.dart';
import 'package:anandhu_s_application4/http/socket_io.dart';
import 'package:anandhu_s_application4/presentation/android_large_5_page/controller/call_chat_controller.dart';
import 'package:anandhu_s_application4/presentation/android_large_5_page/incoming_call_page.dart';
import 'package:anandhu_s_application4/presentation/android_large_5_page/widgets/handle_call_widget.dart';
import 'package:anandhu_s_application4/presentation/chat_screen/controller/chat_controller.dart';
import 'package:anandhu_s_application4/presentation/home_page/controller/home_controller.dart';
import 'package:anandhu_s_application4/presentation/home_page/models/home_model.dart';
import 'package:anandhu_s_application4/presentation/home_page/video_individual_screen.dart';
import 'package:anandhu_s_application4/presentation/profile/controller/profile_controller.dart';
import 'package:anandhu_s_application4/widgets/custom_icon_button.dart';
import 'package:anandhu_s_application4/widgets/custom_text_form_field.dart';
import 'package:anandhu_s_application4/widgets/google_meet.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Section Widget
Widget buildAppBar(String isHod, String teacherName, String profileUrl,
    int teacherId, BuildContext context) {
  final ChatHistoryController chatHistoryController =
      Get.find<ChatHistoryController>();
  final CallandChatController callandChatController =
      Get.find<CallandChatController>();
  final HomeController homeController = Get.find<HomeController>();

  final ProfileController profileController = Get.find<ProfileController>();
  return Container(
    decoration: const BoxDecoration(color: ColorResources.colorwhite),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8.h),
      child: Row(
        children: [
          Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: ColorResources.colorBlue100),
              child: IconButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () async {
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    String studentId =
                        preferences.getString('breffini_student_id') ?? '';

                    if (studentId.isNotEmpty) {
                      try {
                        chatHistoryController.getChatAndCallHistory();
                        int parsedTeacherId = (teacherId);
                        ChatSocket.leaveConversationRoom(
                            studentId.toString(), parsedTeacherId, isHod);
                      } catch (e) {
                        print('Error parsing teacherId: $e');
                      }
                    } else {
                      print('teacherId is empty');
                    }

                    Get.back();
                  },
                  icon: Icon(
                    CupertinoIcons.back,
                    color: ColorResources.colorgrey500,
                    size: 22,
                  ))),
          SizedBox(
            width: 12.h,
          ),
          Container(
            height: 35.h,
            width: 35.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  profileUrl,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 8.h,
          ),
          Expanded(
            child: Text(
              teacherName,
              style: GoogleFonts.plusJakartaSans(
                color: ColorResources.colorgrey700,
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Row(
            children: [
              InkWell(
                onTap: PrefUtils().getGmeetLink().isNotEmpty
                    ? () async {
                        await handleTeacherCall(
                            teacherId: teacherId.toString(),
                            teacherName: teacherName,
                            callId: '',
                            isVideo: true,
                            profileImageUrl: profileUrl,
                            liveLink: PrefUtils().getGmeetLink(),
                            homeController: homeController,
                            callandChatController: callandChatController,
                            safeBack: safeBack,
                            isIncomingCall: false);

                        MeetCallTracker(
                          onCallEnded: () {},
                        ).startMeetCall(meetCode: PrefUtils().getGmeetLink());

                        // final CallandChatController callandChatController =
                        //     Get.find<CallandChatController>();

                        // if (!await isCallExist(context, callandChatController)) {
                        //   Get.to(() => IncomingCallPage(
                        //         liveLink: "",
                        //         callId: "",
                        //         video: false,
                        //         teacherId: teacherId,
                        //         // isIncomingCall: true,
                        //         profileImageUrl: profileUrl,
                        //         teacherName: teacherName,
                        //       ))?.then((value) {});
                        // }
                      }
                    : () {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                'Create a google meet link to initiate call')));
                      },
                child: const SizedBox(
                  width: 24,
                  height: 24,
                  child: Icon(
                    CupertinoIcons.phone,
                    size: 18,
                    color: ColorResources.colorgrey700,
                  ),
                ),
              ),
              SizedBox(
                width: 12.h,
              ),
              GestureDetector(
                onTap: PrefUtils().getGmeetLink().isNotEmpty
                    ? () async {
                        await handleTeacherCall(
                            teacherId: teacherId.toString(),
                            teacherName: teacherName,
                            callId: '',
                            isVideo: true,
                            profileImageUrl: profileUrl,
                            liveLink: PrefUtils().getGmeetLink(),
                            homeController: homeController,
                            callandChatController: callandChatController,
                            safeBack: safeBack,
                            isIncomingCall: false);

                        MeetCallTracker(
                          onCallEnded: () {},
                        ).startMeetCall(meetCode: PrefUtils().getGmeetLink());
                      }
                    : () {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                'Create a google meet link to initiate call')));
                      },
                child: const SizedBox(
                  width: 24,
                  height: 24,
                  child: Icon(
                    CupertinoIcons.videocam,
                    size: 24,
                    color: ColorResources.colorgrey700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget buildMessageSection({
  // required int studentId,
  void Function()? onTap,
  void Function()? onTapFile,
  void Function()? onTapDocument,
  void Function()? onStopVoice,
  void Function()? onPause,
  void Function()? onResume,
  void Function(String)? onTextChanged,
  double? height,
  required BuildContext context,
  TextEditingController? controller,
  required String fileName,
  required Widget imageWidget,
  required bool isVoiceMessage,
  required bool isRecording,
  required bool isRecordingPaused,
  required String formattedTime,
  required bool isMicOn,
  required bool isMessageTyped,
  required bool isSendingMessage,
}) {
  return Container(
    height: height ?? 64.h,
    decoration: const BoxDecoration(color: ColorResources.colorwhite),
    child: Column(
      children: [
        // SizedBox(height: 12.h),
        imageWidget,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!isVoiceMessage)
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          decoration: const BoxDecoration(
                            color: ColorResources.colorwhite,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16)),
                          ),
                          height: 170.h,
                          child: Column(
                            children: [
                              SizedBox(height: 12.h),
                              Container(
                                width: 36.h,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: ColorResources.colorgrey400,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              SizedBox(height: 24.h),
                              ListTile(
                                leading: const Icon(
                                  Icons.image_outlined,
                                  size: 24,
                                  color: ColorResources.colorgrey700,
                                ),
                                title: Text(
                                  'Attach photos & videos',
                                  style: GoogleFonts.plusJakartaSans(
                                    color: ColorResources.colorgrey700,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                onTap: onTapFile,
                              ),
                              ListTile(
                                leading: const Icon(
                                  Icons.upload_file,
                                  size: 24,
                                  color: ColorResources.colorgrey700,
                                ),
                                title: Text(
                                  'Upload file',
                                  style: GoogleFonts.plusJakartaSans(
                                    color: ColorResources.colorgrey700,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                onTap: onTapDocument,
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    height: 38.h,
                    width: 38.h,
                    decoration: BoxDecoration(
                      color: ColorResources.colorgrey200,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: const Icon(CupertinoIcons.add),
                  ),
                ),
              if (!isVoiceMessage) SizedBox(width: 10.h),
              if (!isVoiceMessage)
                Expanded(
                  child: CustomTextFormField(
                    fillColor: ColorResources.colorgrey200,
                    filled: true,
                    height: 40.h,
                    controller: controller,
                    onTextChanged: onTextChanged,
                    hintText: "Type your message",
                    textStyle: CustomTextStyles.bodySmallBlack900.copyWith(
                      fontSize: 14.0,
                    ),
                    hintStyle: CustomTextStyles.bodySmallBluegray40001.copyWith(
                      fontSize: 14.0,
                    ),
                    textInputAction: TextInputAction.done,
                    alignment: Alignment.center,
                  ),
                )
              else
                InkWell(
                  onTap: isRecording ? onPause : onResume,
                  child: CustomIconButton(
                    height: 38.h,
                    width: 38.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFFF4F7FA),
                          Color(0xFFF4F7FA),
                        ],
                      ),
                    ),
                    child: Icon(
                      isRecording ? Icons.pause : Icons.play_arrow,
                      color: const Color(0xFF283B52),
                      size: 20,
                    ),
                  ),
                ),
              SizedBox(width: 10.h),
              if (isVoiceMessage)
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(
                          0xFFE3E7EE), // Set the background color (optional)
                      borderRadius:
                          BorderRadius.circular(12.0), // Set the border radius
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          if (isRecording)
                            Lottie.asset('assets/lottie/record.json',
                                animate: isRecording),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Row(
                            children: [
                              (isRecording)
                                  ? Text(
                                      'Recording...',
                                      style:
                                          TextStyle(color: Color(0xFF6A7487)),
                                    )
                                  : (isRecordingPaused)
                                      ? Text(
                                          'Paused...',
                                          style: TextStyle(
                                              color: Color(0xFF6A7487)),
                                        )
                                          .animate(
                                            onPlay: (controller) =>
                                                controller.repeat(),
                                          )
                                          .fadeIn(
                                              duration: 600.ms,
                                              delay: 200.ms) // Fade in
                                          .scale(
                                              delay: 200.ms,
                                              curve: Curves
                                                  .easeOut) // Scale after a delay
                                          .then() // Then
                                          .fadeOut(duration: 600.ms)
                                      : Text(""), // Fade out
                            ],
                          )),
                          Text(formattedTime),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: onStopVoice,
                            child: CustomIconButton(
                              height: 25.h,
                              width: 25.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: const Color(0xFF283B52)),
                              child: const Icon(
                                Icons.close,
                                color: Color(0xFFE3E7EE),
                                size: 15,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              SizedBox(width: 10),
              isSendingMessage
                  ? Container(
                      height: 38.h,
                      width: 38.h,
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: CircularProgressIndicator(
                        color: ColorResources.colorBlue500,
                      ),
                    )
                  :
                  // Send button
                  (!isMessageTyped &&
                          !isRecording &&
                          !isRecordingPaused &&
                          fileName.isNullOrEmpty())
                      ? InkWell(
                          onTap: onTap,
                          child: CustomIconButton(
                            height: 38.h,
                            width: 38.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  ColorResources.colorBlue600,
                                  ColorResources.colorBlue600,
                                ],
                              ),
                            ),
                            child: const Icon(
                              Icons.mic,
                              color: ColorResources.colorwhite,
                              size: 18,
                            ),
                          ),
                        )
                      : InkWell(
                          onTap: onTap,
                          child: CustomIconButton(
                            height: 38.h,
                            width: 38.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  ColorResources.colorBlue600,
                                  ColorResources.colorBlue600
                                ],
                              ),
                            ),
                            child: const Icon(
                              Icons.send,
                              color: ColorResources.colorwhite,
                              size: 18,
                            ),
                          ),
                        ),
              SizedBox(height: 12.h),
            ],
          ),
        ),
      ],
    ),
  );
}
