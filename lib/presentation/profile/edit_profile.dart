import 'dart:developer';
import 'dart:io';
import 'package:anandhu_s_application4/core/app_export.dart';
import 'package:anandhu_s_application4/core/colors_res.dart';
import 'package:anandhu_s_application4/http/aws_upload.dart';
import 'package:anandhu_s_application4/http/http_urls.dart';
import 'package:anandhu_s_application4/http/loader.dart';
import 'package:anandhu_s_application4/presentation/breff_screen/controller/breff_controller.dart';
import 'package:anandhu_s_application4/presentation/login/login_controller.dart';
import 'package:anandhu_s_application4/presentation/login/model/student_profile_model.dart';
import 'package:anandhu_s_application4/presentation/login/widgets/common_widgets.dart';
import 'package:anandhu_s_application4/presentation/login/widgets/verification_widgets.dart';
import 'package:anandhu_s_application4/presentation/profile/controller/profile_controller.dart';
import 'package:anandhu_s_application4/theme/custom_button_style.dart';
import 'package:anandhu_s_application4/widgets/custom_outlined_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final ProfileController pController = Get.find<ProfileController>();
  final BreffController bController = Get.put(BreffController());
  final LoginController _loginController = Get.put(LoginController());

  File? image;
  final _picker = ImagePicker();

  @override
  void initState() {
    // initFn();
    pController.firstNameController.text = pController.profileData!.firstName;
    pController.lastNameController.text = pController.profileData!.lastName;
    // pController.dobController.text = pController.profileData!.;
    pController.emailController.text = pController.profileData!.email;
    pController.phoneController.text = pController.profileData!.phoneNumber;
    pController.gmeetController.text = pController.profileData!.gmeetLink;

    super.initState();
  }

  // initFn() async {
  //   await onboardingController.getCourseDropdownValue(
  //       courseName: 'recommended');

  //   await onboardingController.getCourseDropdownValue(courseName: 'popular');
  // }

  //from gallery
  Future<void> pickImageFromGallery() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
        log('%%%%%%%%%%%%%%%%%% ${image.toString()}');
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
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorResources.colorgrey200,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.v, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // InkWell(
                //   onTap: () => Get.back(),
                //   child: CircleAvatar(
                //     backgroundColor: ColorResources.colorBlue100,
                //     radius: 18.v,
                //     child: Padding(
                //       padding: EdgeInsets.only(left: 8.v),
                //       child: const Icon(
                //         Icons.arrow_back_ios,
                //         color: ColorResources.colorgrey600,
                //       ),
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: 8.h,
                // ),
                Row(
                  children: [
                    InkWell(
                      onTap: () => Get.back(),
                      child: CircleAvatar(
                        backgroundColor: ColorResources.colorBlue100,
                        radius: 14.v,
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.v),
                          child: const Icon(
                            Icons.arrow_back_ios,
                            size: 14,
                            color: ColorResources.colorgrey600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Edit Profile",
                      style: GoogleFonts.plusJakartaSans(
                        color: Color(0xff283B52),
                        fontSize: 18.fSize,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16.h,
                ),
                Container(
                  // height: 350.h,
                  width: Get.width,
                  decoration: BoxDecoration(
                      color: ColorResources.colorwhite,
                      borderRadius: BorderRadius.circular(10.v)),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.v, vertical: 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        profileImageStackWidget(context),
                        SizedBox(
                          height: 14.h,
                        ),
                        textFieldWidget(
                            controller: pController.firstNameController,
                            labelText: 'First Name'),
                        SizedBox(
                          height: 8.h,
                        ),
                        textFieldWidget(
                            controller: pController.lastNameController,
                            labelText: 'Last Name'),
                        SizedBox(
                          height: 8.h,
                        ),

                        // textFieldWidget(
                        //     controller: pController.gmeetController,
                        //     labelText: 'Google meet link'),
                        SizedBox(
                          height: 8.h,
                        ),
                        (pController.profileData?.email == null ||
                                pController.profileData?.email == '')
                            ? phoneTextFieldWidget(
                                initialSelection:
                                    _loginController.selectedCountryCode.value,
                                onChanged: (value) {
                                  setState(() {
                                    _loginController.selectedCountryCode.value =
                                        value.dialCode ?? '+91';
                                    _loginController.selectedCountryCodeName
                                        .value = value.code ?? 'IN';
                                  });
                                },
                                controller: pController.phoneController,
                                context: context)
                            : textFieldWidget(
                                controller: pController.emailController,
                                labelText: 'Email'),
                        SizedBox(
                          height: 8.h,
                        ),
                        // datePickerWidget(
                        //   controller: pController.dobController,
                        //   labelText: 'Date of Birth',
                        //   context: context,
                        //   onTap: () {
                        //     setState(() {
                        //       selectDate(
                        //           context, pController.dobController);
                        //     });
                        //   },
                        // ),
                        // SizedBox(
                        //   height: 8.h,
                        // ),
                        // dropdownWidget(
                        //   controller: pController.genderController,
                        //   labelText: 'Gender',
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.v, vertical: 16.h),
          child: CustomOutlinedButton(
            onPressed: () async {
              Loader.showLoader();
              // await exController.getAllExploreCourses();
              String imagePath = '';
              if (image != null) {
                imagePath = await AwsUpload.uploadToAws(image!) ?? '';
                // var img = await AwsUpload.uploadToAws(image!) ?? '';
                // if (img != '') {
                //   imagePath = Uri.parse(img).path.replaceFirst('/', '');
                // }
              }

              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              int studentId = int.parse(
                  preferences.getString('breffini_student_id') ?? '0');
              StudentProfileModel studentProfile = StudentProfileModel(
                gMeetLink: pController.gmeetController.text,
                countryCodeId: _loginController.selectedCountryCode.value,
                countryCodeName: _loginController.selectedCountryCode.value,
                studentId: studentId,
                firstName: pController.firstNameController.text.trim(),
                lastName: pController.lastNameController.text.trim(),
                email: pController.emailController.text.trim(),
                profilePhotoPath: image == null
                    ? pController.profileData!.profilePhotoPath
                    : imagePath,
                profilePhotoName: '',
                phoneNumber: pController.phoneController.text.trim(),
                deleteStatus: 0,
                socialProvider: "",
                socialID: "",
                avatar:
                    bController.selectedIndex.value == 0 ? 'Male' : 'Female',
              );
              await pController.saveStudentProfile(studentProfile);
              Loader.stopLoader();
              Get.showSnackbar(GetSnackBar(
                message: 'Profile edited successfully',
                duration: Duration(milliseconds: 1500),
              ));
            },
            text: 'Save',
            margin: EdgeInsets.symmetric(horizontal: 16.h),
            buttonStyle: CustomButtonStyles.none,
            decoration: CustomButtonStyles.gradientBlueToBlueDecoration,
            buttonTextStyle: CustomTextStyles.titleSmallWhiteA700,
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
          decoration: BoxDecoration(
              color: ColorResources.colorgrey200,
              shape: BoxShape.circle,
              border: Border.all(color: ColorResources.colorgrey500)),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(50.h),
              child: image != null
                  ? Image.file(
                      image!,
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object error,
                          StackTrace? stackTrace) {
                        return Center(
                          child: Icon(
                            Icons.person_rounded,
                            color: ColorResources.colorBlue300,
                            size: 18.v,
                          ),
                        );
                      },
                    )
                  : CachedNetworkImage(
                      imageUrl:
                          '${HttpUrls.imgBaseUrl}${pController.profileData?.profilePhotoPath}',
                      height: 10.v,
                      width: 10.v,
                      fit: BoxFit.cover,
                      placeholder: (BuildContext context, String url) {
                        return Center(
                          child: Transform.scale(
                              scale: 0.6,
                              child: CircularProgressIndicator(
                                color: ColorResources.colorBlue500,
                              )),
                        );
                      },
                      errorWidget:
                          (BuildContext context, String url, dynamic error) {
                        return Center(
                          child: Icon(
                            Icons.person_rounded,
                            color: ColorResources.colorBlack.withOpacity(.5),
                            size: 35.v,
                          ),
                        );
                      },
                    )
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
