import 'dart:async';
import 'dart:convert';

import 'package:anandhu_s_application4/core/utils/FirebaseCallModel.dart';
import 'package:anandhu_s_application4/core/utils/common_utils.dart';
import 'package:anandhu_s_application4/core/utils/extentions.dart';
import 'package:anandhu_s_application4/core/utils/firebase_utils.dart';
import 'package:anandhu_s_application4/core/utils/meet_utils.dart';
import 'package:anandhu_s_application4/core/utils/notification_service.dart';
import 'package:anandhu_s_application4/core/utils/pref_utils.dart';
import 'package:anandhu_s_application4/http/http_request.dart';
import 'package:anandhu_s_application4/http/http_urls.dart';
import 'package:anandhu_s_application4/http/socket_io.dart';
import 'package:anandhu_s_application4/main.dart';
import 'package:anandhu_s_application4/presentation/android_large_5_page/incoming_call_page.dart';
import 'package:anandhu_s_application4/presentation/android_large_5_page/models/call_model.dart';
import 'package:anandhu_s_application4/presentation/android_large_5_page/models/current_call_model.dart';
import 'package:anandhu_s_application4/presentation/android_large_5_page/models/ongoing_call_model.dart';
import 'package:anandhu_s_application4/presentation/android_large_5_page/widgets/handle_call_widget.dart';
import 'package:anandhu_s_application4/presentation/chat_screen/models/student_chat_log_model.dart';
import 'package:anandhu_s_application4/presentation/exam_details_screen/live_call_screen.dart';
import 'package:anandhu_s_application4/presentation/exam_details_screen/models/live_class_joining_model.dart';
import 'package:anandhu_s_application4/presentation/home_page/controller/home_controller.dart';
import 'package:anandhu_s_application4/presentation/home_page/models/home_model.dart';
import 'package:anandhu_s_application4/widgets/google_meet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_callkit_incoming_yoer/entities/call_event.dart';
import 'package:flutter_callkit_incoming_yoer/flutter_callkit_incoming.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Zego import removed

CallandChatController getCallChatController() {
  if (!Get.isRegistered<CallandChatController>()) {
    Get.put(CallandChatController(), permanent: true);
  }
  return Get.find<CallandChatController>();
}

class CallandChatController extends GetxController {
  var callandChatList = <CallAndChatHistoryModel>[].obs;
  var studentChatLogList = <StudentChatLogModel>[].obs;
  // var onGoingCallsList = <OnGoingCallsModel>[].obs;
  var isLoading = false.obs;
  var searchableChatList = <StudentChatLogModel>[].obs;
  // var searchableCallList = <OnGoingCallsModel>[].obs;
  RxString audioCallFormatedTime = "00:00".obs;
  Rx<CurrentCallModel> currentCallModel = CurrentCallModel().obs;
  final HomeController homeController =
      Get.put<HomeController>(HomeController(HomeModel().obs));
  //call timer
  Timer? _timer;
  RxInt _start = 0.obs;
  StreamSubscription<CallEvent?>? _callEventSubscription;
  RxList<String> enteredUserList = <String>[].obs;
  DateTime? classStartTime;
  int totalDuration = 0;
  int currentStudentLiveClassId = 0; // Store the ID from first call

