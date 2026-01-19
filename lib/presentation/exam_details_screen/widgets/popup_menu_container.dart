import 'package:flutter/material.dart';
import '../controller/live_class_joining_controller.dart';
import 'popup_menu_items_widget.dart';

class PopUpMenuContainer extends StatelessWidget {
  const PopUpMenuContainer({
    super.key,
    required this.videoCallCtrl,
  });

  final LiveClassJoiningController videoCallCtrl;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        right: 15,
        top: 100,
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 96,
            width: 154,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: Colors.white),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PopUpMenuItems(
                    onTap: () {
                      if (videoCallCtrl.frontCamEnabled.value) {
                        videoCallCtrl.switchCamera(false);
                      } else {
                        videoCallCtrl.switchCamera(true);
                      }
                    },
                    icon: "assets/images/CameraRotate.svg",
                    title: "Switch camera",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  PopUpMenuItems(
                    onTap: () {
                      videoCallCtrl.viewLiveDetails();
                    },
                    icon: "assets/images/Info.svg",
                    title: "Live details",
                  ),
                ],
              ),
            )));
  }
}
