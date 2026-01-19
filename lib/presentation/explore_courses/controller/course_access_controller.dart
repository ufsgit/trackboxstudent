import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';

class CourseAccessController extends GetxController {
  final RxList<int> enrolledCourseIds = <int>[].obs;

  bool canAccessCourse(int courseId) {
    return enrolledCourseIds.contains(courseId);
  }

  Future<void> _launchWhatsApp(String phoneNumber) async {
    final cleanPhoneNumber = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
    final whatsappUrl = 'https://wa.me/$cleanPhoneNumber';

    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      Fluttertoast.showToast(
        msg: 'Could not open WhatsApp',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  void showAccessDeniedToast({
    required String message,
    required Color backgroundColor,
    required Color textColor,
  }) {
    // Updated regex to specifically match +91 followed by 10 digits
    final phoneRegex = RegExp(r'\+91\d{10}\b');
    final match = phoneRegex.firstMatch(message);

    if (match != null) {
      // Split the message into parts
      final beforeNumber = message.substring(0, match.start);
      final number = match.group(0)!;
      final afterNumber = message.substring(match.end);

      // Create a custom widget for the toast
      final widget = Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: beforeNumber,
                style: TextStyle(color: textColor),
              ),
              TextSpan(
                text: number,
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.bold,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => _launchWhatsApp(number),
              ),
              TextSpan(
                text: afterNumber,
                style: TextStyle(color: textColor),
              ),
            ],
          ),
        ),
      );

      Get.snackbar(
        '',
        '',
        titleText: const SizedBox.shrink(),
        messageText: widget,
        backgroundColor: Colors.transparent,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 4),
        margin: const EdgeInsets.all(8),
        padding: EdgeInsets.zero,
      );
    } else {
      // Updated message to be more specific about the required format
      Fluttertoast.showToast(
        msg:
            'No valid Indian phone number (+91XXXXXXXXXX) found in the message',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: backgroundColor,
        textColor: textColor,
      );
    }
  }
}
