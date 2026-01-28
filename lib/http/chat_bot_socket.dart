import 'dart:developer';
import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:anandhu_s_application4/http/http_urls.dart';
import 'package:anandhu_s_application4/http/loader.dart';
import 'package:anandhu_s_application4/presentation/android_large_5_page/controller/call_chat_controller.dart';
import 'package:anandhu_s_application4/presentation/breff_screen/controller/chat_screen_controller.dart';
import 'package:anandhu_s_application4/presentation/breff_screen/models/chat_model.dart';
import 'package:anandhu_s_application4/presentation/chat_screen/controller/chat_map_controller.dart';
import 'package:anandhu_s_application4/presentation/chat_screen/models/student_chat_his_model.dart';
import 'package:anandhu_s_application4/presentation/chat_screen/models/student_chat_log_model.dart';
import 'package:anandhu_s_application4/presentation/chat_screen/models/student_chat_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatbotSocket {
  static IO.Socket? socket;
  static ChatController chatMsgController = Get.put(ChatController());
  static CallandChatController chtLogController =
      Get.put(CallandChatController());

  static Future<void> initSocket() async {
    print('<<<<<<<<<<<<<<<<<<<<socke start>>>>>>>>>>>>>>>>>>>>');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String studentId = preferences.getString('breffini_student_id') ?? '';

    socket = IO.io(HttpUrls.chatBaseUrl, <String, dynamic>{
      'transports': ['websocket'],
      'upgrade': true,
      'extraHeaders': {
        'Authorization': 'Bearer ' + PrefUtils().getAuthToken(),
        'ngrok-skip-browser-warning': 'true',
      },
    });

    socket?.connect();
    // Add event listeners for debugging
    socket?.on('connect_error', (error) {
      print('Connection Error: $error');
    });

    socket?.on('connect_timeout', (timeout) {
      print('Connection Timeout: $timeout');
    });

    socket?.on('error', (error) {
      print('Error: $error');
    });
    socket?.onConnect((_) => print('Connect'));
    socket?.onConnectError((err) => print('Connect Error: $err'));
    socket?.onConnectTimeout((_) => print('Connect Timeout'));
    socket?.onError((err) => print('Error: $err'));
    socket?.onDisconnect((_) => print('Disconnect'));
    socket?.on('connecting', (_) => print('Connecting'));
    socket?.on('connect_failed', (_) => print('Connect Failed'));
    // Check connection status after a delay
    await Future.delayed(Duration(seconds: 2), () {
      print('Connection status after 5 seconds: ${socket?.connected}');
      if (socket?.connected == false) {
        print('Socket? options: ${socket?.opts}');
        print('Socket? id: ${socket?.id}');
      }
    });
    //end here

    socket?.on('connect', (_) {
      print('Connected to server');
      socket?.emit('send', 'hi');
    });

    socket?.emit('send', 'hi');
    socket?.on('get', (data) {
      print('data1111111111111: $data');
    });

    socket?.on('connect_error', (data) {
      print('Connection error: $data');
    });

    socket?.on('error', (data) {
      print('Error: $data');
    });
  }

  static initializeSocket() async {
    print('start');

    socket = IO.io(HttpUrls.baseUrl,
        IO.OptionBuilder().setTransports(['websocket']).build());
    await Future.delayed(Duration(seconds: 2), () {
      print('Connection status after 5 seconds: ${socket?.connected}');
      if (socket?.connected == false) {
        print('Socket? options: ${socket?.opts}');
        print('Socket? id: ${socket?.id}');
      }
    });
    socket?.connect();

    socket?.on('Connection', (_) {
      print('Connected');
    });

    socket?.on('connect_error', (data) {
      print('Connection Error: $data');
    });

    socket?.on('connect_timeout', (data) {
      print('Connection Timeout: $data');
    });

    socket?.on('disconnect', (_) {
      print('Disconnected');
    });

    socket?.on('message', (data) {
      print('Received: $data');
    });

    if (!socket!.connected) {
      socket?.connect();
    }
  }

  //chat bot
  static sendBotQuestion(String question) {
    socket?.emit('Chatbot_Question', {"message": question});
  }

  void listenBotReplay() {
    socket?.on('Chatbot_Answer', (data) {
      var payLoad = data["payload"][0];
      var type = data["type"];
      var id = data["id"];

      print(payLoad);
      ChatModel model = ChatModel.fromJson(payLoad, type, id);
      Get.find<ChatScreenController>().setMessage(model);
    });
  }

  static disconnectSocket() {
    socket?.disconnect();
  }
}
