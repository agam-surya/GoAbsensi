import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../common/common.dart';
import 'pages/dashboard_view.dart';
import 'pages/history/histories_view.dart';
import 'pages/profile/profile.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int? bottomNavBarIndex;
  PageController? pageController;

  cekGPS() async {
    bool servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      print("GPS service is enabled");
    } else {
      print("GPS service is disabled.");
    }
  }

  cekLocPerm() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
      } else if (permission == LocationPermission.deniedForever) {
        print("'Location permissions are permanently denied");
      } else {
        print("GPS Location service is granted");
      }
    } else {
      print("GPS Location permission granted.");
    }
  }

  Future<Map<String, String>> getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    String long = position.longitude.toString();
    String lat = position.latitude.toString();
    return {"lat": lat, "long": long};
  }

  @override
  void initState() {
    super.initState();
    cekGPS();
    cekLocPerm();
    getLocation();

    bottomNavBarIndex = 0;
    pageController = PageController(initialPage: bottomNavBarIndex!);
  }

  @override
  Widget build(BuildContext context) {
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
                    DashboardView(getLocation: getLocation()),
                    HistoriesView(),
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
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          unselectedItemColor: const Color(0xFFE5E5E5),
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
                margin: const EdgeInsets.only(bottom: 4),
                height: 24,
                child: Image.asset(
                  (bottomNavBarIndex == 0)
                      ? "assets/images/dashboard_active.png"
                      : "assets/images/dashboard_inactive.png",
                ),
              ),
            ),
            BottomNavigationBarItem(
              label: "Histories",
              icon: Container(
                margin: const EdgeInsets.only(bottom: 4),
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
                margin: const EdgeInsets.only(bottom: 4),
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
