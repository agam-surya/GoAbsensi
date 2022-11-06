import 'package:flutter/material.dart';
import 'package:flutter_api_test/screens/profile/profile.dart';

import '../common/common.dart';
import 'dashboard_view.dart';
import 'presence_view.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int? bottomNavBarIndex;
  PageController? pageController;

  @override
  void initState() {
    super.initState();
    // presenceCreate()

    bottomNavBarIndex = 0;
    pageController = PageController(initialPage: bottomNavBarIndex!);
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     actions: [
    //       GestureDetector(
    //           onTap: () {
    //             logout().then((value) => Navigator.of(context)
    //                 .pushAndRemoveUntil(
    //                     MaterialPageRoute(builder: (context) => const Login()),
    //                     (route) => false));
    //           },
    //           child: Icon(Icons.logout))
    //     ],
    //   ),
    //   body: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         Text('Home'),
    //       ],
    //     ),
    //   ),
    // );

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: primaryColor,
          ),
          SafeArea(
            child: Stack(
              children: [
                Container(
                  color: screenColor,
                ),
                PageView(
                  controller: pageController,
                  onPageChanged: (index) {
                    setState(() {
                      bottomNavBarIndex = index;
                    });
                  },
                  children: [
                    DashboardView(),
                    PresenceView(),
                    ProfileScreen(),
                  ],
                ),
                bottomNavBar(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomNavBar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          unselectedItemColor: Color(0xFFE5E5E5),
          currentIndex: bottomNavBarIndex!,
          onTap: (index) {
            setState(() {
              bottomNavBarIndex = index;
              pageController!.jumpToPage(index);
            });
          },
          items: [
            BottomNavigationBarItem(
              label: "Dashboard",
              icon: Container(
                margin: EdgeInsets.only(bottom: 4),
                height: 24,
                child: Image.asset(
                  (bottomNavBarIndex == 0)
                      ? "assets/images/dashboard_active.png"
                      : "assets/images/dashboard_inactive.png",
                ),
              ),
            ),
            BottomNavigationBarItem(
              label: "Kehadiran",
              icon: Container(
                margin: EdgeInsets.only(bottom: 4),
                height: 24,
                child: Image.asset(
                  (bottomNavBarIndex == 1)
                      ? "assets/images/list_active.png"
                      : "assets/images/list_inactive.png",
                ),
              ),
            ),
            BottomNavigationBarItem(
              label: "Profile",
              icon: Container(
                margin: EdgeInsets.only(bottom: 4),
                height: 24,
                child: Icon(
                  Icons.person_pin_sharp,
                  color: (bottomNavBarIndex == 2) ? primaryColor : greyColor,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
