import 'package:anandhu_s_application4/core/colors_res.dart';
import 'package:anandhu_s_application4/core/utils/extentions.dart';
import 'package:anandhu_s_application4/core/utils/file_utils.dart';
import 'package:anandhu_s_application4/http/chat_bot_socket.dart';
import 'package:anandhu_s_application4/http/http_urls.dart';
import 'package:anandhu_s_application4/http/socket_io.dart';
import 'package:anandhu_s_application4/presentation/breff_screen/controller/chat_screen_controller.dart';
import 'package:anandhu_s_application4/presentation/course_details_page1_screen/pdf_viewer_screen.dart';
import 'package:anandhu_s_application4/presentation/home_page/controller/home_controller.dart';
import 'package:anandhu_s_application4/presentation/home_page/models/home_model.dart';
import 'package:anandhu_s_application4/widgets/gifviewer/gif_controller.dart';
import 'package:anandhu_s_application4/widgets/gifviewer/gif_view.dart';
import 'package:anandhu_s_application4/widgets/three_dot_loading.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:video_player/video_player.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'controller/breff_controller.dart'; // ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

final List<String> keywords = [
  'who are you',
  'what is flutter',
  'hi',
  'yes',
];

final List<String> responses = [
  'I am a bot created by Iksoft Original, a proud Ghanaian',
  'Flutter transforms the app development process. Build, test, and deploy beautiful mobile, web, desktop, and embedded apps from a single codebase.',
  'You are such an idiot to tell me this. you dont have future. Look for Iksoft Original and seek for knowledge. here is his number +233550138086. call him you lazy deep shit',
  'Good! i have forgiven you. dont do that again!',
];

class BreffScreen extends StatefulWidget {
  bool isLoginButton = false;

  BreffScreen({this.isLoginButton = false});

  @override
  _BreffScreenWidgetState createState() =>
      _BreffScreenWidgetState(this.isLoginButton);
}

class _BreffScreenWidgetState extends State<BreffScreen> {
  _BreffScreenWidgetState(this.isLoginButton);
  // final gemini = Gemini.instance;

  bool isLoginButton = false;

  final BreffController breffController = Get.put(BreffController());

