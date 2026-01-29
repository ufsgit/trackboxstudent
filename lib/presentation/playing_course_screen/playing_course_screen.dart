import 'dart:developer';
import 'package:anandhu_s_application4/core/colors_res.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/controller/video_attendance_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import '../../core/app_export.dart';

class PlayingCourseScreen extends StatefulWidget {
  const PlayingCourseScreen({
    Key? key,
    required this.controller,
    this.courseId,
    this.contentId,
    this.contentTitle,
  }) : super(key: key);
  final VideoPlayerController controller;
  final int? courseId;
  final int? contentId;
  final String? contentTitle;

  @override
  State<PlayingCourseScreen> createState() => _PlayingCourseScreenState();
}

class _PlayingCourseScreenState extends State<PlayingCourseScreen> {
  // Watch time tracking
  Set<int> _watchedSegments = {};
  Duration _lastPosition = Duration.zero;
  bool _hasSubmittedAttendance = false;
  static const double ATTENDANCE_THRESHOLD = 1.0; // Mark immediate attendance

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_trackVideoProgress);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_trackVideoProgress);
    _submitAttendanceIfNeeded(); // Submit on exit
    super.dispose();
  }

  /// Track which seconds of video have been watched
  void _trackVideoProgress() {
    if (!widget.controller.value.isInitialized) return;

    final currentPosition = widget.controller.value.position;
    final currentSecond = currentPosition.inSeconds;

    // Only track forward progress (not seeking backward)
    if (currentPosition >= _lastPosition) {
      _watchedSegments.add(currentSecond);
    }

    _lastPosition = currentPosition;

    // Check if video ended
    if (currentPosition >=
        widget.controller.value.duration - Duration(seconds: 1)) {
      _submitAttendanceIfNeeded();
    }
  }

  /// Submit attendance if watch threshold is met
  Future<void> _submitAttendanceIfNeeded() async {
    if (_hasSubmittedAttendance) return;
    if (widget.courseId == null || widget.contentId == null) return;

    final totalDuration = widget.controller.value.duration.inSeconds;
    final watchedDuration = _watchedSegments.length;
    final watchPercentage = (watchedDuration / totalDuration) * 100;

    if (watchPercentage >= ATTENDANCE_THRESHOLD) {
      _hasSubmittedAttendance = true;

      final controller = Get.find<VideoAttendanceController>();
      final success = await controller.saveVideoAttendance(
        courseId: widget.courseId!,
        contentId: widget.contentId!,
        contentTitle: widget.contentTitle ?? 'Video Content',
        watchDurationSeconds: watchedDuration,
        totalDurationSeconds: totalDuration,
      );

      if (success) {
        Get.snackbar(
          'Attendance Marked',
          'Attendance recorded for this video',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.black,
        child: Stack(
          children: [
            Center(
              child: widget.controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: widget.controller.value.aspectRatio,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: <Widget>[
                          VideoPlayer(widget.controller),
                          _ControlsOverlay(controller: widget.controller),
                          VideoProgressIndicator(
                            widget.controller,
                            allowScrubbing: true,
                          ),
                        ],
                      ),
                    )
                  : Container(),
            ),
            Align(alignment: Alignment.bottomCenter, child: Icon(Icons.abc)),
          ],
        ),
      ),
    );
  }
}

class _ControlsOverlay extends StatelessWidget {
  const _ControlsOverlay({required this.controller});

