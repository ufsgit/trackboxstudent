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

class _VerificationContentPageState extends State<VerificationContentPage> {
  final LoginController _loginController = Get.put(LoginController());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loginController.emailController.clear();
    _loginController.phoneController.clear();
    _loginController.passwordController.clear();
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
                Image.asset("assets/images/HE NEW LOGO Dark-03.png"),
                Text(
                  "Login",
                  style: GoogleFonts.plusJakartaSans(
                    color: ColorResources.colorBlack,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Text(
                //   "Enter your email address to log in to a Breffni\naccount or create a new one.",
                //   style: GoogleFonts.plusJakartaSans(
                //     color: ColorResources.colorgrey600,
                //     fontSize: 14,
                //     fontWeight: FontWeight.w400,
                //   ),
                // ),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 24,
                      ),
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
                      const SizedBox(
                        height: 16,
                      ),
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
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Obx(
          () => buttonWidget(
              isLoading: _loginController.isOtpSending.value,
              backgroundColor: ColorResources.colorBlue600,
              txtColor: ColorResources.colorwhite,
              context: context,
              text: 'Continue',
              onPressed: () {
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
              }),
        ),
      ),
    );
  }
}
