import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../utils/constant.dart';
import '../splash/splash_page.dart';
import 'home_page.dart';
import 'home_profile_page.dart';

class HomeLayout extends StatefulWidget {
  final int pageIndex;
  const HomeLayout({
    super.key,
    this.pageIndex = 0,
  });

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int pageIndex = 0;
  PageController controller = PageController();

  @override
  void initState() {
    pageIndex = widget.pageIndex;
    controller = PageController(initialPage: pageIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 45),
              child: PageView(
                controller: controller,
                onPageChanged: (value) {
                  setState(() {
                    pageIndex = value;
                  });
                },
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 45),
                    child: HomePage(
                      controller: controller,
                    ),
                  ),
                  const HomeProfilePage(),
                ],
              ),
            ),
            Container(
              height: 45,
              color: Colors.white.withOpacity(0.5),
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Profile",
                    style: TextStyle(
                      color: fontColor.withOpacity(0.9),
                      fontWeight: FontWeight.w900,
                      fontFamily: "bufally",
                      fontSize: 24,
                    ),
                  ),
                  InkWell(
                    onTap: () => bottomSheet(context),
                    child: const Icon(Icons.menu_rounded),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(
                      width: 1,
                      color: Colors.grey.shade300,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    tap(
                      iconData: Icons.home_filled,
                      active: pageIndex == 0,
                      onTap: () {
                        setState(() {
                          pageIndex = 0;
                          controller.jumpToPage(pageIndex);
                        });
                      },
                    ),
                    tap(
                      iconData: Icons.account_circle,
                      active: pageIndex == 1,
                      onTap: () {
                        setState(() {
                          pageIndex = 1;
                          controller.jumpToPage(pageIndex);
                        });
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded tap({
    required Function() onTap,
    bool active = false,
    required IconData iconData,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 80,
                height: 2,
              ),
              Icon(
                iconData,
                color: active ? primaryColor : Colors.grey,
                size: 28,
              ),
              Container(
                height: 4,
                color: active ? primaryColor : Colors.transparent,
              )
            ],
          ),
        ),
      ),
    );
  }

  void bottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Sing out'),
                onTap: () async {
                  Navigator.pop(context);
                  await FirebaseAuth.instance.signOut().then((_) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SplashPage(),
                      ),
                    );
                  });
                },
              ),
            ],
          );
        });
  }
}
