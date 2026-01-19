import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/colors_res.dart';
import '../../widgets/app_bar/custom_app_bar.dart';

class LiveDetailsScreen extends StatelessWidget {
  const LiveDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 05,
              ),
              width: 85,
              height: 25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.red.withOpacity(0.4),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.radio_button_checked,
                    color: Colors.red,
                    size: 15,
                  ),
                  const SizedBox(
                    width: 05,
                  ),
                  Text(
                    "On Live",
                    style: GoogleFonts.plusJakartaSans(
                      color: ColorResources.colorwhite,
                      fontSize: 12.fSize,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Text(
              'OET Success Live: From Basics to Brilliance',
              style: GoogleFonts.plusJakartaSans(
                color: ColorResources.colorBlack,
                fontSize: 18.fSize,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            LiveDetailsWidget(title: 'By', subtitle: 'Arathy Krishnan'),
            SizedBox(
              height: 15.h,
            ),
            LiveDetailsWidget(
                subtitle: 'The Complete OET Master Class',
                icon: 'assets/images/book.svg'),
            SizedBox(
              height: 05.h,
            ),
            LiveDetailsWidget(
                subtitle: 'Jul 14, 2024', icon: 'assets/images/calendar.svg'),
            SizedBox(
              height: 05.h,
            ),
            LiveDetailsWidget(
                subtitle: '24 min', icon: 'assets/images/clock.svg'),
            SizedBox(
              height: 05.h,
            ),
            LiveDetailsWidget(
                subtitle: '366 joined', icon: 'assets/images/UsersThree.svg'),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                Text(
                  'File uploads     ',
                  style: GoogleFonts.plusJakartaSans(
                    color: ColorResources.colorBlack,
                    fontSize: 14.fSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                SvgPicture.asset('assets/images/File.svg',
                    color: appTheme.blueGray500),
                Text(
                  ' 3',
                  style: GoogleFonts.plusJakartaSans(
                    color: ColorResources.colorgrey600,
                    fontSize: 12.fSize,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            // Center(
            //   child: Container(
            //       width: 250,
            //       height: 250,
            //       child: SvgPicture.asset('assets/images/emptyfile.svg')),
            // ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) => Divider(
                  color: appTheme.blueGray200,
                ),
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 05),
                    leading: SvgPicture.asset('assets/images/uploadfile.svg'),
                    title: Text(
                      'OET_Masterclass_Complete_Guide_2024.pdf',
                      style: GoogleFonts.plusJakartaSans(
                        color: ColorResources.colorBlack,
                        fontSize: 14.fSize,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(context) {
    return CustomAppBar(
      height: 80.v,
      leadingWidth: 50.v,
      leading: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          margin: EdgeInsets.only(left: 16.h),
          child: CircleAvatar(
            radius: 20,
            backgroundColor: ColorResources.colorBlue100,
            child: Padding(
              padding: EdgeInsets.only(left: 8.v),
              child: Icon(
                Icons.arrow_back_ios,
                color: ColorResources.colorBlack.withOpacity(.8),
              ),
            ),
          ),
        ),
      ),
      // leading: AppbarLeadingIconbutton(
      //   imagePath: ImageConstant.imgArrowLeft,
      //   margin: EdgeInsets.only(left: 16.h),
      //   onTap: () {
      //     onTapArrowleftone();
      //   },
      // ),
      title: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Text(
          "Back to Live",
          style: GoogleFonts.plusJakartaSans(
            color: ColorResources.colorBlack,
            fontSize: 14.fSize,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      // title: AppbarSubtitleOne(
      //   text: "lbl_course_details".tr,
      //   margin: EdgeInsets.only(left: 8.h),
      // ),
    );
  }
}

// ignore: must_be_immutable
class LiveDetailsWidget extends StatelessWidget {
  LiveDetailsWidget({super.key, this.title, this.icon, required this.subtitle});
  String? title;
  String? icon;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        title != null
            ? Text(
                '$title',
                style: GoogleFonts.plusJakartaSans(
                  color: ColorResources.colorgrey500,
                  fontSize: 14.fSize,
                  fontWeight: FontWeight.w500,
                ),
              )
            : SvgPicture.asset(
                icon ?? "",
                color: appTheme.blueGray500,
                width: 15,
              ),
        SizedBox(
          width: 10,
        ),
        Text(
          subtitle,
          style: GoogleFonts.plusJakartaSans(
            color: ColorResources.colorBlack,
            fontSize: 14.fSize,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
