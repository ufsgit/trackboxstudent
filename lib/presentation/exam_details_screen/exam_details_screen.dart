import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:anandhu_s_application4/core/colors_res.dart';
import 'package:anandhu_s_application4/http/loader.dart';
import 'package:anandhu_s_application4/presentation/exam_details_screen/controller/exam_details_controller.dart';
import 'package:anandhu_s_application4/presentation/exam_details_screen/controller/live_class_joining_controller.dart';
import 'package:anandhu_s_application4/presentation/exam_details_screen/live_call_screen.dart';
import 'package:anandhu_s_application4/presentation/my_courses_page/controller/live_class_controller.dart';
import 'package:anandhu_s_application4/theme/custom_button_style.dart';
import 'package:anandhu_s_application4/widgets/custom_outlined_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zego_express_engine/zego_express_engine.dart';
import '../../core/utils/key_center.dart';
import '../home_page/controller/home_controller.dart';
import '../home_page/models/home_model.dart';

class ExamDetailsScreen extends StatefulWidget {
  final bool isNotificationClick;
  int courseId;
  int batchId;

  ExamDetailsScreen(
      {super.key,
      required this.isNotificationClick,
      required this.courseId,
      required this.batchId});

  @override
  State<ExamDetailsScreen> createState() => _ExamDetailsScreenState();
}

class _ExamDetailsScreenState extends State<ExamDetailsScreen> {
  HomeController controller = Get.put(HomeController(HomeModel().obs));

  LiveClassController liveController = Get.put(LiveClassController());

  LiveClassJoiningController liveJoiningController =
      Get.put(LiveClassJoiningController());

  final ExamDetailsScreenController examDetailsScreenController =
      Get.put(ExamDetailsScreenController());
  @override
  void initState() {
    if (widget.isNotificationClick) {}

    super.initState();
    getLiveData();
  }

