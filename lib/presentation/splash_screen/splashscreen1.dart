// import 'package:anandhu_s_application4/presentation/splash_screen/avatar_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class SplashScreen1 extends StatelessWidget {
//   const SplashScreen1({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // Get the screen width to differentiate between mobile and tablet
//     final screenWidth = MediaQuery.of(context).size.width;

//     // Define a breakpoint for tablet screens
//     final isTablet = screenWidth > 600;

//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           child: Column(
//             children: [
//               Container(
//                 height: isTablet ? 60 : 40, // Adjust height for tablet
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage('assets/images/briff_logo.png'),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: isTablet ? 40 : 20, // Adjust spacing for tablet
//               ),
//               SizedBox(
//                 child: Text(
//                   'Begin your learning\njourney guided by experts',
//                   textAlign: TextAlign.center,
//                   style: GoogleFonts.plusJakartaSans(
//                     color:
//                         Color(0xFF000080), // Replace with your color constant
//                     fontSize: isTablet ? 28 : 22, // Adjust font size for tablet
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: isTablet ? 40 : 20, // Adjust spacing for tablet
//               ),
//               Expanded(
//                 child: Container(
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       fit: BoxFit.fitHeight,
//                       image: AssetImage(
//                         'assets/images/splash_screen_avatar_image.png',
//                       ),
//                     ),
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => AvatarScreen(),
//                             ),
//                           );
//                         },
//                         child: Container(
//                           margin: EdgeInsets.symmetric(
//                               horizontal: isTablet ? 40 : 20),
//                           width: double.infinity,
//                           height: isTablet
//                               ? 60
//                               : 40, // Adjust button height for tablet
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(
//                                 isTablet ? 30 : 20), // Adjust radius for tablet
//                           ),
//                           child: Center(
//                             child: Text(
//                               'Choose your Avatar',
//                               style: GoogleFonts.plusJakartaSans(
//                                 color: Color(
//                                     0xFF000080), // Replace with your color constant
//                                 fontSize: isTablet
//                                     ? 18
//                                     : 15, // Adjust font size for tablet
//                                 fontWeight: FontWeight.w700,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: isTablet ? 60 : 40, // Adjust spacing for tablet
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
