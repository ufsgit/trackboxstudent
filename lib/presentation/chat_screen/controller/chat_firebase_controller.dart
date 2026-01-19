// import 'dart:io';

// import 'package:anandhu_s_application4/http/aws_upload.dart';
// import 'package:anandhu_s_application4/presentation/chat_screen/models/chat_message_model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ChatFireBaseController extends GetxController {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final RxList<ChatMessage> messages = <ChatMessage>[].obs;

//   fetchMessages(String teacherId) async {
//     final prefs = await SharedPreferences.getInstance();
//     final String studentId = prefs.getString('breffini_student_id') ?? "0";

//     _firestore
//         .collection('chats')
//         .doc(studentId)
//         .collection('messages')
//         .where('teacherId', isEqualTo: teacherId)
//         .orderBy('sentTime')
//         .snapshots()
//         .listen((snapshot) {
//       final fetchedMessages = snapshot.docs.map((doc) {
//         final data = doc.data();
//         return ChatMessage.fromMap(data);
//       }).toList();
//       print(snapshot.docs.last.data());
//       messages.value = fetchedMessages;
//     });
//   }

//   Future<void> sendMessage(String messageText, String teacherId,
//       {String filePath = ""}) async {
//     fetchMessages(teacherId);
//     final prefs = await SharedPreferences.getInstance();
//     final String studentId = prefs.getString('breffini_student_id') ?? "0";
//     final message = ChatMessage(
//       studentId: studentId,
//       teacherId: teacherId,
//       chatMessage: messageText,
//       sentTime: DateTime.now(),
//       isStudent: true,
//       filePath: filePath,
//     );

//     _firestore
//         .collection('chats')
//         .doc(teacherId)
//         .collection('messages')
//         .add(message.toMap());
//     _firestore
//         .collection('chats')
//         .doc(studentId)
//         .collection('messages')
//         .add(message.toMap());
//   }

//   Future<void> uploadFileAndSendMessage(
//       String messageText, String teacherId, PlatformFile selectedFile) async {
//     fetchMessages(teacherId);
//     final prefs = await SharedPreferences.getInstance();
//     final String studentId = prefs.getString('breffini_student_id') ?? "0";
//     String? uploadedFilePath = await AwsUpload.uploadChatImageToAws(
//       File(selectedFile.path!),
//       studentId,
//       teacherId,
//       selectedFile.extension!,
//     );

//     await sendMessage(messageText, teacherId, filePath: uploadedFilePath!);

//     print('image list//////$messages');
//   }
// }
import 'dart:async';
import 'dart:io';

import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:anandhu_s_application4/core/utils/extentions.dart';
import 'package:anandhu_s_application4/core/utils/file_utils.dart';
import 'package:anandhu_s_application4/http/aws_upload.dart';
import 'package:anandhu_s_application4/http/http_urls.dart';
import 'package:anandhu_s_application4/presentation/chat_screen/models/chat_message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info_plus/device_info_plus.dart';

