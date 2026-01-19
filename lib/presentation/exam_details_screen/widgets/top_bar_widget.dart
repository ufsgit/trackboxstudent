import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:anandhu_s_application4/core/colors_res.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/live_class_joining_controller.dart';

class TopBarWidget extends StatelessWidget {
  const TopBarWidget({
    super.key,
    required this.size,
    required this.videoCallCtrl,
  });

  final Size size;
  final LiveClassJoiningController videoCallCtrl;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50,
      left: 15,
      right: 15,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        width: size.width * 0.9,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: Colors.black),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 15,
            ),
            Text(
              "Simple tricks & Roadmap for OET",
              style: GoogleFonts.plusJakartaSans(
                  color: ColorResources.colorwhite,
                  fontSize: 12.fSize,
                  fontWeight: FontWeight.w700),
            ),
            GestureDetector(
              onTap: () {
                if (videoCallCtrl.onButtonPop.value) {
                  videoCallCtrl.popUpMenuButton(false);
                } else {
                  videoCallCtrl.popUpMenuButton(true);
                }
              },
              child: const Icon(
                Icons.more_vert,
                color: Colors.white,
                size: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}
