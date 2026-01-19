import 'dart:developer';
import 'dart:io';
import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:anandhu_s_application4/http/aws_upload.dart';
import 'package:anandhu_s_application4/presentation/breff_screen/controller/breff_controller.dart';
import 'package:anandhu_s_application4/presentation/login/login_controller.dart';
import 'package:anandhu_s_application4/presentation/login/model/student_profile_model.dart';
import 'package:anandhu_s_application4/presentation/login/widgets/common_widgets.dart';
import 'package:anandhu_s_application4/presentation/login/widgets/verification_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/colors_res.dart';
import '../onboarding/onboard_controller.dart';

class SetProfilePage extends StatefulWidget {
  const SetProfilePage({required this.isEmail});

  @override
  State<SetProfilePage> createState() => _SetProfilePageState();

  final bool isEmail;
}

class _SetProfilePageState extends State<SetProfilePage> {
  // TextEditingController dobController = TextEditingController();
  final LoginController _loginController = Get.put(LoginController());
  final BreffController breffController = Get.put(BreffController());
  Set<String> emptyFields = {};
  File? image;
  final _picker = ImagePicker();

  @override
  void initState() {
    initFn();
    super.initState();
  }

  initFn() async {
    // await onboardingController.getCourseDropdownValue(
    //     courseName: 'recommended');

    // await onboardingController.getCourseDropdownValue(courseName: 'popular');
  }

