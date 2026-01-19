import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:anandhu_s_application4/core/colors_res.dart';
import 'package:anandhu_s_application4/core/utils/extentions.dart';
import 'package:anandhu_s_application4/core/utils/file_utils.dart';
import 'package:anandhu_s_application4/http/aws_upload.dart';
import 'package:anandhu_s_application4/http/http_urls.dart';
import 'package:anandhu_s_application4/http/socket_io.dart';
import 'package:anandhu_s_application4/presentation/chat_screen/controller/chat_controller.dart';
import 'package:anandhu_s_application4/presentation/chat_screen/controller/chat_firebase_controller.dart';
import 'package:anandhu_s_application4/presentation/chat_screen/image_view_screen.dart';
import 'package:anandhu_s_application4/presentation/chat_screen/models/chat_message_model.dart';
import 'package:anandhu_s_application4/presentation/chat_screen/models/student_chat_model.dart';
import 'package:anandhu_s_application4/presentation/chat_screen/video_view_screen.dart';
import 'package:anandhu_s_application4/presentation/chat_screen/widgets/chat_widgets.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/pdf_viewer_screen.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:record/record.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../core/app_export.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:get_thumbnail_video/index.dart';

class ChatFireBaseScreen extends StatefulWidget {
  final String teacherName;
  final String profileUrl;
  final int teacherId;
  final int courseId;
  final bool isHod;
  ChatFireBaseScreen(
      {Key? key,
      required this.teacherName,
      required this.profileUrl,
      required this.teacherId,
      required this.isHod,
      required this.courseId})
      : super(
          key: key,
        );

  @override
  State<ChatFireBaseScreen> createState() => _ChatFireBaseScreenState();
}

class _ChatFireBaseScreenState extends State<ChatFireBaseScreen> {
  final _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _messageFocusNode = FocusNode();
  File? selectedFile = null;
  String filePath = '';
  File? recorderAudioFile;
  bool _isInitialLoadComplete = false;
  int _pendingImageLoads = 0;
  bool _shouldAutoScroll = true;
  final AudioRecorder _audioRecorder = AudioRecorder();
  bool _userIsScrollingUp = false;
  ChatFireBaseController chatController = Get.put(ChatFireBaseController());
  bool isMessageTyped = false;
  Timer? _timer;
  int _start = 0; // Timer starts from 0 seconds

  ChatHistoryController chatHistoryController =
      Get.find<ChatHistoryController>();

  final player = AudioPlayer();

  PlayerState? _playerState;

  StreamSubscription? _durationSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _playerCompleteSubscription;
  StreamSubscription? _playerStateChangeSubscription;
  Directory tempDir = Directory("");

  @override
  void initState() {
    super.initState();

    loadData();
    _messageController.addListener(() {
      setState(() {
        isMessageTyped = _messageController.text.isNotEmpty;
      });
    });
    _scrollController.addListener(_scrollListener);
  }

  Future<void> loadData() async {
    setState(() {
      _isInitialLoadComplete = true;
    });

    await chatController.fetchMessages(widget.isHod
        ? (widget.courseId.toString() + 'Hod')
        : widget.teacherId.toString());

    // await _scrollToBottom(animated: false);

    // // Now listen for new messages
    // chatController.messages.listen((_) {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     _scrollToBottom();
    //   });
    // });

    await _initStreams();
    await getTempDir();
  }

  @override
  void dispose() {
    chatController.isSendingMessage.value = false;
    chatController.isRecording.value = false;
    chatController.shouldAutoScroll.value = true;
    chatController.scrollNow.value = false;
    chatController.visibleScrollBtn.value = false;
    chatController.notVisibleMsgCount.value = 0;
    chatController.isFirstFetch.value = true;
    chatController.messages.value = [];
    chatController.chatSubscription?.cancel();

    _timer?.cancel();
    _scrollController.dispose();
    _messageFocusNode.dispose();
    player.stop();
    player.dispose();
    _audioRecorder.stop();
    _audioRecorder.dispose();

    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _playerStateChangeSubscription?.cancel();

    super.dispose();
  }

