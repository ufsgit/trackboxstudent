import 'dart:developer';
import 'package:anandhu_s_application4/presentation/chat_screen/controller/chat_firebase_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:anandhu_s_application4/core/colors_res.dart';
import 'package:anandhu_s_application4/http/http_urls.dart';
import 'package:anandhu_s_application4/http/socket_io.dart';
import 'package:anandhu_s_application4/presentation/android_large_5_page/controller/call_chat_controller.dart';
import 'package:anandhu_s_application4/presentation/chat_screen/chat_firebase_screen.dart';
import 'package:anandhu_s_application4/presentation/chat_screen/models/student_chat_log_model.dart';
import 'package:anandhu_s_application4/presentation/android_large_5_page/widgets/chat_widget.dart';

class ChatLogScreen extends StatefulWidget {
  const ChatLogScreen({Key? key}) : super(key: key);

  @override
  State<ChatLogScreen> createState() => _ChatLogScreenState();
}

class _ChatLogScreenState extends State<ChatLogScreen> {
  final CallandChatController callLogController =
      Get.put<CallandChatController>(CallandChatController());
  ChatFireBaseController chatController = Get.put(ChatFireBaseController());

  @override
  void initState() {
    super.initState();
    print('dfsdf${callLogController.studentChatLogList}');
    getStudentChatLogHistory();
  }

  Future<void> getStudentChatLogHistory() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String studentId = preferences.getString('breffini_student_id') ?? '';

    // Set loading state
    callLogController.isLoading(true);

    try {
      List<StudentChatLogModel>? chatLogs =
          await ChatSocket.getChatLogHistory(studentId, 'teacher_student');

      if (chatLogs == null) {
        chatLogs = [];
      }

      callLogController.update(chatLogs);
    } catch (e) {
      log('Error fetching chat logs: $e');
    } finally {
      callLogController.isLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.colorgrey200,
      body: Obx(
        () {
          if (callLogController.studentChatLogList.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/images/ic_no_chats_logo.svg',
                      width: 70, height: 60),
                  SizedBox(height: 16),
                  Text(
                    'No chats',
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
                  ListView.builder(
                    itemCount: callLogController.studentChatLogList.length,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      StudentChatLogModel chatLog =
                          callLogController.studentChatLogList[index];
                      DateTime timestamp = chatLog.sentTime;
                      String formattedDate =
                          DateFormat('dd MMM yyyy').format(timestamp);
                      String currentDate =
                          DateFormat('dd MMM yyyy').format(DateTime.now());
                      String yesterdayDate = DateFormat('dd MMM yyyy').format(
                          DateTime.now().subtract(const Duration(days: 1)));
                      String formattedTime =
                          DateFormat('hh:mm a').format(timestamp);

                      String displayDate;
                      if (formattedDate == currentDate) {
                        displayDate = 'Today';
                      } else if (formattedDate == yesterdayDate) {
                        displayDate = 'Yesterday';
                      } else {
                        displayDate = formattedDate;
                      }

                      return Column(
                        children: [
                          InkWell(
                            onTap: () async {
                              SharedPreferences preferences =
                                  await SharedPreferences.getInstance();
                              String studentId = preferences
                                      .getString('breffini_student_id') ??
                                  '';
                              ChatSocket.joinConversationRoom(studentId,
                                  chatLog.teacherId, 'teacher_student');



                              await Get.to(() => ChatFireBaseScreen(
                                    courseId: 0,
                                    isHod: false,
                                    teacherName:
                                        '${chatLog.firstName} ${chatLog.lastName}',
                                    profileUrl:
                                        '${HttpUrls.imgBaseUrl}${chatLog.profilePhotoPath}',
                                    teacherId: chatLog.teacherId,
                                  ));
                            },
                            child: chatWidget(
                              index: index,
                              isCall: false,
                              callIcon: '',
                              name: '${chatLog.firstName} ${chatLog.lastName}',
                              content: chatLog.chatMessage.isNotEmpty
                                  ? chatLog.chatMessage
                                  : 'A file is attached',
                              unreadCount: chatLog.unreadCount.toString(),
                              date: displayDate,
                              time: formattedTime,
                              image:
                                  '${HttpUrls.imgBaseUrl}${chatLog.profilePhotoPath}',
                            ),
                          ),
                          SizedBox(height: 4),
                          Divider(
                              height: 8, color: ColorResources.colorgrey300),
                          SizedBox(height: 4),
                        ],
                      );
                    },
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
