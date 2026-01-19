import 'dart:io';
import 'dart:math';

import 'package:anandhu_s_application4/core/utils/extentions.dart';
import 'package:anandhu_s_application4/core/utils/firebase_utils.dart';
import 'package:anandhu_s_application4/core/utils/new_version_plus.dart';
import 'package:anandhu_s_application4/presentation/android_large_5_page/controller/call_chat_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:url_launcher/url_launcher.dart';

void safeBack({bool canPop = true}) {
  try {
    final currentState = Get.key.currentState;
    if (currentState != null && currentState.canPop()) {
      Get.back(canPop: canPop);
    } else {
      // Handle null state or no routes
      // For example:
      print('Cannot go back - navigator state is null or no routes to pop');
    }
  } catch (e) {
    print('Error during navigation: $e');
    // Handle the error appropriately
  }
}

Future<void> handleChatNotification() async {
  // // Store current route to check if we're already on home
  // final currentRoute = Get.currentRoute;
  //
  // // If we're not already on home screen, navigate back to it
  // if (currentRoute != '/Widget') {
  //   // Get back to home screen by popping until home
  //   while (Get.currentRoute != '/Widget') {
  //     if (Get.previousRoute == '') break; // Stop if no more routes
  //     safeBack();
  //   }
  //
  //   // // If we couldn't find home in stack, navigate directly
  //   // if (Get.currentRoute != '/home') {
  //   //   Get.offAll(() => HomeScreen());
  //   // }
  // }
  //
  // // Short delay to ensure home screen is loaded
  // await Future.delayed(Duration(milliseconds: 100));
}
// Future<bool> isCallExist(BuildContext context,CallandChatController controller) async {
//   bool isCallExist=false;
//   if(controller.currentCallModel.value.callId.isNullOrEmpty()){
//     isCallExist= false;
//   }else{
//     if(controller.currentCallModel.value.type=="new_call") {
//       isCallExist = await FirebaseUtils.isAnyCallExists();
//     }else{
//       isCallExist= true;

//     }
//   }
//   if(!controller.currentCallModel.value.callId.isNullOrEmpty()) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//           content:
//           Text("Cant place new call. While you are in another call or live")),
//     );
//   }
//   return isCallExist;
// }
String getAvatar(String name) {
  List<String> parts = name.trim().split(' ');
  String firstNameInitial = parts.isNotEmpty ? parts[0][0].toUpperCase() : '';
  String secondNameInitial = parts.length > 1 ? parts[1][0].toUpperCase() : '';
  return firstNameInitial + secondNameInitial;
}

// Method to generate a random color
Color getRandomColor() {
  Random random = Random();
  return Color.fromARGB(
    255,
    random.nextInt(256),
    random.nextInt(256),
    random.nextInt(256),
  );
}
Future<void> showAlertDialog(BuildContext context, String title, String message,Widget? icon,{bool isDismissible=true}) async {
  // set up the buttons
  Widget continueButton = ElevatedButton(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: const Text("Continue",style: TextStyle(color: Colors.white),),
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(message,textAlign: TextAlign.center,),
    icon: icon,actions: [continueButton],
  );
  // show the dialog
  return await  showDialog(barrierDismissible: isDismissible,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showUpdateDialog({
  required BuildContext context,
  required VersionStatus versionStatus,
  String dialogTitle = 'Update Available',
  String? dialogText,
  String updateButtonText = 'Update',
  bool allowDismissal = true,
  String dismissButtonText = 'Maybe Later',
  VoidCallback? dismissAction,
}) async {
  final dialogTitleWidget = Text(dialogTitle);
  final dialogTextWidget = Text(
    dialogText ??
        'You can now update this app from ${versionStatus.localVersion} to ${versionStatus.storeVersion}',
  );

  final updateButtonTextWidget = Text(updateButtonText);

  List<Widget> actions = [
    Platform.isAndroid
        ? TextButton(
      onPressed: () async {
        await launchUrl(Uri.parse(versionStatus.appStoreLink),
            mode: LaunchMode.externalApplication);
      },
      child: updateButtonTextWidget,
    )
        : CupertinoDialogAction(
      onPressed: () async {
        await launchUrl(Uri.parse(versionStatus.appStoreLink),
            mode: LaunchMode.externalApplication);
      },
      child: updateButtonTextWidget,
    ),
  ];

  if (allowDismissal) {
    final dismissButtonTextWidget = Text(dismissButtonText);
    dismissAction =
        dismissAction ?? () => Navigator.of(context, rootNavigator: true).pop();
    actions.add(
      Platform.isAndroid
          ? TextButton(
        onPressed: dismissAction,
        child: dismissButtonTextWidget,
      )
          : CupertinoDialogAction(
        onPressed: dismissAction,
        child: dismissButtonTextWidget,
      ),
    );
  }

  await showDialog(
    context: context,
    barrierDismissible: allowDismissal,
    builder: (BuildContext context) {
      return PopScope(
        canPop: allowDismissal,
        child: Platform.isAndroid
            ? AlertDialog(
          title: dialogTitleWidget,
          content: dialogTextWidget,
          actions: actions,
        )
            : CupertinoAlertDialog(
          title: dialogTitleWidget,
          content: dialogTextWidget,
          actions: actions,
        ),
      );
    },
  );
}
