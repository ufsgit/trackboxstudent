import 'package:anandhu_s_application4/presentation/login/login_controller.dart';
import 'package:anandhu_s_application4/presentation/login/verification_tab_page.dart';
import 'package:anandhu_s_application4/presentation/login/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/colors_res.dart';
import 'widgets/verification_widgets.dart';
import 'dart:io';

class LoginHomePage extends StatefulWidget {
  const LoginHomePage();

  @override
  State<LoginHomePage> createState() => _LoginHomePageState();
}

class _LoginHomePageState extends State<LoginHomePage> {
  final LoginController _loginController = Get.put(LoginController());

  // final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/verification_img.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 32),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [],
              ),
            ),
            commonBackgroundLinearColor(
              childWidget: Padding(
                padding: const EdgeInsets.only(left: 40, right: 40, bottom: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Begin your learning\njourney guided by\nexperts',
                      style: GoogleFonts.plusJakartaSans(
                        color: ColorResources.colorwhite,
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    // // const SizedBox(height: 24),
                    // // Platform.isAndroid
                    // //     ? elevatedButtonWidget(
                    // //         context: context,
                    // //         onPressed: () async {
                    // //           await _loginController.signInWithGoogle();
                    // //         },
                    // //         text: 'Continue with Google',
                    // //         logo: 'assets/images/google_logo.png',
                    // //       )
                    //     : elevatedButtonWidget(
                    //         context: context,
                    //         onPressed: () {},
                    //         text: 'Continue with Apple',
                    //         logo: 'assets/images/apple_logo.png',
                    //       ),
                    const SizedBox(height: 16),
                    elevatedButtonWidget(
                      context: context,
                      logo: 'assets/images/user_logo.png',
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const LoginTabviewPage();
                          },
                        ));
                      },
                      text: 'Use Phone or Email',
                    ),
                    const SizedBox(height: 24),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     logoWidget(
                    //       image: 'assets/images/fb_logo.png',
                    //       onTap: () async {
                    //         // await _loginController.signInWithFacebook();
                    //       },
                    //     ),
                    //     const SizedBox(width: 16),
                    //     if (Platform.isIOS)
                    //       logoWidget(
                    //         image: 'assets/images/apple_logo.png',
                    //         onTap: () {},
                    //       ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
