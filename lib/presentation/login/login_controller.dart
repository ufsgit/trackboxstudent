import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:anandhu_s_application4/core/colors_res.dart';
import 'package:anandhu_s_application4/core/utils/extentions.dart';
import 'package:anandhu_s_application4/core/utils/file_utils.dart';
import 'package:anandhu_s_application4/http/aws_upload.dart';
import 'package:anandhu_s_application4/http/loader.dart';
import 'package:anandhu_s_application4/presentation/android_large_5_page/controller/call_chat_controller.dart';
import 'package:anandhu_s_application4/presentation/android_large_5_page/models/current_call_model.dart';
import 'package:anandhu_s_application4/presentation/splash_screen/splashscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_callkit_incoming_yoer/flutter_callkit_incoming.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:anandhu_s_application4/http/http_request.dart';
import 'package:anandhu_s_application4/presentation/breff_screen/controller/breff_controller.dart';
import 'package:anandhu_s_application4/presentation/login/login_home_page.dart';
import 'package:anandhu_s_application4/presentation/login/model/google_signin_model.dart';
import 'package:anandhu_s_application4/presentation/login/model/student_profile_model.dart';
import 'package:anandhu_s_application4/presentation/login/otp_verification_page.dart';
import 'package:anandhu_s_application4/presentation/login/set_profile_page.dart';
import 'package:anandhu_s_application4/presentation/splash_screen/splashscreen1.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Zego import removed
import '../../http/http_urls.dart';
import '../onboarding/occupation_screen.dart';
import '../onboarding/onboard_controller.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxString selectedCountryCode = '+91'.obs;
  RxString selectedCountryCodeName = 'IN'.obs;
  RxBool isOtpVerify = false.obs;
  RxBool isOtpSending = false.obs;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController gmeetController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  // TextEditingController profileMobileNumberController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController profilePasswordController = TextEditingController();

  final BreffController avatarController = Get.put(BreffController());

  @override
  void onInit() {
    super.onInit();
    getFCMToken();
  }

  Future<void> signInWithGoogle() async {
    try {
      log('Attempting to sign in with Google...');
      // Add this at the start of your signInWithGoogle() method
      log('Debug - Firebase Project: ${FirebaseAuth.instance.app.options.projectId}');
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      print("Successfully signed in: ${googleUser?.email}");
      if (googleUser == null) {
        throw FirebaseAuthException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign in aborted by user',
        );
      }

      // Extract user details
      final String? displayName = googleUser.displayName;
      String? email = googleUser.email;
      final String? id = googleUser.id;
      String? photoUrl = googleUser.photoUrl;
      String firstName;
      String lastName;
      log('Display Name: $displayName');
      log('Email: $email');
      log('ID: $id');
      log('Photo URL: $photoUrl');

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      log('Google Access Token: ${googleAuth.accessToken}');

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
      log('Google ID Token: ${googleAuth.idToken}');

      if (googleUser.displayName != null) {
        List<String> nameParts = googleUser.displayName!.split(' ');
        firstName = nameParts[0];
        lastName = nameParts.length > 1 ? nameParts[1] : '';
      } else {
        firstName = '';
        lastName = '';
      }

      if (googleUser.photoUrl != null) {
        File imageUrlToFile = await urlToFile(googleUser.photoUrl!);
        photoUrl = await AwsUpload.uploadToAws(imageUrlToFile);
      }

      GoogleSignInModel googleUserProfile = GoogleSignInModel(
          firstName: firstName,
          lastName: lastName,
          email: email,
          profilePhotoPath: photoUrl ?? '',
          deleteStatus: 0,
          socialProvider: 'Google',
          socialID: googleUser.id,
          avatar: avatarController.selectedIndex.value == 0 ? 'Male' : 'Female',
          deviceID: fcmToken);

      await HttpRequest.httpPostBodyRequest(
        endPoint: '${HttpUrls.googleSignIn}',
        bodyData: googleUserProfile.toJson(),
      ).then((value) async {
        print('login value $value');
        if (value != null) {
          if ((value.data['0']['newuser'].toString() == '0')) {
            Get.showSnackbar(GetSnackBar(
              message: 'Successful Login',
              duration: Duration(seconds: 1),
            ));
            avatarController.isLogin.value = true;
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            preferences.setString('breffini_student_id',
                value.data['0']['Student_ID'].toString());

            String studentId =
                preferences.getString('breffini_student_id') ?? '';
            log('<<<<<<<<<<<<<<<student id $studentId>>>>>>>>>>>>>>>');

            preferences.setString(
                'breffini_new_user', value.data['0']['newuser'].toString());
            preferences.setString('breffini_token', value.data['token']);
            // await onboardingController.getCourseDropdownValue(
            //     courseName: 'recommended');

            // await onboardingController.getCourseDropdownValue(
            //     courseName: 'popular');
            if (value.data['0']['Occupation_Id_'] != null) {
              Get.offAndToNamed(AppRoutes.homePageContainerScreen);
            } else {
              Get.to(() => OccupationScreen());
            }
          }
        } else {
          Get.showSnackbar(GetSnackBar(
            message: 'Invalid Login Credential',
            duration: Duration(milliseconds: 800),
          ));
        }
      });
    } on PlatformException catch (error) {
      print("Error: ${error.code}");
      print("Error message: ${error.message}");
      print("Error details: ${error.details}");
    } catch (e) {
      String errorMessage;

      if (e is FirebaseAuthException) {
        errorMessage = e.message ?? 'An error occurred with FirebaseAuth';
        log('FirebaseAuthException: ${e.code}');
      } else if (e is PlatformException) {
        errorMessage = 'A platform-specific error occurred: ${e.message}';
        log('PlatformException: ${e.message}, code: ${e.code}');
      } else {
        errorMessage = 'An unknown error occurred';
        log('Exception: $e');
      }

      Get.snackbar(
        'Try again',
        errorMessage,
        backgroundColor: ColorResources.colorgrey800,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  String fcmToken = "";
  getFCMToken() {
    FirebaseMessaging.instance.getToken().then((token) {
      fcmToken = token ?? "";
      log(fcmToken);
    });
  }

  Future<File> urlToFile(String imageUrl) async {
    // Get the image from the URL
    final response = await http.get(Uri.parse(imageUrl));

    // Get the temporary directory
    final tempDir = await getTemporaryDirectory();

    String ext = FileUtils.getFileExtension(FileUtils.getFileName(imageUrl));
    if (ext.isNullOrEmpty()) {
      ext = ".png";
    } else {
      ext = ""; // take default extension
    }
    // Create a unique name for the file
    final fileName = path.basename(imageUrl + ext);
    final filePath = path.join(tempDir.path, fileName);

    // Save the image as a file
    final file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);

    return file;
  }

  Future<void> signin({
    required Map<String, dynamic> bodyData,
    required bool isEmail,
  }) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      isOtpSending.value = true;

      final response = await HttpRequest.httpPostBodyRequest(
        endPoint: '${HttpUrls.userLogin}',
        bodyData: bodyData,
      );

      if (response == null || response.data == null) {
        isOtpSending.value = false;
        return;
      }

      Map<String, dynamic> data = response.data as Map<String, dynamic>;

      if (data.containsKey('token') && data['token'] != null) {
        // Handle password login (direct token response)
        print("Login response data: $data"); // Debug print

        String token = data['token'];
        String studentId = '';
        String newUser = '0';
        if (data.containsKey('student') && data['student'] != null) {
          var studentData = data['student'];
          if (studentData is Map) {
            studentId = studentData['Student_ID']?.toString() ??
                studentData['student_id']?.toString() ??
                studentData['id']?.toString() ??
                '';
            newUser = studentData['newuser']?.toString() ??
                data['newuser']?.toString() ??
                '0';
          } else {
            // Fallback if 'student' is just the ID (unlikely based on key name but possible)
            studentId = studentData.toString();
          }
        } else if (data.containsKey('0') && data['0'] != null) {
          var userData = data['0'];
          studentId = userData['Student_ID']?.toString() ??
              userData['student_id']?.toString() ??
              '';
          newUser = userData['newuser']?.toString() ?? '0';
        } else {
          print(
              "Warning: data['0'] and data['student'] missing, checking root level");
          if (data.containsKey('Student_ID')) {
            studentId = data['Student_ID'].toString();
          } else if (data.containsKey('student_id')) {
            studentId = data['student_id'].toString();
          } else if (data.containsKey('id')) {
            studentId = data['id'].toString();
          }

          if (data.containsKey('newuser')) {
            newUser = data['newuser'].toString();
          }
        }

        if (studentId.isEmpty) {
          print("CRITICAL: Student ID missing in response: $data");
          throw Exception('Student ID missing in response. Keys: ${data.keys}');
        }

        await Future.wait([
          preferences.setString('breffini_token', token),
          preferences.setString('breffini_student_id', studentId),
          preferences.setString('breffini_new_user', newUser),
        ]);

        avatarController.isLogin.value = true;
        isOtpSending.value = false;

        if (newUser == '1') {
          Get.off(() => SetProfilePage(isEmail: isEmail));
        } else {
          Get.offAllNamed(AppRoutes.homePageContainerScreen);
        }
      } else if (data.containsKey('otp') && data['otp'] != null) {
        // Handle OTP login
        isOtpSending.value = false;

        if (kDebugMode) {
          Get.showSnackbar(GetSnackBar(
            message: 'OTP ${data['otp']}',
            duration: Duration(seconds: 2),
          ));
        }

        Get.to(() => OtpVerificationPage(
              value: data,
              isEmail: isEmail,
            ));
      } else {
        throw Exception('Invalid response: OTP or Token missing');
      }
    } catch (error) {
      isOtpSending.value = false;

      Get.showSnackbar(GetSnackBar(
        message: error.toString(),
        duration: Duration(seconds: 2),
        backgroundColor: ColorResources.colorgrey700,
      ));

      print('Login error: $error');
    }
  }

  verifyOtp(
      {required String otp,
      required bool isEmail,
      required Map<String, dynamic> data}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String studentId = data['0']['Student_ID'].toString();
    String newUser = data['0']['newuser'].toString();

    try {
      isOtpVerify.value = true;
      final value = await HttpRequest.httpPostBodyRequest(
        // endPoint: HttpUrls.checkOtp,
        bodyData: {
          'student_id': studentId,
          "otp": otp,
        },
      );

      print('login value $value');

      if (value != null) {
        if (value.data['0']['otp_match'].toString() == '1') {
          final token = value.data['token'];
          if (token == null || token.isEmpty) {
            throw Exception('Token is missing or empty');
          }

          // Save all preferences
          await Future.wait([
            preferences.setString('breffini_token', token),
            preferences.setString('breffini_student_id', studentId),
            preferences.setString('breffini_new_user', newUser),
          ]);

          // Update login state
          avatarController.isLogin.value = true;

          // Navigate based on token presence
          final storedToken = preferences.getString('breffini_token');
          if (storedToken != null && storedToken.isNotEmpty) {
            if (newUser == '1') {
              Get.off(() => SetProfilePage(isEmail: isEmail));
            } else {
              Get.offAllNamed(AppRoutes.homePageContainerScreen);
            }
          } else {
            Get.showSnackbar(const GetSnackBar(
              message: 'Authentication failed - token not saved',
              duration: Duration(milliseconds: 800),
            ));
          }
        } else {
          Get.showSnackbar(const GetSnackBar(
            message: 'Invalid OTP',
            duration: Duration(milliseconds: 800),
          ));
        }
      } else {
        Get.showSnackbar(const GetSnackBar(
          message: 'Invalid request',
          duration: Duration(milliseconds: 800),
        ));
      }
    } catch (e) {
      print('Error in verifyOtp: $e');
      Get.showSnackbar(GetSnackBar(
        message: 'Error: ${e.toString()}',
        duration: const Duration(milliseconds: 800),
      ));
    } finally {
      isOtpVerify.value = false;
    }
  }

  saveStudentProfile(StudentProfileModel studentProfile) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String studentId = preferences.getString('breffini_student_id') ?? '';
    String newUser = preferences.getString('breffini_new_user') ?? '';

    await HttpRequest.httpPostBodyRequest(
      endPoint: HttpUrls.saveProfile,
      bodyData: studentProfile.toJson(),
    ).then((value) {
      print('login value $value');

      if (value != null) {
        if (value.data[0] != null) {
          Get.showSnackbar(GetSnackBar(
            message: 'Profile added successfully',
            duration: Duration(milliseconds: 1000),
          ));

          Get.to(() => OccupationScreen());
        }
      } else {
        Get.showSnackbar(GetSnackBar(
          message: 'invalid request',
          duration: Duration(milliseconds: 800),
        ));
      }
    });
  }

  Future<void> logout() async {
    Loader.showLoader();
    CallandChatController callOngoingController = Get.find();

    FirebaseFirestore.instance.clearPersistence();
    FirebaseFirestore.instance.terminate();
    FirebaseMessaging.instance
        .unsubscribeFromTopic("STD-" + PrefUtils().getStudentId());

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? storedBatchIds = preferences.getString('student_batch_ids');
    if (storedBatchIds != null) {
      List<int> batchIds = List<int>.from(jsonDecode(storedBatchIds));
      print('Retrieved batch IDs: $batchIds');
      await unsubscribeFromBatchTopics(batchIds);
    }
    await preferences.clear();
    await _googleSignIn.signOut();
    // await FirebaseMessaging.instance.deleteToken();
    fcmToken = "";
    // await _auth.signOut();
    // isLoggedIn.value = false;
    if (!callOngoingController.currentCallModel.value.callId.isNullOrEmpty()) {
      String callId = callOngoingController.currentCallModel.value.callId ?? "";
      // added clearing currentcallmodel befor api call to ensure call localy disconnected successfully
      callOngoingController.currentCallModel.value = CurrentCallModel();
      // Zego uninit removed
      if (callOngoingController.currentCallModel.value.type == "new_live") {
        callOngoingController.currentCallModel.value = CurrentCallModel();
      } else {
        await callOngoingController.disconnectCall(
            true,
            false,
            callOngoingController.currentCallModel.value.callerId!,
            callOngoingController.currentCallModel.value.callId!);
      }

      await FlutterCallkitIncoming.endCall(callId);
    }

    Loader.stopLoader();
    Get.offAll(() => SplashScreen());

    avatarController.isLogin.value = false;
  }

  Future<void> unsubscribeFromBatchTopics(List<int> batchIds) async {
    for (int batchId in batchIds) {
      String topic = "BATCH-$batchId"; // Construct the topic string
      await FirebaseMessaging.instance.unsubscribeFromTopic(topic);
      print('Unsubscribed from topic: $topic');
    }
  }

  deleteAccount() async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();

    // String studentId = preferences.getString('breffini_student_id') ?? '';
    // String newUser = preferences.getString('breffini_new_user') ?? '';
    Loader.showLoader();
    await HttpRequest.httpPostBodyRequest(
      endPoint: HttpUrls.deleteAccount,
    ).then((value) async {
      print('Delete profile $value');

      if (value != null) {
        Loader.stopLoader();
        if (value.data[0] != null) {
          Get.showSnackbar(GetSnackBar(
            message: 'Account deleted successfully',
            duration: Duration(milliseconds: 3000),
          ));
          logout();
        }
      } else {
        Loader.stopLoader();
        Get.showSnackbar(GetSnackBar(
          message: 'Cant delete your account',
          duration: Duration(milliseconds: 800),
        ));
      }
    });
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    // await _auth.signOut();
    avatarController.isLogin.value = false;
    Get.off(() => const LoginHomePage());
  }
}
