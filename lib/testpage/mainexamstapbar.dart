// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import '../../core/app_export.dart';

// import 'exams_screen.dart';
// import 'examcompletedpage.dart';

// class ExamsTabScreen extends StatefulWidget {
//   final String studentId;
//   final String token;

//   const ExamsTabScreen({
//     super.key,
//     required this.studentId,
//     required this.token,
//   });

//   @override
//   State<ExamsTabScreen> createState() => _ExamsTabScreenState();
// }

// class _ExamsTabScreenState extends State<ExamsTabScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   int selectedTabIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: appTheme.whiteA700,
//         body: Column(
//           children: [
//             /// 🔥 EXACT SAME TOP BAR AS CHAT PAGE
//             SizedBox(height: 18.v),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16.h),
//               child: Row(
//                 children: [
//                   IconButton(
//                     onPressed: () => Get.back(),
//                     icon: const Icon(CupertinoIcons.back),
//                   ),
//                   Text(
//                     "Exams",
//                     style: CustomTextStyles.titleMediumBluegray80001,
//                   ),
//                 ],
//               ),
//             ),

//             SizedBox(height: 17.v),

//             /// 🔥 SAME TAB BAR STYLE
//             _buildTabBar(),

//             SizedBox(height: 8.v),

//             /// 🔽 TAB CONTENT
//             _buildTabView(),
//           ],
//         ),
//       ),
//     );
//   }

//   /// ================= TAB BAR (SAME AS CHAT PAGE) =================
//   Widget _buildTabBar() {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 16.h),
//       child: TabBar(
//         controller: _tabController,
//         isScrollable: true,
//         physics: const NeverScrollableScrollPhysics(),
//         onTap: (i) => setState(() => selectedTabIndex = i),
//         labelColor: appTheme.black900,
//         unselectedLabelColor: appTheme.indigo5001,
//         indicatorColor: appTheme.black900,
//         indicatorPadding: const EdgeInsets.all(10),
//         tabAlignment: TabAlignment.start,
//         dividerColor: Colors.white,
//         tabs: const [
//           Tab(text: "Available Exams"),
//           Tab(text: "Completed Exams"),
//         ],
//       ),
//     );
//   }

//   /// ================= TAB VIEW =================
//   Widget _buildTabView() {
//     return Expanded(
//       child: TabBarView(
//         controller: _tabController,
//         physics: const NeverScrollableScrollPhysics(),
//         children: [
//           ExamsHomeScreen(
//             studentId: widget.studentId, // ✅ CORRECT
//             token: widget.token, // ✅ CORRECT
//           ),
//           ExamResultsScreen(),
//         ],
//       ),
//     );
//   }
// }
