import 'package:flutter/material.dart';
import '../core/app_export.dart';

class CustomSearchView extends StatelessWidget {
  CustomSearchView(
      {Key? key,
      this.alignment,
      this.width,
      this.scrollPadding,
      this.controller,
      this.focusNode,
      this.autofocus = false,
      this.textStyle,
      this.textInputType = TextInputType.text,
      this.maxLines,
      this.hintText,
      this.hintStyle,
      this.prefix,
      this.prefixConstraints,
      this.suffix,
      this.suffixConstraints,
      this.contentPadding,
      this.borderDecoration,
      this.fillColor,
      this.filled = true,
      this.validator,
      this.onChanged})
      : super(
          key: key,
        );

  final Alignment? alignment;

  final double? width;

  final TextEditingController? scrollPadding;

  final TextEditingController? controller;

  final FocusNode? focusNode;

  final bool? autofocus;

  final TextStyle? textStyle;

  final TextInputType? textInputType;

  final int? maxLines;

  final String? hintText;

  final TextStyle? hintStyle;

  final Widget? prefix;

  final BoxConstraints? prefixConstraints;

  final Widget? suffix;

  final BoxConstraints? suffixConstraints;

  final EdgeInsets? contentPadding;

  final InputBorder? borderDecoration;

  final Color? fillColor;

  final bool? filled;

  final FormFieldValidator<String>? validator;

  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center, child: searchViewWidget)
        : searchViewWidget;
  }

  Widget get searchViewWidget => SizedBox(
        width: width ?? double.maxFinite,
        child: TextFormField(
            scrollPadding: EdgeInsets.only(
                bottom: MediaQuery.of(Get.context!).viewInsets.bottom),
            controller: controller,
            focusNode: focusNode,
            onTapOutside: (event) {
              if (focusNode != null) {
                focusNode?.unfocus();
              } else {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            autofocus: autofocus!,
            style: textStyle ?? CustomTextStyles.bodyMediumBluegray40002,
            keyboardType: textInputType,
            maxLines: maxLines ?? 1,
            decoration: decoration,
            validator: validator,
            onChanged: onChanged),
      );
  InputDecoration get decoration => InputDecoration(
        hintText: hintText ?? "",
        hintStyle: hintStyle ?? CustomTextStyles.bodyMediumBluegray40002,
        prefixIcon: prefix ??
            Container(
              margin: EdgeInsets.fromLTRB(12.h, 10.v, 4.h, 10.v),
              child: CustomImageView(
                imagePath: ImageConstant.imgSearchBlueGray400,
                height: 19.v,
                width: 20.h,
              ),
            ),
        prefixIconConstraints: prefixConstraints ??
            BoxConstraints(
              maxHeight: 40.v,
            ),
        // suffixIcon: suffix ??
        //     Container(
        //       margin: EdgeInsets.fromLTRB(11.h, 8.v, 12.h, 8.v),
        //       child: CustomImageView(
        //         imagePath: ImageConstant.imgFrame2609094,
        //         height: 24.adaptSize,
        //         width: 24.adaptSize,
        //       ),
        //     ),
        suffixIconConstraints: suffixConstraints ??
            BoxConstraints(
              maxHeight: 40.v,
            ),
        isDense: true,
        contentPadding: contentPadding ??
            EdgeInsets.only(
              top: 11.v,
              right: 11.h,
              bottom: 11.v,
            ),
        fillColor: fillColor ?? appTheme.whiteA700,
        filled: filled,
        border: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.h),
              borderSide: BorderSide(
                color: appTheme.indigo1005e,
                width: 1,
              ),
            ),
        enabledBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.h),
              borderSide: BorderSide(
                color: appTheme.indigo1005e,
                width: 1,
              ),
            ),
        focusedBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.h),
              borderSide: BorderSide(
                color: appTheme.indigo1005e,
                width: 1,
              ),
            ),
      );
}
