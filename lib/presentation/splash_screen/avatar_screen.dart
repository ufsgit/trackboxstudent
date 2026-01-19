// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// import '../login/login_controller.dart';
// import 'package:anandhu_s_application4/core/app_export.dart';
// import 'package:anandhu_s_application4/core/colors_res.dart';

// class AvatarScreen extends StatefulWidget {
//   const AvatarScreen({Key? key}) : super(key: key);

//   @override
//   _AvatarScreenState createState() => _AvatarScreenState();
// }

// class _AvatarScreenState extends State<AvatarScreen> {
//   int _selectedAvatarIndex = -1;

//   @override
//   Widget build(BuildContext context) {
//     final mediaQuery = MediaQuery.of(context);
//     final screenWidth = mediaQuery.size.width;
//     final screenHeight = mediaQuery.size.height;

//     bool isTablet = screenWidth > 600;

//     return isTablet ? _buildTabletLayout() : _buildPhoneLayout();
//   }

//   Widget _buildPhoneLayout() {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           child: Column(
//             children: [
//               Container(
//                 height: 40.h,
//                 decoration: BoxDecoration(
//                     image: DecorationImage(
//                         image: AssetImage('assets/images/briff_logo.png'))),
//               ),
//               SizedBox(
//                 height: 40.h,
//               ),
//               SizedBox(
//                 child: Text(
//                   'Choose your Avatar',
//                   textAlign: TextAlign.center,
//                   style: GoogleFonts.plusJakartaSans(
//                     color: ColorResources.colorBlue700,
//                     fontSize: 24,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 130.h,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   _buildAvatarContainer(
//                       'assets/images/breff_avatar_round.png', 'Male', 0),
//                   SizedBox(
//                     width: 20.v,
//                   ),
//                   _buildAvatarContainer(
//                       'assets/images/briffini_avatar_round.png', 'Female', 1),
//                 ],
//               ),
//               SizedBox(
//                 height: 100.h,
//               ),
//               Container(
//                 width: Get.width,
//               ),
//               Expanded(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     InkWell(
//                       onTap: () async {
//                         print('fgv $_selectedAvatarIndex');
//                         if (_selectedAvatarIndex != -1) {
//                           final LoginController loginController =
//                               Get.put(LoginController());
//                           await loginController.getFCMToken();
//                           PrefUtils().setBreffGenderData(
//                               _selectedAvatarIndex == 0 ? "Male" : "Female");
//                           Get.toNamed(AppRoutes.breffScreen, parameters: {
//                             "index": '$_selectedAvatarIndex',
//                             'isLogin': 'true'
//                           });
//                         }
//                       },
//                       child: Container(
//                         margin: EdgeInsets.symmetric(horizontal: 20.v),
//                         width: Get.width,
//                         height: 40.h,
//                         decoration: BoxDecoration(
//                             color: _selectedAvatarIndex != -1
//                                 ? ColorResources.colorBlue600
//                                 : ColorResources.colorwhite,
//                             borderRadius: BorderRadius.circular(20.v)),
//                         child: Center(
//                             child: Text(
//                           'Continue',
//                           style: TextStyle(
//                               color: _selectedAvatarIndex != -1
//                                   ? ColorResources.colorwhite
//                                   : ColorResources.colorBlack,
//                               fontSize: 14.v,
//                               fontWeight: FontWeight.w700),
//                         )),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 40.h,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTabletLayout() {
//     return Scaffold(
//       body: SafeArea(
//         child: LayoutBuilder(
//           builder: (context, constraints) {
//             double screenWidth = constraints.maxWidth;
//             double screenHeight = constraints.maxHeight;

