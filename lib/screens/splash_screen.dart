import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:restart_app/restart_app.dart';

import '../common/common.dart';
import '../common/constant.dart';
import '../models/api_response.dart';
import '../services/services.dart';
import '../widgets/custom_alert_dialog.dart';
import 'home.dart';
import 'login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();

  static String routeName = '/splash_screen';
}

class _SplashScreenState extends State<SplashScreen> {
  // Future<void> cekInternetConection() async {
  //   // Check internet connection with singleton (no custom values allowed)
  //   await execute(InternetConnectionChecker());

  //   // Create customized instance which can be registered via dependency injection
  //   final InternetConnectionChecker customInstance =
  //       InternetConnectionChecker.createInstance(
  //     checkTimeout: const Duration(seconds: 1),
  //     checkInterval: const Duration(seconds: 1),
  //   );

  //   // Check internet connection with created instance
  //   await execute(customInstance);
  // }

  Future<bool> execute(
    InternetConnectionChecker internetConnectionChecker,
  ) async {
    // Simple check to see if we have Internet
    final bool isConnected = await InternetConnectionChecker().hasConnection;
    return isConnected;
    // returns a bool
    // We can also get an enum instead of a bool
    // ignore: avoid_print
    // print(
    //   'Current status: ${await InternetConnectionChecker().connectionStatus}',
    // );
    // Prints either InternetConnectionStatus.connected
    // or InternetConnectionStatus.disconnected

    // actively listen for status updates
    // final StreamSubscription<InternetConnectionStatus> listener =
    //     InternetConnectionChecker().onStatusChange.listen(
    //   (InternetConnectionStatus status) {
    //     switch (status) {
    //       case InternetConnectionStatus.connected:
    //         // ignore: avoid_print
    //         print('Data connection is available.');
    //         break;
    //       case InternetConnectionStatus.disconnected:
    //         // ignore: avoid_print
    //         print('You are disconnected from the internet.');
    //         break;
    //     }
    //   },
    // );

    // // close listener after 30 seconds, so the program doesn't run forever
    // await Future<void>.delayed(const Duration(seconds: 5));
    // await listener.cancel();
  }

  void _loadUserInfo() async {
    String token = await getToken();
    bool conn = await execute(InternetConnectionChecker());
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
      }
      if (!conn && response.error == null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const Home()),
            (route) => false);
      } else if (!conn && response.error != null) {
        showDialog(
            context: context,
            builder: (context) => CustomAlertDialog(
                title: "Your Connection is Disabled",
                description:
                    "Enable Your Internet Connection then restart your app",
                imagePath: 'assets/images/logout.png'));
      } else {
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
      _loadUserInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);

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
