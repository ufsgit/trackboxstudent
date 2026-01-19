import 'package:anandhu_s_application4/widgets/gifviewer/gif_controller.dart';
import 'package:anandhu_s_application4/widgets/gifviewer/gif_view.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoPath;
  final String audioPath;

  VideoPlayerWidget({required this.videoPath, required this.audioPath});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  // late VideoPlayerController _controller;
  // bool _isVideoInitialized = false;
  String? _errorMessage;
  final player = AudioPlayer();
  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  Future<void> _initializeVideoPlayer() async {
    if (widget.audioPath.isNotEmpty) {
      await player.play(AssetSource(widget.audioPath));

      // print("Initializing video player with path: ${widget.videoPath}");
      // _controller = VideoPlayerController.asset(
      //     widget.videoPath);
      // _controller.initialize().then((_) {
      //   print("Video player initialized successfully");
      //   setState(() {
      //     _isVideoInitialized = true;
      //   });
      //   _controller.play();
      // }).catchError((error) {
      //   print("Error initializing video player: $error");
      //   if (error is PlatformException) {
      //     print("PlatformException details:");
      //     print("  Code: ${error.code}");
      //     print("  Message: ${error.message}");
      //     print("  Details: ${error.details}");
      //   }
      //   setState(() {
      //     _errorMessage = 'Error initializing video: $error';
      //   });
      // });
    }
  }

  @override
  void dispose() {
    // _controller.dispose();
    player.stop();
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_errorMessage != null) {
      return Center(child: Text(_errorMessage!));
    }

    return
        // _isVideoInitialized
        //   ? AspectRatio(
        //       aspectRatio: _controller.value.aspectRatio,
        //       // child: VideoPlayer(_controller),
        //       child:
        GifView.asset(
      controller: GifController(loop: false),
      widget.videoPath,

      height: 200,
      width: 200,
      frameRate: 30, // default is 15 FPS
    );
    //   )
    // : Center(child: CircularProgressIndicator());
  }
}
