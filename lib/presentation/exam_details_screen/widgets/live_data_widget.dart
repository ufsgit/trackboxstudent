import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/colors_res.dart';
import '../controller/live_class_joining_controller.dart';

class VideoCallLiveDataWidget extends StatelessWidget {
  const VideoCallLiveDataWidget({
    super.key,
    required this.videoCallCtrl,
  });
  final LiveClassJoiningController videoCallCtrl;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 100,
      left: 15,
      right: 15,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 08),
                width: 55,
                height: 22,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: ColorResources.colorLiveButton,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 05,
                      height: 05,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                    ),
                    const SizedBox(
                      width: 05,
                    ),
                    Text(
                      "Live",
                      style: GoogleFonts.plusJakartaSans(
                          color: ColorResources.colorwhite,
                          fontSize: 12.fSize,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 07,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 08),
                height: 22,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.remove_red_eye_rounded,
                      color: ColorResources.colorLiveButton,
                      size: 18,
                    ),
                    SizedBox(
                      width: 05,
                    ),
                    Obx(() => Text(
                          '${videoCallCtrl.userInfoList.length}',
                          style: GoogleFonts.plusJakartaSans(
                              color: ColorResources.colorLiveButton,
                              fontSize: 12.fSize,
                              fontWeight: FontWeight.w600),
                        ))
                  ],
                ),
              ),
            ],
          ),
          Obx(
            () => Text(
              "${videoCallCtrl.formattedTime}",
              style: GoogleFonts.plusJakartaSans(
                  color: ColorResources.colorwhite,
                  fontSize: 12.fSize,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }
}
