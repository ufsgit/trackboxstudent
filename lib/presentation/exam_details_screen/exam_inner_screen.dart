import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:anandhu_s_application4/presentation/exam_details_screen/answer_key_page.dart';
import 'package:anandhu_s_application4/presentation/exam_details_screen/controller/exam_details_controller.dart';
import 'package:anandhu_s_application4/http/http_urls.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ExamInnerPageScreen extends StatefulWidget {
  const ExamInnerPageScreen({Key? key}) : super(key: key);

  @override
  State<ExamInnerPageScreen> createState() => _ExamInnerPageScreenState();
}

class _ExamInnerPageScreenState extends State<ExamInnerPageScreen> {
  final ExamDetailsScreenController examDetailsScreenController =
      Get.put(ExamDetailsScreenController());
  late AudioPlayer audioPlayer;
  bool _isPlaying = false;
  Duration currentPosition = Duration.zero;
  Duration _duration = Duration.zero;

  @override
  void dispose() {
    examDetailsScreenController.audioPlayerLoopTime.value = 0;
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    _initializeAudioPlayer();
  }

  Future<void> _initializeAudioPlayer() async {
    if (examDetailsScreenController.specificExamDetailsList.isNotEmpty) {
      try {
        print('Loading audio from URL...');
        await audioPlayer.setUrl(
          "${HttpUrls.imgBaseUrl}${examDetailsScreenController.specificExamDetailsList[0].examDetails.mainQuestion}",
        );
        audioPlayer.setLoopMode(LoopMode.one);
        audioPlayer.play();
        examDetailsScreenController.isPlaying.value = true;
        setState(() {
          _isPlaying = true;
        });

        audioPlayer.positionStream.listen((position) {
          setState(() {
            currentPosition = position;
            examDetailsScreenController.audioPlayerLoopTime.value =
                position.inMilliseconds;
          });
        });

        audioPlayer.durationStream.listen((duration) {
          setState(() {
            _duration = duration ?? Duration.zero;
          });
        });
      } catch (e) {
        print('Error loading audio: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      splashRadius: 1,
                      onPressed: () async {
                        if (audioPlayer.playing) {
                          examDetailsScreenController.isPlaying.value = false;
                          await audioPlayer.pause();
                        } else {
                          examDetailsScreenController.isPlaying.value = true;
                          await audioPlayer.play();
                        }

                        _isPlaying = !_isPlaying;
                        // examDetailsScreenController.isPlaying.value = audioPlayer.playing;
                      },
                      icon: Obx(() => Icon(
                          examDetailsScreenController.isPlaying.value
                              ? Icons.pause
                              : Icons.play_arrow)),
                    ),
                    SizedBox(width: 15.v),
                    Obx(
                      () => Container(
                        margin: EdgeInsets.only(top: 10.v),
                        width: 250.v,
                        child: ProgressBar(
                          timeLabelPadding: 0,
                          timeLabelTextStyle:
                              TextStyle(fontSize: 8.v, color: Colors.black),
                          progress: Duration(
                              milliseconds: examDetailsScreenController
                                  .audioPlayerLoopTime.value),
                          buffered: Duration(milliseconds: 1000),
                          total: _duration,
                          onSeek: (duration) {
                            audioPlayer.seek(duration);
                          },
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: GetBuilder<ExamDetailsScreenController>(
              builder: (examData) {
                return Container(
                  child: examData.specificExamDetailsList.isEmpty
                      ? SizedBox()
                      : SfPdfViewer.network(
                          '${HttpUrls.imgBaseUrl}${examData.specificExamDetailsList[0].examDetails.supportingDocumentPath}',
                        ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: (examDetailsScreenController
                  .specificExamDetailsList[0].examDetails.answerKeyPath !=
              '')
          ? GetBuilder<ExamDetailsScreenController>(builder: (examData) {
              return InkWell(
                onTap: () {
                  print(
                      '////////////////////////${HttpUrls.imgBaseUrl}${examData.specificExamDetailsList[0].examDetails.answerKeyPath}');
                  Get.to(() => AnswerKeyPage(
                        answerKey:
                            '${HttpUrls.imgBaseUrl}${examData.specificExamDetailsList[0].examDetails.answerKeyPath}',
                      ));
                },
                child: Container(
                  margin: EdgeInsets.only(left: 15.v, right: 15.v),
                  height: 40.v,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(16.v),
                  ),
                  child: Center(
                    child: Text(
                      'View answer key',
                      style: TextStyle(color: Colors.white, fontSize: 12.v),
                    ),
                  ),
                ),
              );
            })
          : SizedBox(),
    );
  }
}
