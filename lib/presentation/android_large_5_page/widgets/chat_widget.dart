import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:anandhu_s_application4/core/colors_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

Widget chatWidget(
    {int? index,
    required String name,
    required String content,
    required String unreadCount,
    required String image,
    required String callIcon,
    required bool isCall,
    required String date,
    required String time}) {
  return SizedBox(
    height: 60.h,
    child: ListTile(
      // onTap: onTap,
      // tileColor: ColorResources.colorBlack,
      leading: CustomImageView(
        bgColor: ColorResources.colorBlue100,
        imagePath: image,
        height: 50.adaptSize,
        width: 50.adaptSize,
        radius: BorderRadius.circular(
          25.adaptSize,
        ),
      ),
      title: Text(
        name,
        style: GoogleFonts.plusJakartaSans(
          color: ColorResources.colorBlack,
          fontSize: 14.fSize,
          fontWeight: FontWeight.w700,
        ),
      ),

      subtitle: isCall == false
          // ? Padding(
          //     padding: const EdgeInsets.only(top: 4),
          //     child: Text(
          //       content,
          //       overflow: TextOverflow.ellipsis,
          //       style: GoogleFonts.plusJakartaSans(
          //         color: ColorResources.colorgrey600,
          //         fontSize: 12,
          //         fontWeight: FontWeight.w500,
          //       ),
          //     ),
          //   )
          ? Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                content,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.plusJakartaSans(
                  color: ColorResources.colorgrey600,
                  fontSize: 12.fSize,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    callIcon,
                    height: 15.h,
                    width: 15,
                  ),
                  SizedBox(
                    width: 4.h,
                  ),
                  Text(
                    content,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.plusJakartaSans(
                      color: ColorResources.colorgrey600,
                      fontSize: 12.fSize,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            date == 'Today' ? time : date,
            style: GoogleFonts.plusJakartaSans(
              color: ColorResources.colorgrey600,
              fontSize: 12.fSize,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 6.h,
          ),
          isCall == false
              ? unreadCount != '0'
                  ? Container(
                      height: 18.h,
                      width: 18.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorResources.colorBlue500,
                      ),
                      child: Center(
                        child: Text(
                          unreadCount,
                          style: GoogleFonts.plusJakartaSans(
                            color: ColorResources.colorwhite,
                            fontSize: 12.fSize,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    )
                  : SizedBox()
              : const SizedBox(),
        ],
      ),
    ),
  );
}
