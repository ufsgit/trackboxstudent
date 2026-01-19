import 'package:anandhu_s_application4/core/colors_res.dart';
import 'package:anandhu_s_application4/presentation/home_page_container_screen/home_page_container_screen.dart';
import 'package:anandhu_s_application4/presentation/login/login_home_page.dart';
import 'package:anandhu_s_application4/presentation/login/verification_tab_page.dart';
import 'package:anandhu_s_application4/presentation/splash_screen/splashscreen1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../home_page/controller/home_controller.dart';
import '../home_page/models/home_model.dart';
// Import FullscreenSliderDemo here

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoAnimation;
  late Animation<double> _textAnimation;
  HomeController controller = Get.put(HomeController(HomeModel().obs));

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (controller.isUserLogin.value == true) {
        controller.initFn();
      }
    });

    init();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _logoAnimation = Tween<double>(
      begin: 2.0,
      end: 0.3,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0.0, 0.5, curve: Curves.easeInOut),
    ));
    _textAnimation = Tween<double>(
      begin: -1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0.5, 1.0, curve: Curves.easeInOut),
    ));
    _controller.forward();

    // Navigate to FullscreenSliderDemo after 1 second
  }

  init() async {
    await isuserLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, // Set background color
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            children: [
              // Logo with entering and scaling animation
              Center(
                child: Transform.scale(
                  scale: _logoAnimation.value,
                  child: Image.asset(
                    "assets/images/HE NEW LOGO Dark-03.png",
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ),
                ),
              ),
              // Text with pop-up animation
              Positioned(
                bottom: 320 + _textAnimation.value * 100,
                left: MediaQuery.of(context).size.width / 2.7,
                child: Opacity(
                  opacity: _textAnimation.value + 1.0,
                  child: Text(
                    'Trackbox',
                    style: GoogleFonts.plusJakartaSans(
                      color: ColorResources.colorwhite,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  isuserLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String studentId = preferences.getString('breffini_student_id') ?? '';

    if (studentId != '') {
      controller.isUserLogin.value = true;
    } else {
      controller.isUserLogin.value = false;
    }
    Get.off(() => controller.isUserLogin.value == true
        ? HomePageContainerScreen()
        : LoginTabviewPage());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