  // void _handleImageLoad() {
  //   _pendingImageLoads--;
  //   if (_pendingImageLoads <= 0 &&
  //       _isInitialLoadComplete &&
  //       _shouldAutoScroll) {
  //     _scrollToBottom(animated: false);
  //   }
  // }
  void _scrollListener() {
    // If user scrolls up manually, disable auto-scroll
    if (_scrollController.position.pixels <
        _scrollController.position.maxScrollExtent - 100) {
      chatController.shouldAutoScroll.value = false;
      chatController.visibleScrollBtn.value = false;
    }
    // Re-enable auto-scroll if user scrolls to bottom manually
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 10) {
      chatController.shouldAutoScroll.value = true;

      chatController.visibleScrollBtn.value = true;
      chatController.notVisibleMsgCount.value = 0;
    }
  }

  Future<void> _scrollToBottom(bool forceScroll) async {
    if ((chatController.shouldAutoScroll.value) || forceScroll) {
      // Use Future.delayed to ensure scroll happens after layout
      Future.delayed(const Duration(milliseconds: 100), () {
        if (_scrollController.hasClients) {
          // Scroll to the very bottom, considering all content
          // if(isJump) {
          _scrollController.jumpTo(
            _scrollController.position.maxScrollExtent +
                (!forceScroll
                    ? 50
                    : 5000), // to handle when last msg is img or video need to scroll extra to visible
          );
          // }else{
          //   _scrollController.animateTo(
          //
          //     _scrollController.position.maxScrollExtent+
          //         (!forceScroll ?50:5000), duration: Duration(milliseconds: 100), curve: Curves.easeIn,// to handle when last msg is img or video need to scroll extra to visible
          //   );
          // }
          chatController.scrollNow.value = false;
        }
      });
    }
  }

  getTempDir() async {
    tempDir = await getTemporaryDirectory();
    setState(() {});
  }

  // void _onScroll() {
  //   if (_scrollController.position.pixels == 0) {
  //     _loadMoreMessages();
  //   }
  // }

  // void _loadMoreMessages() {
  //   if (!chatController.isLoading.value) {
  //     chatController.fetchMessages(widget.teacherId.toString());
  //   }
  // }

  Future<void> pickMedia(bool isDoc) async {
    List<String> docList = [
      'pdf',
      'png',
      'doc',
      'docx',
      'xls',
      'xlsx',
    ];
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: isDoc
          ? docList
          : [
              'jpeg',
              'png',
              'mp4',
            ],
    );

    if (result != null) {
      if (isDoc && docList.contains(result.files.first.extension) || !isDoc) {
        // blocking not listed files like audio

        int maxFileSize = 20 * 1024 * 1024; // Example: 20 MB
        File file = File(result.files.first.path!);
        int fileSize = await file.length();

        if (fileSize > maxFileSize) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Maximum file size is 20 mb")),
          );
        } else {
          selectedFile = file;
        }

        setState(() {});
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  (result.files.first.extension ?? "") + " not supported")),
        );
      }
    } else {
      log('User closed without selecting');
    }
  }

  Future<void> downloadAndOpenFile(
      String fileName, int index, ChatMessageModel messageModel) async {
    final filePath = '${tempDir.path}/$fileName';
    String messageId = messageModel.sentTime.toString();
    //If the file is already downloaded, open it directly
    if (File(filePath).existsSync()) {
      if (fileName.endsWith(".pdf")) {
        OpenFile.open(filePath);
      } else if (fileName.endsWith(".m4a")) {
        playAudio(index, messageModel, filePath, false);
      }
      return;
    }

    chatController.updateDownloadProgress(index, 0.1);

    try {
      final dio = Dio();
      String url = HttpUrls.imgBaseUrl + messageModel.filePath!;
      await dio.download(
        url,
        filePath,
        onReceiveProgress: (received, total) {
          if (total > 0) {
            print((received / total).toString());
            chatController.updateDownloadProgress(index, received / total);
          }
        },
      );

      if (fileName.endsWith(".pdf")) {
        OpenFile.open(filePath);
      } else if (fileName.endsWith(".m4a")) {
        playAudio(index, messageModel, filePath, false);
      }
    } catch (e) {
      log('Error downloading or opening file: $e');
    } finally {
      chatController.updateDownloadProgress(index, 0);
    }
  }

  String _formatDateHeader(DateTime date) {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final isToday =
        date.day == now.day && date.month == now.month && date.year == now.year;
    final isYesterday = date.day == now.day - 1 &&
        date.month == now.month &&
        date.year == now.year;
    final isThisWeek = date.isAfter(startOfWeek);

    if (isToday) {
      return 'Today';
    } else if (isYesterday) {
      return 'Yesterday';
    } else if (isThisWeek) {
      return DateFormat('EEEE').format(date);
    } else {
      return DateFormat('MMMM dd, yyyy').format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        String studentId = preferences.getString('breffini_student_id') ?? '';

        if (studentId.isNotEmpty) {
          try {
            chatHistoryController.getChatAndCallHistory();
            int parsedTeacherId = int.parse(widget.teacherId.toString());
            ChatSocket.leaveConversationRoom(
                studentId.toString(),
                parsedTeacherId,
                widget.isHod ? 'hod_student' : 'teacher_student');
          } catch (e) {
            print('Error parsing teacherId: $e');
          }
        } else {
          print('teacherId is empty');
        }
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: ColorResources.colorgrey200,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(58.h),
            child: buildAppBar(
                widget.isHod ? "hod_student" : "teacher_student",
                widget.teacherName,
                widget.profileUrl,
                widget.teacherId,
                context),
          ),
          body: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 16.h,
                  ),
                  Obx(() {
                    if (chatController.scrollNow.value) {
                      _scrollToBottom(false);
                    }

                    return chatController.isLoadingChat.value
                        ? Expanded(
                            child: Center(
                                child: CircularProgressIndicator(color: ColorResources.colorBlue500,)),
                          )
                        : Expanded(
                            child: chatController.messages.isEmpty
                                ? Center(
                                    child: Text(
                                    'No messages yet',
                                    style: GoogleFonts.plusJakartaSans(
                                      color: ColorResources.colorgrey700,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ))
                                :

                                // ListView.builder(
                                //     cacheExtent: 1000,
                                //     addAutomaticKeepAlives: true,
                                //     itemCount: chatController.messages.length,
                                //     shrinkWrap: false,
                                //     controller: _scrollController,
                                //     itemBuilder: (context, index) {
                                //       ChatMessageModel messageModel =
                                //           chatController.messages[index];
                                //       final messageDate = DateFormat('yyyy-MM-dd')
                                //           .format(messageModel.sentTime!);
                                //       // log("lastDate$lastDate");
                                //       // if (messageDate != lastDate) {
                                //       //   lastDate = messageDate;
                                //       //   return Padding(
                                //       //     padding:
                                //       //         EdgeInsets.symmetric(vertical: 8.h),
                                //       //     child: Center(
                                //       //       child: Text(
                                //       //         _formatDateHeader(
                                //       //             messageModel.sentTime!),
                                //       //         style: GoogleFonts.plusJakartaSans(
                                //       //           color: ColorResources.colorgrey700,
                                //       //           fontSize: 12.0,
                                //       //           fontWeight: FontWeight.w500,
                                //       //         ),
                                //       //       ),
                                //       //     ),
                                //       //   );
                                //       // }
                                //       //  else
                                //       {
                                //         return Column(
                                //           children: [
                                //             if (index == 0 ||
                                //                 messageDate !=
                                //                     DateFormat('yyyy-MM-dd').format(
                                //                         chatController
                                //                             .messages[index - 1]
                                //                             .sentTime))
                                //               Padding(
                                //                 padding: EdgeInsets.symmetric(
                                //                     vertical: 8.h),
                                //                 child: Center(
                                //                   child: Text(
                                //                     _formatDateHeader(
                                //                         messageModel.sentTime!),
                                //                     style:
                                //                         GoogleFonts.plusJakartaSans(
                                //                       color: ColorResources
                                //                           .colorgrey700,
                                //                       fontSize: 12.0,
                                //                       fontWeight: FontWeight.w500,
                                //                     ),
                                //                   ),
                                //                 ),
                                //               ),
                                ListView.builder(
                                    reverse: false,
                                    // cacheExtent: 1000,
                                    // addAutomaticKeepAlives: true,
                                    itemCount: chatController.messages.length,
                                    shrinkWrap: true,
                                    controller: _scrollController,
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      ChatMessageModel messageModel =
                                          chatController.messages[index];
                                      final messageDate =
                                          DateFormat('yyyy-MM-dd').format(
                                              messageModel.sentTime.toLocal());

                                      {
                                        return Column(
                                          children: [
                                            if (index == 0 ||
                                                messageDate !=
                                                    DateFormat('yyyy-MM-dd')
                                                        .format(chatController
                                                            .messages[index - 1]
                                                            .sentTime
                                                            .toLocal()))
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 8.h),
                                                child: Center(
                                                  child: Text(
                                                    _formatDateHeader(
                                                        messageModel.sentTime!
                                                            .toLocal()),
                                                    style: GoogleFonts
                                                        .plusJakartaSans(
                                                      color: ColorResources
                                                          .colorgrey700,
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 16.h, right: 16.h),
                                              child: Row(
                                                mainAxisAlignment: messageModel
                                                        .isStudent!
                                                    ? MainAxisAlignment.end
                                                    : MainAxisAlignment.start,
                                                children: [
                                                  if (messageModel.isStudent!)
                                                    SizedBox(width: 50.h),
                                                  Expanded(
                                                    child: Align(
                                                      alignment: messageModel
                                                              .isStudent!
                                                          ? Alignment
                                                              .centerRight
                                                          : Alignment
                                                              .centerLeft,
                                                      child: Column(
                                                        crossAxisAlignment: messageModel
                                                                .isStudent!
                                                            ? CrossAxisAlignment
                                                                .end
                                                            : CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5.0),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: messageModel.isStudent!
                                                                  ? ColorResources
                                                                      .colorgrey300
                                                                  : ColorResources
                                                                      .colorgrey300,
                                                              borderRadius: BorderRadius.only(
                                                                  topLeft:
                                                                      const Radius.circular(
                                                                          12),
                                                                  topRight:
                                                                      const Radius.circular(
                                                                          12),
                                                                  bottomLeft: messageModel
                                                                          .isStudent!
                                                                      ? const Radius.circular(
                                                                          12)
                                                                      : const Radius
                                                                          .circular(
                                                                          0),
                                                                  bottomRight: messageModel
                                                                          .isStudent!
                                                                      ? const Radius
                                                                          .circular(
                                                                          0)
                                                                      : const Radius
                                                                          .circular(
                                                                          12)),
                                                            ),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  !messageModel
                                                                          .isStudent!
                                                                      ? CrossAxisAlignment
                                                                          .end
                                                                      : CrossAxisAlignment
                                                                          .start,
                                                              children: [
                                                                if (messageModel
                                                                    .filePath!
                                                                    .isNotEmpty)
                                                                  Column(
                                                                    children: [
                                                                      (messageModel
                                                                              .filePath!
                                                                              .endsWith('.pdf'))
                                                                          ? GestureDetector(
                                                                              onTap: () {
                                                                                downloadAndOpenFile(messageModel.filePath!.split('/').last, index, messageModel);
                                                                              },
                                                                              child: Container(
                                                                                height: 67.h,
                                                                                width: 200.h,
                                                                                decoration: BoxDecoration(
                                                                                    color: messageModel.isStudent! ? ColorResources.colorwhite : ColorResources.colorwhite,
                                                                                    borderRadius: BorderRadius.all(
                                                                                      Radius.circular(12),
                                                                                    )),
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                  child: Row(
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    children: [
                                                                                      Obx(() {
                                                                                        return Container(
                                                                                          width: 40,
                                                                                          child: Column(
                                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            children: [
                                                                                              messageModel.progress! > 0
                                                                                                  ? Container(
                                                                                                      height: 23,
                                                                                                      width: 23,
                                                                                                      child: CircularProgressIndicator(
                                                                                                        value: messageModel.progress?.value,
                                                                                                      ),
                                                                                                    )
                                                                                                  : Icon(Icons.picture_as_pdf),
                                                                                              Padding(
                                                                                                padding: const EdgeInsets.only(top: 4.0),
                                                                                                child: Text(
                                                                                                  messageModel.fileSize! > 0 ? FileUtils.getFileSize(messageModel.fileSize ?? 0) : "",
                                                                                                  style: GoogleFonts.plusJakartaSans(color: ColorResources.colorBlack, fontSize: 8, fontWeight: FontWeight.w600),
                                                                                                ),
                                                                                              )
                                                                                            ],
                                                                                          ),
                                                                                        );
                                                                                      }),
                                                                                      Padding(
                                                                                        padding: const EdgeInsets.only(top: 4.0, left: 8),
                                                                                        child: Text(
                                                                                          'Pdf file',
                                                                                          style: GoogleFonts.plusJakartaSans(color: ColorResources.colorBlack, fontSize: 12, fontWeight: FontWeight.w600),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            )
                                                                          : (messageModel.filePath!.endsWith('.mp4'))
                                                                              ? GestureDetector(
                                                                                  onTap: () async {
                                                                                    Get.to(() => VideoViewScreen(videoUrl: '${HttpUrls.imgBaseUrl}${messageModel.filePath}', thumbUrl: '${HttpUrls.imgBaseUrl}${messageModel.thumbUrl}'));
                                                                                  },
                                                                                  child: Container(
                                                                                      height: 200.h,
                                                                                      width: 200.h,
                                                                                      decoration: BoxDecoration(
                                                                                        color: messageModel.isStudent! ? ColorResources.colorwhite : ColorResources.colorwhite,
                                                                                        borderRadius: BorderRadius.all(
                                                                                          Radius.circular(12),
                                                                                        ),
                                                                                      ),
                                                                                      child: Stack(
                                                                                        alignment: Alignment.center,
                                                                                        // mainAxisAlignment: MainAxisAlignment.center,
                                                                                        // crossAxisAlignment: CrossAxisAlignment.center,
                                                                                        children: [
                                                                                          if (!messageModel.thumbUrl!.isNullOrEmpty())
                                                                                            ClipRRect(
                                                                                              borderRadius: BorderRadius.circular(12),
                                                                                              child: CachedNetworkImage(
                                                                                                  imageUrl: '${HttpUrls.imgBaseUrl}${messageModel.thumbUrl}',
                                                                                                  width: double.infinity,
                                                                                                  height: double.infinity,
                                                                                                  fit: BoxFit.cover,
                                                                                                  errorWidget: (context, url, error) => const Center(
                                                                                                        child: Icon(
                                                                                                          Icons.image_not_supported_outlined,
                                                                                                          color: ColorResources.colorBlue100,
                                                                                                          size: 40,
                                                                                                        ),
                                                                                                      )),
                                                                                            ),
                                                                                          Icon(
                                                                                            Icons.play_circle,
                                                                                            color: ColorResources.colorgrey300,
                                                                                            size: 50,
                                                                                          ),
                                                                                          Padding(
                                                                                            padding: EdgeInsets.only(top: 70.h),
                                                                                            child: Text(
                                                                                              messageModel.fileSize! > 0 ? FileUtils.getFileSize(messageModel.fileSize ?? 0) : "",
                                                                                              style: GoogleFonts.plusJakartaSans(color: ColorResources.colorgrey300, fontSize: 10, fontWeight: FontWeight.w600),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      )),
                                                                                )
                                                                              : (messageModel.filePath!.endsWith('.m4a'))
                                                                                  ? SizedBox(
                                                                                      // height: 0,
                                                                                      width: 500,
                                                                                      child: Obx(() {
                                                                                        return Row(
                                                                                          children: [
                                                                                            (messageModel.progress! > 0)
                                                                                                ? Container(
                                                                                                    height: 20,
                                                                                                    width: 20,
                                                                                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                                                                                    child: CircularProgressIndicator(
                                                                                                      color: ColorResources.colorBlue300,
                                                                                                    ),
                                                                                                  )
                                                                                                : Container(
                                                                                                    width: 45,
                                                                                                    height: 45,
                                                                                                    margin: const EdgeInsets.all(4),
                                                                                                    decoration: const BoxDecoration(
                                                                                                      color: Color(0xFF6A7487),
                                                                                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                                                                                    ),
                                                                                                    child: InkWell(
                                                                                                        onTap: () {
                                                                                                          if (chatController.currentPlayingIndex == index) {
                                                                                                            final filePath = tempDir.path + "/" + messageModel.filePath!.split('/').last;
                                                                                                            playAudio(index, messageModel, filePath, true);
                                                                                                          } else {
                                                                                                            downloadAndOpenFile(messageModel.filePath!.split('/').last, index, messageModel);
                                                                                                          }
                                                                                                        },
                                                                                                        child: Icon(
                                                                                                          chatController.currentPlayingIndex == index ? Icons.pause : Icons.play_arrow,
                                                                                                          color: Colors.white,
                                                                                                          size: 28,
                                                                                                        )),
                                                                                                  ),
                                                                                            Expanded(
                                                                                              child: Slider(
                                                                                                thumbColor: messageModel.isStudent! ? const Color(0xFFE3E7EE) : const Color(0xFF6A7487),
                                                                                                activeColor: messageModel.isStudent! ? const Color(0xFF6A7487) : const Color(0xFF6A7487),
                                                                                                inactiveColor: messageModel.isStudent! ? const Color(0xFF6A7487) : const Color(0xFF6A7487),

                                                                                                min: 0,
                                                                                                max: chatController.currentPlayingIndex == index ? chatController.duration.value.inMilliseconds.toDouble() : 0,
                                                                                                // inactiveColor: ColorResources.colorgrey700,
                                                                                                // activeColor: ColorResources.colorgrey700,
                                                                                                value: chatController.currentPlayingIndex == index ? (chatController.position.value.inMilliseconds.toDouble() < chatController.duration.value.inMilliseconds.toDouble() ? chatController.position.value.inMilliseconds.toDouble() : chatController.duration.value.inMilliseconds.toDouble()) : 0,
                                                                                                onChanged: (value) {
                                                                                                  player.seek(Duration(milliseconds: value.round()));
                                                                                                },
                                                                                              ),
                                                                                            ),
                                                                                            (chatController.currentPlayingIndex == index)
                                                                                                ? Padding(
                                                                                                    padding: const EdgeInsets.only(right: 0),
                                                                                                    child: Text(
                                                                                                      ((chatController.position.value.inSeconds.toMinSecond()) + "/" + chatController.duration.value.inSeconds.toMinSecond()),
                                                                                                      style: GoogleFonts.plusJakartaSans(color: messageModel.isStudent ?? false ? ColorResources.colorBlack : ColorResources.colorBlack, fontSize: 8, fontWeight: FontWeight.w600),
                                                                                                    ),
                                                                                                  )
                                                                                                : Padding(
                                                                                                    padding: const EdgeInsets.only(right: 0),
                                                                                                    child: Text(
                                                                                                      "00:00/00:00",
                                                                                                      style: GoogleFonts.plusJakartaSans(color: messageModel.isStudent ?? false ? ColorResources.colorBlack : ColorResources.colorBlack, fontSize: 8, fontWeight: FontWeight.w600),
                                                                                                    ),
                                                                                                  ),
                                                                                          ],
                                                                                        );
                                                                                      }))
                                                                                  : GestureDetector(
                                                                                      onTap: () {
                                                                                        Get.to(() => ImageViewerScreen(imageUrl: '${HttpUrls.imgBaseUrl}${messageModel.filePath}'));
                                                                                      },
                                                                                      child: ClipRRect(
                                                                                          borderRadius: BorderRadius.circular(12),

                                                                                          // height: 150.h,
                                                                                          // width: 200.h,
                                                                                          // decoration:
                                                                                          // BoxDecoration(
                                                                                          //     color: messageModel
                                                                                          //         .isStudent!
                                                                                          //         ? ColorResources
                                                                                          //         .colorwhite
                                                                                          //         : ColorResources
                                                                                          //         .colorwhite,
                                                                                          //     borderRadius: BorderRadius.all(Radius
                                                                                          //         .circular(12),
                                                                                          //     )
                                                                                          // ),
                                                                                          child: CachedNetworkImage(
                                                                                            height: 150.h,
                                                                                            width: 200.h,
                                                                                            imageUrl: '${HttpUrls.imgBaseUrl}${messageModel.filePath}',
                                                                                            fit: BoxFit.cover,
                                                                                            errorWidget: (context, url, error) => const Center(
                                                                                              child: Icon(
                                                                                                Icons.image_not_supported_outlined,
                                                                                                color: ColorResources.colorBlue100,
                                                                                                size: 40,
                                                                                              ),
                                                                                            ),
                                                                                            progressIndicatorBuilder: (context, url, downloadProgress) => Center(
                                                                                              child: CircularProgressIndicator(
                                                                                                strokeWidth: 3,
                                                                                                color: ColorResources.colorBlue500,
                                                                                                value: downloadProgress.progress,
                                                                                              ),
                                                                                            ),
                                                                                            imageBuilder: (context, imageProvider) {
                                                                                              // WidgetsBinding.instance.addPostFrameCallback((_) {
                                                                                              //   _handleImageLoad();
                                                                                              // });
                                                                                              return Image(image: imageProvider, fit: BoxFit.cover);
                                                                                            },
                                                                                          )),
                                                                                    ),
                                                                      SizedBox(
                                                                          height:
                                                                              2),
                                                                    ],
                                                                  ),
                                                                if (!messageModel
                                                                    .chatMessage
                                                                    .isNullOrEmpty())
                                                                  SizedBox(
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                      child:
                                                                          Text(
                                                                        messageModel
                                                                            .chatMessage!,
                                                                        style: GoogleFonts
                                                                            .plusJakartaSans(
                                                                          color: messageModel.isStudent!
                                                                              ? ColorResources.colorBlack
                                                                              : ColorResources.colorBlack,
                                                                          fontSize:
                                                                              14.0,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                              ],
                                                            ),
                                                          ),
                                                          Text(
                                                            messageModel
                                                                .formattedTime,
                                                            style: GoogleFonts
                                                                .plusJakartaSans(
                                                              color: ColorResources
                                                                  .colorgrey600,
                                                              fontSize: 10.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              height: 15.h),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  if (!messageModel.isStudent!)
                                                    SizedBox(width: 50.h),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      }
                                    }),
                          );
                  }),
                ],
              ),
              Obx(() {
                return (chatController.visibleScrollBtn.value ||
                        chatController.messages.isEmpty)
                    ? const SizedBox.shrink()
                    : Positioned(
                        right: -5,
                        bottom: 90,
                        child: FloatingActionButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          )),
                          mini: true,
                          backgroundColor: Colors.grey[800],
                          onPressed: () {
                            _scrollToBottom(true);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.white,
                              ),
                              if (chatController.notVisibleMsgCount > 0)
                                Text(
                                  (chatController.notVisibleMsgCount)
                                      .toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 8),
                                )
                            ],
                          ),
                        ),
                      );
              }),
            ],
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Obx(() {
              return buildMessageSection(
                isVoiceMessage: chatController.isVoiceMessage.value,
                isRecording: chatController.isRecording.value,
                formattedTime: chatController.formattedTime.value,
                isMicOn: _messageController.text.isEmpty,
                isMessageTyped: isMessageTyped,
                isRecordingPaused: chatController.isRecordingPaused.value,
                onTextChanged: (value) {
                  if (value.isEmpty || value.length == 1) {
                    setState(() {});
                  }
                },
                controller: _messageController,
                isSendingMessage: chatController.isSendingMessage.value,
                onTapDocument: () async {
                  await pickMedia(true);
                  setState(() {});
                  Get.back();
                },
                onTapFile: () async {
                  await pickMedia(false);
                  setState(() {});
                  Get.back();
                },
                onPause: pauseRecording,
                onResume: resumeRecording,
                onStopVoice: () {
                  stopRecording(true);
                },
                height: selectedFile == null ? 68.h : Get.height / 1.6,
                context: context,
                fileName: null != selectedFile
                    ? FileUtils.getFileName(selectedFile!.path)
                    : "",
                onTap: () async {
                  if (_messageController.text.isNotEmpty ||
                      selectedFile != null) {
                    chatController.isSendingMessage.value = true;

                    await sendMessage(
                        selectedFile != null, selectedFile ?? File(""));
                    chatController.isSendingMessage.value = false;
                  } else {
                    if (recorderAudioFile == null ||
                        recorderAudioFile!.path.isNullOrEmpty()) {
                      chatController.isMicOn.value =
                          !chatController.isMicOn.value;
                      chatController.isVoiceMessage.value =
                          !chatController.isVoiceMessage.value;
                    }

                    if (!(await _audioRecorder.isRecording())) {
                      _startTimer();
                      await startRecording(); // Start recording
                    } else {
                      _stopTimer();
                      await stopRecording(false);
                      chatController.isSendingMessage.value = true;
                      await sendMessage(true, recorderAudioFile!);
                      chatController.isSendingMessage.value = false;
                    }

                    // // Check if there's an audio file to send
                    // if (selectedFile != null ) {
                    //   print('fgdf2');
                    //   File file = File(selectedFile?.path??"");
                    //
                    //   String? uploadKey = await AwsUpload.uploadChatImageToAws(
                    //     file,
                    //     widget.studentId,
                    //     await SharedPreferences.getInstance().then((prefs) =>
                    //     prefs.getString('breffini_teacher_Id') ?? "0"),
                    //     selectedFile?.extension ?? p.extension(audioFile!.path),
                    //   );
                    //
                    //   if (uploadKey != null) {
                    //     final filePath = uploadKey;
                    //     widget.userType == '2'
                    //         ? await _chatController.uploadFileAndSendMessage(
                    //         _messageController.text,
                    //         widget.studentId,
                    //         selectedFile?.path ?? audioFile!.path,
                    //         selectedFile?.extension ??
                    //             p.extension(audioFile!.path))
                    //         : await _chatController.uploadFileAndSendMessageofHod(
                    //         _messageController.text,
                    //         widget.studentId,
                    //         widget.courseId.toString(),
                    //         selectedFile?.path ?? audioFile!.path,
                    //         selectedFile?.extension ??
                    //             p.extension(audioFile!.path));
                    //
                    //     SharedPreferences preferences =
                    //     await SharedPreferences.getInstance();
                    //     String teacherId =
                    //         preferences.getString('breffini_teacher_Id') ?? '';
                    //     String courseIdString = widget.courseId;
                    //     int courseId = int.parse(
                    //         RegExp(r'\d+').stringMatch(courseIdString)!);
                    //     log("////////courseIDDDDDDDDD$courseId");
                    //
                    //     StudentChatModel studentMsg = StudentChatModel(
                    //       courseId: courseId,
                    //       chatType: widget.userType == '2'
                    //           ? 'teacher_student'
                    //           : 'hod_student',
                    //       teacherId: int.parse(teacherId),
                    //       studentId: int.parse(widget.studentId),
                    //       chatMessage: _messageController.text.trim(),
                    //       sentTime: DateTime.now().toString(),
                    //       isStudent: false,
                    //       filePath: filePath,
                    //     );
                    //
                    //     ChatbotSocket.startChatting(studentMsg);
                    //     _messageController.clear();
                    //
                    //     // String userTypeId =
                    //     //     preferences.getString('user_type_id') ?? '2';
                    //     // log('teacher id $teacherId');
                    //     // ChatbotSocket.getChatLogHistory(
                    //     //     teacherId,
                    //     //     userTypeId == '2'
                    //     //         ? 'teacher_student'
                    //     //         : 'hod_student');
                    //   } else {
                    //     log('Error uploading image');
                    //   }
                  }
                },
                imageWidget: selectedFile != null
                    ? Expanded(
                        child: Container(
                          // height: selectedFile!.path.isPdfFile()?(Get.height/2):40.h,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.h, vertical: 5),
                          alignment: Alignment.center,
                          // width: MediaQuery.of(context).size.width - 80.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.h),
                            color: ColorResources.colorwhite,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedFile = null;
                                        filePath = '';
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(4),
                                      child: const Icon(
                                        CupertinoIcons.clear_circled,
                                        color: ColorResources.colorBlue300,
                                        size: 35,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(4),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            FileUtils.getFileName(
                                                    selectedFile!.path) +
                                                "." +
                                                FileUtils.getFileExtension(
                                                    selectedFile!.path),
                                            overflow: TextOverflow.ellipsis,
                                            style: CustomTextStyles
                                                .titleSmallBluegray300Medium,
                                          ),
                                          Text(
                                            FileUtils.getFileSize(
                                                FileUtils.getFileSizeInKB(
                                                        selectedFile!.path) ??
                                                    0.0),
                                            overflow: TextOverflow.ellipsis,
                                            style: CustomTextStyles
                                                .titleSmallBluegray300Medium,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // Container(height: 50,),
                              Expanded(
                                child: selectedFile!.path.isPdfFile()
                                    ? PdfViewerPage(
                                        isFromCourseScreen: false,
                                        fileUrl: (selectedFile!.path),
                                        showAppBar: false,
                                      )
                                    : selectedFile!.path.isImageFile()
                                        ? Image.file(File(selectedFile!.path))
                                        : selectedFile!.path.isVideoFile()
                                            ? VideoViewScreen(
                                                videoUrl: selectedFile!.path,
                                                showAppBar: false,
                                              )
                                            : Text(
                                                FileUtils.getFileName(
                                                    selectedFile!.path),
                                                overflow: TextOverflow.ellipsis,
                                                style: CustomTextStyles
                                                    .titleSmallBluegray300Medium,
                                              ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : SizedBox(),
              );
            }),
          ),
        ),
      ),
    );
  }

  Future<void> sendMessage(bool isFileUpload, File file) async {
    String? thumbUrl = "";
    String? awsFileUrl = "";
    String teacherId = widget.isHod
        ? (widget.courseId.toString() + 'Hod')
        : widget.teacherId.toString();
    if (isFileUpload) {
      if (file.path.isVideoFile()) {
        // generate thumbnail
        String thumbnailFilePath =
            await FileUtils.generateThumbnail(selectedFile!.path);
        thumbUrl = await AwsUpload.uploadChatImageToAws(
          File(thumbnailFilePath),
          PrefUtils().getStudentId(),
          teacherId,
          FileUtils.getFileExtension(thumbnailFilePath),
        );
      }
      awsFileUrl = await chatController.uploadFileAndSendMessage(
          _messageController.text, teacherId, file, thumbUrl ?? "");
    } else {
      await chatController.sendMessage(
          _messageController.text, teacherId, 0.0, "");
    }

    String studentId = PrefUtils().getStudentId();
    StudentChatModel studentMsg = StudentChatModel(
      courseId: widget.isHod ? widget.courseId.toString() : null,
      chatType: widget.isHod ? "hod_student" : "teacher_student",
      teacherId: int.parse(widget.teacherId.toString()),
      studentId: int.parse(studentId),
      chatMessage: _messageController.text.trim(),
      sentTime: DateTime.now().toUtc().toString(),
      isStudent: true,
      filePath: awsFileUrl,
      fileSize: FileUtils.getFileSizeInKB(file.path),
      thumbUrl: thumbUrl,
      senderName: PrefUtils().getStudentName(),
      profileUrl: HttpUrls.imgBaseUrl + (PrefUtils().getProfileUrl()),
    );
    chatController.shouldAutoScroll.value = true;

    ChatSocket.startChatting(studentMsg);
    _messageController.clear();
    ChatSocket.getChatLogHistory(studentId, 'teacher_student');

    // _scrollToBottom();

    setState(() {
      selectedFile = null;
      filePath = '';
      recorderAudioFile = null;
    });
    _messageController.clear();
  }

  void _startTimer() {
    _timer?.cancel(); // Cancel any existing timer

    _start = 0; // Reset start time
    _updateTime(); // Update time immediately

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _start++;
        _updateTime();
      });
    });
  }

  void _updateTime() {
    int minutes = (_start ~/ 60);
    int seconds = (_start % 60);
    chatController.formattedTime.value =
        '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  void _pauseTimer() {
    if (_timer == null) return; // Only pause if the timer is running

    _timer?.cancel(); // Cancel the timer
    _timer = null; // Clear the timer variable
  }

  void _resumeTimer() {
    if (_timer != null)
      return; // Prevent resuming if the timer is already running

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _start++;
        _updateTime();
      });
    });
  }

  startRecording() async {
    try {
      if (player.state == PlayerState.playing) {
        await player.pause();
      }
      if (await _audioRecorder.hasPermission()) {
        chatController.isRecording.value = true;
        String fileName =
            DateTime.now().millisecondsSinceEpoch.toString() + ".m4a";
        final filePath = '${tempDir.path}/$fileName';

        recorderAudioFile = File(filePath);
        setState(() {});
        await _audioRecorder.start(const RecordConfig(), path: filePath);
      }
    } catch (e) {
      log('Error starting recording: $e');
    }
  }

  stopRecording(bool isStopAndExit) async {
    try {
      final path = await _audioRecorder.stop();
      setState(() {
        if (path != null) {
          recorderAudioFile = File(path);
        }
        if (isStopAndExit) {
          recorderAudioFile = null;
        }
      });
      chatController.isRecording.value = false;
      chatController.isRecordingPaused.value = false;
      chatController.isMicOn.value = !chatController.isMicOn.value;
      chatController.isVoiceMessage.value =
          !chatController.isVoiceMessage.value;
    } catch (e) {
      log('Error stopping recording: $e');
    }
  }

  pauseRecording() async {
    try {
      _pauseTimer();

      if (player.state == PlayerState.playing) {
        await player.pause();
      }
      await _audioRecorder.pause();
      setState(() {
        chatController.isRecording.value = false;
        chatController.isRecordingPaused.value = true;
      });
    } catch (e) {
      log('Error pausing recording: $e');
    }
  }

  resumeRecording() async {
    try {
      _resumeTimer();
      await _audioRecorder.resume();
      chatController.isRecordingPaused.value = false;
      chatController.isRecording.value = true;
    } catch (e) {
      log('Error resuming recording: $e');
    }
  }

  playAudio(int index, ChatMessageModel messageModel, String localPath,
      bool isPause) async {
    if (player.state == PlayerState.playing) {
      await player.pause();
      chatController.updatePlayerStatus(index, false);
      if (isPause) {
        return;
      }
    }
    if (localPath.isNotEmpty) {
      chatController.updatePlayerStatus(index, true);
      await player.play(DeviceFileSource(localPath));
    } else {
      await player.play(UrlSource(messageModel.filePath!));
    }
  }

  _initStreams() {
    _durationSubscription = player.onDurationChanged.listen((duration) {
      chatController.updatePlayerDuration(duration);

      // setState(() => _duration = duration);
      // print(duration.inSeconds.toString() + "dddddddddddd");
    });

    _positionSubscription = player.onPositionChanged.listen(
      (p) {
        chatController.updatePlayerPosition(p);
        // setState(() => _position = p);
        // print(_position.inSeconds.toString() + "position");
      },
    );

    _playerCompleteSubscription = player.onPlayerComplete.listen((event) {
      chatController.updatePlayerStatus(-1, false);

      // setState(() {
      //   _playerState = PlayerState.stopped;
      //   _position = Duration.zero;
      // });
    });

    _playerStateChangeSubscription =
        player.onPlayerStateChanged.listen((state) {
      // setState(() {
      //   _playerState = state;
      // });
    });
  }
}
