import 'package:anandhu_s_application4/core/utils/key_center.dart';
import 'package:anandhu_s_application4/core/utils/notification_controller.dart';
import 'package:anandhu_s_application4/firebase_options.dart';
import 'package:anandhu_s_application4/http/socket_io.dart';
import 'package:anandhu_s_application4/presentation/android_large_5_page/controller/call_chat_controller.dart';
import 'package:anandhu_s_application4/presentation/chat_screen/controller/chat_controller.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/controller/course_content_controller.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/controller/course_details_page1_controller.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/controller/course_enrol_controller.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/controller/exam_result_controller.dart';
import 'package:anandhu_s_application4/presentation/explore_courses/controller/course_access_controller.dart';
import 'package:anandhu_s_application4/presentation/home_page/controller/home_controller.dart';
import 'package:anandhu_s_application4/presentation/home_page/models/home_model.dart';
import 'package:anandhu_s_application4/presentation/home_page_container_screen/controller/home_page_container_controller.dart';
import 'package:anandhu_s_application4/presentation/profile/controller/profile_controller.dart';
import 'package:anandhu_s_application4/widgets/animated_container_widget.dart';
// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:zego_effects_plugin/zego_effects_plugin.dart';
// import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:zego_express_engine/zego_express_engine.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'core/app_export.dart';
import 'core/utils/notification_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
      name: "Trackbox", options: DefaultFirebaseOptions.currentPlatform);
  // await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
  // Gemini.init(apiKey: 'AIzaSyA0v7yLtkegaU96vTHyQklCwBlNnlrkgxw');
  if (!kDebugMode) {
    const fatalError = true;
    FlutterError.onError = (errorDetails) {
      if (fatalError) {
        // If you want to record a "fatal" exception
        FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
        // ignore: dead_code
      } else {
        // If you want to record a "non-fatal" exception
        FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
      }
    };
    // Async exceptions
    PlatformDispatcher.instance.onError = (error, stack) {
      if (fatalError) {
        // If you want to record a "fatal" exception
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        // ignore: dead_code
      } else {
        // If you want to record a "non-fatal" exception
        FirebaseCrashlytics.instance.recordError(error, stack);
      }
      return true;
    };
  }
  //--Initialize Notification Services
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  // NotificationService().initializeLocalNotifications();
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  // AwesomeNotifications().initialize(
  //   'resource://drawable/res_app_icon',
  //   [
  //     NotificationChannel(
  //       channelKey: 'message_channel',
  //       channelName: 'Message notifications',
  //       channelDescription: 'Notification channel for new messages',
  //       defaultColor: Colors.teal,
  //       importance: NotificationImportance.High,
  //       channelShowBadge: true,
  //     ),
  //     NotificationChannel(
  //       channelKey: 'call_channel',
  //       channelName: 'Call notifications',
  //       channelDescription: 'Notification channel for new calls',
  //       defaultColor: Colors.red,
  //       importance: NotificationImportance.High,
  //       channelShowBadge: true,
  //       soundSource: 'resource://raw/call_sound',
  //     ),
  //   ],
  // );

/////
  // PushNotificationHelper.initialize();
  await PrefUtils().init();

  await ChatSocket.initSocket();

  print('Socket initialized');
  Get.put(CourseAccessController(), permanent: true);
  Get.put(ProfileController());
  Get.put(ChatHistoryController(), permanent: true);
  Get.put(HomePageContainerController());
  Get.put(HomeController(HomeModel().obs), permanent: true);
  Get.put(CourseModuleController());
  Get.put(CourseEnrolController());
  Get.put(ExamResultController());
  Get.put(CourseContentController());
  Get.put(CallandChatController());

  ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);

  Get.put(CallandChatController()).listenIncomingCallNotification();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    // Logger.init(kReleaseMode ? LogMode.live : LogMode.debug);
    ZegoExpressEngine.createEngineWithProfile(ZegoEngineProfile(
            appID, ZegoScenario.Default,
            appSign: appSign, enablePlatformView: true))
        .then((onValue) {
      runApp(MyApp());
    });
  });
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String version = 'Unknown';
  @override
  void initState() {
    super.initState();

    // AwesomeNotifications().setListeners(
    //   onActionReceivedMethod: NotificationController.onActionReceivedMethod,
    //   onNotificationCreatedMethod:
    //       NotificationController.onNotificationCreatedMethod,
    //   onNotificationDisplayedMethod:
    //       NotificationController.onNotificationDisplayedMethod,
    //   onDismissActionReceivedMethod:
    //       NotificationController.onDismissActionReceivedMethod,
    // );
    requestNotificationPermission();
    // ZegoEffectsPlugin.instance.setResources();

    // ZegoEffectsPlugin.instance.create(appSign);
    // ZegoEffectsPlugin.instance.getVersion().then((value) {
    //   version = value;
    // });
  }

  Future<void> requestNotificationPermission() async {
    final settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User denied permission');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: theme,
        translations: AppLocalization(),
        locale: Get.deviceLocale,
        fallbackLocale: Locale('en', 'US'),
        builder: (BuildContext context, Widget? child) {
          return Stack(
            children: [
              child!,
              ZegoUIKitPrebuiltCallMiniOverlayPage(
                showLeaveButton: false,
                foregroundBuilder: (BuildContext context, Size size,
                    ZegoUIKitUser? user, Map extraInfo) {
                  return user != null
                      ? ValueListenableBuilder(
                          valueListenable:
                              ZegoUIKit().getCameraStateNotifier(user.id),
                          builder: (context, isCameraOn, child) {
                            return isCameraOn ? const SizedBox() : child!;
                          },
                          child: const AnimatedPhoneCallContainer())
                      : const SizedBox();
                },
                contextQuery: () {
                  return navigatorKey.currentState!.context;
                },
              ),
            ],
          );
        },
        title: 'Happy English',
        initialRoute: AppRoutes.initialRoute,
        getPages: AppRoutes.pages,
      );
    });
  }
}
