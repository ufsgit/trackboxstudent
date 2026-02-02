import 'package:anandhu_s_application4/presentation/login/login_controller.dart';
import 'package:anandhu_s_application4/presentation/login/widgets/verification_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/colors_res.dart';

class VerificationContentPage extends StatefulWidget {
  const VerificationContentPage({super.key});

  @override
  State<VerificationContentPage> createState() =>
      _VerificationContentPageState();
}

class _VerificationContentPageState extends State<VerificationContentPage>
    with TickerProviderStateMixin {
  final LoginController _loginController = Get.put(LoginController());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late AnimationController _entryAnimationController;
  late Animation<double> _logoFade;
  late Animation<Offset> _logoSlide;
  late Animation<double> _titleFade;
  late Animation<double> _emailFade;
  late Animation<double> _passwordFade;

  late AnimationController _btnScaleController;
  late Animation<double> _btnScale;

  @override
  void initState() {
    super.initState();
    _loginController.emailController.clear();
    _loginController.phoneController.clear();
    _loginController.passwordController.clear();

    _entryAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _logoFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entryAnimationController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
      ),
    );
    _logoSlide =
        Tween<Offset>(begin: const Offset(0, -0.2), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _entryAnimationController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
      ),
    );

    _titleFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entryAnimationController,
        curve: const Interval(0.2, 0.5, curve: Curves.easeOut),
      ),
    );

    _emailFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entryAnimationController,
        curve: const Interval(0.3, 0.6, curve: Curves.easeOut),
      ),
    );

    _passwordFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entryAnimationController,
        curve: const Interval(0.5, 0.8, curve: Curves.easeOut),
      ),
    );

    _entryAnimationController.forward();

    _btnScaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _btnScale = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: _btnScaleController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _entryAnimationController.dispose();
    _btnScaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SlideTransition(
                  position: _logoSlide,
                  child: FadeTransition(
                    opacity: _logoFade,
                    child: Image.asset("assets/images/HE NEW LOGO Dark-03.png"),
                  ),
                ),
                FadeTransition(
                  opacity: _titleFade,
                  child: Text(
                    "Login",
                    style: GoogleFonts.plusJakartaSans(
                      color: ColorResources.colorBlack,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 24,
                      ),
                      FadeTransition(
                        opacity: _emailFade,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Email",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: ColorResources.colorBlack,
                              ),
                            ),
                            textFieldWidget(
                              controller: _loginController.emailController,
                              labelText: '',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      FadeTransition(
                        opacity: _passwordFade,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Password",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: ColorResources.colorBlack,
                              ),
                            ),
                            passwordTextFieldWidget(
                                controller: _loginController.passwordController,
                                labelText: '',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a password';
                                  }

                                  return null;
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Obx(
          () {
            bool isLoading = _loginController.isOtpSending.value;
            return GestureDetector(
              onTapDown: (_) => _btnScaleController.forward(),
              onTapUp: (_) => _btnScaleController.reverse(),
              onTapCancel: () => _btnScaleController.reverse(),
              child: ScaleTransition(
                scale: _btnScale,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  width: isLoading ? 50 : MediaQuery.of(context).size.width,
                  height: 45,
                  decoration: BoxDecoration(
                    color: ColorResources.colorBlue600,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: () {
                        if (isLoading) return;
                        if (!formKey.currentState!.validate()) {
                          return;
                        }
                        _loginController.signin(bodyData: {
                          "email": _loginController.emailController.text,
                          "password": _loginController.passwordController.text,
                          // "isGoogleSign": false,
                          "Device_ID": _loginController.fcmToken,
                          "country_code": "",
                          "country_code_name": ""
                        }, isEmail: true);
                      },
                      child: Center(
                        child: isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : Text(
                                'Continue',
                                style: GoogleFonts.plusJakartaSans(
                                  color: ColorResources.colorwhite,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