  getLiveData() {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      Loader.showLoader();
      await liveController.checkCourseLiveByID(widget.courseId, widget.batchId);
      Loader.stopLoader();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
                color: ColorResources.colorBlue100,
                borderRadius: BorderRadius.circular(100)),
            child: IconButton(
              padding: EdgeInsets.all(0),
              constraints: BoxConstraints(),
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                CupertinoIcons.back,
                color: ColorResources.colorBlack.withOpacity(.8),
              ),
            ),
          ),
        ),
        title: Text(
          'Live Classes',
          style: TextStyle(
            fontSize: 18.v,
            fontWeight: FontWeight.w700,
            color: Color(0xff283B52),
          ),
        ),
      ),
      body: SafeArea(child: buildTabContent()),
    );
  }

  Widget buildTabContent() {
    return SingleChildScrollView(
      child: Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12.h),
            liveController.liveNowCourseList.isEmpty
                ? Column(
                    children: [
                      SizedBox(
                        height: Get.height / 2.5,
                      ),
                      Center(
                        child: Text('No Live Classes'),
                      ),
                    ],
                  )
                : buildLiveCourseNowCard(),
            // SizedBox(height: 12.h),
            // // Container(
            // //     margin: EdgeInsets.only(left: 12.v),
            // //     child: Text(
            // //       'ExamDetails',
            // //       style: TextStyle(
            // //           color: Colors.black,
            // //           fontWeight: FontWeight.w800,
            // //           fontSize: 18.v),
            // //     )),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: List.generate(
            //     controller.courseDetailsContent.length,
            //     (index) => Container(
            //       margin: EdgeInsets.only(top: 12.v, left: 12.v, right: 12.v),
            //       child: ExpansionTile(
            //         collapsedBackgroundColor: Colors.white,
            //         collapsedShape: OutlineInputBorder(
            //             borderRadius: BorderRadius.circular(12.v),
            //             borderSide: BorderSide.none),
            //         childrenPadding: EdgeInsets.symmetric(horizontal: 12.v),
            //         backgroundColor: Colors.white,
            //         shape: OutlineInputBorder(
            //             borderRadius: BorderRadius.circular(12.v),
            //             borderSide: BorderSide.none),
            //         tilePadding: EdgeInsets.only(left: 4.v),
            //         leading: Container(
            //           width: 39.v,
            //           height: 39.v,
            //           decoration: BoxDecoration(
            //             color: Color(0xffE3E7EE),
            //             borderRadius: BorderRadius.circular(11.v),
            //           ),
            //           child: Icon(
            //             Icons.headphones_outlined,
            //             color: Colors.black,
            //           ),
            //         ),
            //         expandedCrossAxisAlignment: CrossAxisAlignment.start,
            //         expandedAlignment: Alignment.topLeft,
            //         title: Text(
            //             controller.courseDetailsContent[0].contents.isEmpty
            //                 ? 'll'
            //                 : controller.courseDetailsContent[index].sectionName),
            //         children: List.generate(
            //           controller.courseDetailsContent[index].contents.length,
            //           (contentIndex) => Container(
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: List.generate(
            //                 controller.courseDetailsContent[index]
            //                     .contents[contentIndex].exams!.length,
            //                 (examIndex) => InkWell(
            //                   onTap: () async {
            //                     await examDetailsScreenController.getExamDetails(
            //                         examId: controller
            //                             .courseDetailsContent[index]
            //                             .contents[contentIndex]
            //                             .exams![examIndex]
            //                             .examId);
            //                   },
            //                   child: Row(
            //                     children: [
            //                       Container(
            //                           width: 304.v,
            //                           margin: EdgeInsets.only(
            //                               top: 12.v, bottom: 12.v),
            //                           child: Text(controller
            //                               .courseDetailsContent[index]
            //                               .contents[contentIndex]
            //                               .contentName)),
            //                       Icon(
            //                         Icons.arrow_forward_ios,
            //                         size: 14.v,
            //                         color: Color(0xffBAC1CA),
            //                       )
            //                     ],
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        );
      }),
    );
  }

  Widget buildLiveCourseNowCard() {
    return Container(
      padding: EdgeInsets.all(12.h),
      margin: EdgeInsets.symmetric(horizontal: 12.v),
      decoration: AppDecoration.outlineIndigo5001.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 20.h,
                width: 60.v,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.v),
                    color: ColorResources.colorLiveButton),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Text(
                        textAlign: TextAlign.center,
                        'LIVE',
                        style: GoogleFonts.plusJakartaSans(
                          color: ColorResources.colorwhite,
                          fontSize: 14.fSize,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.v),
                    Container(
                      height: 2.h,
                      width: 2.v,
                      margin:
                          EdgeInsets.symmetric(horizontal: 4.v, vertical: 8.v),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: ColorResources.colorwhite,
                            spreadRadius: 3,
                            blurRadius: 2,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 12.h),
                child: Text(
                  '${liveController.liveNowCourseList[0].firstName} ${liveController.liveNowCourseList[0].lastName}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    color: ColorResources.colorgrey500,
                    fontSize: 14.fSize,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 15.v),
          Text(
            liveController.liveNowCourseList[0].courseName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.plusJakartaSans(
              color: ColorResources.colorBlack,
              fontSize: 16.fSize,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 13.v),
          CustomOutlinedButton(
            onPressed: () async {
              // LiveClassJoiningController videoCallCtrl =
              //     Get.put(LiveClassJoiningController());
              // SharedPreferences preferences =
              //     await SharedPreferences.getInstance();
              // String studentId =
              //     preferences.getString('breffini_student_id') ?? '';
              // LiveClassJoiningModel liveJoiningModel = LiveClassJoiningModel(
              //   liveClassID: liveController.liveNowCourseList[0].liveClassID,
              //   studentID: int.parse(studentId),
              //   startTime: DateTime.now(),
              //   endTime: null,
              //   duration: 0,
              // );
              // Loader.showLoader();
              // await liveJoiningController
              //     .startStudentLiveClass(liveJoiningModel);
              // Loader.stopLoader();
              // Get.to(() => LiveCallScreen(
              //       liveLink: liveController.liveNowCourseList[0].liveLink,
              //       callId: liveController.liveNowCourseList[0].liveClassID,
              //       teacherId: liveController.liveNowCourseList[0].teacherID
              //           .toString(),
              //       teacherName: liveController.liveNowCourseList[0].firstName,
              //     ));
            },
            text: "Join Now",
            buttonStyle: CustomButtonStyles.none,
            decoration: CustomButtonStyles.gradientBlueToBlueDecoration,
            buttonTextStyle: CustomTextStyles.titleSmallWhiteA700,
          ),
          SizedBox(height: 15.v),
        ],
      ),
    );
  }

  Future<void> createEngine() async {
    await ZegoExpressEngine.createEngineWithProfile(ZegoEngineProfile(
      appID,
      ZegoScenario.Default,
      appSign: appSign,
    ));
  }
}
