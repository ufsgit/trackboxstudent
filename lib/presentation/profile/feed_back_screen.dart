import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:anandhu_s_application4/core/colors_res.dart';
import 'package:anandhu_s_application4/presentation/profile/controller/profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedBackScreen extends StatelessWidget {
  const FeedBackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.find<ProfileController>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Feedback',
            style: TextStyle(
              fontSize: 18.v,
              fontWeight: FontWeight.w700,
              color: Color(0xff283B52),
            ),
          ),
          titleSpacing: 0,
          leading: Padding(
            padding: const EdgeInsets.all(12.0),
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
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: ColorResources.colorwhite,
                  borderRadius: BorderRadius.circular(2),
                  border: Border.all(
                      color: ColorResources.colorBlack.withOpacity(.3)),
                  boxShadow: [
                    BoxShadow(
                      color: ColorResources.colorgrey300,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: TextField(
                  controller: profileController.feedbackController,
                  maxLines: 8,
                  decoration: InputDecoration(
                    hintText: 'Please enter your feedback here...',
                    hintStyle: GoogleFonts.plusJakartaSans(
                      color: ColorResources.colorgrey600,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    contentPadding: EdgeInsets.all(16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: ColorResources.colorBlue100,
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: ColorResources.colorBlue100,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: ColorResources.colorBlue100,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
              // Submit button
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: InkWell(
            onTap: () async {
              if (profileController.feedbackController.text.trim().isNotEmpty) {
                await profileController.submitFeedBack(
                    feedBack: profileController.feedbackController.text);
                print(
                    'Feedback submitted: ${profileController.feedbackController.text}');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Thank you for your feedback!'),
                    backgroundColor: ColorResources.colorBlue600,
                  ),
                );
                profileController.feedbackController.clear();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Please enter your feedback'),
                    backgroundColor: ColorResources.colorgrey800,
                  ),
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.v),
                width: Get.width,
                height: 40.h,
                decoration: BoxDecoration(
                    color: ColorResources.colorBlue600,
                    borderRadius: BorderRadius.circular(20.v)),
                child: Center(
                    child: Text(
                  'Submit feedback',
                  style: TextStyle(
                      color: ColorResources.colorwhite,
                      fontSize: 14.v,
                      fontWeight: FontWeight.w700),
                )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