  final HomeController homeController =
      Get.put(HomeController(HomeModel().obs));
  final ChatScreenController chatScreenController =
      Get.put(ChatScreenController());
  final Map<String, String?> parameters = Get.parameters;
  final player = AudioPlayer();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    chatScreenController.geminiChatDataList.clear();
    super.initState();
    // playAudio();
    initSocketIo();
  }

  @override
  void dispose() {
    Get.find<ChatScreenController>().clearBotHistory();
    ChatbotSocket.disconnectSocket();

    // _controller.dispose();
    player.stop();
    player.dispose();
    super.dispose();
  }

  initSocketIo() async {
    await ChatbotSocket.initSocket();
    ChatbotSocket().listenBotReplay();
  }

  // playAudio() async {
  //   await player.play(AssetSource(PrefUtils().getBreffGenderData() == "Male"
  //       ? 'sounds/breffini_male_audio.mp3'
  //       : 'sounds/breffini_female_audio.mp3'));
  // }

  @override
  Widget build(BuildContext context) {
    // breffController.selectedIndex.value = int.parse(parameters['index'] ?? '0');
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: appTheme.whiteA700,
        appBar: PreferredSize(
            preferredSize: Size(Get.width, 200.h),
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                    Color(0xffFFFFFF),

                    Color.fromARGB(255, 86, 141, 217),
                    //  Color(0xff1580E3),
                    // Color(0xffFFFFFF),
                  ])),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16.h, top: 16.h),
                      child: CustomIconButton(
                        height: 24.adaptSize,
                        width: 24.adaptSize,
                        padding: EdgeInsets.all(7.h),
                        alignment: Alignment.topLeft,
                        onTap: () {
                          onTapBtnArrowLeftButton();
                        },
                        child: CustomImageView(
                          imagePath: ImageConstant.imgArrowLeft,
                        ),
                      ),
                    ),
                    // Obx(
                    //   () =>
                    Container(
                      width: 120.v,
                      height: 130.h,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  PrefUtils().getBreffGenderData() == "Male"
                                      ? ImageConstant.breffImageNewAvatar
                                      : ImageConstant.breffniImageNewAvatar),
                              fit: BoxFit.fitHeight)),
                      // child: GifView.asset(
                      //   controller: GifController(loop: false),
                      //   PrefUtils().getBreffGenderData() == "Male"
                      //       ? 'assets/videos/brefnni_male_gif.gif'
                      //       : 'assets/videos/brefiini_female_gif.gif',

                      //   height: 200,
                      //   width: 200,
                      //   frameRate: 0, // default is 15 FPS
                      // )
                      // VideoPlayerWidget(
                      //
                      //   videoPath: PrefUtils().getBreffGenderData()=="Male"
                      //       ? 'assets/videos/brefnni_male_gif.gif'
                      //       : 'assets/videos/brefiini_female_gif.gif',
                      //   audioPath: PrefUtils().getBreffGenderData()=="Male"
                      //       ? 'sounds/breffini_male_audio.mp3'
                      //       : 'sounds/breffini_female_audio.mp3',
                      //
                      // ),
                      // ),
                    ),
                  ],
                ),
              ),
            )),
        body: SizedBox(
          // width: double.maxFinite,
          child: GetBuilder<ChatScreenController>(builder: (sendChatData) {
            _scrollToBottom();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24.v),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: EdgeInsets.only(left: 16.h),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  'Hello, I\'m ${PrefUtils().getBreffGenderData() == "Male" ? 'AI' : 'AI'}\n',
                              style: theme.textTheme.headlineSmall,
                            ),
                            TextSpan(
                              text: 'Your study partner in game',
                              style: theme.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
                SizedBox(height: 12.v),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.h, bottom: 10),
                    child: Text(
                      "msg_how_i_can_help_you".tr,
                      style: CustomTextStyles.titleSmallMedium_4,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: sendChatData.geminiChatDataList.length,
                      shrinkWrap: true,
                      controller: scrollController,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Align(
                          alignment:
                              sendChatData.geminiChatDataList[index].isUser !=
                                          null &&
                                      sendChatData.geminiChatDataList[index]
                                              .isUser ==
                                          false
                                  ? Alignment.centerLeft
                                  : Alignment.centerRight,
                          child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.h),
                              child: Container(
                                margin: EdgeInsets.only(top: 15.v),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.h,
                                  vertical: 10.v,
                                ),
                                decoration: AppDecoration.fillGray.copyWith(
                                  color: ColorResources.colorgrey300,
                                  borderRadius:
                                      BorderRadiusStyle.roundedBorder15,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(top: 4.v),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SelectableText(
                                        sendChatData.geminiChatDataList[index]
                                            .contentName
                                            .toString(),
                                        style: CustomTextStyles
                                            .titleSmallBluegray300
                                            .copyWith(
                                          color: appTheme.blueGray80003,
                                        ),
                                      ),
                                      if (!sendChatData
                                          .geminiChatDataList[index].fileLink
                                          .isNullOrEmpty())
                                        InkWell(
                                          child: Row(
                                            children: [
                                              Text(
                                                "Click Here",
                                                style: CustomTextStyles
                                                    .titleSmallBluegray300
                                                    .copyWith(
                                                  color: Colors.blue,
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 4.0,
                                                        vertical: 4),
                                                child: FileUtils.getFileIcon(
                                                    sendChatData
                                                        .geminiChatDataList[
                                                            index]
                                                        .fileLink!),
                                              )
                                            ],
                                          ),
                                          onTap: () {
                                            if (sendChatData
                                                    .geminiChatDataList[index]
                                                    .type ==
                                                "whatsapp") {
                                              _launchUrl(sendChatData
                                                  .geminiChatDataList[index]
                                                  .fileLink!);
                                            } else {
                                              Get.to(() => PdfViewerPage(
                                                    media: sendChatData
                                                                    .geminiChatDataList[
                                                                        index]
                                                                    .mainQuestion !=
                                                                "" &&
                                                            sendChatData
                                                                    .geminiChatDataList[
                                                                        index]
                                                                    .sectionId ==
                                                                1
                                                        ? sendChatData
                                                            .geminiChatDataList[
                                                                index]
                                                            .mainQuestion!
                                                        : "",
                                                    isFromCourseScreen: false,
                                                    answerKey: HttpUrls
                                                            .imgBaseUrl +
                                                        sendChatData
                                                            .geminiChatDataList[
                                                                index]
                                                            .answerKey!,
                                                    fileUrl: HttpUrls
                                                            .imgBaseUrl +
                                                        sendChatData
                                                            .geminiChatDataList[
                                                                index]
                                                            .fileLink!,
                                                  ));
                                            }
                                          },
                                        ),
                                    ],
                                  ),
                                ),
                              )),
                        );
                      }),
                ),
                if (sendChatData.isChatLoading)
                  Container(
                    height: 45,
                    width: 70,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.h,
                      vertical: 10.v,
                    ),
                    decoration: AppDecoration.fillGray.copyWith(
                      color: ColorResources.colorgrey300,
                      borderRadius: BorderRadiusStyle.roundedBorder15,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: ThreeDotLoading(),
                    ),
                  ),
                SizedBox(height: 4.v),
                SizedBox(height: 10.v),
              ],
            );
          }),
        ),
        bottomNavigationBar: SingleChildScrollView(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                Obx(
                  () => breffController.isLoginButton.value == true ||
                          isLoginButton == true
                      ? InkWell(
                          onTap: () {
                            player.stop();
                            player.dispose();
                            Get.toNamed(AppRoutes.loginHome);
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 20.v),
                            height: 40.h,
                            width: Get.width,
                            decoration: BoxDecoration(
                                color: appTheme.blue80001,
                                borderRadius: BorderRadius.circular(10.v)),
                            child: Center(
                              child: Text(
                                'Login/SignUp',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.v,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ),
                SizedBox(height: 8.v),
                _buildAskAnythingSection(),
              ],
            )),
      ),
    );

    //   Scaffold(
    //     resizeToAvoidBottomInset: true,
    //     appBar: PreferredSize(
    //         preferredSize: Size(Get.width, 200.h),
    //         child: Container(
    //           decoration: BoxDecoration(
    //               gradient: LinearGradient(
    //                   begin: Alignment.bottomLeft,
    //                   end: Alignment.topRight,
    //                   colors: [
    //                 Color(0xffFFFFFF),

    //                 Color.fromARGB(255, 86, 141, 217),
    //                 //  Color(0xff1580E3),
    //                 // Color(0xffFFFFFF),
    //               ])),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Padding(
    //                 padding: EdgeInsets.only(left: 16.h, top: 16.h),
    //                 child: CustomIconButton(
    //                   height: 24.adaptSize,
    //                   width: 24.adaptSize,
    //                   padding: EdgeInsets.all(7.h),
    //                   alignment: Alignment.topLeft,
    //                   onTap: () {
    //                     onTapBtnArrowleftone();
    //                   },
    //                   child: CustomImageView(
    //                     imagePath: ImageConstant.imgArrowLeft,
    //                   ),
    //                 ),
    //               ),
    //               Obx(
    //                 ()=> Container(
    //                   width: 120.v,
    //                   height: 150.h,
    //                   decoration: BoxDecoration(
    //                       image: DecorationImage(
    //                           image:
    //                               AssetImage(breffController.selectedIndex.value!=0? 'assets/images/breffini_female.png':              'assets/images/brefiini male.png'))),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         )),
    //     body:

    //   //  Column(
    //   //    children: [

    //   //      Expanded(child: ikchatbot(config: chatBotConfig)),
    //   //      SizedBox(height: 20.v),
    //   //      InkWell(
    //   //           onTap: () {
    //   //             Get.toNamed(AppRoutes.loginHome);
    //   //           },
    //   //           child: Container(
    //   //             margin: EdgeInsets.symmetric(horizontal: 20.v),
    //   //             height: 40.h,
    //   //             width: Get.width,
    //   //             decoration: BoxDecoration(
    //   //                 color: appTheme.blue80001,
    //   //                 borderRadius: BorderRadius.circular(10.v)),
    //   //             child: Center(
    //   //               child: Text(
    //   //                 'Login/SignUp',
    //   //                 style: TextStyle(
    //   //                     color: Colors.white,
    //   //                     fontSize: 14.v,
    //   //                     fontWeight: FontWeight.w500),
    //   //               ),
    //   //             ),
    //   //           ),
    //   //         ),
    //   //         SizedBox(height: 20.v,),

    //   //    ],
    //   //  ),
    //   ),
    // );

    //   Scaffold(
    //     resizeToAvoidBottomInset: false,
    //     backgroundColor: appTheme.whiteA700,
    //     appBar: PreferredSize(
    //         preferredSize: Size(Get.width, 200.h),
    //         child: Container(
    //           decoration: BoxDecoration(
    //               gradient: LinearGradient(
    //                   begin: Alignment.bottomLeft,
    //                   end: Alignment.topRight,
    //                   colors: [
    //                 Color(0xffFFFFFF),

    //                 Color.fromARGB(255, 86, 141, 217),
    //                 //  Color(0xff1580E3),
    //                 // Color(0xffFFFFFF),
    //               ])),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Padding(
    //                 padding: EdgeInsets.only(left: 16.h, top: 16.h),
    //                 child: CustomIconButton(
    //                   height: 24.adaptSize,
    //                   width: 24.adaptSize,
    //                   padding: EdgeInsets.all(7.h),
    //                   alignment: Alignment.topLeft,
    //                   onTap: () {
    //                     onTapBtnArrowleftone();
    //                   },
    //                   child: CustomImageView(
    //                     imagePath: ImageConstant.imgArrowLeft,
    //                   ),
    //                 ),
    //               ),
    //               Obx(
    //                 ()=> Container(
    //                   width: 120.v,
    //                   height: 150.h,
    //                   decoration: BoxDecoration(
    //                       image: DecorationImage(
    //                           image:
    //                               AssetImage(breffController.selectedIndex.value!=0? 'assets/images/breffini_female.png':              'assets/images/brefiini male.png'))),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         )),
    //     body: SizedBox(
    //       width: double.maxFinite,
    //       child: Column(
    //         children: [
    //           // _buildStackVectorTwenty(),
    //           SizedBox(height: 29.v),
    //           Obx(
    //          ()=> Align(
    //               alignment: Alignment.centerLeft,
    //               child: Padding(
    //                 padding: EdgeInsets.only(left: 16.h),
    //                 child: Text(
    //                   'Hello, I’m ${breffController.selectedIndex.value!=0? 'Breffini':' Breff'}     ',
    //                   style: theme.textTheme.headlineSmall,
    //                 ),
    //               ),
    //             ),
    //           ),
    //           SizedBox(height: 12.v),
    //           // Align(
    //           //   alignment: Alignment.centerLeft,
    //           //   child: Padding(
    //           //     padding: EdgeInsets.only(left: 20.h),
    //           //     child: Row(
    //           //       children: [
    //           //         Container(
    //           //           height: 42.adaptSize,
    //           //           width: 42.adaptSize,
    //           //           decoration: AppDecoration.fillErrorContainer.copyWith(
    //           //             borderRadius: BorderRadiusStyle.circleBorder21,
    //           //           ),
    //           //           child: CustomImageView(
    //           //             imagePath: 'assets/images/breff_avatar_round.png',
    //           //             height: 41.adaptSize,
    //           //             width: 41.adaptSize,
    //           //             alignment: Alignment.center,
    //           //           ),
    //           //         ),
    //           //         Container(
    //           //           margin: EdgeInsets.only(left: 4.h),
    //           //           padding: EdgeInsets.symmetric(
    //           //             horizontal: 18.h,
    //           //             vertical: 9.v,
    //           //           ),
    //           //           decoration: AppDecoration.fillIndigo.copyWith(
    //           //             borderRadius: BorderRadiusStyle.customBorderBL21,
    //           //           ),
    //           //           child: Column(
    //           //             mainAxisSize: MainAxisSize.min,
    //           //             mainAxisAlignment: MainAxisAlignment.center,
    //           //             children: [
    //           //               SizedBox(height: 4.v),

    //           //             ],
    //           //           ),
    //           //         )
    //           //       ],
    //           //     ),
    //           //   ),
    //           // ),
    //           Align(
    //             alignment: Alignment.centerLeft,
    //             child: Padding(
    //               padding: EdgeInsets.only(left: 16.h),
    //               child: Text(
    //                 "msg_how_i_can_help_you".tr,
    //                 style: CustomTextStyles.titleSmallMedium_4,
    //               ),
    //             ),
    //           ),
    //           Spacer(),
    //           Align(
    //             alignment: Alignment.centerLeft,
    //             child: Padding(
    //               padding: EdgeInsets.symmetric(horizontal: 16.h),
    //               child: _buildFindCourseSection(
    //                 helpmetofind: "msg_find_me_a_good_tutor".tr,
    //               ),
    //             ),
    //           ),
    //           SizedBox(height: 4.v),
    //           Align(
    //             alignment: Alignment.centerLeft,
    //             child: Padding(
    //               padding: EdgeInsets.symmetric(horizontal: 16.h),
    //               child: _buildFindCourseSection(
    //                 helpmetofind: "msg_help_me_to_find".tr,
    //               ),
    //             ),
    //           ),
    //           SizedBox(height: 4.v),
    //           Align(
    //             alignment: Alignment.centerLeft,
    //             child: Padding(
    //               padding: EdgeInsets.symmetric(horizontal: 16.h),
    //               child: _buildFindCourseSection(
    //                 helpmetofind: "msg_suggest_some_online".tr,
    //               ),
    //             ),
    //           ),

    //           SizedBox(height: 15.v),
    //           SizedBox(
    //             height: 20.h,
    //           ),
    //           zInkWell(
    //             onTap: () {
    //               Get.toNamed(AppRoutes.loginHome);
    //             },
    //             child: Container(
    //               margin: EdgeInsets.symmetric(horizontal: 20.v),
    //               height: 40.h,
    //               width: Get.width,
    //               decoration: BoxDecoration(
    //                   color: appTheme.blue80001,
    //                   borderRadius: BorderRadius.circular(10.v)),
    //               child: Center(
    //                 child: Text(
    //                   'Login/SignUp',
    //                   style: TextStyle(
    //                       color: Colors.white,
    //                       fontSize: 14.v,
    //                       fontWeight: FontWeight.w500),
    //                 ),
    //               ),
    //             ),
    //           ),
    //           SizedBox(
    //             height: 20.h,
    //           )
    //         ],
    //       ),
    //     ),
    //     bottomNavigationBar: _buildAskAnythingSection(),
    //   ),
    // );
  }

  /// Section Widget
  // Widget _buildStackVectorTwenty() {
  //   return SizedBox(
  //     height: 231.v,
  //     width: double.maxFinite,
  //     child: Stack(
  //       alignment: Alignment.center,
  //       children: [
  //         CustomImageView(
  //           imagePath: ImageConstant.imgVector20,
  //           height: 48.v,
  //           width: 360.h,
  //           alignment: Alignment.topCenter,
  //         ),
  //         Align(
  //           alignment: Alignment.center,
  //           child: SizedBox(
  //             height: 231.v,
  //             width: double.maxFinite,
  //             child: Stack(
  //               alignment: Alignment.topLeft,
  //               children: [
  //                 Align(
  //                   alignment: Alignment.center,
  //                   child: SizedBox(
  //                     height: 231.v,
  //                     width: double.maxFinite,
  //                     child: Stack(
  //                       alignment: Alignment.center,
  //                       children: [
  //                         CustomImageView(
  //                           imagePath: ImageConstant.imgRectangle27231x360,
  //                           height: 231.v,
  //                           width: 360.h,
  //                           radius: BorderRadius.vertical(
  //                             bottom: Radius.circular(24.h),
  //                           ),
  //                           alignment: Alignment.center,
  //                         ),
  //                         Align(
  //                           alignment: Alignment.center,
  //                           child: SizedBox(
  //                             height: 220.v,
  //                             width: double.maxFinite,
  //                             child: Stack(
  //                               alignment: Alignment.centerLeft,
  //                               children: [
  //                                 CustomImageView(
  //                                   imagePath: ImageConstant.imgVector19,
  //                                   height: 16.v,
  //                                   width: 360.h,
  //                                   alignment: Alignment.bottomCenter,
  //                                 ),
  //                                 Align(
  //                                   alignment: Alignment.centerLeft,
  //                                   child: SizedBox(
  //                                     height: 220.v,
  //                                     width: 198.h,
  //                                     child: Stack(
  //                                       alignment: Alignment.centerLeft,
  //                                       children: [
  //                                         CustomImageView(
  //                                           imagePath:
  //                                               ImageConstant.imgImage29220x198,
  //                                           height: 220.v,
  //                                           width: 198.h,
  //                                           alignment: Alignment.center,
  //                                         ),
  //                                         CustomImageView(
  //                                           imagePath: ImageConstant.imgImage27,
  //                                           height: 218.v,
  //                                           width: 109.h,
  //                                           alignment: Alignment.centerLeft,
  //                                           margin: EdgeInsets.only(left: 20.h),
  //                                         )
  //                                       ],
  //                                     ),
  //                                   ),
  //                                 ),
  //                                 CustomImageView(
  //                                   imagePath:
  //                                       ImageConstant.imgEllipse13BlueGray10001,
  //                                   height: 45.v,
  //                                   width: 360.h,
  //                                   alignment: Alignment.bottomCenter,
  //                                 ),
  //                                 Align(
  //                                   alignment: Alignment.bottomRight,
  //                                   child: Container(
  //                                     width: 119.h,
  //                                     margin: EdgeInsets.only(
  //                                       right: 33.h,
  //                                       bottom: 28.v,
  //                                     ),
  //                                     child: Text(
  //                                       "msg_hi_there_i_m".tr,
  //                                       maxLines: 2,
  //                                       overflow: TextOverflow.ellipsis,
  //                                       style: CustomTextStyles
  //                                           .headlineSmallWhiteA700
  //                                           .copyWith(
  //                                         height: 1.52,
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 )
  //                               ],
  //                             ),
  //                           ),
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //                 Padding(
  //                   padding: EdgeInsets.only(left: 16.h),
  //                   child: CustomIconButton(
  //                     height: 24.adaptSize,
  //                     width: 24.adaptSize,
  //                     padding: EdgeInsets.all(7.h),
  //                     alignment: Alignment.topLeft,
  //                     onTap: () {
  //                       onTapBtnArrowleftone();
  //                     },
  //                     child: CustomImageView(
  //                       imagePath: ImageConstant.imgArrowLeft,
  //                     ),
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  /// Section Widget
  Widget _buildAskAnythingSection() {
    return Padding(
      padding: EdgeInsets.only(
        left: 16.h,
        right: 16.h,
        bottom: 16.v,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: CustomTextFormField(
              controller: breffController.askanythingoneController,
              hintText: "lbl_ask_me_anything".tr,
              hintStyle: CustomTextStyles.titleSmallBluegray300,
              textInputAction: TextInputAction.done,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 4.h),
            child: CustomIconButton(
              onTap: () {
                if (breffController.askanythingoneController.text.isNotEmpty) {
                  chatScreenController.sendText(
                      sendData: breffController.askanythingoneController.text);

                  chatScreenController.update();
                } else {
                  Get.showSnackbar(GetSnackBar(
                    message: 'Enter valid command',
                    duration: Duration(milliseconds: 2000),
                  ));
                }

                //         final gemini = Gemini.instance;

                // gemini.text(controller.askanythingoneController.text)
                //   .then((value) => print( value?.output )) /// or value?.content?.parts?.last.text
                //   .catchError((e) => print(e));
              },
              height: 40.v,
              width: 40.v,
              padding: EdgeInsets.all(8.h),
              decoration: IconButtonStyleHelper.outlineWhiteA,
              child: CustomImageView(
                imagePath: ImageConstant.imgPaperplaneright,
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Navigates to the previous screen.
  onTapBtnArrowLeftButton() {
    Get.back();
  }

  void _scrollToBottom() {
    if (scrollController.hasClients) {
      // Ensure scrolling happens after the list is fully built
      Future.delayed(Duration(milliseconds: 50), () {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      });
    }
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}
