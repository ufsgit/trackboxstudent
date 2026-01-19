import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:anandhu_s_application4/core/colors_res.dart';
import 'package:anandhu_s_application4/presentation/login/login_controller.dart';
import 'package:anandhu_s_application4/presentation/profile/controller/profile_controller.dart';
import 'package:anandhu_s_application4/presentation/profile/edit_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountAndSecurityView extends StatelessWidget {
  AccountAndSecurityView({super.key});
  final LoginController profileController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        // bottom: TitleText(preferredHeight: 50),
        title: Text(
          'Account and security',
          style: TextStyle(
              fontSize: 18.v,
              fontWeight: FontWeight.w700,
              color: Color(0xff283B52)),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 36,
            width: 36,
            decoration: BoxDecoration(
                color: ColorResources.colorBlue100,
                borderRadius: BorderRadius.circular(100)),
            child: IconButton(
              padding: EdgeInsets.all(0),
              constraints: BoxConstraints(),
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                CupertinoIcons.back,
                color: ColorResources.colorBlack.withOpacity(.8),
                size: 25,
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          ListButton(
            onTap: () => Get.to(() => EditProfileScreen()),
            title: 'Edit Profile',
          ),
          // ListButton(
          //   onTap: () {},
          //   title: 'Reset Password',
          // ),
          ListButton(
            onTap: () => showDeleteDialogue(context),
            title: 'Delete My account',
            isDeleteAccount: true,
          ),
        ],
      ),
    );
  }

  showDeleteDialogue(BuildContext context) {
    return showDialog(
      context: context,
      builder: (c) => AlertDialog(
        content: Material(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset('assets/images/Container.svg'),
              SizedBox(height: 24),
              Text(
                'Deleting your account will permanently remove all data, including course progress. This cannot be undone.',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(200, 36),
                    padding: const EdgeInsets.all(18.0),
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0XFFEB4141)),
                onPressed: () {
                  profileController.deleteAccount();
                },
                child: Text('Delete Account'),
              ),
              SizedBox(height: 16),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                    fixedSize: Size(200, 36),
                    side: BorderSide(color: Colors.black),
                    padding: const EdgeInsets.all(18.0),
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white),
                onPressed: () => Get.back(),
                child: Text('Cancel'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListButton extends StatelessWidget {
  const ListButton({
    super.key,
    required this.title,
    required this.onTap,
    this.isDeleteAccount = false,
  });
  final String title;
  final void Function() onTap;
  final bool isDeleteAccount;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 52.v,
        padding: EdgeInsets.symmetric(horizontal: 12.v),

        margin: EdgeInsets.only(top: 9.v),

        // width: 328.v,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12.v)),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                    color: isDeleteAccount ? Colors.red.shade700 : Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 13.v),
              ),
              isDeleteAccount
                  ? SizedBox()
                  : Icon(
                      Icons.arrow_forward_ios,
                      size: 14.v,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class TitleText extends StatelessWidget implements PreferredSizeWidget {
  final double preferredHeight;

  TitleText({required this.preferredHeight});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
        child: Text(
          'Account & Security',
          style: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(preferredHeight);
}
