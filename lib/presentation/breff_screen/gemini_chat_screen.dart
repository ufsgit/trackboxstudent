// import 'package:flutter/material.dart';
// // import 'package:flutter_gemini/flutter_gemini.dart';
//
// class GeminiChatScreen extends StatefulWidget {
//   const GeminiChatScreen({Key? key}) : super(key: key);
//
//   @override
//   State<GeminiChatScreen> createState() => _GeminiChatScreenState();
// }
//
// class _GeminiChatScreenState extends State<GeminiChatScreen> {
//   TextEditingController chatController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           child: Container(
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextFormField(
//                     controller: chatController,
//                   ),
//                 ),
//                 InkWell(
//                   onTap: () {
//                     final gemini = Gemini.instance;
//
//                     gemini
//                         .text("who are you")
//                         .then((value) => print(value?.output))
//
//                         /// or value?.content?.parts?.last.text
//                         .catchError((e) => print(e));
//                   },
//                   child: Container(
//                     color: Colors.amber,
//                     width: 100,
//                     height: 40,
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
