import 'package:anandhu_s_application4/core/colors_res.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class CustomControls extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final ChewieController chewieController;

  CustomControls({
    required this.videoPlayerController,
    required this.chewieController,
  });

  @override
  _CustomControlsState createState() => _CustomControlsState();
}

class _CustomControlsState extends State<CustomControls> {
  bool showControls = true;

  void toggleControls() {
    setState(() {
      showControls = !showControls;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleControls,
      child: AnimatedOpacity(
        opacity: showControls ? 1.0 : 0.0,
        duration: Duration(milliseconds: 300),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: ColorResources.colorBlack.withOpacity(.5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.forward_10,
                          color: ColorResources.colorwhite,
                        ),
                        onPressed: () {
                          widget.videoPlayerController.seekTo(
                            widget.videoPlayerController.value.position +
                                Duration(seconds: 10),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(
                            widget.videoPlayerController.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                            color: ColorResources.colorwhite,
                            size: 20),
                        onPressed: () {
                          widget.videoPlayerController.value.isPlaying
                              ? widget.videoPlayerController.pause()
                              : widget.videoPlayerController.play();
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.replay_10,
                          size: 20,
                          color: ColorResources.colorwhite,
                        ),
                        onPressed: () {
                          widget.videoPlayerController.seekTo(
                            widget.videoPlayerController.value.position -
                                Duration(seconds: 10),
                          );
                        },
                      ),
                      Expanded(
                        child: VideoProgressIndicator(
                          widget.videoPlayerController,
                          allowScrubbing: true,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.speed),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return SimpleDialog(
                                title: Text('Select Speed'),
                                children: [
                                  SimpleDialogOption(
                                    onPressed: () {
                                      widget.videoPlayerController
                                          .setPlaybackSpeed(0.5);
                                      Navigator.pop(context);
                                    },
                                    child: Text('0.5x'),
                                  ),
                                  SimpleDialogOption(
                                    onPressed: () {
                                      widget.videoPlayerController
                                          .setPlaybackSpeed(1.0);
                                      Navigator.pop(context);
                                    },
                                    child: Text('1.0x'),
                                  ),
                                  SimpleDialogOption(
                                    onPressed: () {
                                      widget.videoPlayerController
                                          .setPlaybackSpeed(1.5);
                                      Navigator.pop(context);
                                    },
                                    child: Text('1.5x'),
                                  ),
                                  SimpleDialogOption(
                                    onPressed: () {
                                      widget.videoPlayerController
                                          .setPlaybackSpeed(2.0);
                                      Navigator.pop(context);
                                    },
                                    child: Text('2.0x'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.fullscreen),
                        onPressed: () {
                          widget.chewieController.enterFullScreen();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