  Widget textFieldWidget({
    required TextEditingController? controller,
    required String? labelText,
  }) {
    bool showAsterisk = emptyFields.contains(labelText);

    return SizedBox(
      height: 54,
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter an email address';
          }

          final emailRegex = RegExp(
            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
          );
          if (!emailRegex.hasMatch(value)) {
            return 'Please enter a valid email address';
          }
          return null;
        },
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        style: GoogleFonts.plusJakartaSans(
          color: ColorResources.colorBlack,
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          label: RichText(
            text: TextSpan(
              text: labelText,
              style: GoogleFonts.plusJakartaSans(
                color: ColorResources.colorgrey600,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
              children: [
                if (showAsterisk)
                  const TextSpan(
                    text: ' *',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
              ],
            ),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          fillColor: ColorResources.colorwhite,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: ColorResources.colorBlack,
              width: showAsterisk
                  ? 1.5
                  : 1.0, // Optional: make border thicker for empty fields
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: showAsterisk ? Colors.red : ColorResources.colorgrey300,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: ColorResources.colorgrey200),
          ),
        ),
      ),
    );
  }

  void onContinuePressed() {
    setState(() {
      // Clear previous empty fields
      emptyFields.clear();

      // Check each field and add to emptyFields if empty
      if (_loginController.firstNameController.text.trim().isEmpty) {
        emptyFields.add('First Name');
      }
      if (_loginController.gmeetController.text.trim().isEmpty) {
        emptyFields.add('Google meet link');
      }
      if (_loginController.lastNameController.text.trim().isEmpty) {
        emptyFields.add('Last Name');
      }
      if (widget.isEmail) {
        if (_loginController.emailController.text.trim().isEmpty) {
          emptyFields.add('Email');
        }
      } else {
        if (_loginController.phoneController.text.trim().isEmpty) {
          emptyFields.add('Phone');
        }
      }
      if (_loginController.dobController.text.trim().isEmpty) {
        emptyFields.add('Date of Birth');
      }
      if (_loginController.genderController.text.trim().isEmpty) {
        emptyFields.add('Gender');
      }
      if (_loginController.profilePasswordController.text.trim().isEmpty) {
        emptyFields.add('Password');
      }
    });

    // Only proceed if all fields are filled
    if (emptyFields.isEmpty) {
      // Your existing logic for when all fields are valid
      handleValidSubmission();
    } else {
      Get.showSnackbar(const GetSnackBar(
        message: 'Please fill in all required fields',
        duration: Duration(seconds: 2),
      ));
    }
  }

  Future<void> handleValidSubmission() async {
    String imagePath = '';
    if (image != null) {
      log('%%%%%%%%%%%%%%%%%% ${image.toString()}');
      imagePath = await AwsUpload.uploadToAws(image!) ?? '';
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();
    int studentId =
        int.parse(preferences.getString('breffini_student_id') ?? '0');

    StudentProfileModel studentProfile = StudentProfileModel(
      gMeetLink: _loginController.gmeetController.text,
      studentId: studentId,
      firstName: _loginController.firstNameController.text.trim(),
      lastName: _loginController.lastNameController.text.trim(),
      email: _loginController.emailController.text.trim(),
      profilePhotoPath: image == null ? '' : imagePath,
      profilePhotoName: '',
      phoneNumber: _loginController.phoneController.text.trim(),
      deleteStatus: 0,
      socialProvider: "",
      socialID: "",
      avatar: breffController.selectedIndex.value == 0 ? 'Male' : 'Female',
      countryCodeId: _loginController.selectedCountryCode.value,
      countryCodeName: _loginController.selectedCountryCodeName.value,
      password: _loginController.profilePasswordController.text.trim(),
    );

    await _loginController.saveStudentProfile(studentProfile);
  }

  //from gallery
  Future<void> pickImageFromGallery() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
        Get.back();
      });
    }
  }

  //from camera
  Future<void> pickImageFromCamera() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
        Get.back();
      });
    }
  }

  @override
  void dispose() {
    _loginController.firstNameController.clear();
    _loginController.lastNameController.clear();
    _loginController.dobController.clear();
    _loginController.genderController.clear();
    _loginController.gmeetController.clear();
    _loginController.profilePasswordController.clear();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        // appBar: AppBar(
        //   actions: [
        //     IconButton(
        //         onPressed: () async {
        //           await _loginController.signOut();
        //         },
        //         icon: const Icon(Icons.logout))
        //   ],
        // ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 24.v),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Excellent, Now Let's Set Up\nYour Personal Profile",
                    style: GoogleFonts.plusJakartaSans(
                      color: ColorResources.colorBlack,
                      fontSize: 23.fSize,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    "Tell us about yourself",
                    style: GoogleFonts.plusJakartaSans(
                      color: ColorResources.colorgrey600,
                      fontSize: 14.fSize,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      profileImageStackWidget(context),
                      SizedBox(
                        height: 14.h,
                      ),
                      textFieldWidget(
                          controller: _loginController.firstNameController,
                          labelText: 'First Name'),
                      SizedBox(
                        height: 8.h,
                      ),
                      textFieldWidget(
                          controller: _loginController.lastNameController,
                          labelText: 'Last Name'),
                      SizedBox(
                        height: 8.h,
                      ),
                      widget.isEmail != true
                          ? phoneTextFieldWidget(
                              initialSelection: _loginController
                                  .selectedCountryCodeName.value,
                              onChanged: (value) {
                                setState(() {
                                  _loginController.selectedCountryCode.value =
                                      value.dialCode ?? '+91';
                                  _loginController.selectedCountryCodeName
                                      .value = value.code ?? 'IN';
                                });
                              },
                              controller: _loginController.phoneController,
                              context: context)
                          : textFieldWidget(
                              controller: _loginController.emailController,
                              labelText: 'Email'),
                      SizedBox(
                        height: 8.h,
                      ),
                      passwordTextFieldWidget(
                          controller:
                              _loginController.profilePasswordController,
                          labelText: 'Password',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          }),
                      SizedBox(
                        height: 8.h,
                      ),
                      textFieldWidget(
                          controller: _loginController.gmeetController,
                          labelText: 'Google meet link'),
                      SizedBox(
                        height: 8.h,
                      ),
                      datePickerWidget(
                        controller: _loginController.dobController,
                        labelText: 'Date of Birth',
                        context: context,
                        showAsterisk: emptyFields.contains('Date of Birth'),
                        onTap: () {
                          setState(() {
                            selectDate(context, _loginController.dobController);
                          });
                        },
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      dropdownWidget(
                        showAsterisk: emptyFields.contains('Gender'),
                        controller: _loginController.genderController,
                        labelText: 'Gender',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: buttonWidget(
            context: context,
            text: 'Continue',
            backgroundColor: ColorResources.colorBlue600,
            txtColor: ColorResources.colorwhite,
            onPressed: onContinuePressed,
          ),
        ),
      ),
    );
  }

  Widget profileImageStackWidget(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 100.h,
          width: 100.h,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50.h),
            child: image != null
                ? Image.file(
                    image!,
                    fit: BoxFit.cover,
                    errorBuilder: (BuildContext context, Object error,
                        StackTrace? stackTrace) {
                      return Center(
                        child: Icon(Icons.image_not_supported_outlined,
                            color: ColorResources.colorBlue100, size: 10),
                      );
                    },
                  )
                : Image.asset(
                    '${ImageConstant.defaultProfile}',
                    fit: BoxFit.fill,
                  ),
            // child: Image.network(
            //   'https://images.vexels.com/media/users/3/145908/raw/52eabf633ca6414e60a7677b0b917d92-male-avatar-maker.jpg',
            //   fit: BoxFit.fill,
            // ),
          ),
          //  CircleAvatar(
          //   backgroundImage: NetworkImage(
          //       'https://images.vexels.com/media/users/3/145908/raw/52eabf633ca6414e60a7677b0b917d92-male-avatar-maker.jpg'),
          // ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return ShowDialogWidget(
                    fromCamera: () {
                      pickImageFromCamera();
                    },
                    fromGallery: () {
                      pickImageFromGallery();
                    },
                  );
                },
              );
            },
            child: Container(
              height: 30.h,
              width: 30.v,
              decoration: BoxDecoration(
                  color: ColorResources.colorgrey600,
                  borderRadius: BorderRadius.circular(8.v)),
              child: Icon(
                Icons.camera_alt_outlined,
                size: 14.fSize,
                color: ColorResources.colorwhite,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
