import 'package:anandhu_s_application4/http/http_request.dart';
import 'package:anandhu_s_application4/http/http_urls.dart';
import 'package:anandhu_s_application4/presentation/chat_screen/models/student_chat_history_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatHistoryController extends GetxController {
  TextEditingController messageController = TextEditingController();

  var callandChatList = <ChatHistoryModel>[].obs;

  void getChatAndCallHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final String studentId = prefs.getString('breffini_student_id') ?? "0";
    await HttpRequest.httpGetRequest(
      endPoint: '${HttpUrls.getStudentChatLog}$studentId',
    ).then((response) {
      if (response!.statusCode == 200) {
        final responseData = response.data;
        if (responseData is List<dynamic>) {
          final callandChatListDetails = responseData;
          callandChatList.value = callandChatListDetails
              .map((result) => ChatHistoryModel.fromJson(result))
              .toList();
        } else if (responseData is Map<String, dynamic>) {
          final callandChatListDetails = [responseData];
          callandChatList.value = callandChatListDetails
              .map((result) => ChatHistoryModel.fromJson(result))
              .toList();
        } else {
          throw Exception('Unexpected response data format');
        }
      } else {
        throw Exception('Failed to load profile data: ${response.statusCode}');
      }
    }).catchError((error) {
      print('Error fetching datassssssss: $error');
    });

    update();
  }

  @override
  void onClose() {
    super.onClose();
    messageController.dispose();
  }
}
