import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:anandhu_s_application4/core/colors_res.dart';
import 'package:anandhu_s_application4/http/http_urls.dart';
import 'package:anandhu_s_application4/presentation/account_and_security/account_and_security.dart';
import 'package:anandhu_s_application4/presentation/home_page_container_screen/controller/home_page_container_controller.dart';
import 'package:anandhu_s_application4/presentation/login/login_controller.dart';
import 'package:anandhu_s_application4/presentation/profile/attandencereportpage.dart';
import 'package:anandhu_s_application4/presentation/profile/controller/payment_controller.dart';
import 'package:anandhu_s_application4/presentation/profile/feed_back_screen.dart';
import 'package:anandhu_s_application4/presentation/profile/payment_history_page.dart';
import 'package:anandhu_s_application4/presentation/profile/controller/profile_controller.dart';
import 'package:anandhu_s_application4/presentation/profile/privacy_policy_page.dart';
import 'package:anandhu_s_application4/presentation/profile/terms_and_conditions_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class StudentProfileScreen extends StatefulWidget {
  bool? isHomePage;
  StudentProfileScreen({Key? key, this.isHomePage}) : super(key: key);

  @override
  State<StudentProfileScreen> createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  final ProfileController profileController = Get.find<ProfileController>();
  final LoginController lgController = Get.put(LoginController());
  final HomePageContainerController controllers =
      Get.find<HomePageContainerController>();
  PackageInfo? packageInfo;
  @override
  void initState() {
    super.initState();
    profileController.getProfileStudent();
    initDevicePlugin();
  }

  Future<bool> _onWillPop() async {
    Get.back();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Color(0xffF4F7FA),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.v),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 16.v,
                  ),
                  SizedBox(
                      child: widget.isHomePage == true
                          ? Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    icon: Icon(CupertinoIcons.back)),
                                Text(
                                  'My Profile',
                                  style: TextStyle(
                                      fontSize: 18.v,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff283B52)),
                                )
                              ],
                            )
                          : Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      controllers
                                          .setTemporaryPage(AppRoutes.homePage);
                                    },
                                    icon: Icon(CupertinoIcons.back)),
                                Text(
                                  'My Profile',
                                  style: TextStyle(
                                      fontSize: 18.v,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff283B52)),
                                )
                              ],
                            )),
                  SizedBox(
                    height: 16.v,
                  ),
                  Container(
                    color: Colors.white,

                    // width: 328.v,

                    // height: 155.v,
                    padding: EdgeInsets.all(10.v),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GetBuilder<ProfileController>(
                            builder: (profController) {
                          return Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  leading: Container(
                                    height: 52.v,
                                    width: 52.v,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: ColorResources.colorgrey400,
                                          width: 1),
                                      shape: BoxShape.circle,
                                      color: ColorResources.colorgrey200,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50.h),
                                      child: profController.profileData
                                                  ?.profilePhotoPath !=
                                              null
                                          ?

// Your image widget
                                          CachedNetworkImage(
                                              imageUrl:
                                                  '${HttpUrls.imgBaseUrl}${profController.profileData?.profilePhotoPath}',
                                              fit: BoxFit.cover,
                                              placeholder:
                                                  (BuildContext context,
                                                      String url) {
                                                return Shimmer.fromColors(
                                                  baseColor: Colors.grey[300]!,
                                                  highlightColor:
                                                      Colors.grey[100]!,
                                                  child: Container(
                                                    height: 52.v,
                                                    width: 52.v,
                                                    color: Colors.white,
                                                  ),
                                                );
                                              },
                                              errorWidget:
                                                  (BuildContext context,
                                                      String url,
                                                      dynamic error) {
                                                return Center(
                                                  child: Icon(
                                                    Icons.person_rounded,
                                                    color: ColorResources
                                                        .colorBlack
                                                        .withOpacity(.5),
                                                    size: 25.v,
                                                  ),
                                                );
                                              },
                                            )
                                          : Image.asset(
                                              '${ImageConstant.defaultProfile}',
                                              fit: BoxFit.fill,
                                            ),
                                      // child: Image.network(
                                      //   'https://images.vexels.com/media/users/3/145908/raw/52eabf633ca6414e60a7677b0b917d92-male-avatar-maker.jpg',
                                      //   fit: BoxFit.fill,
                                      // ),
                                    ),
                                  ),
                                  // leading: Container(
                                  //   height: 52.v,
                                  //   width: 52.v,
                                  //   decoration: BoxDecoration(
                                  //     shape: BoxShape.circle,
                                  //     image: DecorationImage(
                                  //       fit: BoxFit.cover,
                                  //       image: NetworkImage(
                                  //         '${HttpUrls.imgUploadBaseUrl}${profController.profileData?.profilePhotoPath}',
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  title: Text(
                                    profController.profileData?.firstName !=
                                            null
                                        ? '${profController.profileData?.firstName} ${profController.profileData?.lastName}'
                                        : 'No Name',
                                    style: TextStyle(
                                        color: Color(0xff283B52),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14.v),
                                  ),
                                  subtitle:
                                      profController.profileData?.email != ''
                                          ? Text(
                                              '${profController.profileData?.email}',
                                              style: TextStyle(
                                                  color: Color(0xff283B52),
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 12.v),
                                            )
                                          : Text(
                                              '${profController.profileData?.phoneNumber}',
                                              style: TextStyle(
                                                  color: Color(0xff283B52),
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 12.v),
                                            ),
                                  // trailing: InkWell(
                                  //   onTap: () {
                                  //     Get.to(() => EditProfileScreen());
                                  //   },
                                  //   child: CustomImageView(
                                  //     imagePath: ImageConstant.imgEditIcon,
                                  //     height: 20.adaptSize,
                                  //     width: 20.adaptSize,
                                  //     color: theme.colorScheme.onError,
                                  //   ),
                                  // ),
                                  // trailing: CustomImageView(
                                  //   imagePath: ImageConstant.imgEditIcon,
                                  //   bgColor: ColorResources.colorBlue100,
                                  //   height: 30.adaptSize,
                                  //   width: 30.adaptSize,
                                  //   radius: BorderRadius.circular(
                                  //     15.adaptSize,
                                  //   ),
                                  // ),
                                ),
                              ),
                            ],
                          );
                        }),
                        // SizedBox(
                        //   height: 16.v,
                        // ),
                        // Text(
                        //   'Course completion progress',
                        //   style: TextStyle(
                        //       fontSize: 12.v,
                        //       fontWeight: FontWeight.w600,
                        //       color: Color(0xff283B52)),
                        // ),
                        // SizedBox(
                        //   height: 6.v,
                        // ),
                        // LinearPercentIndicator(
                        //   padding: EdgeInsets.zero,
                        //   width: 296.v,
                        //   lineHeight: 8.0,
                        //   percent: 0.2,
                        //   progressColor: Colors.blue,
                        // ),
                        // SizedBox(
                        //   height: 16.v,
                        // ),
                        // Text(
                        //   'Course types',
                        //   style: TextStyle(
                        //       color: Color(0xff6A7487),
                        //       fontSize: 12.v,
                        //       fontWeight: FontWeight.w600),flutter
                        // ),
                        // Text(
                        //   'IELTS, OET, German...',
                        //   style: TextStyle(
                        //       color: Color(0xff283B52),
                        //       fontSize: 14.v,
                        //       fontWeight: FontWeight.w400),
                        // )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 28.v,
                  ),
                  Column(
                      children: List.generate(
                          profileController.profileTileTextList.length,
                          (index) => InkWell(
                                onTap: () {
                                  _handleIconTap(context, index);
                                },
                                child: Container(
                                  height: 52.v,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.v),

                                  margin: EdgeInsets.only(top: 4.v),

                                  // width: 328.v,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(12.v)),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          profileController
                                              .profileTileTextList[index],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13.v),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          size: 14.v,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ))),
                  // SizedBox(
                  //   height: 24.v,
                  // ),
                  // Row(
                  //   children: [
                  //     Image.asset('assets/images/question_mark.png'),
                  //     SizedBox(
                  //       width: 12.v,
                  //     ),
                  //     Text(
                  //       'Help and Feedback',
                  //       style: TextStyle(
                  //           color: Color(
                  //             0xff283B52,
                  //           ),
                  //           fontSize: 14.v,
                  //           fontWeight: FontWeight.w400),
                  //     )
                  //   ],
                  // ),
                  SizedBox(
                    height: 16.v,
                  ),
                  TextButton(
                      onPressed: () {
                        showLogoutDialog();
                      },
                      child: Text(
                        'Logout',
                        style: TextStyle(
                            color: Color(0xffEB4141),
                            fontSize: 14.fSize,
                            fontWeight: FontWeight.w500),
                      )),
                  SizedBox(
                    height: 64.v,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      child: Column(children: [
                        Text(
                          ("App Version " +
                              (null != packageInfo
                                  ? packageInfo!.version +
                                      "." +
                                      packageInfo!.buildNumber
                                  : "0.0")),
                          style: TextStyle(color: Color(0xff949596)),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Our  ',
                              style: TextStyle(
                                  color: Color(0xff949596), fontSize: 12),
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(() => TermsAndConditionsPage());
                              },
                              child: Text(
                                'Terms & conditions',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: ColorResources.colorBlack,
                                    decoration: TextDecoration.underline,
                                    decorationThickness: 2.5,
                                    decorationColor: ColorResources.colorBlack),
                              ),
                            ),
                            Text(
                              '  and  ',
                              style: TextStyle(
                                  color: Color(0xff949596), fontSize: 12),
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(() => PrivacyPolicyPage());
                              },
                              child: Text(
                                'Privacy Policy',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: ColorResources.colorBlack,
                                    decoration: TextDecoration.underline,
                                    decorationThickness: 2.5,
                                    decorationColor: ColorResources.colorBlack),
                              ),
                            ),
                          ],
                        )
                      ]),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showLogoutDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text(
            'Logout',
            style: TextStyle(
                fontSize: 18.v,
                fontWeight: FontWeight.w700,
                color: Color(0xff283B52)),
          ),
          content: Text(
            'Are you sure you want to log out?',
            style: GoogleFonts.plusJakartaSans(),
          ),
          actions: [
            TextButton(
              child: Text(
                'No',
                style: GoogleFonts.plusJakartaSans(
                  color: ColorResources.colorgrey700,
                ),
              ),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              child: Text(
                'Yes',
                style: GoogleFonts.plusJakartaSans(
                  color: Color(0xffEB4141),
                ),
              ),
              onPressed: () {
                Get.back();
                lgController.logout();
              },
            ),
          ],
        );
      },
    );
  }

  initDevicePlugin() async {
    await PackageInfo.fromPlatform().then((value) {
      packageInfo = value;
      setState(() {});
    });
  }

  void _handleIconTap(BuildContext context, int index) async {
    final PaymentController paymentController = Get.put(PaymentController());

    switch (index) {
      case 0:
        print('First');
        Get.to(() {
          return AccountAndSecurityView();
        });

        break;
      case 1:
        print('second');
        Get.to(() {
          return AttendanceReportScreen();
        });
        break;

      default:
        break;
    }
  }
}
