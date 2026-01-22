import 'package:anandhu_s_application4/data/models/home/course_content_by_module_model.dart';
import 'package:anandhu_s_application4/presentation/android_large_5_page/android_large_5_page.dart';
import 'package:anandhu_s_application4/presentation/explore_courses/explore_courses.dart';
import 'package:anandhu_s_application4/presentation/login/login_home_page.dart';
import 'package:anandhu_s_application4/presentation/profile/student_profile_screen.dart';
import 'package:anandhu_s_application4/presentation/splash_screen/splashscreen.dart';
import 'package:anandhu_s_application4/testpage/exams_screen.dart';
import 'package:anandhu_s_application4/testpage/mainexamstapbar.dart';

import 'package:anandhu_s_application4/testpage/rulsscreen.dart';
import 'package:flutter/material.dart';
import '../core/app_export.dart';
import '../presentation/chat_screen/chat_firebase_screen.dart';
import '../presentation/android_large_7_screen/android_large_7_screen.dart';
import '../presentation/android_large_7_screen/binding/android_large_7_binding.dart';
import '../presentation/app_navigation_screen/app_navigation_screen.dart';
import '../presentation/app_navigation_screen/binding/app_navigation_binding.dart';
import '../presentation/breff_screen/binding/breff_binding.dart';
import '../presentation/breff_screen/breff_screen.dart';
import '../presentation/breffini_screen/binding/breffini_binding.dart';
import '../presentation/breffini_screen/breffini_screen.dart';
import '../presentation/cart_checkout_screen/binding/cart_checkout_binding.dart';
import '../presentation/cart_checkout_screen/cart_checkout_screen.dart';
import '../presentation/course_details_page_screen/binding/course_details_page_binding.dart';
import '../presentation/course_details_page_screen/course_details_page_screen.dart';
import '../presentation/frame_1000004938_screen/binding/frame_1000004938_binding.dart';
import '../presentation/frame_1000004938_screen/frame_1000004938_screen.dart';
import '../presentation/frame_1000004939_screen/binding/frame_1000004939_binding.dart';
import '../presentation/frame_1000004939_screen/frame_1000004939_screen.dart';
import '../presentation/frame_1000004940_screen/binding/frame_1000004940_binding.dart';
import '../presentation/frame_1000004940_screen/frame_1000004940_screen.dart';
import '../presentation/frame_1000004949_screen/binding/frame_1000004949_binding.dart';
import '../presentation/frame_1000004949_screen/frame_1000004949_screen.dart';
import '../presentation/frame_1000004952_screen/binding/frame_1000004952_binding.dart';
import '../presentation/frame_1000004952_screen/frame_1000004952_screen.dart';
import '../presentation/frame_1000004962_screen/binding/frame_1000004962_binding.dart';
import '../presentation/frame_1000004962_screen/frame_1000004962_screen.dart';
import '../presentation/frame_1000005261_screen/binding/frame_1000005261_binding.dart';
import '../presentation/frame_1000005261_screen/frame_1000005261_screen.dart';
import '../presentation/home_page_after_joining_a_course_screen/binding/home_page_after_joining_a_course_binding.dart';
import '../presentation/home_page_after_joining_a_course_screen/home_page_after_joining_a_course_screen.dart';
import '../presentation/home_page_container_screen/binding/home_page_container_binding.dart';
import '../presentation/home_page_container_screen/home_page_container_screen.dart';
import '../presentation/listening_test_ongoing_screen/binding/listening_test_ongoing_binding.dart';
import '../presentation/listening_test_ongoing_screen/listening_test_ongoing_screen.dart';
import '../presentation/playing_course_screen/binding/playing_course_binding.dart';
import '../presentation/playing_course_screen/playing_course_screen.dart';
import '../presentation/reading_test_passage_screen/binding/reading_test_passage_binding.dart';
import '../presentation/reading_test_passage_screen/reading_test_passage_screen.dart';
import '../presentation/reading_test_question_screen/binding/reading_test_question_binding.dart';
import '../presentation/reading_test_question_screen/reading_test_question_screen.dart';
import '../presentation/reading_test_questions1_screen/binding/reading_test_questions1_binding.dart';
import '../presentation/reading_test_questions1_screen/reading_test_questions1_screen.dart';
import '../presentation/reading_test_questions_screen/binding/reading_test_questions_binding.dart';
import '../presentation/reading_test_questions_screen/reading_test_questions_screen.dart';
import '../presentation/search_page_screen/binding/search_page_binding.dart';
import '../presentation/search_page_screen/search_page_screen.dart';
import '../presentation/speaking_test_checking_screen/binding/speaking_test_checking_binding.dart';
import '../presentation/speaking_test_checking_screen/speaking_test_checking_screen.dart';
import '../presentation/speaking_test_question_screen/binding/speaking_test_question_binding.dart';
import '../presentation/speaking_test_question_screen/speaking_test_question_screen.dart';
import '../presentation/writing_test_question_screen/binding/writing_test_question_binding.dart';
import '../presentation/writing_test_question_screen/writing_test_question_screen.dart'; // ignore_for_file: must_be_immutable