class ChatFireBaseController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final RxList<ChatMessageModel> messages = <ChatMessageModel>[].obs;
  final isLoading = false.obs;
  final isSendingMessage = false.obs;
  final hasMore = true.obs;
  final int pageSize = 10;
  RxInt currentPlayingIndex = (-1).obs;
  DocumentSnapshot? lastDocument;
  Rx<Duration> duration = (Duration.zero).obs;
  Rx<Duration> position = (Duration.zero).obs;
  RxBool isMicOn = true.obs;
  RxBool isVoiceMessage = false.obs;
  RxBool isRecording = false.obs;
  RxBool isRecordingPaused = false.obs;
  RxString formattedTime = "00:00".obs;
  RxBool isLoadingChat = false.obs;
  RxBool shouldAutoScroll = true.obs;
  RxBool scrollNow = false.obs;
  RxBool visibleScrollBtn = false.obs;
  RxInt notVisibleMsgCount = 0.obs;
  RxBool isFirstFetch = true.obs;
  StreamSubscription? chatSubscription;

  updateDownloadProgress(int index, double progress) {
    messages[index].progress?.value = progress;

    update();
  }

  updatePlayerStatus(int index, bool playing) {
    if (playing) {
      currentPlayingIndex.value = index;
    } else {
      currentPlayingIndex.value = -1;
    }
    // messages[currentPlayingIndex.value].isPlaying=playing;

    update();
  }

  updatePlayerPosition(Duration pos) {
    position.value = pos;

    update();
  }

  updatePlayerDuration(Duration dur) {
    duration.value = dur;

    update();
  }

  String _getChatCollectionPath(String teacherId, String studentId) {
    return 'chats/$teacherId/students/$studentId/messages';
  }

  Future<void> fetchMessages(String teacherId) async {
    // Show loading only on first fetch
    if (isFirstFetch.value) {
      isLoadingChat.value = true;
    }
    if (null != chatSubscription) {
      chatSubscription?.cancel();
    }

    final prefs = await SharedPreferences.getInstance();
    final String studentId = prefs.getString('breffini_student_id') ?? "0";
    final chatCollectionPath = _getChatCollectionPath(teacherId, studentId);

    print('Teacher ID: $teacherId, Student ID: $studentId');

    chatSubscription = _firestore
        .collection(chatCollectionPath)
        .orderBy('sentTime')
        .snapshots()
        .listen((snapshot) {
      if (!isFirstFetch.value) {
        notVisibleMsgCount.value =
            notVisibleMsgCount.value + snapshot.docChanges.length;
      } else {}
      scrollNow.value = true;

      final fetchedMessages = snapshot.docs.map((doc) {
        final data = doc.data();
        return ChatMessageModel.fromMap(data, doc.id);
      }).toList();

      messages.value = fetchedMessages;

      // Hide loading and update first fetch flag
      if (isFirstFetch.value) {
        isLoadingChat.value = false;
        isFirstFetch.value = false;
      }
    });
  }

  Future<void> sendMessage(String messageText, String teacherId,
      double localFileSize, String thumbUrl,
      {String filePath = ""}) async {
    final prefs = await SharedPreferences.getInstance();
    final String studentId = prefs.getString('breffini_student_id') ?? "0";
    final message = ChatMessageModel(
      studentId: studentId,
      userId: teacherId,
      chatMessage: messageText,
      sentTime: DateTime.now().toUtc(),
      isStudent: true,
      filePath: filePath,
      fileSize: localFileSize,
      thumbUrl: thumbUrl,
      senderName: PrefUtils().getStudentName(),
    );

    final chatCollectionPath = _getChatCollectionPath(teacherId, studentId);

    await _firestore.collection(chatCollectionPath).add(message.toMap());

    // // Refresh messages to include the new message
    // fetchMessages(
    //   teacherId,
    // );
  }

  Future<String> uploadFileAndSendMessage(String messageText, String teacherId,
      File selectedFile, String thumbUrl) async {
    final prefs = await SharedPreferences.getInstance();
    final String studentId = prefs.getString('breffini_student_id') ?? "0";
    String? uploadedFilePath = await AwsUpload.uploadChatImageToAws(
      selectedFile,
      studentId,
      teacherId,
      FileUtils.getFileExtension(selectedFile.path),
    );
    if (!thumbUrl.isNullOrEmpty()) {
      DefaultCacheManager().putFile(HttpUrls.imgBaseUrl + uploadedFilePath!,
          selectedFile.readAsBytesSync(),
          fileExtension: FileUtils.getFileExtension(selectedFile.path));
    }

    await sendMessage(messageText, teacherId,
        FileUtils.getFileSizeInKB(selectedFile.path) ?? 0.0, thumbUrl,
        filePath: uploadedFilePath!);

    return uploadedFilePath;
  }

  Future<void> updateLog(String messageText, String extraData) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    final prefs = await SharedPreferences.getInstance();
    final String studentId = prefs.getString('breffini_student_id') ?? "0";
    final message = {
      "studentId": studentId,
      "studentName": PrefUtils().getStudentName(),
      "errorMsg": messageText,
      "extraData": extraData,
      "time": DateTime.now().toString(),
      "modelName": androidInfo.model,
      "osVersion": androidInfo.version.release,
      'sdkInt': androidInfo.version.sdkInt.toString(), // API Level (e.g. 26)
      'manufacturer': androidInfo.manufacturer, // e.g. Samsung
    };

    await _firestore.collection("studentLog").add(message);
  }
}
