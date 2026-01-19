import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/colors_res.dart';

Container commonBackgroundLinearColor({required Widget childWidget}) {
  return Container(
    decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: ColorResources.backgroundColors)),
    child: childWidget,
  );
}

class ShowDialogWidget extends StatelessWidget {
  final void Function()? fromGallery;
  final void Function()? fromCamera;
  const ShowDialogWidget(
      {super.key, required this.fromGallery, required this.fromCamera});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: false,
      shadowColor: ColorResources.colorBlack,
      elevation: 15,
      backgroundColor: ColorResources.colorwhite,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: fromGallery,
                icon: Icon(Icons.photo_size_select_actual_rounded),
              ),
              Text(
                'Gallery',
                style: GoogleFonts.dmSans(
                  color: ColorResources.colorBlack,
                  fontSize: 14.fSize,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  onPressed: fromCamera,
                  icon: const Icon(Icons.camera_alt_rounded)),
              Text(
                'Camera',
                style: GoogleFonts.dmSans(
                  color: ColorResources.colorBlack,
                  fontSize: 14.fSize,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
