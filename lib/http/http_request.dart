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

  static Dio _getDio() {
    final Dio dio = Dio();
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          debugPrint('\n🌐 [API REQUEST] =============================================');
          debugPrint('➡️ ${options.method.toUpperCase()} ${options.uri}');
          if (options.headers.isNotEmpty) {
            debugPrint('➡️ Headers: ${options.headers}');
          }
          if (options.queryParameters.isNotEmpty) {
            debugPrint('➡️ Query Parameters: ${options.queryParameters}');
          }
          if (options.data != null) {
            debugPrint('➡️ Request Body: ${options.data}');
          }
          debugPrint('==============================================================');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          debugPrint('\n✅ [API RESPONSE] ============================================');
          debugPrint('⬅️ Status: ${response.statusCode} (${response.statusMessage ?? "OK"})');
          debugPrint('⬅️ URL   : ${response.requestOptions.uri}');
          debugPrint('⬅️ Data  : ${response.data}');
          debugPrint('==============================================================');
          return handler.next(response);
        },
        onError: (DioException err, handler) {
          debugPrint('\n❌ [API ERROR] ===============================================');
          debugPrint('⛔ Method & URL : ${err.requestOptions.method.toUpperCase()} ${err.requestOptions.uri}');
          debugPrint('⛔ Status Code  : ${err.response?.statusCode}');
          debugPrint('⛔ Error Type   : ${err.type}');
          debugPrint('⛔ Error Message: ${err.message}');
          if (err.response?.data != null) {
            debugPrint('⛔ Server Data  : ${err.response?.data}');
          }
          debugPrint('==============================================================\n');
          return handler.next(err);
        },
      ),
    );
    return dio;
  }

  static Future<Response?> httpGetRequest(
      {Map<String, dynamic>? bodyData,
      String endPoint = '',
      bool showLoader = false}) async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final BreffController avatarController = getx.Get.put(BreffController());

    if (showLoader) {
      Loader.showLoader();
    }

    final Dio dio = _getDio();
    final prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('breffini_token') ?? "";

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

      // Only stop loader if it was shown
      if (showLoader) {
        Loader.stopLoader();
      }

      return response;
    } catch (ex) {
      debugPrint('❌ [HttpGetRequest Error] $endPoint: $ex');
      if (ex is DioException && ex.response != null) {
        debugPrint('❌ [Response Status]: ${ex.response?.statusCode}');
        debugPrint('❌ [Response Data]: ${ex.response?.data}');
      }
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

    final Dio dio = _getDio();
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

      return response;
    } catch (ex) {
      debugPrint('❌ [HttpPostRequest Error] $endPoint: $ex');
      if (ex is DioException && ex.response != null) {
        debugPrint('❌ [Response Status]: ${ex.response?.statusCode}');
        debugPrint('❌ [Response Data]: ${ex.response?.data}');
      }

      if (endPoint == HttpUrls.userLogin &&
          ex is DioException &&
          ex.response != null) {
        return ex.response;
      }

      if (ex.toString().contains('401')) {
        getx.Get.find<LoginController>().logout();

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

      return null;
    }
  }

  static Future<Response?> httpPostBodyRequest(
      {Map<String, dynamic>? bodyData,
      String endPoint = '',
      bool showLoader = false,
      bool dismissible = true}) async {
    final BreffController avatarController = getx.Get.put(BreffController());

    if (showLoader) {
      Loader.showLoader(dismissible: dismissible);
    }

    final Dio dio = _getDio();
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
        data: bodyData,
      );

      if (showLoader) {
        Loader.stopLoader();
      }
      return response;
    } catch (ex) {
      if (showLoader) {
        Loader.stopLoader();
      }
      debugPrint('❌ [HttpPostBodyRequest Error] $endPoint: $ex');
      if (ex is DioException && ex.response != null) {
        debugPrint('❌ [Response Status]: ${ex.response?.statusCode}');
        debugPrint('❌ [Response Data]: ${ex.response?.data}');
      }

      if (endPoint == HttpUrls.userLogin &&
          ex is DioException &&
          ex.response != null) {
        return ex.response;
      }

      if (ex.toString().contains('401')) {
        getx.Get.find<LoginController>().logout();

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
      return null;
    }
  }
}
