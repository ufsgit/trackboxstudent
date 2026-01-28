import 'dart:async';
import 'package:anandhu_s_application4/core/colors_res.dart';
import 'package:anandhu_s_application4/http/http_urls.dart';
import 'package:anandhu_s_application4/http/loader.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/controller/course_content_controller.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/controller/course_enrol_controller.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/listening_test_screen.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/pdf_viewer_screen.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/widgets/course_curriculam_widget.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/models/course_content_model.dart';
import 'package:anandhu_s_application4/presentation/course_details_page_screen/models/course_content_model.dart'
    as CoursePageModel;
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/widgets/course_overview_page.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:video_player/video_player.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/custom_outlined_button.dart';
import '../../widgets/custom_rating_bar.dart';
import '../home_page/controller/home_controller.dart';
import '../home_page/models/home_model.dart';
import 'controller/course_details_page1_controller.dart';
import 'models/course_review_model.dart';
import 'models/viewhierarchy2_item_model.dart';
import 'widgets/viewhierarchy2_item_widget.dart';
import 'package:audioplayers/audioplayers.dart';

class CourseDetailsPage1Screen extends StatefulWidget {
  CourseDetailsPage1Screen({
    Key? key,
    this.courseId,
    this.moduleId,
    this.sectionId,
    this.dayId,
    required this.isLibrary,
    this.isMock,
  }) : super(
          key: key,
        );
  final String? courseId;
  final String? moduleId;
  final String? sectionId;
  final bool isLibrary;
  final String? dayId;
  final bool? isMock;
  @override
  State<CourseDetailsPage1Screen> createState() =>
      _CourseDetailsPage1ScreenState();
}

