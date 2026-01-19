import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:anandhu_s_application4/core/colors_res.dart';
import 'package:anandhu_s_application4/presentation/profile/widgets/common_widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CustomBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final TextEditingController controller;
  final void Function(String)? onChanged;

  const CustomBar(
      {super.key,
      required this.title,
      required this.controller,
      required this.onChanged});

  @override
  State<CustomBar> createState() => _CustomBarState();

  @override
  Size get preferredSize => Size.fromHeight(120);
}

class _CustomBarState extends State<CustomBar> {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(115), // Adjust the height as needed
      child: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        flexibleSpace: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Container(
                    height: 35,
                    width: 35,
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
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    widget.title,
                    style: TextStyle(
                        fontSize: 18.v,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff283B52)),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 14,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: textFieldWidgetPayment(
                onChanged: widget.onChanged,
                prefixIcon: Icon(
                  CupertinoIcons.search,
                  color: ColorResources.colorgrey400,
                  size: 24,
                ),
                height: 43,
                controller: widget.controller,
                labelText: 'Search Course',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