  //call timer
  void startTimer() {
    _timer?.cancel(); // Cancel any existing timer

    _start.value = 0; // Reset start time
    _updateTime(); // Update time immediately

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _start.value++;
      _updateTime();
    });
  }

  void stopTimer() {
    if (null != _timer) {
      _timer?.cancel();
    }
    _start.value = 0;
  }

  Future<void> startStudentLiveClass({
    required String liveClassId,
    required DateTime? startTime,
    required DateTime? endTime,
    required bool firstCall,
  }) async {
    if (!firstCall) {
      classStartTime = startTime;
      startTimer();
      print('Starting new class session at: $classStartTime');
    } else {
      stopTimer();
    }

    int attendanceDuration = 0;
    if (firstCall && classStartTime != null && endTime != null) {
      attendanceDuration = endTime.difference(classStartTime!).inSeconds;
    }
    final requestBody = {
      "StudentLiveClass_ID": firstCall ? currentStudentLiveClassId : 0,
      "Student_ID": PrefUtils().getStudentId(),
      "LiveClass_ID": liveClassId,
      "Start_Time":
          (!firstCall ? startTime : classStartTime)?.toIso8601String(),
      "End_Time": endTime?.toIso8601String(),
      "Attendance_Duration": attendanceDuration,
    };

    try {
      final value = await HttpRequest.httpPostBodyRequest(
        endPoint: HttpUrls.startStudentLiveClass,
        bodyData: requestBody,
      );

      if (value != null && value.data != null) {
        try {
          final List responseList = value.data;
          if (responseList.isNotEmpty && responseList.first is Map) {
            final extractedId = responseList.first['StudentLiveClass_ID'];
            if (extractedId is String) {
              currentStudentLiveClassId = int.tryParse(extractedId) ?? 0;
            } else if (extractedId is int) {
              currentStudentLiveClassId = extractedId;
            } else {
              throw Exception('Unexpected type for StudentLiveClass_ID');
            }

            print('Stored StudentLiveClass_ID: $currentStudentLiveClassId');

            // Show success message
            Get.showSnackbar(GetSnackBar(
              message: firstCall
                  ? 'Class ended successfully'
                  : 'Joined class successfully',
              duration: Duration(milliseconds: 800),
            ));
          } else {
            throw Exception('Unexpected response format');
          }
        } catch (error) {
          print('Error extracting StudentLiveClass_ID: $error');
          Get.showSnackbar(GetSnackBar(
            message: 'Failed to process response',
            duration: Duration(milliseconds: 800),
          ));
        }
      } else {
        // Handle invalid response
        print('Invalid API response: $value');
        Get.showSnackbar(GetSnackBar(
          message: 'Invalid Request',
          duration: Duration(milliseconds: 800),
        ));
      }
    } catch (error) {
      print('Live Class API Error: $error');
      Get.showSnackbar(GetSnackBar(
        message: 'Error: ${error.toString()}',
        duration: Duration(milliseconds: 800),
      ));
    }
  }

  // Future<void> getChatAndCallHistory(String type, String sender) async {
  //   try {
  //     isLoading.value = true;
  //     final prefs = await SharedPreferences.getInstance();
  //     final String studentId = prefs.getString('breffini_student_id') ?? "0";
  //
  //     final response = await HttpRequest.httpGetRequest(
  //       endPoint:
  //           '${HttpUrls.chatCallModel}?type=$type&sender=$sender&studentId=$studentId',
  //     );
  //
  //     if (response!.statusCode == 200) {
  //       final responseData = response.data;
  //       if (responseData is List<dynamic>) {
  //         callandChatList.value = responseData
  //             .map((result) => CallAndChatHistoryModel.fromJson(result))
  //             .toList();
  //       } else if (responseData is Map<String, dynamic>) {
  //         callandChatList.value = [responseData]
  //             .map((result) => CallAndChatHistoryModel.fromJson(result))
  //             .toList();
  //       } else {
  //         throw Exception('Unexpected response data format');
  //       }
  //     } else {
  //       throw Exception(
  //           'Failed to load chat and call data: ${response.statusCode}');
  //     }
  //   } catch (error) {
  //     print('Error fetching chat and call history: $error');
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  Future<void> getStudentChatLog() async {
    try {
      print('object fgdf');
      isLoading.value = true;
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String studentId = preferences.getString('breffini_student_id') ?? '';

      final response = await HttpRequest.httpGetRequest(
        endPoint: '${HttpUrls.getStudentChatLog}$studentId',
      );

      if (response != null) {
        List data = response.data;
        // studentChatLogList.value =
        //     data.map((e) => StudentChatLogModel.fromJson(e)).toList();
        // searchableChatList.value = studentChatLogList;
        print('On Search $studentChatLogList');
        print('On Search $searchableChatList');
      } else {
        throw Exception('No response data received');
      }
    } catch (error) {
      print('Error fetching student chat log: $error');
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<OnGoingCallsModel>> getOngoingCallsApi(String callId) async {
    List<OnGoingCallsModel> callList = [];
    try {
      var data = {
        "isOnAnotherCall": false,
        "callId": callId,
        "isStudent": 1,
      };
      final response = await HttpRequest.httpPostBodyRequest(
        bodyData: data,
        endPoint: '${HttpUrls.getOngoingCalls}',
      );

      if (response?.statusCode == 200) {
        final responseData = response!.data as List<dynamic>;
        callList = responseData
            .map((result) => OnGoingCallsModel.fromJson(result))
            .toList();
      } else {
        // throw Exception(
        //     'Failed to load ongoing calls data: ${response?.statusCode}');
      }
    } catch (error) {
    } finally {}
    return callList;
  }

  Future<void> getOngoingCalls() async {
    try {
      isLoading.value = true;

      // Emit the socket event to request ongoing calls
      ChatSocket.emitOngoingCalls();

      // Listen for incoming ongoing call data
      ChatSocket.listenOngoingCalls();

      print('Listening for ongoing calls...');
    } catch (error) {
      print('Error fetching ongoing calls: $error');
    } finally {}
  }

  void searchMentors({required bool isChat, required String query}) {
    if (query.isNotEmpty) {
      if (isChat) {
        studentChatLogList.value = searchableChatList
            .where((e) =>
                e.firstName.toLowerCase().contains(query.toLowerCase()) ||
                e.lastName.toLowerCase().contains(query.toLowerCase()))
            .toList();
      } else {
        // onGoingCallsList.value = searchableCallList
        //     .where(
        //         (e) => e.callerName.toLowerCase().contains(query.toLowerCase()))
        //     .toList();
      }
    } else {
      if (isChat) {
        studentChatLogList.value = searchableChatList;
      } else {
        // onGoingCallsList.value = searchableCallList;
      }
    }
    update();
  }

  void _updateTime() {
    int minutes = (_start.value ~/ 60);
    int seconds = (_start.value % 60);
    audioCallFormatedTime.value =
        '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    showCallNotification(
        audioCallFormatedTime.value, currentCallModel.value.isVideo ?? false);
  }

  Future<void> disconnectCall(
      bool clearNotification, bool isReject, String teacherId, String callId,
      {String newCallerId = ""}) async {
    int totalDuration = _start.value;

    enteredUserList.clear();
    if (!newCallerId.isNullOrEmpty() &&
        newCallerId == currentCallModel.value.callerId) {
      safeBack();
    } else {
      FirebaseUtils.deleteCall(teacherId, "incoming screen");
    }
    // added clearing currentcallmodel befor api call to ensure call localy disconnected successfully
    currentCallModel.value = CurrentCallModel();
    // Zego uninit removed
    if (!callId.isNullOrEmpty()) {
      await Get.put(CallandChatController())
          .stopCall(teacherId, callId, totalDuration, isRejectCall: isReject);
    }

    // currentCallId.value = 0;
    audioCallFormatedTime.value = "00:00";
    // currentCallerName.value = "";
    // currentCallerId.value = "";
    stopTimer();

    if (clearNotification) {
      cancelNotification();
      // AwesomeNotifications().cancel(0);
    }
  }

  stopCall(String teacherId, String callId, int totalDuration,
      {bool isRejectCall = false}) async {
    // final prefs = await SharedPreferences.getInstance();
    // final String liveId = prefs.getString('id') ?? "0";

    // DateTime now = DateTime.now();

    Map<String, dynamic> jsonData = {
      "id": callId,
      "teacher_id": teacherId,
      "student_id": PrefUtils().getStudentId(),
      "call_start": null,
      "call_end": DateTime.now().toString(),
      "call_duration": totalDuration.toString(),
      "call_type": null,
      "Is_Student_Called": 1,
      "Live_Link": null,
      "is_call_rejected": isRejectCall,
    };
    await HttpRequest.httpPostBodyRequest(
      bodyData: jsonData,
      endPoint: HttpUrls.saveStudentCall,
    ).then((response) {
      if (response != null) {
        print(response);
        print("Successful");
      } else {
        print(response);
        print("Not Successful");
      }
    });

    update();
  }

  void showCallNotification(String timer, bool isVideoCall) async {
    // Show a notification to the user
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            'audio_call_channel', isVideoCall ? "Video Call" : 'Audio Call',
            channelDescription:
                'Ongoing ' + (isVideoCall ? "video" : "voice") + ' call ',
            // importance: Importance.max,
            // priority: Priority.high,
            autoCancel: false,
            ongoing: true,
            silent: true,
            showWhen: false,
            category: AndroidNotificationCategory.call,
            enableVibration: timer == "",
            chronometerCountDown: false);

    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Ongoing ' + (isVideoCall ? "video call " : 'voice call ') + timer,
      'Tap to return to the call',
      platformChannelSpecifics,
      payload: jsonEncode(currentCallModel.value
          .toMap()), // Pass roomID as payload to restore call
    );
  }

  Future<void> cancelNotification() async {
    await flutterLocalNotificationsPlugin
        .cancel(0); // Cancel notification with ID 0
  }

  // initNotification(
  //     String liveLink,int teacherId,String callId,bool isVideo,String profileImageUrl,
  //     String teacherName) async {
  //   var androidInitializationSettings =
  //   const AndroidInitializationSettings('@mipmap/ic_launcher');
  //   var iosInitializationSettings = const DarwinInitializationSettings();
  //
  //   var initializationSetting = InitializationSettings(
  //       android: androidInitializationSettings, iOS: iosInitializationSettings);
  //
  //   await flutterLocalNotificationsPlugin.initialize(initializationSetting,
  //       onDidReceiveNotificationResponse: (response) {
  //         Map<String, dynamic> payLoad = {};
  //         // if (!response.payload.isNullOrEmpty()) {
  //         //   payLoad = jsonDecode(response.payload!);
  //         // }
  //         // handleNotificationClick(payLoad);
  //         print("onBackgroundMessage: ");
  //         // handle interaction when app is active for android
  //         // handleMessage(message,context);
  //         String type=payLoad["type"];
  //         if(type=="new_call"){
  //         if (!Get.currentRoute.isNullOrEmpty() &&
  //             Get.currentRoute != "/IncomingCallPage") {
  //           Navigator.push(
  //             navigatorKey.currentContext!,
  //             MaterialPageRoute(
  //                 builder: (context) => IncomingCallPage(
  //                   liveLink: liveLink,
  //                   teacherId: teacherId,
  //                   callId: callId,
  //                   video: isVideo,
  //                   // isIncomingCall: true,
  //                   profileImageUrl: profileImageUrl,
  //                   teacherName: teacherName,
  //                 )),
  //           );
  //         }
  //         }
  //       }
  //       );
  // }

  listenIncomingCallNotification() async {
    // List<dynamic> activeCalls = await FlutterCallkitIncoming.activeCalls();

    // if(null!=_callEventSubscription){
    //   _callEventSubscription?.cancel();
    // }
    // bool hasAcceptedCall = activeCalls.any((call) => call["accepted"] == true);
    // if(!hasAcceptedCall) {
    FlutterCallkitIncoming.onEvent.listen((CallEvent? event) async {
      var payload = event?.body["extra"];
      switch (event!.event) {
        case Event.actionCallIncoming:
          // TODO: received an incoming call
          break;
        case Event.actionCallStart:
          // TODO: started an outgoing call
          // TODO: show screen calling in Flutter
          break;
        case Event.actionCallAccept:
          SchedulerBinding.instance.addPostFrameCallback((_) async {
            String liveLink = payload!['Live_Link'] ?? '';
            print(liveLink + "live link+accept");
            String callId = payload!['id'] ?? '';

            if (!liveLink.isNullOrEmpty()) {
              String type = payload!['type'] ?? '';
              if (type == "new_live") {
                String profileImgUrl = payload!.containsKey("Profile_Photo_Img")
                    ? payload!['Profile_Photo_Img'] ?? ""
                    : "";
                String callerName = payload.containsKey("Teacher_Name")
                    ? payload['Teacher_Name']
                    : "";
                String teacherId = payload!['Teacher_Id'] ?? "0";

                CallandChatController callChatController = Get.find();
                if (!callChatController.currentCallModel.value.callId
                    .isNullOrEmpty()) {
                  if (null != callChatController.currentCallModel.value.type &&
                      callChatController.currentCallModel.value.type ==
                          "new_call") {
                    // disconnect old call and join new call
                    await callChatController.disconnectCall(
                        true,
                        false,
                        callChatController.currentCallModel.value.callerId
                            .toString(),
                        callChatController.currentCallModel.value.callId ?? "");
                  }
                }

                await Future.delayed(const Duration(seconds: 1), () {
                  // Get.to(() => LiveCallScreen(
                  //       liveLink: liveLink,
                  //       callId: int.parse(callId),
                  //       teacherId: teacherId,
                  //       // isIncomingCall: true,
                  //       profileImageUrl: profileImgUrl,
                  //       teacherName: callerName,
                  //     ));
                });
              } else {
                String callId = payload!['id'] ?? '';
                String callType = payload!['call_type'] ?? '';
                int callerId = int.parse(payload!['teacher_id'] ?? "0");
                String profileImgUrl = payload!.containsKey("profile_url")
                    ? payload!['profile_url'] ?? ""
                    : "";
                String callerName = payload!.containsKey("teacher_name")
                    ? payload!['teacher_name'] ?? ""
                    : "";
                // String callId = payload!['id'] ?? '';
                // String callType = payload!['call_type'] ?? '';
                // int callerId = int.parse(payload!['sender_id'] ?? "0");
                // String profileImgUrl = payload!.containsKey("Profile_Photo_Img")
                //     ? payload!['Profile_Photo_Img'] ?? ""
                //     : "";
                // String callerName = payload!.containsKey("Caller_Name")
                //     ? payload!['Caller_Name'] ?? ""
                //     : "";
                //
                // if (Get.previousRoute.isNullOrEmpty()) {
                //   print("null //////////////////////");
                // } else {
                //   print("not null //////////////////////");
                // }
                CallandChatController callChatController = Get.find();
                if (!callChatController.currentCallModel.value.callId
                        .isNullOrEmpty() &&
                    callChatController.currentCallModel.value.type ==
                        "new_call") {
                  // disconnect old call and join new call
                  await callChatController.disconnectCall(
                      true,
                      false,
                      callChatController.currentCallModel.value.callerId
                          .toString(),
                      callChatController.currentCallModel.value.callId
                          .toString(),
                      newCallerId: callerId.toString());
                } else {
                  if (null != callChatController.currentCallModel.value.type &&
                      callChatController.currentCallModel.value.type ==
                          "new_live") {
                    // if (null != navigatorKey.currentState) {
                    //   // await ZegoUIKitPrebuiltCallController()
                    //   //     .hangUp(navigatorKey.currentState!.context);
                    // }

                    // if (ZegoUIKitPrebuiltCallController()
                    //     .minimize
                    //     .isMinimizing) {
                    //   ZegoUIKitPrebuiltCallController().minimize.hide();
                    // }
                  }
                }
                await handleTeacherCall(
                    teacherId: callerId.toString(),
                    teacherName: callerName,
                    callId: callId,
                    isVideo: true,
                    profileImageUrl: profileImgUrl,
                    liveLink: liveLink,
                    homeController: homeController,
                    callandChatController: getCallChatController(),
                    safeBack: safeBack,
                    isIncomingCall: true);
                update();

                await Future.delayed(const Duration(seconds: 1), () {
                  MeetCallTracker(
                    onCallEnded: () {},
                  ).startMeetCall(meetCode: liveLink);

                  // Get.to(() => IncomingCallPage(
                  //       liveLink: liveLink,
                  //       callId: callId,
                  //       video: callType == 'Video',
                  //       teacherId: callerId,
                  //       // isIncomingCall: true,
                  //       profileImageUrl: profileImgUrl,
                  //       teacherName: callerName,
                  //     ));
                });
              }
            }
          });
          break;
        case Event.actionCallDecline:
          String liveLink = payload!['Live_Link'] ?? '';

          print(liveLink + "live link");
          if (!liveLink.isNullOrEmpty()) {
            String type = payload!['type'] ?? '';
            if (type == "new_call") {
              String callId = payload!['id'] ?? '';
              // String callType=receivedAction.payload!['call_type']??'';
              // int callerId = int.parse(payload!['sender_id'] ?? "0");
              int callerId = int.parse(payload!['teacher_id'] ?? "0");

              FirebaseUtils.deleteCall(callerId.toString(), "reject");

              Get.put(CallandChatController())
                  .stopCall(callerId.toString(), callId, 0, isRejectCall: true);
            }
          }
          break;
        case Event.actionCallEnded:
          // TODO: ended an incoming/outgoing call
          break;
        case Event.actionCallTimeout:
          // TODO: missed an incoming call
          break;
        case Event.actionCallCallback:
          // TODO: only Android - click action `Call back` from missed call notification
          break;
        case Event.actionCallToggleHold:
          // TODO: only iOS
          break;
        case Event.actionCallToggleMute:
          // TODO: only iOS
          break;
        case Event.actionCallToggleDmtf:
          // TODO: only iOS
          break;
        case Event.actionCallToggleGroup:
          // TODO: only iOS
          break;
        case Event.actionCallToggleAudioSession:
          // TODO: only iOS
          break;
        case Event.actionDidUpdateDevicePushTokenVoip:
          // TODO: only iOS
          break;
        case Event.actionCallCustom:
          // TODO: for custom action
          break;
      }
    });
    // }
  }
}