class _CourseDetailsPage1ScreenState extends State<CourseDetailsPage1Screen>
    with SingleTickerProviderStateMixin {
  HomeController homeController = Get.put(HomeController(HomeModel().obs));
  CourseContentController courseContentController =
      Get.put(CourseContentController());

  CourseModuleController videoController = Get.put(CourseModuleController());

  CourseEnrolController enrolController = Get.put(CourseEnrolController());

  late FlickManager flickManager;
  final ScrollController _scrollController = ScrollController();
  // late VideoPlayerController _videoPlayerController;
  late Future<void> _initializeVideoPlayerFuture;

  // ChewieController? _chewieController;
  int? bufferDelay;
  bool _showControls = false;
  String? _videoUrl;

  Timer? _hideControlsTimer;
  String selectedPdfUrl = '';
  int currPlayIndex = 0;
  late Animation<double> animation;
  late AnimationController controller;
  bool _isAnimating = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      print(courseContentController.courseContent.value.contents);
      print(widget.moduleId);
      courseContentController.isLoading.value = true;
      homeController.selectedIndex.value = 0;
      controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 800),
      );
      animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);

      getData();
    });

    super.initState();
  }

  final player = AudioPlayer();

  void _toggleAnimation(String url) async {
    print('fg $url');
    // player.stop();
    // print('fg ${player.paus}');

    setState(() {
      if (_isAnimating) {
        controller.reverse();
      } else {
        controller.forward();
      }
      _isAnimating = !_isAnimating;
    });
    if (player.state == PlayerState.playing) {
      print('Pausingg');
      await player.pause();
    } else {
      await player.play(UrlSource(url));
    }
  }

  getData() async {
    // if (courseContentController.courseContent.value.contents != null) {

    await courseContentController
        .getCourseContent(
            courseId: widget.courseId!,
            moduleId: widget.moduleId!,
            dayId: widget.dayId.toString(),
            sectionId: widget.sectionId.toString(),
            value: widget.isLibrary ? true : false)
        .then((v) {
      print('hiii frtwr');
      if (courseContentController.courseContent.value.contents != null &&
          courseContentController.courseContent.value.contents?[0].fileType ==
              'video/mp4') {
        print(
            'hiii dgsfg ${courseContentController.courseContent.value.contents?[0].file}');
        _videoUrl =
            '${HttpUrls.imgBaseUrl}${courseContentController.courseContent.value.contents?[0].file}';
        flickManager = FlickManager(
          videoPlayerController:
              VideoPlayerController.networkUrl(Uri.parse(_videoUrl ?? '')),
        );
      } else {
        print('hiii er4w');

        _videoUrl = null;
        flickManager = FlickManager(
          videoPlayerController:
              VideoPlayerController.networkUrl(Uri.parse('')),
        );
      }
      _initializeVideoPlayerFuture = Future.value(); // Placeholder
      // _videoPlayerController.initialize();

      homeController.setTitle(courseContentController
              .courseContent.value.contents?[0].contentName ??
          courseContentController
              .courseContent.value.contents?[0].exams![0].examName ??
          '');
      homeController.getSelectedCourseCategory(
          courseContentController.courseContent.value.contents?[0].fileType ??
              courseContentController
                  .courseContent.value.contents?[0].exams?[0].fileType ??
              '');
      print('sfasdfadf');

      // flickManager = FlickManager(
      //     videoPlayerController: VideoPlayerController.networkUrl(
      //   Uri.parse(courseContentController.courseContent.contents?[0].file ??
      //       homeController.videoURL),
      // ));
      // enrolController.checkCourseEnrolled(
      //     homeController.courseDetails?.courseId.toString());
      initializePlayer();
    });
    // }
    courseContentController.isLoading.value = false;
  }

  void showVideo(String url) {
    setState(() {
      _videoUrl = url;

      // Dispose of the old controller if it exists
      flickManager.flickControlManager?.pause();
      flickManager.dispose();

      flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.networkUrl(
            Uri.parse('${HttpUrls.imgBaseUrl}$url')),
      );
      flickManager.flickControlManager?.play();
    });
  }

  @override
  void dispose() {
    flickManager.dispose();

    player.dispose();

    courseContentController.courseContent.value.contents = null;
    // _videoPlayerController.dispose();
    // _chewieController?.dispose();
    super.dispose();
  }

  List<String> srcs = [
    'https://ufsnabeelphotoalbum.s3.us-east-2.amazonaws.com/Briffni/123/b285e15a-2287-4397-a541-6bc6ebc5cd09_Bulk SMS _ SMS Service _ Bulk SMS Gateway _ Bulk SMS Company - Brave 2024-02-02 10-56-03.mp4',
    "https://assets.mixkit.co/videos/preview/mixkit-spinning-around-the-earth-29351-large.mp4",
    "https://assets.mixkit.co/videos/preview/mixkit-daytime-city-traffic-aerial-view-56-large.mp4",
    "https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4"
  ];
  void _scrollToTop() {
    _scrollController.animateTo(
      0.0,
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  Future<void> initializePlayer() async {
    print(
        '//////////////video player initialisation completed ${HttpUrls.imgBaseUrl}${homeController.videoURL}>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
    await Future.wait([
      // _videoPlayerController.initialize(),
    ]);
    // _videoPlayerController = VideoPlayerController.networkUrl(
    //     videoPlayerOptions: VideoPlayerOptions(
    //       mixWithOthers: true,
    //       allowBackgroundPlayback: true,
    //     ),
    //     Uri.parse('${HttpUrls.imgBaseUrl}${homeController.videoURL}'));
    // videoController.addListener(() {
    //   print('listenersssssssssssssssssssss');
    // });

    // _createChewieController();
    setState(() {});
  }

  // void _createChewieController() {
  //   _chewieController = ChewieController(
  //     allowPlaybackSpeedChanging: true,
  //     videoPlayerController: _videoPlayerController,
  //     autoPlay: true,
  //     looping: false,
  //     zoomAndPan: true,
  //     showControls: true,
  //     // customControls: CustomControls(
  //     //   videoPlayerController: _videoPlayerController,
  //     //   chewieController: ChewieController(
  //     //     videoPlayerController: _videoPlayerController,
  //     //     autoPlay: true,
  //     //     looping: false,
  //     //   ),
  //     // ),
  //     progressIndicatorDelay:
  //         bufferDelay != null ? Duration(milliseconds: bufferDelay!) : null,
  //     additionalOptions: (context) {
  //       return <OptionItem>[
  //         OptionItem(
  //           onTap: toggleVideo,
  //           iconData: Icons.live_tv_sharp,
  //           title: 'Toggle Video Src',
  //         ),
  //         OptionItem(
  //           onTap: _fastForward,
  //           iconData: Icons.forward_10,
  //           title: 'Fast Forward 10s',
  //         ),
  //         OptionItem(
  //           onTap: _fastRewind,
  //           iconData: Icons.replay_10,
  //           title: 'Rewind 10s',
  //         ),
  //       ];
  //     },
  //     hideControlsTimer: const Duration(seconds: 3),
  //     showOptions: true,
  //     autoInitialize: true,
  //   );
  // }

  Future<void> toggleVideo() async {
    print('dafwefe');
    // _videoPlayerController.pause();
    // currPlayIndex += 1;
    // if (currPlayIndex >= srcs.length) {
    //   currPlayIndex = 0;
    // }
    await initializePlayer();
  }

  void _fastForward() {
    // final currentPosition = _videoPlayerController.value.position;
    // final maxDuration = _videoPlayerController.value.duration;
    // final newPosition = currentPosition + const Duration(seconds: 10);

    // if (newPosition < maxDuration) {
    //   _videoPlayerController.seekTo(newPosition);
    // } else {
    //   _videoPlayerController.seekTo(maxDuration);
    // }
  }

  void _fastRewind() {
    // final currentPosition = _videoPlayerController.value.position;
    // final maxDuration = _videoPlayerController.value.duration;
    // final newPosition = currentPosition - const Duration(seconds: 10);

    // if (newPosition < maxDuration) {
    //   _videoPlayerController.seekTo(newPosition);
    // } else {
    //   _videoPlayerController.seekTo(maxDuration);
    // }
  }
  double _playbackSpeed = 1.0;
  void _changePlaybackSpeed(double speed) {
    setState(() {
      _playbackSpeed = speed;
      flickManager.flickControlManager?.setPlaybackSpeed(speed);
    });
  }

  // Widget _buildExamsTab() {
  //   return FutureBuilder<List<ExamModel>>(
  //     future: examsFuture,
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return Center(child: CircularProgressIndicator());
  //       } else if (snapshot.hasError) {
  //         return Center(child: Text("Error: ${snapshot.error}"));
  //       } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
  //         return Center(
  //             child: Padding(
  //           padding: const EdgeInsets.all(20.0),
  //           child: Text("No exams found for this course."),
  //         ));
  //       }
  //       final exams = snapshot.data!;
  //       return ListView.builder(
  //         shrinkWrap: true,
  //         physics: NeverScrollableScrollPhysics(),
  //         itemCount: exams.length,
  //         padding: EdgeInsets.zero,
  //         itemBuilder: (context, index) {
  //           final exam = exams[index];
  //           return Container(
  //             margin: EdgeInsets.symmetric(vertical: 5),
  //             decoration: BoxDecoration(
  //                 color: Colors.white,
  //                 borderRadius: BorderRadius.circular(12),
  //                 border: Border.all(color: Colors.grey.shade200)),
  //             child: ListTile(
  //               leading: Container(
  //                 padding: EdgeInsets.all(8),
  //                 decoration: BoxDecoration(
  //                   color: ColorResources.colorBlue500.withOpacity(0.1),
  //                   borderRadius: BorderRadius.circular(8),
  //                 ),
  //                 child: Icon(Icons.assignment_outlined,
  //                     color: ColorResources.colorBlue500),
  //               ),
  //               title: Text("Course Exam ID: ${exam.courseExamId}",
  //                   style:
  //                       TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
  //               subtitle: Text(
  //                   "Duration: ${exam.duration} mins | Qs: ${exam.questions}",
  //                   style: TextStyle(fontSize: 12)),
  //               trailing:
  //                   Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
  //               onTap: () {
  //                 Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                     builder: (_) => RulesScreen(exam: exam),
  //                   ),
  //                 );
  //               },
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: Obx(() {
          final message = courseContentController.courseContent.value.message;
          return courseContentController.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(
                    color: ColorResources.colorBlue500,
                  ),
                )
              : courseContentController.courseContent.value.contents == null &&
                      message == null
                  ? Center(
                      child: Text('No Documents Found In This Course'),
                    )
                  : message != null
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(message),
                          ),
                        )
                      : Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.symmetric(vertical: 5.v),
                          child: Column(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  controller: _scrollController,
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 5.v),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.h),
                                    child: Obx(() {
                                      return Column(
                                        children: [
                                          // FlickVideoPlayer(
                                          //   flickManager: flickManager,
                                          //   flickVideoWithControls: FlickSetPlayBack(
                                          //     speed: 1.5,
                                          //   ),
                                          // ),
                                          if (homeController
                                                  .selectedCourseCategory
                                                  .value ==
                                              'video/mp4')
                                            Container(
                                              height: 200,
                                              child: Stack(
                                                children: [
                                                  FlickVideoPlayer(
                                                      flickManager: flickManager

                                                      // flickVideoWithControls: FlickSetPlayBack(
                                                      //   speed: 1.5,
                                                      // ),
                                                      ),
                                                  Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: PopupMenuButton(
                                                      color: Colors.white,
                                                      iconColor:
                                                          Colors.grey.shade600,
                                                      itemBuilder: (c) => [
                                                        PopupMenuItem(
                                                          onTap: () =>
                                                              _changePlaybackSpeed(
                                                                  0.5),
                                                          child: Text(
                                                            '0.5x',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ),
                                                        PopupMenuItem(
                                                          onTap: () =>
                                                              _changePlaybackSpeed(
                                                                  1.0),
                                                          child: Text(
                                                            '1x',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ),
                                                        PopupMenuItem(
                                                          onTap: () =>
                                                              _changePlaybackSpeed(
                                                                  1.5),
                                                          child: Text(
                                                            '1.5x',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ),
                                                        PopupMenuItem(
                                                          onTap: () =>
                                                              _changePlaybackSpeed(
                                                                  2),
                                                          child: Text(
                                                            '2x',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                  // Row(
                                                  //   mainAxisAlignment:
                                                  //       MainAxisAlignment.center,
                                                  //   children: [
                                                  //     ElevatedButton(
                                                  //       onPressed: () =>
                                                  //           _changePlaybackSpeed(
                                                  //               0.5),
                                                  //       child: Text('0.5x'),
                                                  //     ),
                                                  //     SizedBox(width: 10),
                                                  //     ElevatedButton(
                                                  //       onPressed: () =>
                                                  //           _changePlaybackSpeed(
                                                  //               1.0),
                                                  //       child: Text('1x'),
                                                  //     ),
                                                  //     SizedBox(width: 10),
                                                  //     ElevatedButton(
                                                  //       onPressed: () =>
                                                  //           _changePlaybackSpeed(
                                                  //               1.5),
                                                  //       child: Text('1.5x'),
                                                  //     ),
                                                  //     SizedBox(width: 10),
                                                  //     ElevatedButton(
                                                  //       onPressed: () =>
                                                  //           _changePlaybackSpeed(
                                                  //               2.0),
                                                  //       child: Text('2x'),
                                                  //     ),
                                                  //   ],
                                                  // ),
                                                ],
                                              ),
                                            )
                                          // _chewieController != null &&
                                          //         _chewieController!.videoPlayerController
                                          //             .value.isInitialized
                                          //     ? SizedBox(
                                          //         height: 200,
                                          //         child:
                                          //             Chewie(controller: _chewieController!))
                                          //     : SizedBox(
                                          //         height: 200,
                                          //         child: const Center(
                                          //           child: CircularProgressIndicator(),
                                          //         ),
                                          //       )
                                          else
                                            Container(
                                              height: 200,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/OET Thumbnails 1.png'),
                                                ),
                                              ),
                                              child: Center(
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.white,
                                                    foregroundColor:
                                                        Colors.black,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 37,
                                                            vertical: 25),
                                                  ),
                                                  onPressed: () {
                                                    final currentIndex =
                                                        homeController
                                                            .selectedIndex
                                                            .value;
                                                    final currentContent =
                                                        courseContentController
                                                                .courseContent
                                                                .value
                                                                .contents?[
                                                            currentIndex];
                                                    final exam = currentContent
                                                        ?.exams[0];

                                                    // Early exit if currentContent or exam is null
                                                    if (currentContent ==
                                                            null ||
                                                        exam == null) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                            content: Text(
                                                                'Content not available.')),
                                                      );
                                                      return;
                                                    }

                                                    bool isPdf = exam
                                                        .supportingDocumentName
                                                        .endsWith('.pdf');
                                                    bool isAudio = exam.fileName
                                                        .endsWith('.mp3');
                                                    bool isExamTest =
                                                        currentContent
                                                                .examTest ==
                                                            1;

                                                    // Check if exam test is locked
                                                    bool isQuestionUnlocked =
                                                        exam.isQuestionUnlocked ==
                                                            0;
                                                    bool
                                                        isQuestionMediaUnlocked =
                                                        exam.isQuestionMediaUnlocked ==
                                                            0;
                                                    if (isExamTest) {
                                                      if ((isQuestionUnlocked &&
                                                          isQuestionMediaUnlocked)) {
                                                        // Show SnackBar if content is locked
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                              content: Text(
                                                                  'Access restricted: Unlock content to proceed.')),
                                                        );
                                                        return;
                                                      }
                                                    }

/////
                                                    if (isPdf || isAudio) {
                                                      print("Content ID --- " +
                                                          currentContent
                                                              .contentId
                                                              .toString());
                                                      print("Course ID --- " +
                                                          widget.courseId
                                                              .toString());
                                                      //update last access
                                                      courseContentController
                                                          .updatelastaccess(
                                                              currentContent
                                                                  .contentId
                                                                  .toString(),
                                                              widget.courseId
                                                                  .toString());
                                                      Get.to(
                                                          () => PdfViewerPage(
                                                                isAnswerKeyUnlocked:
                                                                    exam.isAnswerUnlocked ==
                                                                            1
                                                                        ? true
                                                                        : false,
                                                                answerPdf: exam
                                                                    .answerKeyPath,
                                                                isExamTest:
                                                                    currentContent.examTest ==
                                                                            1
                                                                        ? true
                                                                        : false,
                                                                isFromCourseScreen:
                                                                    true,
                                                                isMediaUnlocked:
                                                                    exam.isQuestionMediaUnlocked ==
                                                                            1
                                                                        ? true
                                                                        : false,
                                                                isPdfUnLocked:
                                                                    exam.isQuestionUnlocked ==
                                                                            1
                                                                        ? true
                                                                        : false,
                                                                answerKey:
                                                                    '${HttpUrls.imgBaseUrl}${exam.answerKeyPath}',
                                                                media: exam
                                                                    .mainQuestion,
                                                                fileUrl:
                                                                    '${HttpUrls.imgBaseUrl}${exam.supportingDocumentPath}',
                                                              ));
                                                    } else {
                                                      // Show SnackBar if content is locked
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                            content: Text(
                                                                'No contents to show')),
                                                      );
                                                    }
                                                  },
                                                  child: Text(
                                                    homeController
                                                                .selectedCourseCategory
                                                                .value ==
                                                            'application/pdf'
                                                        ? 'Open PDF'
                                                        : 'Start Your Test',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          SizedBox(height: 20.v),
                                          Container(
                                            width: 322.h,
                                            margin: EdgeInsets.only(right: 5.h),
                                            child: Text(
                                              homeController.title
                                                  .value, // controllerCourseDetailsController
                                              //         .courseDetails?.courseName ??
                                              //     '',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: CustomTextStyles
                                                  .titleMedium18_1
                                                  .copyWith(
                                                height: 1.50,
                                              ),
                                            ),
                                          ),
//<<<<<<<<<<<<<<<<<<<<<NEW DESIGN>>>>>>>>>>>>>>>>>>>>>>
                                          SizedBox(height: 16),
                                          Divider(),
                                          SizedBox(height: 16),

                                          CourseCurriculamWidget(
                                              toggleVideo: showVideo,
                                              modules: courseContentController
                                                  .courseContent.value.contents,
                                              scrollController:
                                                  _scrollController,
                                              controllerCourseDetailsController:
                                                  homeController),

                                          SizedBox(height: 3.v),
                                          SizedBox(
                                            width: 323.h,
                                            child: Text(
                                              controllerCourseDetailsController
                                                      .courseDetails
                                                      ?.description ??
                                                  '',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: CustomTextStyles
                                                  .bodyMediumBluegray500_1
                                                  .copyWith(
                                                height: 1.43,
                                              ),
                                            ),
                                          ),
                                          // SizedBox(height: 15.v),
                                          // _buildCourseRatingRow(),
                                          // SizedBox(height: 18.v),
                                          // Divider(),
                                          // SizedBox(height: 20.v),
                                          // _buildLearningOutcomesColumn(),
                                          // SizedBox(height: 17.v),
                                          // Divider(),
                                          // SizedBox(height: 18.v),
                                          // Align(
                                          //   alignment: Alignment.centerLeft,
                                          //   child: Text(
                                          //     "lbl_course_overview".tr,
                                          //     style: theme.textTheme.titleSmall,
                                          //   ),
                                          // ),
                                          // SizedBox(height: 10.v),
                                          // _buildCourseOverviewRow(),
                                          // SizedBox(height: 18.v),
                                          // Divider(),
                                          // SizedBox(height: 20.v),
                                          // Align(
                                          //   alignment: Alignment.centerLeft,
                                          //   child: Text(
                                          //     "lbl_summary".tr,
                                          //     style: theme.textTheme.titleSmall,
                                          //   ),
                                          // ),
                                          // SizedBox(height: 6.v),
                                          // _buildChapterColumn3(setState),
                                          // SizedBox(height: 12.v),
                                          // Align(
                                          //   alignment: Alignment.centerLeft,
                                          //   child: Text(
                                          //     "lbl_reviews".tr,
                                          //     style: theme.textTheme.titleSmall,
                                          //   ),
                                          // ),
                                          SizedBox(height: 12.v),
                                          Column(
                                            children: List.generate(
                                              controllerCourseDetailsController
                                                  .courseReviewList.length,
                                              (index) => Container(
                                                margin:
                                                    EdgeInsets.only(top: 15.v),
                                                child: Column(
                                                  children: [
                                                    _buildReviewRow(
                                                        reviewData:
                                                            controllerCourseDetailsController
                                                                    .courseReviewList[
                                                                index]),
                                                    SizedBox(height: 17.v),
                                                    Container(
                                                      width: 320.h,
                                                      margin: EdgeInsets.only(
                                                          right: 6.h),
                                                      child: Text(
                                                        controllerCourseDetailsController
                                                            .courseReviewList[
                                                                index]
                                                            .comments,
                                                        maxLines: 5,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: theme.textTheme
                                                            .bodyMedium!
                                                            .copyWith(
                                                          height: 1.43,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
        }),
        // bottomNavigationBar: _buildTotalPriceRow(),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      height: 80.v,
      leadingWidth: 50.v,
      leading: Container(
        margin: EdgeInsets.only(left: 16.h),
        child: InkWell(
          onTap: () {
            onTapArrowleftone();
          },
          child: CircleAvatar(
            radius: 20,
            backgroundColor: ColorResources.colorBlue100,
            child: Padding(
              padding: EdgeInsets.only(left: 8.v),
              child: Icon(
                Icons.arrow_back_ios,
                color: ColorResources.colorBlack.withOpacity(.8),
              ),
            ),
          ),
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text(
          "lbl_course_details".tr,
          style: CustomTextStyles.titleMediumBluegray8000118,
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildImageStack() {
    return SizedBox(
      height: 182.v,
      width: 328.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // CustomImageView(
          //   imagePath: ImageConstant.imgRectangle23,
          //   height: 182.v,
          //   width: 328.h,
          //   radius: BorderRadius.circular(
          //     12.h,
          //   ),
          //   alignment: Alignment.center,
          // ),

          //   Scaffold(body: Container(
          // color: Colors.amber,
          // child: Stack(
          //   children: [
          // Center(
          //     child: controllerCourseDetailsController.controller.value.isInitialized
          //         ? AspectRatio(
          //             aspectRatio: controllerCourseDetailsController.controller.value.aspectRatio,
          //             child: VideoPlayer(controllerCourseDetailsController.controller),
          //           )
          //         : Container(),
          //   ),

          //         Align(

          //           alignment: Alignment.bottomCenter,

          //           child: Icon(Icons.abc)),
          //     ],
          //   ),
          // ),
          //   floatingActionButton: FloatingActionButton(
          //     onPressed: () {

          //       controllerCourseDetailsController.controller.value.isPlaying
          //             ? controllerCourseDetailsController.controller.pause()
          //             : controllerCourseDetailsController.controller.play();

          //     },
          //     child: Icon(
          //    controllerCourseDetailsController.controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          //     ),
          //   ),),

          Container(
            height: 182.v,
            width: 328.h,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        '${HttpUrls.imgBaseUrl}${homeController.courseDetails?.thumbnailPath}'))),
          ),
          CustomIconButton(
            onTap: () {
              Get.toNamed(AppRoutes.playingCourseScreen);
            },
            height: 60.adaptSize,
            width: 60.adaptSize,
            padding: EdgeInsets.all(17.h),
            decoration: IconButtonStyleHelper.fillWhiteA,
            alignment: Alignment.center,
            child: CustomImageView(
              imagePath: ImageConstant.imgOverflowMenuBlue80003,
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildCourseRatingRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 49.h,
          padding: EdgeInsets.symmetric(
            horizontal: 12.h,
            vertical: 2.v,
          ),
          decoration: AppDecoration.fillBlue80003.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder12,
          ),
          child: Text(
            "lbl_oet".tr,
            style: CustomTextStyles.labelLargeBlue80003,
          ),
        ),
        Container(
          width: 87.h,
          margin: EdgeInsets.only(left: 4.h),
          padding: EdgeInsets.symmetric(
            horizontal: 12.h,
            vertical: 2.v,
          ),
          decoration: AppDecoration.fillOrange.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder12,
          ),
          child: Text(
            "lbl_best_seller".tr,
            style: CustomTextStyles.labelLargeAmber700,
          ),
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.only(
            top: 3.v,
            bottom: 2.v,
          ),
          child: Text(
            "lbl_4_4".tr,
            style: CustomTextStyles.labelLargeBlack900,
          ),
        ),
        CustomImageView(
          imagePath: ImageConstant.imgStarAmber600,
          height: 10.adaptSize,
          width: 10.adaptSize,
          margin: EdgeInsets.only(
            left: 4.h,
            top: 6.v,
            bottom: 6.v,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 4.h,
            top: 4.v,
          ),
          child: Text(
            "lbl_56_reviews".tr,
            style: CustomTextStyles.bodySmallBluegray700,
          ),
        )
      ],
    );
  }

  /// Section Widget
  Widget _buildLearningOutcomesColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "msg_what_you_ll_learn".tr,
          style: theme.textTheme.titleSmall,
        ),
        // SizedBox(height: 6.v),
        // Padding(
        //   padding: EdgeInsets.only(right: 29.h),
        //   child: Row(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       CustomImageView(
        //         imagePath: ImageConstant.imgFrame1000004924,
        //         height: 15.v,
        //         width: 12.h,
        //         margin: EdgeInsets.only(bottom: 22.v),
        //       ),
        //       Expanded(
        //         child: Container(
        //           width: 278.h,
        //           margin: EdgeInsets.only(left: 8.h),
        //           child: Text(
        //             "msg_learn_the_templ".tr,
        //             maxLines: 2,
        //             overflow: TextOverflow.ellipsis,
        //             style: CustomTextStyles.labelLargeMedium.copyWith(
        //               height: 1.50,
        //             ),
        //           ),
        //         ),
        //       )
        //     ],
        //   ),
        // ),
        SizedBox(height: 6.v),

        Text(homeController.courseDetails?.thingsToLearn ?? '')

        // Padding(
        //   padding: EdgeInsets.only(right: 31.h),
        //   child: Row(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       CustomImageView(
        //         imagePath: ImageConstant.imgFrame1000004924,
        //         height: 15.v,
        //         width: 12.h,
        //         margin: EdgeInsets.only(bottom: 22.v),
        //       ),
        //       Expanded(
        //         child: Container(
        //           width: 276.h,
        //           margin: EdgeInsets.only(left: 8.h),
        //           child: Text(
        //             "msg_understand_how_to".tr,
        //             maxLines: 2,
        //             overflow: TextOverflow.ellipsis,
        //             style: CustomTextStyles.labelLargeMedium.copyWith(
        //               height: 1.50,
        //             ),
        //           ),
        //         ),
        //       )
        //     ],
        //   ),
        // ),
        // SizedBox(height: 6.v),
        // Padding(
        //   padding: EdgeInsets.only(right: 20.h),
        //   child: Row(
        //     children: [
        //       CustomImageView(
        //         imagePath: ImageConstant.imgFrame1000004924,
        //         height: 15.v,
        //         width: 12.h,
        //         margin: EdgeInsets.only(bottom: 3.v),
        //       ),
        //       Padding(
        //         padding: EdgeInsets.only(
        //           left: 8.h,
        //           top: 2.v,
        //         ),
        //         child: Text(
        //           "msg_gain_expert_guidance".tr,
        //           style: CustomTextStyles.labelLargeMedium,
        //         ),
        //       )
        //     ],
        //   ),
        // )
      ],
    );
  }

  /// Section Widget
  Widget _buildCourseOverviewRow() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(right: 36.h),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "lbl_4".tr,
                  style: theme.textTheme.titleSmall,
                ),
                SizedBox(height: 1.v),
                Text(
                  "lbl_weeks".tr,
                  style: CustomTextStyles.labelLargeBluegray500Medium,
                )
              ],
            ),
            Spacer(
              flex: 53,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "lbl_56".tr,
                  style: theme.textTheme.titleSmall,
                ),
                SizedBox(height: 1.v),
                Text(
                  "lbl_classes".tr,
                  style: CustomTextStyles.labelLargeBluegray500Medium,
                )
              ],
            ),
            Spacer(
              flex: 46,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "lbl_56".tr,
                  style: theme.textTheme.titleSmall,
                ),
                SizedBox(height: 1.v),
                Text(
                  "lbl_resourses".tr,
                  style: CustomTextStyles.labelLargeBluegray500Medium,
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 26.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "lbl_14".tr,
                    style: theme.textTheme.titleSmall,
                  ),
                  SizedBox(height: 1.v),
                  Text(
                    "lbl_tests".tr,
                    style: CustomTextStyles.labelLargeBluegray500Medium,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildChapterColumn3(setState) {
    bool isCoursePurchased = (enrolController.courseEnrollist.isNotEmpty &&
        enrolController.courseEnrollist[0].studentCourseId != 0);
    return Column(
      children: List.generate(
        homeController.courseDetailsContent.length,
        (index) => Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 2.v),
                  child: Text(
                    'Chapter ${homeController.courseDetailsContent[index].sectionId} :  ${homeController.courseDetailsContent[index].sectionName}',
                    style: CustomTextStyles.labelLargeBluegray500Medium,
                  ),
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgArrowDownBlack900,
                  height: 18.adaptSize,
                  width: 18.adaptSize,
                )
              ],
            ),
            SizedBox(height: 3.v),
            Column(
              children: List.generate(
                  homeController.courseDetailsContent[index].contents.length,
                  (contentIndex) => Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(3.h),
                            decoration: AppDecoration.outlineBlueGray.copyWith(
                              borderRadius: BorderRadiusStyle.roundedBorder12,
                            ),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    final content = homeController
                                        .courseDetailsContent[index]
                                        .contents[contentIndex];

                                    final fileUrl = content.file;
                                    final fileName = content.fileName;

                                    if (fileUrl != null && fileUrl.isNotEmpty) {
                                      if (!isCoursePurchased &&
                                          contentIndex > 0) {
                                        Get.showSnackbar(GetSnackBar(
                                          message:
                                              'Purchase to view the full content!',
                                          duration:
                                              Duration(milliseconds: 2000),
                                        ));
                                        return;
                                      }

                                      if (fileName!.endsWith('.pdf')) {
                                        Get.to(() => PdfViewerPage(
                                              isFromCourseScreen: true,
                                              fileUrl:
                                                  '${HttpUrls.imgBaseUrl}$fileUrl',
                                            ));
                                      } else {
                                        videoController.contentVideoUrl.value =
                                            '${HttpUrls.imgBaseUrl}$fileUrl';
                                        print(
                                            '<<<<<<<<<<<<<<<urllllllllllll>>>>>>>>>>>>>>>');
                                        print(videoController
                                            .contentVideoUrl.value);

                                        // _videoPlayerController.dispose();
                                        _scrollToTop();
                                        Loader.showLoader();

                                        // _videoPlayerController =
                                        //     VideoPlayerController.networkUrl(
                                        //         Uri.parse(
                                        //             '${HttpUrls.imgBaseUrl}$fileUrl'));
                                        // await Future.wait([
                                        //   _videoPlayerController.initialize(),
                                        // ]);
                                        // _createChewieController();
                                        setState(() {});
                                        Loader.stopLoader();
                                        print('calling build');
                                      }
                                    } else {
                                      Get.showSnackbar(GetSnackBar(
                                        message: 'Video not available',
                                        duration: Duration(milliseconds: 2000),
                                      ));
                                    }

                                    print('contents clicked');
                                    print(fileUrl);
                                    print(fileName);
                                    print(content.fileType);
                                  },
                                  child: _buildChapterColumn(
                                    oneOne: "lbl_1".tr,
                                    courseId: homeController
                                            .courseDetails?.courseId ??
                                        0,
                                    contentData: homeController
                                        .courseDetailsContent[index]
                                        .contents[contentIndex],
                                    imgUrl: homeController
                                        .courseDetailsContent[index]
                                        .contents[contentIndex]
                                        .contentThumbnailPath,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 3.v),
                        ],
                      )),

              // SizedBox(height: 4.v),
              // Container(
              //   padding: EdgeInsets.all(3.h),
              //   decoration: AppDecoration.outlineBlueGray.copyWith(
              //     borderRadius: BorderRadiusStyle.roundedBorder12,
              //   ),
              //   child: Row(
              //     children: [
              //       Expanded(
              //         child: _buildChapterColumn(
              //           oneOne: "lbl_1".tr,
              //         ),
              //       ),
              //       Padding(
              //         padding: EdgeInsets.only(
              //           left: 8.h,
              //           top: 4.v,
              //           bottom: 3.v,
              //         ),
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Text(
              //               "msg_introduction_to2".tr,
              //               style: theme.textTheme.labelLarge,
              //             ),
              //             SizedBox(height: 3.v),
              //             Row(
              //               children: [
              //                 Text(
              //                   "lbl_15_04_mins".tr,
              //                   style: theme.textTheme.bodySmall,
              //                 ),
              //                 Opacity(
              //                   opacity: 0.5,
              //                   child: Container(
              //                     height: 2.adaptSize,
              //                     width: 2.adaptSize,
              //                     margin: EdgeInsets.only(
              //                       left: 4.h,
              //                       top: 5.v,
              //                       bottom: 5.v,
              //                     ),
              //                     decoration: BoxDecoration(
              //                       color: theme.colorScheme.primaryContainer,
              //                       borderRadius: BorderRadius.circular(
              //                         1.h,
              //                       ),
              //                     ),
              //                   ),
              //                 ),
              //                 Padding(
              //                   padding: EdgeInsets.only(left: 4.h),
              //                   child: Text(
              //                     "lbl_3_tests".tr,
              //                     style: theme.textTheme.bodySmall,
              //                   ),
              //                 ),
              //                 Opacity(
              //                   opacity: 0.5,
              //                   child: Container(
              //                     height: 2.adaptSize,
              //                     width: 2.adaptSize,
              //                     margin: EdgeInsets.only(
              //                       left: 4.h,
              //                       top: 5.v,
              //                       bottom: 5.v,
              //                     ),
              //                     decoration: BoxDecoration(
              //                       color: theme.colorScheme.primaryContainer,
              //                       borderRadius: BorderRadius.circular(
              //                         1.h,
              //                       ),
              //                     ),
              //                   ),
              //                 ),
              //                 Padding(
              //                   padding: EdgeInsets.only(left: 4.h),
              //                   child: Text(
              //                     "lbl_8_materials".tr,
              //                     style: theme.textTheme.bodySmall,
              //                   ),
              //                 )
              //               ],
              //             )
              //           ],
              //         ),
              //       ),
              //       Spacer(),
              //       CustomImageView(
              //         imagePath: ImageConstant.imgFrame2609175,
              //         height: 26.adaptSize,
              //         width: 26.adaptSize,
              //         margin: EdgeInsets.only(
              //           top: 7.v,
              //           right: 7.h,
              //           bottom: 7.v,
              //         ),
              //       )
              //     ],
              //   ),
              // )
            ),
            SizedBox(height: 6.v),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildChapterColumn4() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "msg_chapter_2_oet".tr,
          style: CustomTextStyles.labelLargeInterBluegray500,
        ),
        SizedBox(height: 4.v),
        Obx(
          () => ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 4.v,
              );
            },
            itemCount: videoController.courseDetailsPage1ModelObj.value
                .viewhierarchy2ItemList.value.length,
            itemBuilder: (context, index) {
              Viewhierarchy2ItemModel model = videoController
                  .courseDetailsPage1ModelObj
                  .value
                  .viewhierarchy2ItemList
                  .value[index];
              return Viewhierarchy2ItemWidget(
                model,
              );
            },
          ),
        ),
        SizedBox(height: 12.v),
        CustomOutlinedButton(
          height: 36.v,
          text: "msg_view_all_23_chapters".tr,
          buttonStyle: CustomButtonStyles.outlineBlueGrayTL12,
          buttonTextStyle: CustomTextStyles.titleSmallMedium_1,
        )
      ],
    );
  }

  /// Section Widget
  Widget _buildReviewRow({required CourseReviewModel reviewData}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          height: 36.adaptSize,
          width: 36.adaptSize,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      '${HttpUrls.imgBaseUrl}${reviewData.reviewImgPath}'))),
        ),

        // CustomImageView(
        //   imagePath: ImageConstant.imgEllipse8,
        //   height: 36.adaptSize,
        //   width: 36.adaptSize,
        //   radius: BorderRadius.circular(
        //     18.h,
        //   ),
        // ),
        Padding(
          padding: EdgeInsets.only(
            left: 12.h,
            bottom: 3.v,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                reviewData.firstName,
                style: CustomTextStyles.labelLargeInterBlack900_1,
              ),
              SizedBox(height: 1.v),
              Text(
                DateFormat('dd-MM-yyyy').format(reviewData.createdAt),
                style: CustomTextStyles.labelLargeInterBlack900Medium,
              )
            ],
          ),
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.only(
            top: 17.v,
            bottom: 3.v,
          ),
          child: Text(
            reviewData.rating.toString(),
            style: CustomTextStyles.labelLargeInterPrimaryContainer,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 4.h,
            top: 19.v,
            bottom: 5.v,
          ),
          child: CustomRatingBar(
            initialRating: double.parse(reviewData.rating.toString()),
            unselectedColor: appTheme.gray200,
            color: Colors.amber,
          ),
        )
      ],
    );
  }

  /// Section Widget
  Widget _buildReviewRow1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomImageView(
          imagePath: ImageConstant.imgEllipse8,
          height: 36.adaptSize,
          width: 36.adaptSize,
          radius: BorderRadius.circular(
            18.h,
          ),
          margin: EdgeInsets.only(bottom: 2.v),
        ),
        Padding(
          padding: EdgeInsets.only(left: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "lbl_arthur".tr,
                style: CustomTextStyles.labelLargeInterBlack900,
              ),
              SizedBox(height: 6.v),
              Text(
                "lbl_04_02_2023".tr,
                style: CustomTextStyles.labelLargeInterBlack900Medium,
              )
            ],
          ),
        ),
        Spacer(),
        Container(
          width: 112.h,
          margin: EdgeInsets.only(top: 23.v),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "lbl_4_4".tr,
                style: CustomTextStyles.labelLargeInterBlack900Medium_1,
              ),
              Padding(
                padding: EdgeInsets.only(left: 4.h),
                child: CustomRatingBar(
                  initialRating: 5,
                  color: appTheme.gray200,
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  /// Section Widget
  // Widget _buildTotalPriceRow() {
  //   return Container(
  //     margin: EdgeInsets.only(
  //       left: 16.h,
  //       right: 16.h,
  //       bottom: 16.v,
  //     ),
  //     decoration: AppDecoration.gradientWhiteAToWhiteA,
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Text(
  //               "lbl_total_price".tr,
  //               style: CustomTextStyles.titleSmallBluegray80001Medium,
  //             ),
  //             Padding(
  //               padding: EdgeInsets.only(top: 2.v),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   Padding(
  //                     padding: EdgeInsets.only(bottom: 1.v),
  //                     child: Text(
  //                       "lbl".tr,
  //                       style: CustomTextStyles.titleMediumMedium,
  //                     ),
  //                   ),
  //                   Padding(
  //                     padding: EdgeInsets.only(left: 2.h),
  //                     child: Text(
  //                       controllerCourseDetailsController
  //                               .courseDetails?.price ??
  //                           '0',
  //                       style: CustomTextStyles.titleMedium18,
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             )
  //           ],
  //         ),
  //         CustomElevatedButton(
  //           onPressed: () async {
  //             // await showModalBottomSheet(
  //             //     context: Get.context!,
  //             //     builder: (context) => CheckoutBottomSheetWidget(
  //             //           courseDetails:
  //             //               controllerCourseDetailsController.courseDetails,
  //             //         ));
  //             enrolController.courseEnrollist[0].studentCourseId != 0
  //                 ? Get.showSnackbar(GetSnackBar(
  //                     message: 'Already Enrolled',
  //                     duration: Duration(milliseconds: 2000),
  //                   ))
  //                 : await showModalBottomSheet(
  //                     context: Get.context!,
  //                     builder: (context) => BottomSheetGuidanceWidget(
  //                       amount: controllerCourseDetailsController
  //                               .courseDetails?.price ??
  //                           '0',
  //                       courseDetails:
  //                           controllerCourseDetailsController.courseDetails,
  //                     ),
  //                   );

  //             // controllerCourseDetailsController.enrollNowApi(
  //             //     courseId: controllerCourseDetailsController
  //             //             .courseDetails?.courseId ??
  //             //         0,
  //             //     totalPrice:
  //             //         controllerCourseDetailsController.courseDetails?.price ??
  //             //             '0');
  //           },
  //           width: 169.h,
  //           text: "lbl_enroll_now".tr,
  //           margin: EdgeInsets.only(bottom: 7.v),
  //         )
  //       ],
  //     ),
  //   );
  // }

  /// Common widget
  Widget _buildChapterColumn(
      {required String oneOne,
      required String imgUrl,
      required int courseId,
      required CoursePageModel.Content contentData}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 100.v,
              height: MediaQuery.of(context).size.width * 0.2,
              padding: EdgeInsets.symmetric(
                horizontal: 8.h,
                vertical: 2.v,
              ),
              decoration: AppDecoration.fillBlack900.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder8,
                image: DecorationImage(
                  image: NetworkImage(
                    '${HttpUrls.imgBaseUrl}$imgUrl',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   oneOne,
                  //   style: CustomTextStyles.bodySmallWhiteA700.copyWith(
                  //     color: appTheme.whiteA700,
                  //   ),
                  // ),
                  // SizedBox(height: 10.v),
                  CustomImageView(
                    imagePath: ImageConstant.imgPlay,
                    height: 13.adaptSize,
                    width: 13.adaptSize,
                    alignment: Alignment.center,
                  )
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.width * 0.2,
              padding: EdgeInsets.only(
                left: 8.h,
                top: 5.v,
                bottom: 5.v,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contentData.contentName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.labelLarge,
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        "lbl_15_04_mins".tr,
                        style: theme.textTheme.bodySmall,
                      ),
                      Opacity(
                        opacity: 0.5,
                        child: Container(
                          height: 2.adaptSize,
                          width: 2.adaptSize,
                          margin: EdgeInsets.only(
                            left: 4.h,
                            top: 5.v,
                            bottom: 5.v,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(
                              1.h,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 4.h),
                        child: Text(
                          "lbl_3_tests".tr,
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                      Opacity(
                        opacity: 0.5,
                        child: Container(
                          height: 2.adaptSize,
                          width: 2.adaptSize,
                          margin: EdgeInsets.only(
                            left: 4.h,
                            top: 5.v,
                            bottom: 5.v,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(
                              1.h,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 4.h),
                        child: Text(
                          "lbl_8_materials".tr,
                          style: theme.textTheme.bodySmall,
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),

        //     Column(children: List.generate(contentData.exams!.length, (index) => InkWell(

        //        onTap: (){
        //          controllerCourseDetailsController.getExamDetails(
        //         courseId: contentData.exams![index].examId);

        //       },

        //       child: Container(child: Text(' Total questions  ${contentData.exams![index].}'),))),)
      ],
    );
  }

  /// Navigates to the previous screen.
  onTapArrowleftone() {
    Get.back();
  }
}
