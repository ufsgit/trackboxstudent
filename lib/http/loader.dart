import 'package:anandhu_s_application4/core/colors_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

class Loader {
  static showLoader({bool dismissible = true}) {
    showDialog(
        barrierDismissible: dismissible,
        barrierColor: Colors.transparent,
        context: Get.context!,
        builder: (ctx) => Center(
              child: CircularProgressIndicator(
                color: ColorResources.colorBlue500,
              ),
            ));
  }

  static stopLoader() {
    Get.back(closeOverlays: true);
  }
}

class LoaderChat {
  static showLoader() {
    showDialog(
        barrierDismissible: false,
        barrierColor: Colors.transparent,
        context: Get.context!,
        builder: (ctx) => Center(
              child: CircularProgressIndicator(
                color: ColorResources.colorBlue500,
              ),
            ));
  }

  static stopLoader() {
    Get.back(closeOverlays: true);
  }
}

class ShimmerLoading extends StatefulWidget {
  const ShimmerLoading({
    super.key,
    required this.isLoading,
    required this.child,
  });

  final bool isLoading;
  final Widget child;

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading> {
  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading) {
      return widget.child;
    }

    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: widget.child,
    );
  }
}
