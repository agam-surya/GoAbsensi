import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_api_test/screens/loading.dart';

import '../common/common.dart';
import '../common/constant.dart';
import '../models/api_response.dart';
import '../services/services.dart';
import 'home.dart';
import 'login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();

  static String routeName = '/splash_screen';
}

class _SplashScreenState extends State<SplashScreen> {
  void _loadUserInfo() async {
    String token = await getToken();
    if (token == '') {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const Login()),
          (route) => false);
    } else {
      ApiResponse response = await getUserDetail();
      if (response.error == null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const Home()),
            (route) => false);
      } else if (response.error == unauthorized) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const Login()),
            (route) => false);
      } else {
        // ScaffoldMessenger.of(context)
        //     .showSnackBar(SnackBar(content: Text('${response.error}')));
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const Login()),
            (route) => false);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    splashTimer(context);
  }

  splashTimer(BuildContext context) async {
    return Timer(const Duration(seconds: 5), () {
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (BuildContext context) => const Loading(),
      //   ),
      // );
      _loadUserInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 130,
              height: 130,
              margin: EdgeInsets.only(bottom: 18),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/secondary_logo.png"),
                ),
              ),
            ),
            Text(
              "GoAbsensi",
              style: extraWhiteFont.copyWith(fontSize: 28),
            ),
          ],
        ),
      ),
    );
  }
}
