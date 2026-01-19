import 'package:anandhu_s_application4/core/colors_res.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewerScreen extends StatelessWidget {
  const ImageViewerScreen({
    super.key,
    required this.imageUrl,
  });
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorResources.colorBlack,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: ColorResources.colorwhite,
            ),
          ),
          title: Text(
            'Image',
            style: GoogleFonts.plusJakartaSans(
                color: ColorResources.colorwhite,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
        ),
        body: Container(
          color: ColorResources.colorBlack,
          height: size.height,
          width: size.width,
          child: Center(
            child: PhotoView(
              imageProvider: CachedNetworkImageProvider(imageUrl),
            ),
          ),
        ));
  }
}