  static const List<Duration> _exampleCaptionOffsets = <Duration>[
    Duration(seconds: -3),
    Duration(seconds: -1, milliseconds: -500),
    Duration(milliseconds: -250),
    Duration.zero,
    Duration(milliseconds: 250),
    Duration(seconds: 1, milliseconds: 500),
    Duration(seconds: 3),
  ];
  static const List<double> _examplePlaybackRates = <double>[
    0.25,
    0.5,
    1.0,
    1.5,
    2.0,
    3.0,
  ];

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          reverseDuration: const Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? const SizedBox.shrink()
              : const ColoredBox(
                  color: Colors.black26,
                  child: Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                      semanticLabel: 'Play',
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            log('${controller.value.duration}');
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
        ),
        Align(
          alignment: Alignment.topLeft,
          child: PopupMenuButton<Duration>(
            initialValue: controller.value.captionOffset,
            tooltip: 'Caption Offset',
            onSelected: (Duration delay) {
              controller.setCaptionOffset(delay);
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<Duration>>[
                for (final Duration offsetDuration in _exampleCaptionOffsets)
                  PopupMenuItem<Duration>(
                    value: offsetDuration,
                    child: Text('${offsetDuration.inMilliseconds / 1000}s'),
                  )
              ];
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                // Using less vertical padding as the text is also longer
                // horizontally, so it feels like it would need more spacing
                // horizontally (matching the aspect ratio of the video).
                vertical: 30.v,
                horizontal: 16.h,
              ),
              child: controller.value.isPlaying
                  ? const SizedBox.shrink()
                  : Container(
                      alignment: Alignment.center,
                      height: 20.h,
                      width: 40.v,
                      decoration: BoxDecoration(
                        color: ColorResources.colorBlue100,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        '${controller.value.captionOffset.inMilliseconds / 1000}s',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                        ),
                      ),
                    ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: PopupMenuButton<double>(
            initialValue: controller.value.playbackSpeed,
            tooltip: 'Playback speed',
            onSelected: (double speed) {
              controller.setPlaybackSpeed(speed);
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<double>>[
                for (final double speed in _examplePlaybackRates)
                  PopupMenuItem<double>(
                    value: speed,
                    child: Text('${speed}x'),
                  )
              ];
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                // Using less vertical padding as the text is also longer
                // horizontally, so it feels like it would need more spacing
                // horizontally (matching the aspect ratio of the video).
                vertical: 30.v,
                horizontal: 16.h,
              ),
              child: controller.value.isPlaying
                  ? const SizedBox.shrink()
                  : Container(
                      height: 20.h,
                      width: 76.v,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 20.h,
                            width: 40.v,
                            decoration: BoxDecoration(
                              color: ColorResources.colorBlue100,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              '${controller.value.playbackSpeed}x',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              SystemChrome.setPreferredOrientations(
                                  [DeviceOrientation.portraitUp]);
                              Get.toNamed(AppRoutes.playingCourseScreen);
                            },
                            child: Icon(
                              Icons.screen_rotation,
                              size: 20.v,
                              color: ColorResources.colorBlue100,
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}

// class PlayingCourseScreen extends GetWidget<PlayingCourseController> {
//   const PlayingCourseScreen({Key? key})
//       : super(
//           key: key,
//         );

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: appTheme.black900,
//         appBar: _buildAppBar(),
//         body: SizedBox(
//           width: SizeUtils.width,
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 _buildIntroductionRow(),
//                 SizedBox(height: 240.v),
//                 _buildImageStack(),
//                 SizedBox(height: 187.v),
//                 _buildTimeMapRow(),
//                 SizedBox(height: 301.v),
//                 Container(
//                   width: 328.h,
//                   margin: EdgeInsets.symmetric(horizontal: 16.h),
//                   child: Text(
//                     "msg_learn_the_templ".tr,
//                     maxLines: null,
//                     overflow: TextOverflow.ellipsis,
//                     textAlign: TextAlign.center,
//                     style: CustomTextStyles.bodyMediumInterGray200.copyWith(
//                       height: 1.43,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   /// Section Widget
//   PreferredSizeWidget _buildAppBar() {
//     return CustomAppBar(
//       height: 71.v,
//       leadingWidth: double.maxFinite,
//       leading: AppbarLeadingImage(
//         imagePath: ImageConstant.imgCaretleft,
//         margin: EdgeInsets.fromLTRB(16.h, 16.v, 334.h, 16.v),
//         onTap: () {
//           onTapCaretleftone();
//         },
//       ),
//     );
//   }

//   /// Section Widget
//   Widget _buildIntroductionRow() {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 16.h),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Padding(
//             padding: EdgeInsets.only(
//               top: 7.v,
//               bottom: 2.v,
//             ),
//             child: Text(
//               "msg_introduction_to2".tr,
//               style: CustomTextStyles.titleSmallWhiteA700SemiBold,
//             ),
//           ),
//           Opacity(
//             opacity: 0.7,
//             child: Container(
//               width: 30.h,
//               margin: EdgeInsets.only(
//                 left: 12.h,
//                 top: 3.v,
//                 bottom: 3.v,
//               ),
//               padding: EdgeInsets.symmetric(
//                 horizontal: 7.h,
//                 vertical: 2.v,
//               ),
//               decoration: AppDecoration.outlineWhiteA.copyWith(
//                 borderRadius: BorderRadiusStyle.roundedBorder4,
//               ),
//               child: Text(
//                 "lbl_1x".tr,
//                 style: CustomTextStyles.titleSmallInterWhiteA700,
//               ),
//             ),
//           ),
//           Container(
//             width: 30.h,
//             margin: EdgeInsets.only(
//               left: 20.h,
//               top: 3.v,
//               bottom: 3.v,
//             ),
//             padding: EdgeInsets.symmetric(
//               horizontal: 4.h,
//               vertical: 2.v,
//             ),
//             decoration: AppDecoration.outlineWhiteA.copyWith(
//               borderRadius: BorderRadiusStyle.roundedBorder4,
//             ),
//             child: Text(
//               "lbl_cc".tr,
//               style: CustomTextStyles.titleSmallInterWhiteA700,
//             ),
//           ),
//           CustomImageView(
//             imagePath: ImageConstant.imgSearch,
//             height: 28.adaptSize,
//             width: 28.adaptSize,
//             margin: EdgeInsets.only(left: 20.h),
//           )
//         ],
//       ),
//     );
//   }

//   /// Section Widget
//   Widget _buildImageStack() {
//     return SizedBox(
//       height: 200.v,
//       width: double.maxFinite,
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           CustomImageView(
//             imagePath: ImageConstant.imgRectangle23200x360,
//             height: 200.v,
//             width: 360.h,
//             alignment: Alignment.center,
//           ),
//           CustomImageView(
//             imagePath: ImageConstant.imgFrame1000005239,
//             height: 60.v,
//             width: 260.h,
//             alignment: Alignment.center,
//           )
//         ],
//       ),
//     );
//   }

//   /// Section Widget
//   Widget _buildTimeMapRow() {
//     return Padding(
//       padding: EdgeInsets.only(
//         left: 16.h,
//         right: 13.h,
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Expanded(
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       "lbl_28_35".tr,
//                       style: CustomTextStyles.bodySmallWhiteA70012,
//                     ),
//                     Text(
//                       "lbl_50_35".tr,
//                       style: CustomTextStyles.bodySmallWhiteA70012,
//                     )
//                   ],
//                 ),
//                 Slider(
//                   value: 0.0,
//                   min: 0.0,
//                   max: 100.0,
//                   onChanged: (value) {},
//                 )
//               ],
//             ),
//           ),
//           CustomImageView(
//             imagePath: ImageConstant.imgMap,
//             height: 15.adaptSize,
//             width: 15.adaptSize,
//             margin: EdgeInsets.only(
//               left: 11.h,
//               top: 4.v,
//               bottom: 4.v,
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   /// Navigates to the previous screen.
//   onTapCaretleftone() {
//     Get.back();
//   }
// }
