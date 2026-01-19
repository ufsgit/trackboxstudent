import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:anandhu_s_application4/presentation/login/login_controller.dart';
// import 'package:dio/src/response.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

import '../../core/colors_res.dart';
import 'widgets/verification_widgets.dart';

class OtpVerificationPage extends StatefulWidget {
  final bool isEmail;
  final Map<String, dynamic> value;
  const OtpVerificationPage({required this.isEmail, required this.value});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final LoginController _loginController = Get.put(LoginController());
  TextEditingController otpController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  bool isFocused = false;

  @override
  void initState() {
    super.initState();

    focusNode.addListener(() {
      setState(() {
        isFocused = focusNode.hasFocus;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 48,
      height: 48,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: isFocused ? Colors.black : ColorResources.colorgrey400,
            width: isFocused ? 2 : 1),
      ),
    );
    return Scaffold(
      body: Container(
        height: 500.h,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Check your Inbox",
                style: GoogleFonts.plusJakartaSans(
                  color: ColorResources.colorBlack,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              widget.isEmail == true
                  ? SizedBox(
                      width: 300,
                      child: Text(
                        "We've sent a code 4 digit to ${_loginController.emailController.text}",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.plusJakartaSans(
                          color: ColorResources.colorgrey600,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  : Text(
                      "We've sent a code 4 digit to ${_loginController.phoneController.text}",
                      style: GoogleFonts.plusJakartaSans(
                        color: ColorResources.colorgrey600,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
              const SizedBox(
                height: 24,
              ),
              Form(
                key: formKey,
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Pinput(
                    controller: otpController,
                    focusNode: focusNode,
                    defaultPinTheme: defaultPinTheme,
                    // androidSmsAutofillMethod:
                    //     AndroidSmsAutofillMethod.smsUserConsentApi,
                    // listenForMultipleSmsOnAndroid: true,
                    hapticFeedbackType: HapticFeedbackType.lightImpact,
                    onCompleted: (String verificationCode) {},
                    onChanged: (code) {},
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't get a code?",
                    style: GoogleFonts.plusJakartaSans(
                      color: ColorResources.colorgrey600,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Obx(
                    () => TextButton(
                        onPressed: _loginController.isOtpSending.value
                            ? null
                            : () {
                                if (widget.isEmail == true) {
                                  _loginController.signin(bodyData: {
                                    "email":
                                        _loginController.emailController.text,
                                    "isGoogleSign": false,
                                    "Device_ID": _loginController.fcmToken
                                  }, isEmail: true);
                                } else {
                                  _loginController.signin(bodyData: {
                                    "mobile":
                                        _loginController.phoneController.text,
                                    "isGoogleSign": false,
                                    "Device_ID": _loginController.fcmToken
                                  }, isEmail: false);
                                }
                              },
                        child: Text(
                          _loginController.isOtpSending.value
                              ? 'Sending OTP...'
                              : 'Resend',
                          style: GoogleFonts.plusJakartaSans(
                            color: !_loginController.isOtpSending.value
                                ? ColorResources.colorBlue600
                                : ColorResources.colorgrey500,
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                          ),
                        )),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Obx(
            () => buttonWidget(
              backgroundColor: ColorResources.colorBlue600,
              txtColor: ColorResources.colorwhite,
              isLoading: _loginController.isOtpVerify.value,
              context: context,
              text: 'Verify',
              onPressed: () async {
                await _loginController.verifyOtp(
                    data: widget.value,
                    otp: otpController.text,
                    isEmail: widget.isEmail ?? false);
              },
            ),
          )),
    );
  }
}