class AppRoutes {
  static const String homePageContainerScreen = '/home_page_container_screen';
  static const String testTab = '/test_tab';

  static const String homePage = '/home_page';

  static const String splashScreen1 = '/splash_screen_1';

  static const String homePageAfterJoiningACourseScreen =
      '/home_page_after_joining_a_course_screen';

  static const String breffScreen = '/breff_screen';

  static const String breffiniScreen = '/breffini_screen';

  static const String searchPageScreen = '/search_page_screen';

  static const String courseDetailsPageScreen = '/course_details_page_screen';

  static const String frame1000004952Screen = '/frame_1000004952_screen';

  static const String playingCourseScreen = '/playing_course_screen';

  // static const String courseDetailsPage1Screen = '/course_details_page1_screen';

  static const String cartCheckoutScreen = '/cart_checkout_screen';

  static const String androidLarge5Page = '/android_large_5_page';
  static const String connectMentorsPage = '/connect_mentors_page';

  static const String homeContainer = '/home_container';

  static const String profileScreen = '/profile_screen';

  static const String androidLarge7Screen = '/android_large_7_screen';

  static const String chatScreen = '/chat_screen';

  static const String frame1000004938Screen = '/frame_1000004938_screen';

  static const String frame1000004939Screen = '/frame_1000004939_screen';

  static const String frame1000004940Screen = '/frame_1000004940_screen';

  static const String frame1000004949Screen = '/frame_1000004949_screen';

  static const String frame1000005261Screen = '/frame_1000005261_screen';

  static const String frame1000004962Screen = '/frame_1000004962_screen';

  static const String writingTestQuestionScreen =
      '/writing_test_question_screen';

  static const String readingTestPassageScreen = '/reading_test_passage_screen';

  static const String readingTestQuestionsScreen =
      '/reading_test_questions_screen';

  static const String readingTestQuestionScreen =
      '/reading_test_question_screen';

  static const String readingTestQuestions1Screen =
      '/reading_test_questions1_screen';

  static const String speakingTestQuestionScreen =
      '/speaking_test_question_screen';

  static const String speakingTestCheckingScreen =
      '/speaking_test_checking_screen';

  static const String listeningTestOngoingScreen =
      '/listening_test_ongoing_screen';

  static const String myCoursesPage = '/my_courses_page';

  //explore courses
  static const String exploreCoursesPage = '/explore_courses_page';

  static const String appNavigationScreen = '/app_navigation_screen';

  static const String initialRoute = '/initialRoute';
  static const String loginHome = '/login_home';
  static const String liveDetails = '/live_details';

