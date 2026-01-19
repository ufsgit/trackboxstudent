import 'package:anandhu_s_application4/core/colors_res.dart';
import 'package:anandhu_s_application4/core/utils/pref_utils.dart';
import 'package:anandhu_s_application4/http/http_urls.dart';
import 'package:anandhu_s_application4/http/loader.dart';
import 'package:anandhu_s_application4/presentation/breff_screen/controller/breff_controller.dart';
import 'package:anandhu_s_application4/presentation/login/login_controller.dart';
import 'package:anandhu_s_application4/presentation/splash_screen/splashscreen1.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HttpRequest {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final BreffController avatarController = getx.Get.put(BreffController());

  static Future<Response?> httpGetRequest(
      {Map<String, dynamic>? bodyData,
      String endPoint = '',
      bool showLoader = false}) async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final BreffController avatarController = getx.Get.put(BreffController());

    if (showLoader) {
      Loader.showLoader();
    }

    if (kDebugMode) {
      print('get request ====> $endPoint $bodyData ');
    }

    final Dio dio = Dio();
    final prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('breffini_token') ?? "";
    print(token);

    try {
      final Response response = await dio.get(
        '${HttpUrls.baseUrl}$endPoint',
        options: Options(headers: {
          'ngrok-skip-browser-warning': 'true',
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        }),
        queryParameters: bodyData,
      );

      if (kDebugMode) {
        print('get result ====> ${response.data}  ');
      }

      // Only stop loader if it was shown
      if (showLoader) {
        Loader.stopLoader();
      }

      return response;
    } catch (ex) {
      if (ex.toString().contains('401')) {
        print('CRITICAL: 401 Error. Token: $token');
        if (ex is DioException) {
          print('Response info: ${ex.response?.data}');
        }
        getx.Get.find<LoginController>().logout();

        getx.Get.snackbar(
          '',
          '',
          backgroundColor: ColorResources.colorgrey800,
          titleText: const Text(
            'Your session was expired',
            style: TextStyle(color: ColorResources.colorwhite),
          ),
          messageText: const Text(
              "Please contact support for more information.",
              style: TextStyle(color: ColorResources.colorwhite)),
          snackPosition: getx.SnackPosition.BOTTOM,
        );
      } else {
        getx.Get.snackbar(
          '',
          '',
          backgroundColor: ColorResources.colorgrey800,
          titleText: const Text(
            "Bad response",
            style: TextStyle(color: ColorResources.colorwhite),
          ),
          messageText: Text(ex.toString(),
              style: TextStyle(color: ColorResources.colorwhite)),
          snackPosition: getx.SnackPosition.BOTTOM,
        );
      }

      // Only stop loader if it was shown
      if (showLoader) {
        Loader.stopLoader();
      }

      return null;
    }
  }

  static Future<Response?> httpPostRequest(
      {Map<String, dynamic>? bodyData, String endPoint = ''}) async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final BreffController avatarController = getx.Get.put(BreffController());
    //  Loader.showLoader();
    if (kDebugMode) {
      print('post request ====> $endPoint $bodyData ');
    }
    final Dio dio = Dio();
    final prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('breffini_token') ?? "";
    try {
      final Response response = await dio.post(
        '${HttpUrls.baseUrl}$endPoint',
        options: Options(headers: {
          'ngrok-skip-browser-warning': 'true',
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        }),
        queryParameters: bodyData,
      );
      if (kDebugMode) {
        print('post result ====> ${response.data}  ');
      }

      //  Loader.stopLoader();

      return response;
    } catch (ex) {
      if (ex.toString().contains('401')) {
        getx.Get.find<LoginController>().logout();

        // print('401 Error detected: ${ex.toString()}');
        // FirebaseMessaging.instance
        //     .unsubscribeFromTopic("STD-" + PrefUtils().getStudentId());
        //
        //
        // SharedPreferences preferences = await SharedPreferences.getInstance();
        // await preferences.clear();
        // await _googleSignIn.signOut();
        // // await FirebaseMessaging.instance.deleteToken();
        // // await _auth.signOut();
        // // isLoggedIn.value = false;
        // avatarController.isLogin.value = false;
        //
        // getx.Get.offAll(() => SplashScreen1());
        getx.Get.snackbar(
          '',
          '',
          backgroundColor: ColorResources.colorgrey800,
          titleText: Text(
            'Account was deleted',
            style: TextStyle(color: ColorResources.colorwhite),
          ),
          messageText: Text('Your account was deleted by admin',
              style: TextStyle(color: ColorResources.colorwhite)),
          snackPosition: getx.SnackPosition.BOTTOM,
        );
      } else {
        String errorMessage = ex.toString();
        if (ex is DioException &&
            ex.response != null &&
            ex.response!.data != null) {
          errorMessage += "\n${ex.response!.data}";
        }

        getx.Get.snackbar(
          '',
          '',
          backgroundColor: ColorResources.colorgrey800,
          titleText: const Text(
            "Bad response",
            style: TextStyle(color: ColorResources.colorwhite),
          ),
          messageText: Text(errorMessage,
              style: TextStyle(color: ColorResources.colorwhite)),
          snackPosition: getx.SnackPosition.BOTTOM,
        );
      }

      //  Loader.stopLoader();
      return null;
    }
  }

  static Future<Response?> httpPostBodyRequest(
      {Map<String, dynamic>? bodyData,
      String endPoint = '',
      bool showLoader = false,
      bool dismissible = true}) async {
    final BreffController avatarController = getx.Get.put(BreffController());
    //  Loader.showLoader();
    if (showLoader) {
      Loader.showLoader(dismissible: dismissible);
    }
    if (kDebugMode) {
      print('post request ====> $endPoint $bodyData ');
    }
    final Dio dio = Dio();
    final prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('breffini_token') ?? "";

    print('post token $token');
    try {
      final Response response = await dio.post(
        '${HttpUrls.baseUrl}$endPoint',
        options: Options(headers: {
          'ngrok-skip-browser-warning': 'true',
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        }),
        data: bodyData,
      );
      if (kDebugMode) {
        print('post result ====> ${response.data}  ');
      }
      if (showLoader) {
        Loader.stopLoader();
      }
      return response;
    } catch (ex) {
      if (showLoader) {
        Loader.stopLoader();
      }
      if (ex.toString().contains('401')) {
        getx.Get.find<LoginController>().logout();

        // print('401 Error detected: ${ex.toString()}');
        // FirebaseMessaging.instance
        //     .unsubscribeFromTopic("STD-" + PrefUtils().getStudentId());
        //
        // SharedPreferences preferences = await SharedPreferences.getInstance();
        // await preferences.clear();
        // final GoogleSignIn _googleSignIn = GoogleSignIn();
        //
        // await _googleSignIn.signOut();
        // // await FirebaseMessaging.instance.deleteToken();
        // // await _auth.signOut();
        // // isLoggedIn.value = false;
        // avatarController.isLogin.value = false;
        getx.Get.snackbar(
          '',
          '',
          backgroundColor: ColorResources.colorgrey800,
          titleText: Text(
            'Account was deleted',
            style: TextStyle(color: ColorResources.colorwhite),
          ),
          messageText: Text('Your account was deleted by admin',
              style: TextStyle(color: ColorResources.colorwhite)),
          snackPosition: getx.SnackPosition.BOTTOM,
        );
        // await getx.Get.offAll(() => SplashScreen1());
      } else {
        String errorMessage = ex.toString();
        if (ex is DioException &&
            ex.response != null &&
            ex.response!.data != null) {
          errorMessage += "\n${ex.response!.data}";
        }

        getx.Get.snackbar(
          '',
          '',
          backgroundColor: ColorResources.colorgrey800,
          titleText: const Text(
            "Bad response",
            style: TextStyle(color: ColorResources.colorwhite),
          ),
          messageText: Text(errorMessage,
              style: TextStyle(color: ColorResources.colorwhite)),
          snackPosition: getx.SnackPosition.BOTTOM,
        );
      }
      return null;
    }
  }
}
