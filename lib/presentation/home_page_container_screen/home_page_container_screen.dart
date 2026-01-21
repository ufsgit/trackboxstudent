import 'dart:convert';
import 'dart:io';

import 'package:anandhu_s_application4/core/utils/common_utils.dart';
import 'package:anandhu_s_application4/core/utils/extentions.dart';
import 'package:anandhu_s_application4/core/utils/file_utils.dart';
import 'package:anandhu_s_application4/core/utils/firebase_utils.dart';
import 'package:anandhu_s_application4/core/utils/meet_utils.dart';
import 'package:anandhu_s_application4/core/utils/native_utils.dart';
import 'package:anandhu_s_application4/core/utils/new_version_plus.dart';
import 'package:anandhu_s_application4/core/utils/notification_service.dart';
import 'package:anandhu_s_application4/http/socket_io.dart';
import 'package:anandhu_s_application4/main.dart';
import 'package:anandhu_s_application4/presentation/android_large_5_page/call_log_screen.dart';
import 'package:anandhu_s_application4/presentation/android_large_5_page/controller/call_chat_controller.dart';
import 'package:anandhu_s_application4/presentation/android_large_5_page/incoming_call_page.dart';
import 'package:anandhu_s_application4/presentation/android_large_5_page/models/current_call_model.dart';
import 'package:anandhu_s_application4/presentation/android_large_5_page/models/ongoing_call_model.dart';
import 'package:anandhu_s_application4/presentation/android_large_5_page/widgets/handle_call_widget.dart';
import 'package:anandhu_s_application4/presentation/chat_screen/chat_firebase_screen.dart';
import 'package:anandhu_s_application4/presentation/chat_screen/controller/chat_firebase_controller.dart';
import 'package:anandhu_s_application4/presentation/exam_details_screen/live_call_screen.dart';
import 'package:anandhu_s_application4/presentation/home_page/controller/home_controller.dart';
import 'package:anandhu_s_application4/presentation/home_page/models/home_model.dart';
import 'package:anandhu_s_application4/presentation/home_page/teacher_list_page.dart';
import 'package:anandhu_s_application4/presentation/profile/student_profile_screen.dart';

import 'package:anandhu_s_application4/widgets/google_meet.dart';
import 'package:anandhu_s_application4/widgets/no_internet_widget.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' as scheduler;
import 'package:flutter/services.dart';
import 'package:flutter_callkit_incoming_yoer/flutter_callkit_incoming.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../android_large_5_page/android_large_5_page.dart';
import '../home_page/home_page.dart';
import '../my_courses_page/my_courses_page.dart';

import 'package:anandhu_s_application4/testpage/mainexamstapbar.dart';
import 'controller/home_page_container_controller.dart'; // ignore_for_file: must_be_immutable

class HomePageContainerScreen extends StatefulWidget {
  const HomePageContainerScreen({Key? key}) : super(key: key);

  @override
  State<HomePageContainerScreen> createState() =>
      _HomePageContainerScreenState();
}

class _HomePageContainerScreenState extends State<HomePageContainerScreen> {
  final HomePageContainerController controller =
      Get.find<HomePageContainerController>();
  final CallandChatController callandChatController =
      Get.put(CallandChatController());
  final HomeController homeController =
      Get.put<HomeController>(HomeController(HomeModel().obs));

