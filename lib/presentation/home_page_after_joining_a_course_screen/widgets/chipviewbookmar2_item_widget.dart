import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/chipviewbookmar2_item_model.dart';

// ignore_for_file: must_be_immutable
class Chipviewbookmar2ItemWidget extends StatelessWidget {
  Chipviewbookmar2ItemWidget(this.chipviewbookmar2ItemModelObj, {Key? key})
      : super(
          key: key,
        );

  Chipviewbookmar2ItemModel chipviewbookmar2ItemModelObj;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => RawChip(
        padding: EdgeInsets.only(
          top: 10.v,
          right: 14.h,
          bottom: 10.v,
        ),
        showCheckmark: false,
        labelPadding: EdgeInsets.zero,
        label: Text(
          chipviewbookmar2ItemModelObj.bookmark!.value,
          style: TextStyle(
            color: appTheme.blueGray80003,
            fontSize: 12.fSize,
            fontFamily: 'Plus Jakarta Sans',
            fontWeight: FontWeight.w600,
          ),
        ),
        avatar: CustomImageView(
          imagePath: ImageConstant.imgBookmark,
          height: 16.adaptSize,
          width: 16.adaptSize,
          radius: BorderRadius.circular(
            11.h,
          ),
          margin: EdgeInsets.only(right: 8.h),
        ),
        selected: (chipviewbookmar2ItemModelObj.isSelected?.value ?? false),
        backgroundColor: appTheme.whiteA700,
        selectedColor: appTheme.whiteA700,
        shape: (chipviewbookmar2ItemModelObj.isSelected?.value ?? false)
            ? RoundedRectangleBorder(
                side: BorderSide(
                  color: appTheme.whiteA700.withOpacity(0.6),
                  width: 1.h,
                ),
                borderRadius: BorderRadius.circular(
                  12.h,
                ))
            : RoundedRectangleBorder(
                side: BorderSide(
                  color: appTheme.indigo5001,
                  width: 1.h,
                ),
                borderRadius: BorderRadius.circular(
                  12.h,
                ),
              ),
        onSelected: (value) {
          chipviewbookmar2ItemModelObj.isSelected!.value = value;
        },
      ),
    );
  }
}
