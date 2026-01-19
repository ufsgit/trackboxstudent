import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:anandhu_s_application4/core/colors_res.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

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
                padding: EdgeInsets.only(left: 4),
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
          'Our Privacy Policy',
          style: GoogleFonts.plusJakartaSans(
            color: ColorResources.colorgrey700,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: const PrivacyPolicyContent(),
    );
  }
}

class PrivacyPolicyContent extends StatelessWidget {
  const PrivacyPolicyContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   'Privacy Policy',
            //   style: TextStyle(
            //     fontSize: 24.0,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            SizedBox(height: 16.0),
            Container(
              decoration: BoxDecoration(color: ColorResources.colorgrey100),
              width: Get.width,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Effective Date: August 16, 2024\n\n'
                  'Welcome to our Privacy Policy. Your privacy is critically important to us.\n\n'
                  'We are committed to safeguarding the privacy of our website visitors; this policy sets out how we will treat your personal information.\n\n'
                  '1. **Information We Collect**\n'
                  'We may collect, store, and use the following kinds of personal data:\n'
                  '   - Information about your computer and your visits to and use of this website (e.g., your IP address, geographical location, browser type, referral source, length of visit, and page views).\n'
                  '   - Information that you provide to us when you register with our website (e.g., your email address).\n'
                  '   - Information that you provide to us for the purpose of subscribing to our email notifications and/or newsletters (e.g., your name and email address).\n'
                  '   - Any other information that you choose to send to us.\n\n'
                  '2. **Using Your Personal Data**\n'
                  'Personal data submitted to us through our website will be used for the purposes specified in this privacy policy or in relevant parts of the website.\n'
                  'We may use your personal information to:\n'
                  '   - Administer the website and improve your browsing experience.\n'
                  '   - Send you email notifications that you have specifically requested.\n'
                  '   - Send you our email newsletter, if you have requested it (you can inform us at any time if you no longer require the newsletter).\n'
                  '   - Deal with inquiries and complaints made by or about you relating to the website.\n'
                  '   - Keep the website secure and prevent fraud.\n\n'
                  '3. **Disclosures**\n'
                  'We may disclose your personal information to any of our employees, officers, agents, suppliers, or subcontractors as reasonably necessary for the purposes set out in this privacy policy.\n'
                  'In addition, we may disclose your personal information:\n'
                  '   - To the extent that we are required to do so by law.\n'
                  '   - In connection with any legal proceedings or prospective legal proceedings.\n'
                  '   - In order to establish, exercise, or defend our legal rights (including providing information to others for the purposes of fraud prevention and reducing credit risk).\n'
                  '   - To the purchaser (or prospective purchaser) of any business or asset that we are (or are contemplating) selling.\n\n'
                  '4. **Security of Your Personal Data**\n'
                  'We will take reasonable technical and organizational precautions to prevent the loss, misuse, or alteration of your personal information.\n'
                  'We will store all the personal information you provide on secure servers.\n'
                  'Information relating to electronic transactions entered into via this website will be protected by encryption technology.\n\n'
                  '5. **Your Rights**\n'
                  'You may instruct us to provide you with any personal information we hold about you.\n'
                  'Provision of such information will be subject to:\n'
                  '   - The payment of a fee (currently fixed at £10).\n'
                  '   - The supply of appropriate evidence of your identity.\n'
                  'We may withhold personal information that you request to the extent permitted by law.\n\n'
                  '6. **Cookies**\n'
                  'Our website uses cookies. A cookie is a file containing an identifier (a string of letters and numbers) that is sent by a web server to a web browser and is stored by the browser.\n'
                  'The identifier is then sent back to the server each time the browser requests a page from the server.\n'
                  'Cookies may be either "persistent" cookies or "session" cookies. A persistent cookie will be stored by a web browser and will remain valid until its set expiry date, unless deleted by the user before the expiry date.\n'
                  'A session cookie, on the other hand, will expire at the end of the user session, when the web browser is closed.\n'
                  'Cookies do not typically contain any information that personally identifies a user, but personal information that we store about you may be linked to the information stored in and obtained from cookies.\n\n'
                  '7. **Changes to This Privacy Policy**\n'
                  'We may update this privacy policy from time to time by posting a new version on our website.\n'
                  'You should check this page occasionally to ensure you are happy with any changes.\n'
                  'We may notify you of significant changes to this privacy policy by email.\n\n'
                  '8. **Contact Us**\n'
                  'If you have any questions about this privacy policy or our treatment of your personal data, please write to us by email to www.Trackbox.com.',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Plus Jakarta Sans',
                    color: ColorResources.colorgrey700,
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
