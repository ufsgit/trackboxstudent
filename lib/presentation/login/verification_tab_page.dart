import 'package:anandhu_s_application4/presentation/login/verification_content_page.dart';
import 'package:flutter/material.dart';

import '../../core/colors_res.dart';

class LoginTabviewPage extends StatefulWidget {
  const LoginTabviewPage();

  @override
  LoginTabviewPageState createState() => LoginTabviewPageState();
}

class LoginTabviewPageState extends State<LoginTabviewPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 32,
              ),
              // TabBar(
              //   tabAlignment: TabAlignment.center,
              //   dividerColor: ColorResources.colorBlack,
              //   indicatorColor: ColorResources.colorBlack,
              //   indicatorSize: TabBarIndicatorSize.tab,
              //   dividerHeight: .2,
              //   unselectedLabelColor: ColorResources.colorgrey400,
              //   labelColor: ColorResources.colorBlack,
              //   controller: _tabController,
              //   tabs: const [
              //     Tab(text: 'Email'),
              //     // Tab(text: 'Phone'),
              //   ],
              // ),
              const SizedBox(height: 20),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    VerificationContentPage(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
