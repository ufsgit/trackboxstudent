import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/chipviewbookmar_item_model.dart';

// ignore_for_file: must_be_immutable
class ChipviewbookmarItemWidget extends StatelessWidget {
  ChipviewbookmarItemWidget(this.chipviewbookmarItemModelObj, {Key? key})
      : super(
          key: key,
        );

  ChipviewbookmarItemModel chipviewbookmarItemModelObj;

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
          chipviewbookmarItemModelObj.bookmark!.value,
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
          // margin: EdgeInsets.only(right: 8.h),
        ),
        selected: (chipviewbookmarItemModelObj.isSelected?.value ?? false),
        backgroundColor: appTheme.whiteA700,
        selectedColor: appTheme.whiteA700,
        shape: (chipviewbookmarItemModelObj.isSelected?.value ?? false)
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
          Get.toNamed(AppRoutes.readingTestQuestionScreen);
          chipviewbookmarItemModelObj.isSelected!.value = value;
        },
      ),
    );
  }
}
