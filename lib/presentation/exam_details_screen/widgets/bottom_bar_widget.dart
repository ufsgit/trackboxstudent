import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zego_express_engine/zego_express_engine.dart';

import '../../../core/colors_res.dart';
import '../controller/live_class_joining_controller.dart';

// ignore: must_be_immutable
class BottomBarWidget extends StatefulWidget {
  BottomBarWidget(
      {super.key,
      required this.videoCallCtrl,
      required this.callID,
      this.localViewID,
      this.localView});
  Widget? localView;
  int? localViewID;
  final String callID;
  final LiveClassJoiningController videoCallCtrl;

  @override
  State<BottomBarWidget> createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 08,
        left: widget.videoCallCtrl.userCount.value > 1 ? 40 : 70,
        right: widget.videoCallCtrl.userCount.value > 1 ? 40 : 70,
        child: Obx(
          () => Container(
            padding: const EdgeInsets.symmetric(horizontal: 05, vertical: 05),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(28),
                color: Colors.grey.shade600),
            height: 64,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                
                
                if (widget.videoCallCtrl.userCount.value > 1)
                  GestureDetector(
                    onTap: () {
                      if (widget.videoCallCtrl.isAudioEnabled.value == true) {
                        widget.videoCallCtrl.turnMicrophoneOn(false, context);
                      } else {
                        widget.videoCallCtrl.turnMicrophoneOn(true, context);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      height: 56,
                      width: 56,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: widget.videoCallCtrl.isAudioEnabled.value
                              ? Colors.grey.shade800
                              : Colors.white),
                      child: SvgPicture.asset(
                          "assets/images/MicrophoneSlash.svg",
                          color: widget.videoCallCtrl.isAudioEnabled.value
                              ? Colors.white
                              : Colors.blue),
                    ),
                  ),
                GestureDetector(
                  onTap: () {
                    if (widget.videoCallCtrl.isVideoEnabled.value) {
                      widget.videoCallCtrl.turnCameraOn(false, context);
                    } else {
                      widget.videoCallCtrl.turnCameraOn(true, context);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: widget.videoCallCtrl.isVideoEnabled.value
                            ? Colors.grey.shade800
                            : Colors.white),
                    child: SvgPicture.asset(
                      "assets/images/VideoCameraSlash.svg",
                      color: widget.videoCallCtrl.isVideoEnabled.value
                          ? Colors.white
                          : Colors.blue,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    height: 56,
                    width: 56,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: Colors.grey.shade800),
                    child: SvgPicture.asset("assets/images/UsersThree.svg"),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    stopListenEvent();
                    logoutRoom();
                  },
                  child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: ColorResources.colorLeaveButton),
                      child: Center(
                          child: Text(
                        "Leave",
                        style: GoogleFonts.plusJakartaSans(
                            color: ColorResources.colorwhite,
                            fontSize: 12.fSize,
                            fontWeight: FontWeight.w600),
                      ))),
                ),
              ],
            ),
          ),
        ));
  }

  Future<ZegoRoomLogoutResult> logoutRoom() async {
    widget.videoCallCtrl.timer?.cancel();
    widget.videoCallCtrl.disconnectUser();
    stopPreview();
    stopPublish();
    return ZegoExpressEngine.instance.logoutRoom(widget.callID);
  }

  Future<void> stopPublish() async {
    return ZegoExpressEngine.instance.stopPublishingStream();
  }

  Future<void> stopPreview() async {
    ZegoExpressEngine.instance.stopPreview();
    if (widget.localViewID != null) {
      await ZegoExpressEngine.instance.destroyCanvasView(widget.localViewID!);
      if (mounted) {
        setState(() {
          widget.localViewID = null;
          widget.localView = null;
        });
      }
    }
  }

  void stopListenEvent() {
    ZegoExpressEngine.onRoomUserUpdate = null;
    ZegoExpressEngine.onRoomStreamUpdate = null;
    ZegoExpressEngine.onRoomStateUpdate = null;
    ZegoExpressEngine.onPublisherStateUpdate = null;
    ZegoExpressEngine.onRemoteCameraStateUpdate = null;
    ZegoExpressEngine.onRoomOnlineUserCountUpdate = null;
    ZegoExpressEngine.onRemoteMicStateUpdate = null;
    ZegoExpressEngine.onRemoteCameraStateUpdate = null;
  }
}