  static List<GetPage> pages = [
    GetPage(
      name: homePageContainerScreen,
      page: () => HomePageContainerScreen(),
      bindings: [HomePageContainerBinding()],
    ),
    GetPage(
      name: loginHome,
      page: () => LoginHomePage(),
      bindings: [HomePageContainerBinding()],
    ),
    GetPage(
      name: profileScreen,
      page: () => StudentProfileScreen(),
    ),
    GetPage(
      name: homePageAfterJoiningACourseScreen,
      page: () => HomePageAfterJoiningACourseScreen(),
      bindings: [HomePageAfterJoiningACourseBinding()],
    ),
    GetPage(
      name: breffScreen,
      page: () => BreffScreen(),
      bindings: [BreffBinding()],
    ),
    GetPage(
      name: breffiniScreen,
      page: () => BreffiniScreen(),
      bindings: [BreffiniBinding()],
    ),
    GetPage(
      name: searchPageScreen,
      page: () => SearchPageScreen(),
      bindings: [SearchPageBinding()],
    ),
    GetPage(
      name: courseDetailsPageScreen,
      page: () => CourseDetailsPageScreen(),
      bindings: [CourseDetailsPageBinding()],
    ),
    GetPage(
      name: frame1000004952Screen,
      page: () => Frame1000004952Screen(),
      bindings: [Frame1000004952Binding()],
    ),
    GetPage(
      name: playingCourseScreen,
      page: () => PlayingCourseScreen(
        controller: Get.arguments['controller'],
      ),
      bindings: [PlayingCourseBinding()],
    ),
    // GetPage(
    //   name: testTab,
    //   page: () {
    //     final args = Get.arguments as Map<String, dynamic>?;

    //     if (args == null ||
    //         args['studentId'] == null ||
    //         args['token'] == null) {
    //       return const Scaffold(
    //         body: Center(
    //           child: Text(
    //             "Missing student data",
    //             style: TextStyle(fontSize: 16),
    //           ),
    //         ),
    //       );
    //     }

    //     return ExamsTabScreen(
    //       studentId: args['studentId'],
    //       token: args['token'],
    //     );
    //   },
    // ),

    // GetPage(
    //   name: courseDetailsPage1Screen,
    //   page: () => CourseDetailsPage1Screen(),
    //   bindings: [CourseDetailsPage1Binding()],
    // ),
    GetPage(
      name: cartCheckoutScreen,
      page: () => CartCheckoutScreen(),
      bindings: [CartCheckoutBinding()],
    ),
    GetPage(
      name: androidLarge7Screen,
      page: () => AndroidLarge7Screen(),
      bindings: [AndroidLarge7Binding()],
    ),
    GetPage(
      name: androidLarge5Page,
      page: () => AndroidLarge5Screen(
        isNotificationClick: false,
      ),
      bindings: [AndroidLarge7Binding()],
    ),

    GetPage(
      name: homeContainer,
      page: () => HomePageContainerScreen(),
      bindings: [AndroidLarge7Binding()],
    ),
    GetPage(
      name: chatScreen,
      page: () => ChatFireBaseScreen(
          courseId: 0,
          isHod: false,
          teacherName: Get.arguments['teacherName'],
          profileUrl: Get.arguments['profileUrl'],
          teacherId: Get.arguments['teacherId']),
      // bindings: [AndroidLarge4Binding(),],
    ),
    GetPage(
      name: frame1000004938Screen,
      page: () => Frame1000004938Screen(),
      bindings: [Frame1000004938Binding()],
    ),
    GetPage(
      name: frame1000004939Screen,
      page: () => Frame1000004939Screen(),
      bindings: [Frame1000004939Binding()],
    ),
    GetPage(
      name: frame1000004940Screen,
      page: () => Frame1000004940Screen(),
      bindings: [Frame1000004940Binding()],
    ),
    GetPage(
      name: frame1000004949Screen,
      page: () => Frame1000004949Screen(),
      bindings: [Frame1000004949Binding()],
    ),
    GetPage(
      name: frame1000005261Screen,
      page: () => Frame1000005261Screen(),
      bindings: [Frame1000005261Binding()],
    ),
    GetPage(
      name: frame1000004962Screen,
      page: () => Frame1000004962Screen(),
      bindings: [Frame1000004962Binding()],
    ),
    GetPage(
      name: writingTestQuestionScreen,
      page: () => WritingTestQuestionScreen(),
      bindings: [WritingTestQuestionBinding()],
    ),
    GetPage(
      name: readingTestPassageScreen,
      page: () => ReadingTestPassageScreen(),
      bindings: [ReadingTestPassageBinding()],
    ),
    GetPage(
      name: readingTestQuestionsScreen,
      page: () => ReadingTestQuestionsScreen(),
      bindings: [ReadingTestQuestionsBinding()],
    ),
    GetPage(
      name: readingTestQuestionScreen,
      page: () => ReadingTestQuestionScreen(),
      bindings: [ReadingTestQuestionBinding()],
    ),
    GetPage(
      name: readingTestQuestions1Screen,
      page: () => ReadingTestQuestions1Screen(),
      bindings: [ReadingTestQuestions1Binding()],
    ),
    GetPage(
      name: speakingTestQuestionScreen,
      page: () => SpeakingTestQuestionScreen(),
      bindings: [SpeakingTestQuestionBinding()],
    ),
    GetPage(
      name: speakingTestCheckingScreen,
      page: () => SpeakingTestCheckingScreen(),
      bindings: [SpeakingTestCheckingBinding()],
    ),
    GetPage(
      name: listeningTestOngoingScreen,
      page: () => ListeningTestOngoingScreen(),
      bindings: [ListeningTestOngoingBinding()],
    ),
    GetPage(
      name: appNavigationScreen,
      page: () => AppNavigationScreen(),
      bindings: [AppNavigationBinding()],
    ),
    GetPage(
      name: initialRoute,
      page: () => SplashScreen(),
      bindings: [HomePageAfterJoiningACourseBinding()],
    ),
    // GetPage(
    //   name: exploreCoursesPage,
    //   page: () => ExploreCourses(),
    // )
  ];
}
