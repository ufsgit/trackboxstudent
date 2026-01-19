import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:anandhu_s_application4/core/colors_res.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget commonTextFieldWidget({
  required TextEditingController controller,
  required String labelText,
  required ValueChanged<String> onChanged,
}) {
  return SizedBox(
    height: 54,
    child: TextField(
      controller: controller,
      style: GoogleFonts.plusJakartaSans(
        color: ColorResources.colorBlue800,
        fontSize: 14.fSize,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: GoogleFonts.plusJakartaSans(
          color: ColorResources.colorgrey600,
          fontSize: 12.fSize,
          fontWeight: FontWeight.w400,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 10.v, horizontal: 10.h),
        fillColor: ColorResources.colorwhite,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.v),
          borderSide: const BorderSide(color: ColorResources.colorBlack),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.v),
          borderSide: const BorderSide(color: ColorResources.colorgrey300),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.v),
          borderSide: const BorderSide(color: ColorResources.colorgrey200),
        ),
      ),
      onChanged: onChanged,
    ),
  );
}

/// Section Widget
Widget paymentHistoryWidget() {
  return ListView.separated(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    separatorBuilder: (context, index) {
      return SizedBox(
        height: 24.v,
      );
    },
    itemCount: 3,
    itemBuilder: (context, index) {
      return InkWell(
        onTap: () async {},
        child: Container(
          color: ColorResources.colorwhite,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 80.h,
                      width: 110.v,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.v),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.v),
                        child: Image.network(
                          'https://th.bing.com/th/id/OIP.tjY-sk6hGjTCg7hAO0-NqwAAAA?rs=1&pid=ImgDetMain',
                          fit: BoxFit.contain,
                          errorBuilder: (BuildContext context, Object error,
                              StackTrace? stackTrace) {
                            return Center(
                              child: Icon(Icons.image_not_supported_outlined,
                                  color: ColorResources.colorBlue100, size: 40),
                            );
                          },
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                  color: darkbluesix,
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          (loadingProgress.expectedTotalBytes ??
                                              1)
                                      : null,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 12.h,
                        top: 2.v,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 180.h,
                                child: Text(
                                  'The complete OET Masterclass : Basic to Advanced',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.titleSmall!.copyWith(
                                    height: 1.43,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.more_vert_rounded,
                                color: ColorResources.colorgrey500,
                              )
                            ],
                          ),
                          SizedBox(height: 2.v),
                          SizedBox(
                            width: 180.h,
                            child: Text(
                              '5000',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleSmall!.copyWith(
                                height: 1.43,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                    width: Get.width,
                    height: 32,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            side:
                                BorderSide(color: ColorResources.colorgrey500),
                            backgroundColor: ColorResources.colorwhite),
                        onPressed: () {},
                        child: Text(
                          'View details',
                          style: TextStyle(color: ColorResources.colorBlack),
                        ))),
                SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget textFieldWidgetPayment(
    {required TextEditingController? controller,
    required String? labelText,
    required double? height,
    void Function(String)? onChanged,
    Widget? prefixIcon,
    Widget? suffixIcon}) {
  return SizedBox(
    height: height,
    child: TextField(
      onChanged: onChanged,
      controller: controller,
      style: GoogleFonts.plusJakartaSans(
        color: ColorResources.colorgrey800,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        // suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        hintText: labelText,
        hintStyle: GoogleFonts.plusJakartaSans(
          color: ColorResources.colorgrey600,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        fillColor: ColorResources.colorwhite,
        filled: true,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
                color: ColorResources.colorgrey700, width: 1.5)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
                color: ColorResources.colorgrey400, width: 1.5)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: ColorResources.colorgrey200)),
      ),
    ),
  );
}
