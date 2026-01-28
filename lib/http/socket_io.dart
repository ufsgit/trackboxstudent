import 'dart:developer';
import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:anandhu_s_application4/http/http_urls.dart';
import 'package:anandhu_s_application4/http/loader.dart';
import 'package:anandhu_s_application4/presentation/android_large_5_page/controller/call_chat_controller.dart';
import 'package:anandhu_s_application4/presentation/android_large_5_page/models/call_model.dart';
import 'package:anandhu_s_application4/presentation/android_large_5_page/models/ongoing_call_model.dart';
import 'package:anandhu_s_application4/presentation/breff_screen/controller/chat_screen_controller.dart';
import 'package:anandhu_s_application4/presentation/chat_screen/controller/chat_map_controller.dart';
import 'package:anandhu_s_application4/presentation/chat_screen/models/student_chat_his_model.dart';
import 'package:anandhu_s_application4/presentation/chat_screen/models/student_chat_log_model.dart';
import 'package:anandhu_s_application4/presentation/chat_screen/models/student_chat_model.dart';
import 'package:anandhu_s_application4/presentation/my_courses_page/controller/live_class_controller.dart';
import 'package:anandhu_s_application4/presentation/my_courses_page/models/live_class_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:anandhu_s_application4/core/utils/notification_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatSocket {
  static IO.Socket? socket;
  static ChatController chatMsgController = Get.put(ChatController());
  static CallandChatController chtLogController =
      Get.put(CallandChatController());

  static Future<void> initSocket() async {
    if (socket != null && socket!.connected) {
      print('Socket is already initialized and connected');
      return;
    }
    print('<<<<<<<<<<<<<<<<<<<<socke start>>>>>>>>>>>>>>>>>>>>');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String studentId = preferences.getString('breffini_student_id') ?? '';

    socket = IO.io(HttpUrls.baseUrl, <String, dynamic>{
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
    socket?.onConnect((_) {
      print('Connect');
      emitOngoingCalls();
    });
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

    socket?.on('chat history', (data) {
      print('chat history clicked received: $data');
      // LoaderChat.showLoader();
      if (data != null) {
        Map<String, dynamic> originalMap = data;
        chatMsgController.chatHistoryListMap = originalMap.map((key, value) {
          List<dynamic> chatList = value;
          return MapEntry(
            key,
            chatList
                .map((item) => StudentChatHistoryModel.fromMap(item))
                .toList(),
          );
        });
        chatMsgController.update();
      }

      // Print converted map for verification
      log('Print converted map for verification>>>>>>>>>>>>>>>>>>');
      log(chatMsgController.chatHistoryListMap.toString());
      // LoaderChat.stopLoader();
      //chatMsgController.chatHistoryBackup(data[0]);
    });

    socket?.on('chat list', (data) {
      print('chat log list clicked received: $data');
      LoaderChat.showLoader();
      List<dynamic> chatLogHistory = data;
      chtLogController.studentChatLogList.value =
          chatLogHistory.map((e) => StudentChatLogModel.fromJson(e)).toList();
      chtLogController.searchableChatList.value =
          chatLogHistory.map((e) => StudentChatLogModel.fromJson(e)).toList();

      print('chat log lis: ${chtLogController.searchableChatList.value}');
      print(
          'chat log list after received: ${chtLogController.searchableChatList}');

      // Removed redundant notification logic that triggered every time the chat tab was opened

      chtLogController.update();
      LoaderChat.stopLoader();
    });

    socket?.on(
      'new message',
      (data) async {
        log('Received new message socket event: $data');
        try {
          int parsedTeacherId = int.tryParse(data['teacherId']?.toString() ??
                  data['teacher_id']?.toString() ??
                  '0') ??
              0;
          int parsedStudentId = int.tryParse(studentId) ?? 0;

          StudentChatHistoryModel newChat = StudentChatHistoryModel(
              messageId: null,
              teacherId: parsedTeacherId,
              studentId: parsedStudentId,
              message: data['message'] ?? '',
              messageTimestamp: DateTime.now(),
              callId: null,
              callStart: null,
              callEnd: null,
              // callDuration: 0,
              callType: '',
              filePath: data['File_Path'] ?? '',
              isStudent: (data['isStudent'] == true || data['isStudent'] == 1));

          // Get the current date
          DateTime now = DateTime.now();

          // Format the current date
          String formattedDate = DateFormat('yyyy-MM-dd').format(now);

          log('Updating chat map for date $formattedDate');
          if (!chatMsgController.chatHistoryListMap
              .containsKey(formattedDate)) {
            chatMsgController.chatHistoryListMap[formattedDate] = [];
          }
          chatMsgController.chatHistoryListMap[formattedDate]!.add(newChat);
          chatMsgController.update();
          log('mark as read for teacher $parsedTeacherId');
          socket?.emit('mark as read', {
            "studentId": studentId,
            "teacherId": parsedTeacherId,
            "isStudent": newChat.isStudent,
            "chatType": 'teacher_student',
          });

          chtLogController.getStudentChatLog();
          chtLogController.update();

          // Show Notification if we are NOT in the active chat with this teacher
          bool isFromTeacher =
              (data['isStudent'] == false || data['isStudent'] == 0);
          if (isFromTeacher) {
            log('Attempting to show notification for teacher: ${data['senderName']}');
            await NotificationService().showNotification(
              title: data['senderName'] ?? "Teacher",
              body: data['message'] ?? "New Message",
              data: Map<String, dynamic>.from(data),
            );
            log('Notification call completed');
          } else {
            log('Not showing notification: message is from current user/student');
          }
        } catch (e, stack) {
          log('Error in new message listener: $e');
          log(stack.toString());
        }
      },
    );

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

    // // Add all possible event listeners
    // socket?.onConnect((_) => print('Connect'));
    // socket?.onConnectError((err) => print('Connect Error: $err'));
    // socket?.onConnectTimeout((_) => print('Connect Timeout'));
    // socket?.onError((err) => print('Error: $err'));
    // socket?.onDisconnect((_) => print('Disconnect'));
    // socket?.on('connecting', (_) => print('Connecting'));
    // socket?.on('connect_failed', (_) => print('Connect Failed'));
  }

  // IO.Socket get socket => socket;
  static joinConversationRoom(
      String studentId, int teacherId, String chatType) {
    socket?.emit('join conversation', {
      "studentId": studentId,
      "teacherId": teacherId,
      "isStudent": true,
      "chatType": chatType
    });
  }

  static leaveConversationRoom(
      String studentId, int teacherId, String chatType) {
    socket?.emit('leave conversation', {
      "studentId": studentId,
      "teacherId": teacherId,
      "isStudent": true,
      "chatType": chatType
    });
  }

  static getChatLogHistory(String studentId, String chatType) {
    print('chat log list clicked received');
    socket?.emit(
        'get list', {"id": studentId, "isStudent": true, "chatType": chatType});
  }

  static leaveChatLogHistory(String studentId, String chatType) {
    log('chat log list leaved');
    socket?.emit('leave chatlist', {
      "id": studentId,
      "isStudent": true,
      "chatType": chatType,
    });
  }

  static startChatting(StudentChatModel chat) {
    socket?.emit(
      'send message',
      chat.toMap(),
    );
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

  // static socketConnection() {
  //   if (socket == null || !socket!.connected) {
  //     initializeSocket();
  //   }
  //
  //   socket?.onConnect((_) {
  //     print('Connected');
  //     socket?.emit('msg', 'test');
  //   });
  //
  //   socket?.on('event', (data) => print(data));
  //   socket?.onDisconnect((_) => print('Disconnected'));
  //   socket?.on('fromServer', (_) => print(_));
  //
  //   print('connect_last');
  // }

  //call
  static emitOngoingCalls() {
    String ss = PrefUtils().getStudentId();
    socket?.emit('Get_Ongoing_Calls', {"user_Id": ss, "isStudent": 1});
  }

  static listenOngoingCalls() {
    CallandChatController callandChatController =
        Get.find<CallandChatController>();
    // used to block looping of getting calles
    socket?.off("Get_Ongoing_Calls");
    final chatController =
        Get.put<CallandChatController>(CallandChatController());
    socket?.on('Get_Ongoing_Calls', (data) {
      var dataList = data as List;

      if (dataList.length > 0) {
        // List<OnGoingCallsModel> onGoingList = dataList
        //     .map((result) => OnGoingCallsModel.fromJson(result))
        //     .toList();
        callandChatController.callandChatList.value = dataList
            .map((result) => CallAndChatHistoryModel.fromJson(result))
            .toList();
        // chatController.onGoingCallsList.value = onGoingList;
        // chatController.searchableCallList.value = onGoingList;
      } else {
        // chatController.onGoingCallsList.value = [];
        chatController.callandChatList.value = [];
      }
      chatController.isLoading.value = false;
    });
  }

  //live class
  static emitLiveClass(int courseId, int batchId) {
    String ss = PrefUtils().getStudentId();
    socket?.emit('Get_Live_Classes_By_CourseId',
        {"user_Id": ss, "course_Id": courseId, "batch_Id": batchId});
  }

  static listenOngoingLiveClass() {
    final liveController = Get.put<LiveClassController>(LiveClassController());
    socket?.on('Get_Live_Classes_By_CourseId', (data) {
      var dataList = data as List;

      if (dataList.length > 0) {
        liveController.liveNowCourseList.value =
            data.map((e) => LiveClassModel.fromJson(e)).toList();
      } else {
        liveController.liveNowCourseList.value = [];
      }
    });
  }

  //listen current Call
  void listenCurrentCall(Function(bool, String) callback) {
    // socket?.on('Call_Status', (data) {
    //   Map<String, dynamic> dataList = data ;
    //   if(dataList.isNotEmpty){//here need to check reject call id and current call id is same ..
    //     // (case when going one one call btw a and b and person c call person a and rejct call by c ..then a and b call disconnected )
    //     bool isRejected=dataList["is_call_rejected"];
    //     String id=dataList["id"].toString();
    //     callback(isRejected,id);      // Pass
    //   }
    // });
  }

  void removeCallStatusListener() {
    socket?.off('Call_Status');
  }
}
