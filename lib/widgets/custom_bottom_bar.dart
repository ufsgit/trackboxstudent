import 'package:anandhu_s_application4/core/colors_res.dart';
import 'package:anandhu_s_application4/presentation/home_page_container_screen/controller/home_page_container_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/app_export.dart';

enum BottomBarEnum { Home, Connect, Mentors, Test, Profile, Mycourses }

class CustomBottomBar extends StatelessWidget {
  CustomBottomBar({Key? key, this.onChanged}) : super(key: key);

  final Function(BottomBarEnum)? onChanged;

  final List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: ImageConstant.imgbottomhome,
      activeIcon: ImageConstant.imgbottomhomeFilled,
      title: "lbl_home".tr,
      type: BottomBarEnum.Home,
    ),
    // BottomMenuModel(
    //   icon: ImageConstant.imgbottomcourse,
    //   activeIcon: ImageConstant.imgbottomcourseFilled,
    //   title: "Course".tr,
    //   type: BottomBarEnum.Mycourses,
    // ),
    BottomMenuModel(
      icon: ImageConstant.imgBottomConnect,
      activeIcon: ImageConstant.imgBottomConnectFilled,
      title: "Faculty",
      type: BottomBarEnum.Connect,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgbottomchat,
      activeIcon: ImageConstant.imgbottomchatFilled,
      title: "Chats",
      type: BottomBarEnum.Mentors,
    ),
    // BottomMenuModel(
    //   icon: ImageConstant.imgPen,
    //   activeIcon: ImageConstant.imgPen,
    //   title: "Test",
    //   type: BottomBarEnum.Test,
    // ),
    BottomMenuModel(
      icon: ImageConstant.imgBottomProfile,
      activeIcon: ImageConstant.imgBottomProfileFilled,
      title: "lbl_profile".tr,
      type: BottomBarEnum.Profile,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final HomePageContainerController controller =
        Get.find<HomePageContainerController>();

    return Container(
      height: 92.v,
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
        border: Border(
          top: BorderSide(
            color: appTheme.indigo5001,
            width: 1.h,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withOpacity(0.25),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              1,
            ),
          )
        ],
      ),
      child: Obx(() {
        return BottomNavigationBar(
          backgroundColor: Colors.transparent,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedFontSize: 0,
          elevation: 0,
          currentIndex: controller.selectedIndex.value,
          type: BottomNavigationBarType.fixed,
          items: List.generate(bottomMenuList.length, (index) {
            return BottomNavigationBarItem(
              icon: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomImageView(
                    imagePath: bottomMenuList[index].icon,
                    height: 24.adaptSize,
                    width: 24.adaptSize,
                    color: theme.colorScheme.onError,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.v),
                    child: Text(
                      bottomMenuList[index].title ?? "",
                      style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w800,
                          fontSize: 13,
                          color: ColorResources.colorgrey500),
                    ),
                  )
                ],
              ),
              activeIcon: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomImageView(
                    imagePath: bottomMenuList[index].activeIcon,
                    height: 26.adaptSize,
                    width: 26.adaptSize,
                    color: appTheme.blue800,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 7.v),
                    child: Text(
                      bottomMenuList[index].title ?? "",
                      style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                          color: ColorResources.colorBlue600),
                    ),
                  )
                ],
              ),
              label: '',
            );
          }),
          onTap: (index) {
            controller.selectedIndex.value = index;
            onChanged?.call(bottomMenuList[index].type);
          },
        );
      }),
    );
  }
}

class BottomMenuModel {
  BottomMenuModel(
      {required this.icon,
      required this.activeIcon,
      this.title,
      required this.type});

  String icon;

  String activeIcon;

  String? title;

  BottomBarEnum type;
}

class DefaultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffffffff),
      padding: EdgeInsets.all(10),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please replace the respective Widget here',
              style: TextStyle(
                fontSize: 18,
              ),
            )
          ],
        ),
      ),
    );
  }
}