//             return SingleChildScrollView(
//               child: Center(
//                 child: Container(
//                   width: screenWidth,
//                   height: screenHeight,
//                   padding: EdgeInsets.symmetric(
//                     horizontal: 16,
//                     vertical: 24,
//                   ),
//                   child: Column(
//                     children: [
//                       Container(
//                         height: 70,
//                         decoration: BoxDecoration(
//                           image: DecorationImage(
//                             image: AssetImage('assets/images/briff_logo.png'),
//                             fit: BoxFit.contain,
//                           ),
//                         ),
//                       ),
//                       Spacer(),
//                       Text(
//                         'Choose your Avatar',
//                         textAlign: TextAlign.center,
//                         style: GoogleFonts.plusJakartaSans(
//                           color: ColorResources.colorBlue700,
//                           fontSize: 32,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       SizedBox(
//                         height: 48,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           _buildTabletAvatarContainer(
//                               'assets/images/breff_avatar_round.png',
//                               'Male',
//                               0,
//                               screenWidth),
//                           SizedBox(width: screenWidth * 0.1),
//                           _buildTabletAvatarContainer(
//                               'assets/images/briffini_avatar_round.png',
//                               'Female',
//                               1,
//                               screenWidth),
//                         ],
//                       ),
//                       Spacer(),
//                       InkWell(
//                         onTap: () async {
//                           if (_selectedAvatarIndex != -1) {
//                             final LoginController loginController =
//                                 Get.put(LoginController());
//                             await loginController.getFCMToken();
//                             PrefUtils().setBreffGenderData(
//                                 _selectedAvatarIndex == 0 ? "Male" : "Female");
//                             Get.toNamed(AppRoutes.breffScreen, parameters: {
//                               "index": '$_selectedAvatarIndex',
//                               'isLogin': 'true'
//                             });
//                           }
//                         },
//                         child: Container(
//                           width: screenWidth * 0.8,
//                           height: screenHeight * 0.05,
//                           decoration: BoxDecoration(
//                             color: _selectedAvatarIndex != -1
//                                 ? ColorResources.colorBlue600
//                                 : ColorResources.colorwhite,
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           child: Center(
//                             child: Text(
//                               'Continue',
//                               style: TextStyle(
//                                 color: _selectedAvatarIndex != -1
//                                     ? ColorResources.colorwhite
//                                     : ColorResources.colorBlack,
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w700,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 32,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildAvatarContainer(String imagePath, String name, int index) {
//     bool isSelected = _selectedAvatarIndex == index;
//     return InkWell(
//       borderRadius: BorderRadius.circular(50),
//       onTap: () {
//         setState(() {
//           _selectedAvatarIndex = index;
//         });
//       },
//       child: Column(
//         children: [
//           Container(
//             width: 145.v,
//             height: 145.h,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               image: DecorationImage(
//                   image: AssetImage(imagePath), fit: BoxFit.cover),
//               border: Border.all(
//                 color: isSelected
//                     ? ColorResources.colorBlue600
//                     : Colors.transparent,
//                 width: 3.0,
//               ),
//             ),
//           ),
//           Text(
//             name,
//             style: GoogleFonts.plusJakartaSans(
//               color: ColorResources.colorBlue800,
//               fontSize: 14,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTabletAvatarContainer(
//       String imagePath, String name, int index, double screenWidth) {
//     bool isSelected = _selectedAvatarIndex == index;
//     return InkWell(
//       onTap: () {
//         setState(() {
//           _selectedAvatarIndex = index;
//         });
//       },
//       child: Column(
//         children: [
//           Container(
//             width: screenWidth * 0.3,
//             height: screenWidth * 0.3,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               image: DecorationImage(
//                   image: AssetImage(imagePath), fit: BoxFit.cover),
//               border: Border.all(
//                 color: isSelected
//                     ? ColorResources.colorBlue600
//                     : Colors.transparent,
//                 width: 3.0,
//               ),
//             ),
//           ),
//           SizedBox(height: 10),
//           Text(
//             name,
//             style: GoogleFonts.plusJakartaSans(
//               color: ColorResources.colorBlue800,
//               fontSize: 18,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