  @override
  void initState() {
    super.initState();
    _initializePage();
    // checkUpdate();
    // clearOldCallsFromFirebase();
    // subscribeToFirebaseTopic();
    scheduler.SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (Platform.isAndroid) {
        await NativeUtils.requestFullScreenIntentPermission();
        await Future.delayed(const Duration(seconds: 3), () async {
          await NativeUtils.requestBatteryOptimization();
        });
      }

      // NativeUtils.initFirebaseCleanup();

      getInitialData();
      initLocalNotification();

      // _initAppLinks();
    });
  }

  checkUpdate() async {
    final newVersion = NewVersionPlus();
    var status = await newVersion.getVersionStatus();
    if (status!.canUpdate) {
      showUpdateDialog(
          context: context, versionStatus: status, allowDismissal: true);
    }
  }

  getInitialData() {
    ChatSocket.emitOngoingCalls(); // used to listen calls when first login...
    FirebaseUtils.listenCalls();

    listenCalls();
  }
  // Future<void> _initAppLinks() async {
  //   // Handle app links while the app is already running
  //   appLinks.uriLinkStream.listen((Uri? uri) {
  //     if (uri != null) {
  //       // _handleDeepLink(uri);
  //     }
  //   });
  //
  //   // Handle initial URI - app was opened from a link
  //   // try {
  //   //   final initialUri = await appLinks.getInitialLink();
  //   //   if (initialUri != null) {
  //   //     // _handleDeepLink(initialUri);
  //   //   }
  //   // } catch (e) {
  //   //   print('Error handling initial deep link: $e');
  //   // }
  // }
  // clearOldCallsFromFirebase() async {//this function must be called before  FirebaseUtils.listenCalls()
  //   // deleting calls which is started from teacher and teacher not ended or app closed (which is not delete from firebase )
  //
  //   var calls = await FlutterCallkitIncoming.activeCalls();
  //
  //
  //
  //   // Check if there are no calls or if none of the calls are accepted
  //   if (calls is List && calls.isNotEmpty ) {
  //     // bool hasAcceptedCall = calls.any((call) => call["accepted"] == true);
  //     for (var call in calls) {
  //
  //       if(!call["accepted"]){
  //         var payload = calls[0]["extra"];
  //         String callId = payload!['id'] ?? '';
  //
  //         // await FirebaseUtils.deleteCall(callId);
  //
  //       }
  //     }
  //
  //   } else {
  //     // If there are no calls, delete all inactive calls
  //     // await FirebaseUtils.deleteStudentInactiveCalls();
  //   }
  //   Get.put(CallandChatController()).listenIncomingCallNotification();
  //
  //
  // }
  //

  // to handle call notification
  listenCalls() async {
    // List<OnGoingCallsModel> callList=await Get.find<CallandChatController>().getOngoingCallsApi("");
    getCurrentCall();
    // await Get.put(CallandChatController()).getOngoingCalls();
    ChatSocket().listenCurrentCall((status, callId) {
      if (status) {
        // ChatSocket().removeCallStatusListener();
        if (mounted) {
          FlutterCallkitIncoming.endAllCalls();
          // if (Get.currentRoute == "/IncomingCallPage") {
          //   safeBack();
          //   Get.showSnackbar(const GetSnackBar(
          //     message: 'Call Rejected',
          //     duration: Duration(milliseconds: 2000),
          //   ));
          // } else {
          // FlutterCallkitIncoming.endAllCalls();
          // }
        }
      }
    });
  }

  Future getCurrentCall() async {
    //check current call from pushkit if possible
    var calls = await FlutterCallkitIncoming.activeCalls();
    if (calls is List) {
      if (calls.isNotEmpty) {
        print('DATA: $calls');
        // _currentUuid = calls[0]['id'];
        if (calls[0].length > 0) {
          bool isAccepted = calls[0]["accepted"];
          var payload = calls[0]["extra"];
          String callId = payload!['id'] ?? '';
          String type = payload!['type'] ?? '';
          if (isAccepted) {
            String liveLink = payload!['Live_Link'] ?? '';

            if (type == "new_live") {
              String profileImgUrl = payload!.containsKey("Profile_Photo_Img")
                  ? payload!['Profile_Photo_Img'] ?? ""
                  : "";
              String callerName = payload.containsKey("Teacher_Name")
                  ? payload['Teacher_Name']
                  : "";
              String teacherId = payload!['Teacher_Id'] ?? "0";
              // Get.to(() => LiveCallScreen(
              //       liveLink: liveLink,
              //       callId: int.parse(callId),
              //       teacherId: teacherId,
              //       // isIncomingCall: true,
              //       profileImageUrl: profileImgUrl,
              //       teacherName: callerName,
              //     ));
            } else {
              int teacherId = int.parse(payload!['teacher_id'] ?? "0");

              if (await FirebaseUtils.checkIfCallExists(
                  teacherId.toString(), callId)) {
                if (!liveLink.isNullOrEmpty()) {
                  // String callType = payload!['call_type'] ?? '';
                  // int callerId = int.parse(payload!['sender_id'] ?? "0");
                  // String profileImgUrl = payload!.containsKey(
                  //     "Profile_Photo_Img")
                  //     ? payload!['Profile_Photo_Img'] ?? ""
                  //     : "";
                  // String callerName = payload!.containsKey("Caller_Name")
                  //     ? payload!['Caller_Name'] ?? ""
                  //     : "";
                  String callId = payload!['id'] ?? '';
                  String callType = payload!['call_type'] ?? '';
                  String profileImgUrl = payload!.containsKey("profile_url")
                      ? payload!['profile_url'] ?? ""
                      : "";
                  String callerName = payload!.containsKey("teacher_name")
                      ? payload!['teacher_name'] ?? ""
                      : "";

                  await handleTeacherCall(
                      teacherId: teacherId.toString(),
                      teacherName: callerName,
                      callId: callId,
                      isVideo: true,
                      profileImageUrl: profileImgUrl,
                      liveLink: liveLink,
                      homeController: homeController,
                      callandChatController: callandChatController,
                      safeBack: safeBack,
                      isIncomingCall: true);
                  setState(() {});

                  MeetCallTracker(
                    onCallEnded: () {},
                  ).startMeetCall(meetCode: liveLink);

                  // Get.to(() => IncomingCallPage(
                  //       liveLink: liveLink,
                  //       callId: callId,
                  //       video: callType == 'Video',
                  //       teacherId: teacherId,
                  //       // isIncomingCall: true,
                  //       profileImageUrl: profileImgUrl,
                  //       teacherName: callerName,
                  //     ));
                }
              }
            }
          }
        }
      } else {
        // _currentUuid = "";
      }
    }
  }

  void _initializePage() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        final args = Get.arguments;
        if (args != null) {
          if (args['showSpecialPage'] == true) {
            controller.setTemporaryPage(AppRoutes.androidLarge5Page);

            int? selectedTabIndex = args['selectedTabIndex'];
            if (selectedTabIndex != null) {
              controller.updateTabIndex(selectedTabIndex);
            }
          } else {
            controller.setTemporaryPage(AppRoutes.homePage);
          }
        } else {
          controller.setTemporaryPage(AppRoutes.homePage);
        }
      } catch (e, stackTrace) {
        print('Error occurred during page initialization: $e');
        print('Stack trace: $stackTrace');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (controller.currentPage.value == AppRoutes.homePage) {
          await _showExitConfirmationDialog();
        } else {
          controller.setTemporaryPage(AppRoutes.homePage);
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: Obx(() {
            return NoInternetScreen(
              onConnected: () {
                getInitialData();
              },
              child: Column(
                children: [
                  if (!callandChatController.currentCallModel.value.callId
                          .isNullOrEmpty() &&
                      callandChatController.audioCallFormatedTime.value !=
                          "00:00")
                    Container(
                        height: 70.h,
                        margin: const EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () async {
                                ZegoUIKit().turnMicrophoneOn(!ZegoUIKit()
                                    .getMicrophoneStateNotifier(
                                        ZegoUIKit().getLocalUser().id)
                                    .value);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      ZegoUIKit()
                                              .getMicrophoneStateNotifier(
                                                  ZegoUIKit().getLocalUser().id)
                                              .value
                                          ? Icons.mic
                                          : Icons.mic_off,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                // ZegoUIKitPrebuiltCallController()
                                //     .minimize
                                //     .restore(context);
                                // Get.to(
                                //   () => IncomingCallPage(
                                //     liveLink: callandChatController
                                //         .currentCallModel.value.liveLink!,
                                //     callId: callandChatController
                                //         .currentCallModel.value.callId!,
                                //     teacherId: int.parse(callandChatController
                                //         .currentCallModel.value.callerId!),
                                //     video: callandChatController
                                //         .currentCallModel.value.isVideo!,
                                //     profileImageUrl: callandChatController
                                //         .currentCallModel.value.profileImg!,
                                //     teacherName: callandChatController
                                //         .currentCallModel.value.callerName!,
                                //   ),
                                // );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.call,
                                      color: Colors.green,
                                    ),
                                  ),
                                  Text(
                                    callandChatController.currentCallModel.value
                                            .callerName! +
                                        "   " +
                                        callandChatController
                                            .audioCallFormatedTime.value,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.plusJakartaSans(
                                      color: Colors.green,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                await ZegoUIKit().leaveRoom();
                                CallandChatController callChatController =
                                    Get.find();
                                callChatController.disconnectCall(
                                    true,
                                    false,
                                    callChatController
                                        .currentCallModel.value.callerId!,
                                    callChatController
                                            .currentCallModel.value.callId ??
                                        "");
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.call_end,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )),
                  Expanded(child: getCurrentPage(controller.currentPage.value)),
                ],
              ),
            );
          }),
          bottomNavigationBar: _buildBottomNavigationBar(),
        ),
      ),
    );
  }

  Future<void> initLocalNotification() async {
    AndroidNotificationChannel? channel;

    var androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSettings = const DarwinInitializationSettings();

    var initializationSetting = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);

    await flutterLocalNotificationsPlugin.initialize(initializationSetting,
        onDidReceiveNotificationResponse: (response) {
      Map<String, dynamic> payLoad = {};
      if (!response.payload.isNullOrEmpty()) {
        payLoad = jsonDecode(response.payload!);
        handleNotificationClick(payLoad);
      }
      print("onBackgroundMessage: ");
      // handle interaction when app is active for android
      // handleMessage(message,context);
    });
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        description:
            'This channel is used for important notifications.', // description
        importance: Importance.max,
      );
    }
    if (Platform.isIOS) {
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel!);

    if (!kIsWeb) {
      firebaseMessaging.subscribeToTopic("STD-" + PrefUtils().getStudentId());
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showFlutterNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Map<String, dynamic> data = message.data;
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      AppleNotification? apple = message.notification?.apple;
      String imgUrl = "";

      if (notification != null) {
        if (null != android && !android.imageUrl.isNullOrEmpty()) {
          imgUrl = android.imageUrl ?? "";
        }
        if (null != apple && !apple.imageUrl.isNullOrEmpty()) {
          imgUrl = apple.imageUrl ?? "";
        }
        Map<String, dynamic> newData1 = {
          'body': notification.body,
          'title': notification.title,
          'imageUrl': imgUrl,
        };
        data.addAll(newData1);
        handleNotificationClick(data);
      }
    });
    //This method will call when the app is in kill state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      RemoteNotification? notification = message?.notification;
      AndroidNotification? android = message?.notification?.android;
      AppleNotification? apple = message?.notification?.apple;
      String imgUrl = "";

      if (notification != null) {
        if (null != android && !android.imageUrl.isNullOrEmpty()) {
          imgUrl = android.imageUrl ?? "";
        }
        if (null != apple && !apple.imageUrl.isNullOrEmpty()) {
          imgUrl = apple.imageUrl ?? "";
        }
        Map<String, dynamic> data = message!.data;
        Map<String, dynamic> newData1 = {
          'body': notification.body,
          'title': notification.title,
          'imageUrl': imgUrl,
        };
        data.addAll(newData1);
        handleNotificationClick(data);
      }
    });
  }

  Future<void> showFlutterNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    AppleNotification? apple = message.notification?.apple;
    String imgUrl = "";
    if (message.data.isNotEmpty) {
      // Convert message.data from Map<String, dynamic> to Map<String, String?>
      final Map<String, String?> payload =
          message.data.map((key, value) => MapEntry(key, value.toString()));

      // Determine the channel key based on the payload
      String channelKey = ""; // Default channel

      if (payload['type'] == 'new_call') {
        channelKey = 'call_channel'; // Use the call channel
      } else if (payload['type'] == 'new_live') {
        channelKey = 'live_channel'; // Use the call channel
      } else {
        channelKey = 'message_channel'; // Use the message channel
      }
      String liveLink = message.data.containsKey("Live_Link")
          ? message.data['Live_Link']
          : "";
      int id = message.data.containsKey("id")
          ? int.parse(message.data['id'])
          : message.hashCode;

      // hide already started cales
      String profileImgUrl = message.data.containsKey("Profile_Photo_Img")
          ? message.data['Profile_Photo_Img']
          : "";
      String callId = message.data.containsKey("id") ? message.data['id'] : "";

      // if (channelKey == "call_channel") {
      //   String callerName = message.data.containsKey("Caller_Name")
      //       ? message.data['Caller_Name']
      //       : "";
      //   String callType = message.data.containsKey("call_type")
      //       ? message.data['call_type']
      //       : "";
      //
      //     if (Get.currentRoute != "/IncomingCallPage") {
      //       //checking notification call id is current call id in server.(to handle delayed notification showing call screen)
      //       List<OnGoingCallsModel> callList =
      //       await Get.find<CallandChatController>().getOngoingCallsApi(callId);
      //
      //     if (callList.isNotEmpty && callList[0].id.toString() == callId) {
      //       if (!callId.isNullOrEmpty()) {
      //         // to handle duplicate notification
      //         var calls = await FlutterCallkitIncoming.activeCalls();
      //         if (calls is List && calls.isNotEmpty && calls.isNotEmpty) {
      //           if (!calls.any((value) => value["id"].toString() == callId)) {
      //             showCallkitIncoming(callId, callerName, profileImgUrl,
      //                 callType, message.data);
      //             return; // to hide default notification
      //           }
      //         } else {
      //           showCallkitIncoming(
      //               callId, callerName, profileImgUrl, callType, message.data);
      //           return; // to hide default notification
      //         }
      //       }
      //     } else {
      //       // remove all calls when no current call at server
      //       await FlutterCallkitIncoming.endAllCalls();
      //     }
      //   }
      // } else
      if (channelKey == "live_channel") {
        String callerName = message.data.containsKey("Teacher_Name")
            ? message.data['Teacher_Name']
            : "";

        bool isLiveStart = (message.data.containsKey("status")
                ? message.data['status']
                : "0") ==
            "0";

        if (isLiveStart && Get.currentRoute != "/VideoScreen") {
          showCallkitIncoming(
              callId, callerName, profileImgUrl, "Video", message.data, false,
              sessionType: "Live");
        }
        // handling missed live class (case when teacher start live class and end live
        // ...if user side is ring ing call then hide call ringing)
        if (!isLiveStart) {
          String callId =
              message.data.containsKey("id") ? message.data['id'] : "";
          await FlutterCallkitIncoming.endCall(callId);
        }
      }
      // }
      else {
        Map<String, dynamic> data = message.data;
        Map<String, dynamic> newData1 = {
          'body': notification?.body,
          'title': notification?.title,
          'imageUrl': imgUrl,
        };
        data.addAll(newData1);
        if (payload['type'] != 'new_call') {
          // showing notification and ring then ringing go behind notification fix
          flutterLocalNotificationsPlugin
              .show(
            payload: jsonEncode(data),
            notification.hashCode,
            notification?.title,
            notification?.body,
            NotificationDetails(
              iOS:
                  // filename.isNullOrEmpty()?
                  null,
              //     :
              // DarwinNotificationDetails(
              //   presentAlert: true,
              //   presentBadge: true,
              //   presentSound: true,
              //   attachments: [
              //     DarwinNotificationAttachment(filename)
              //   ],
              // ),
              android: AndroidNotificationDetails(
                "high_importance_channel", channelKey,
                // channelDescription: channel!.description,
                importance: Importance.max,
                priority: Priority.high,
                fullScreenIntent: true, onlyAlertOnce: true,
                autoCancel:
                    true, //cause message always showing when chat msg arrives
                ongoing: false, silent: false, enableVibration: false,
                category: AndroidNotificationCategory.message,
                visibility: NotificationVisibility.public,
                // Use this instead of categoryIdentifier

                // additionalFlags: Int32List.fromList([
                //   4, // FLAG_HIGH_PRIORITY
                //   8, // FLAG_AUTO_CANCEL
                //   16, // FLAG_LOCAL_ONLY
                //   32, // FLAG_DEFAULT_LIGHTS
                //   64, // FLAG_DEFAULT_SOUND
                //   128 // FLAG_DEFAULT_VIBRATE
                // ]),
                // styleInformation: styleInformation
              ),
            ),
          )
              .then((value) {
            // if(File(filename).existsSync()){
            //   File(filename).delete();
            // }
          });
        }
        // AwesomeNotifications().createNotification(
        //   actionButtons: channelKey == "call_channel" ? [
        //     NotificationActionButton(
        //         key: 'reject_btn', label: 'Reject', color: Colors.red),
        //     NotificationActionButton(
        //         key: 'accept_btn', label: 'Accept', color: Colors.green),
        //   ] : [],
        //   content: NotificationContent(
        //     id: id,
        //     channelKey: channelKey,
        //     title: message.notification?.title,
        //     body: message.notification?.body,
        //     payload: payload,
        //     largeIcon: HttpUrls.imgBaseUrl + profileImgUrl,
        //     roundedLargeIcon: true,wakeUpScreen: true,
        //
        //   ),
        // );
      }

      if (channelKey == "call_channel") {
        // AwesomeNotifications().cancel(id);
      }
    }
  }

  handleNotificationClick(Map<String, dynamic> payLoad) async {
    String type = payLoad.containsKey("type") ? payLoad['type'] : "";
    if (type == "new_message") {
      if (!callandChatController.currentCallModel.value.callId
          .isNullOrEmpty()) {
        // await handleChatNotification();
        // _onItemTapped(0);
        if (!ZegoUIKitPrebuiltCallController().minimize.isMinimizing) {
          ZegoUIKitPrebuiltCallController().minimize.minimize(
                navigatorKey.currentContext ?? Get.context!,
                rootNavigator: true,
              );
        }
      }
      String senderId = payLoad['sender_id'];
      String senderName = payLoad['senderName'];
      String courseId = (payLoad['course_id'] ?? "0").toString();
      String profileUrl = payLoad['profileUrl'] ?? "";
      Get.to(() => ChatFireBaseScreen(
            courseId: int.parse(courseId),
            isHod: courseId != "0",
            profileUrl: FileUtils.getFileExtension(profileUrl).isNullOrEmpty()
                ? ""
                : profileUrl,
            teacherId: int.parse(senderId),
            teacherName: senderName,
          ));
    } else if (type == "new_call") {
      Get.to(
        () => AndroidLarge5Screen(
          initialTabIndex: 1,
          isNotificationClick: false,
        ),
      );
      //
      // if (!Get.currentRoute.isNullOrEmpty() &&
      //     Get.currentRoute != "/IncomingCallPage") {
      //   CurrentCallModel callModel = CurrentCallModel.fromMap(payLoad);
      //
      //
      //   Get.to(
      //         () =>
      //         IncomingCallPage(
      //           liveLink: callModel.liveLink!,
      //           callId: callModel.callId!,
      //           teacherId: int.parse(callModel.callerId!),
      //           video: callModel.isVideo!,
      //           profileImageUrl: callModel.profileImg!,
      //           teacherName: callModel.callerName!,
      //         ),
      //   );
      // }
    }
  }

  Future<void> _showExitConfirmationDialog() async {
    await Get.dialog(
      AlertDialog(
        title: const Text('Exit App'),
        content: const Text('Are you sure you want to exit the app?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('No', style: TextStyle(color: Colors.black)),
          ),
          TextButton(
            onPressed: () {
              // exit(0);
              Get.back();
              if (Platform.isAndroid) {
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              } else if (Platform.isIOS) {
                exit(0);
              }
            },
            child: const Text(
              'Yes',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  Widget _buildBottomNavigationBar() {
    return CustomBottomBar(
      onChanged: (BottomBarEnum type) {
        print('Selected tab: ${getCurrentRoute(type)}');
        controller.setTemporaryPage(getCurrentRoute(type));
      },
    );
  }

  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return AppRoutes.homePage;
      case BottomBarEnum.Mycourses:
        return AppRoutes.myCoursesPage;
      case BottomBarEnum.Connect:
        return AppRoutes.connectMentorsPage;
      case BottomBarEnum.Mentors:
        return AppRoutes.androidLarge5Page;
      case BottomBarEnum.Test:
        return AppRoutes.testTab;
      case BottomBarEnum.Profile:
        return AppRoutes.profileScreen;

      default:
        return AppRoutes.homePage;
    }
  }

  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.homePage:
        return HomePage();
      case AppRoutes.myCoursesPage:
        return MyCoursesPage();
      case AppRoutes.connectMentorsPage:
        return TeacherScreen(
          isBottomBar: true,
        );
      case AppRoutes.androidLarge5Page:
        return AndroidLarge5Screen(
          isNotificationClick: false,
        );
      case AppRoutes.profileScreen:
        return StudentProfileScreen();

      case AppRoutes.testTab:
        return Navigator(
          onGenerateRoute: (settings) {
            return MaterialPageRoute(
              builder: (context) => ExamsTabScreen(
                studentId: PrefUtils().getStudentId(),
                token: PrefUtils().getAuthToken(),
              ),
            );
          },
        );
      default:
        return DefaultWidget();
    }
  }
}
