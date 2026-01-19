import 'package:anandhu_s_application4/core/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/colors_res.dart';

class PopUpMenuItems extends StatelessWidget {
  const PopUpMenuItems(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap});
  final String title;
  final String icon;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          SvgPicture.asset(icon),
          const SizedBox(
            width: 05,
          ),
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(
                color: ColorResources.colorBlack,
                fontSize: 14.fSize,
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
