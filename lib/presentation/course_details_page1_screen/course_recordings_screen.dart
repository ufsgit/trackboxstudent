import 'dart:async';
import 'package:anandhu_s_application4/core/colors_res.dart';
import 'package:anandhu_s_application4/http/http_urls.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/controller/course_content_controller.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/controller/course_enrol_controller.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/listening_test_screen.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/pdf_viewer_screen.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/widgets/course_curriculam_widget.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/widgets/course_recording_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:video_player/video_player.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../home_page/controller/home_controller.dart';
import '../home_page/models/home_model.dart';
import 'controller/course_details_page1_controller.dart';
import 'package:audioplayers/audioplayers.dart';

class CourseRecordingsScreen extends StatefulWidget {
  CourseRecordingsScreen({
    Key? key,
    required this.courseId,
  }) : super(
          key: key,
        );
  final String? courseId;

  @override
  State<CourseRecordingsScreen> createState() => _CourseRecordingsScreenState();
}

class _CourseRecordingsScreenState extends State<CourseRecordingsScreen>
    with SingleTickerProviderStateMixin {
  HomeController homeController = Get.put(HomeController(HomeModel().obs));
  CourseModuleController courseContentController =
      Get.put(CourseModuleController());

  late FlickManager flickManager;
  final ScrollController _scrollController = ScrollController();
  late Future<void> _initializeVideoPlayerFuture;
  int? bufferDelay;
  bool _showControls = false;

  String? _videoUrl;
  int? selectedIndex = 0;

  Timer? _hideControlsTimer;
  String selectedPdfUrl = '';
  int currPlayIndex = 0;
  late Animation<double> animation;
  late AnimationController controller;
  bool _isAnimating = false;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);

    getData();
    super.initState();
  }

  getData() async {
    await courseContentController
        .getRecordings(courseId: widget.courseId.toString())
        .then((v) {
      flickManager = FlickManager(
        videoPlayerController:
            VideoPlayerController.networkUrl(Uri.parse(_videoUrl ?? '')),
      );
      _initializeVideoPlayerFuture = Future.value();

      initializePlayer();
    });
  }

  void showVideo(String url) {
    setState(() {
      _videoUrl = url;
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
    super.dispose();
  }

  Future<void> initializePlayer() async {
    setState(() {});
  }

  Future<void> toggleVideo() async {
    await initializePlayer();
  }

  double _playbackSpeed = 1.0;
  void _changePlaybackSpeed(double speed) {
    setState(() {
      _playbackSpeed = speed;
      flickManager.flickControlManager?.setPlaybackSpeed(speed);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(vertical: 5.v),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 5.v),
                    padding: EdgeInsets.symmetric(horizontal: 16.h),
                    child: Obx(() {
                      return courseContentController.recordings.isNotEmpty
                          ? Column(
                              children: [
                                Container(
                                  height: 200,
                                  child: Stack(
                                    children: [
                                      FlickVideoPlayer(
                                          flickManager: flickManager =
                                              FlickManager(
                                        videoPlayerController:
                                            VideoPlayerController.networkUrl(
                                                Uri.parse(
                                                    '${HttpUrls.imgBaseUrl}${courseContentController.recordings.isNotEmpty ? courseContentController.recordings[0].recordClassLink : ''}' ??
                                                        '')),
                                      )),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: PopupMenuButton(
                                          color: Colors.white,
                                          iconColor: Colors.grey.shade600,
                                          itemBuilder: (c) => [
                                            PopupMenuItem(
                                              onTap: () =>
                                                  _changePlaybackSpeed(0.5),
                                              child: Text(
                                                '0.5x',
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                            PopupMenuItem(
                                              onTap: () =>
                                                  _changePlaybackSpeed(1.0),
                                              child: Text(
                                                '1x',
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                            PopupMenuItem(
                                              onTap: () =>
                                                  _changePlaybackSpeed(1.5),
                                              child: Text(
                                                '1.5x',
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                            PopupMenuItem(
                                              onTap: () =>
                                                  _changePlaybackSpeed(2),
                                              child: Text(
                                                '2x',
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20.v),
                                Container(
                                  width: 322.h,
                                  margin: EdgeInsets.only(right: 5.h),
                                  child: Text(
                                    homeController.title.value,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: CustomTextStyles.titleMedium18_1
                                        .copyWith(
                                      height: 1.50,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Videos',
                                      style: GoogleFonts.plusJakartaSans(
                                          color: ColorResources.colorgrey700,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18),
                                    ),
                                  ],
                                ),
                                Divider(),
                                SizedBox(height: 16),
                                ListView.builder(
                                  itemCount:
                                      courseContentController.recordings.length,
                                  shrinkWrap: true,
                                  physics: ClampingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final recording = courseContentController
                                        .recordings[index];
                                    final isSelected = selectedIndex == index;

                                    return Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 3.0),
                                          child: Material(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              side: BorderSide(
                                                color: isSelected
                                                    ? Colors.blue
                                                    : Colors.transparent,
                                                width: 2,
                                              ),
                                            ),
                                            child: ListTile(
                                              onTap: () {
                                                isSelected
                                                    ? () {}
                                                    : setState(() {
                                                        selectedIndex = index;
                                                        _scrollController
                                                            .animateTo(
                                                          0.0,
                                                          duration: Duration(
                                                              milliseconds:
                                                                  300),
                                                          curve: Curves.easeOut,
                                                        );
                                                        showVideo(recording
                                                            .recordClassLink);
                                                      });
                                              },
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 0),
                                              dense: true,
                                              minVerticalPadding: 2,
                                              visualDensity:
                                                  VisualDensity.comfortable,
                                              title: Text(
                                                recording.recordClassLink,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style:
                                                    GoogleFonts.plusJakartaSans(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14),
                                              ),
                                              leading: Container(
                                                  height: 44,
                                                  width: 48,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          Colors.blue.shade200,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7)),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        '${HttpUrls.imgBaseUrl}${recording.thumbMailPath}',
                                                    fit: BoxFit.contain,
                                                    placeholder:
                                                        (BuildContext context,
                                                            String url) {
                                                      return Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          color: ColorResources
                                                              .colorBlue500,
                                                        ),
                                                      );
                                                    },
                                                    errorWidget:
                                                        (BuildContext context,
                                                            String url,
                                                            dynamic error) {
                                                      return Center(
                                                        child: Icon(
                                                          Icons
                                                              .image_not_supported_outlined,
                                                          color: ColorResources
                                                              .colorBlue100,
                                                          size: 40,
                                                        ),
                                                      );
                                                    },
                                                  )),
                                              subtitle: Row(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.all(5),
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5),
                                                    decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade200,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: Text(
                                                      recording.courseName,
                                                      style: GoogleFonts
                                                          .plusJakartaSans(
                                                              color: Colors.grey
                                                                  .shade600,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 12),
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                )
                              ],
                            )
                          : SizedBox(
                              height: Get.height / 1.5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(child: Text('No Recordings')),
                                ],
                              ),
                            );
                    }),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

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
        "Recordings",
        style: CustomTextStyles.titleMediumBluegray8000118,
      ),
    ),
  );
}

onTapArrowleftone() {
  Get.back();
}
