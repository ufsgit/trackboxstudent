import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:anandhu_s_application4/core/colors_res.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class TeacherWidget extends StatelessWidget {
  final String name;
  final String timeSlots;
  final String image;
  final void Function()? onTapVideo;
  final void Function()? onTapAudio;
  final void Function()? tileOnTap;
  final bool isBatch;
  final String bannerText;
  final Color bannerColor;
  final Color bannerTextColor;

  const TeacherWidget(
      {Key? key,
      required this.name,
      required this.timeSlots,
      required this.image,
      this.onTapVideo,
      this.onTapAudio,
      this.tileOnTap,
      required this.isBatch,
      required this.bannerColor,
      required this.bannerTextColor,
      required this.bannerText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('teacher widget $image');
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            height: 85.h,
            decoration: BoxDecoration(
                color: ColorResources.colorwhite,
                boxShadow: [
                  BoxShadow(color: ColorResources.colorgrey300, blurRadius: 9)
                ]),
            child: Center(
              child: ListTile(
                onTap: tileOnTap,
                leading: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: ClipOval(
                    child: SizedBox(
                      width: 46,
                      height: 46,
                      child: image.contains("assets")
                          ? Container(
                              color: ColorResources.colorBlue600,
                              child: Image(
                                image: AssetImage(
                                  image,
                                ),
                                fit: BoxFit.fill,
                                color: ColorResources.colorBlue100,
                              ),
                            )
                          : CachedNetworkImage(
                              imageUrl: image,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  width: 46,
                                  height: 46,
                                  color: Colors.white,
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  CircleAvatar(
                                radius: 23,
                                backgroundColor: Colors.grey[300],
                                child: Icon(
                                  Icons.person,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                    ),
                  ),
                ),
                title: Text(
                  name,
                  style: GoogleFonts.plusJakartaSans(
                    color: ColorResources.colorBlack,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                  softWrap: true, // Allows the text to wrap
                  overflow: TextOverflow.visible, // Ensures no clipping
                ),
                subtitle: Text(
                  timeSlots,
                  style: GoogleFonts.plusJakartaSans(
                    color: ColorResources.colorgrey600,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  softWrap: true,
                  overflow: TextOverflow.visible,
                ),
                // trailing: Row(
                //   mainAxisSize: MainAxisSize.min,
                //   children: [
                //     InkWell(
                //       onTap: onTapAudio,
                //       child: CircleAvatar(
                //         backgroundColor: ColorResources.colorBlue500,
                //         radius: 14,
                //         child: const Icon(
                //           Icons.phone,
                //           color: Colors.white,
                //           size: 18,
                //         ),
                //       ),
                //     ),
                //     const SizedBox(width: 12),
                //     InkWell(
                //       onTap: onTapVideo,
                //       child: CircleAvatar(
                //         backgroundColor: ColorResources.colorBlue500,
                //         radius: 14,
                //         child: const Icon(
                //           Icons.videocam_outlined,
                //           color: Colors.white,
                //           size: 18,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
              ),
            ),
          ),
        ),
        // Positioned(
        //     right: 0,
        //     top: 0,
        //     child: Padding(
        //       padding: const EdgeInsets.symmetric(horizontal: 16),
        //       child: Container(
        //         height: 20,
        //         child: Center(
        //             child: Padding(
        //           padding: const EdgeInsets.symmetric(horizontal: 8),
        //           child: Text(
        //             bannerText,
        //             style: GoogleFonts.plusJakartaSans(
        //               color: bannerTextColor,
        //               fontSize: 12,
        //               fontWeight: FontWeight.w700,
        //             ),
        //           ),
        //         )),
        //         decoration: BoxDecoration(
        //             color: bannerColor,
        //             borderRadius: BorderRadius.only(
        //                 bottomLeft: Radius.circular(12),
        //                 topRight: Radius.circular(6))),
        //       ),
        //     ))
      ],
    );
  }
}
