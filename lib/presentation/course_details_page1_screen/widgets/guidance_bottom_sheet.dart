import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GuidanceBottomSheet extends StatelessWidget {
  const GuidanceBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/guidance.png"))),
        ),
        Text(
          'data',
          style: GoogleFonts.plusJakartaSans(),
        ),
        InkWell(
          onTap: () {},
          child: Container(
            width: 328.v,
            height: 40.v,
            decoration: BoxDecoration(
                color: Color(0xff1863D3),
                borderRadius: BorderRadius.circular(42.v)),
            child: Center(
              child: Text(
                'Continue',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
