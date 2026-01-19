import 'package:anandhu_s_application4/presentation/chat_screen/models/student_chat_his_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  TextEditingController messageController = TextEditingController();
  List<StudentChatHistoryModel> chatHistoryList = [];
  Map<String, List<StudentChatHistoryModel>> chatHistoryListMap = {};

  // void chatHistoryBackup(List<dynamic> chatHistory) {
  //   chatHistoryList = chatHistory
  //       .map((chat) => StudentChatHistoryModel.fromMap(chat))
  //       .toList();
  //   print('Chat history updated: $chatHistoryList');
  //   update();
  // }

  // void addMessage(StudentChatHistoryModel chatMessage) {
  //   chatHistoryList.add(chatMessage);
  //   print('Message added: $chatMessage');
  //   update();
  // }

  @override
  void onClose() {
    super.onClose();
    messageController.dispose();
  }
}
