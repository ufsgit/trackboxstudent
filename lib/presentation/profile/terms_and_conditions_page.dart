import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:anandhu_s_application4/core/colors_res.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(16.0),
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: CircleAvatar(
              radius: 15,
              backgroundColor: ColorResources.colorBlue100,
              child: Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 14,
                  color: ColorResources.colorBlack.withOpacity(.8),
                ),
              ),
            ),
          ),
        ),
        titleSpacing: 0,
        title: Text(
          'Terms and Conditions',
          style: GoogleFonts.plusJakartaSans(
            color: ColorResources.colorgrey700,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: const TermsAndConditionsContent(),
    );
  }
}

class TermsAndConditionsContent extends StatelessWidget {
  const TermsAndConditionsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            // Text(
            //   'Terms and Conditions',
            //   style: TextStyle(
            //     fontSize: 24.0,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            SizedBox(height: 16.0),
            // Introduction
            // Text(
            //   'Effective Date: August 16, 2024\n\n'
            //   'Welcome to the Trackbox Academy application. By using our services, you agree to the following terms and conditions. Please read them carefully.\n\n',
            //   style: TextStyle(
            //     fontSize: 16,
            //     fontWeight: FontWeight.w500,
            //     fontFamily: 'Plus Jakarta Sans',
            //     color: ColorResources.colorgrey700,
            //   ),
            // ),
            SizedBox(height: 16.0),
            // Sections
            Container(
              width: Get.width,
              decoration: BoxDecoration(color: ColorResources.colorgrey100),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  'Effective Date: August 16, 2024\n\n'
                  'Welcome to the Trackbox Academy application. By using our services, you agree to the following terms and conditions. Please read them carefully.\n\n'
                  '1. **General Terms**\n'
                  'By using our app, you agree to comply with all applicable laws and regulations. You must be at least 18 years old or have parental consent to use our services.\n\n'
                  '2. **One-to-One Mentoring**\n'
                  'Our one-to-one mentoring services are designed to provide personalized guidance. You agree to respect the mentor\'s time and follow the agreed schedule. Cancellations should be made at least 24 hours in advance.\n\n'
                  '3. **Chats and Calls**\n'
                  'You may use our chat and call features for communication with mentors and other users. Any abusive or inappropriate behavior will not be tolerated and may result in suspension or termination of your account.\n\n'
                  '4. **Live Sessions**\n'
                  'Live sessions are conducted in real-time and require a stable internet connection. You are responsible for ensuring that you have the necessary hardware and software for participation.\n\n'
                  '5. **Video Calls**\n'
                  'Video calls should be conducted respectfully. Ensure that your environment is suitable for video interactions and that you adhere to the scheduled timings.\n\n'
                  '6. **Course Purchase**\n'
                  'All course purchases are final. If you encounter any issues with a purchased course, please contact our support team. Refunds will only be issued in accordance with our refund policy.\n\n'
                  '7. **Intellectual Property**\n'
                  'All content provided through our application, including course materials and mentor content, is protected by intellectual property laws. You may not reproduce or distribute any content without our explicit permission.\n\n'
                  '8. **Limitation of Liability**\n'
                  'We are not liable for any damages resulting from the use or inability to use our services. This includes but is not limited to direct, indirect, incidental, or consequential damages.\n\n'
                  '9. **Changes to Terms**\n'
                  'We may update these terms and conditions from time to time. Any changes will be posted on this page, and it is your responsibility to review them periodically.\n\n'
                  '10. **Contact Us**\n'
                  'If you have any questions or concerns about these terms and conditions, please contact us at www.Trackbox.com',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Plus Jakarta Sans',
                    color: ColorResources.colorgrey700,
                    height: 1.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
