import 'package:flutter/material.dart';

import '../widgets/custom_alert_dialog.dart';

// untuk generate alert dialog ketika login
alertLogin(String? err, BuildContext context, String? desc) {
  if (err!.toLowerCase() == 'akun di perangkat lain') {
    return showDialog(
        context: context,
        builder: (context) => CustomAlertDialog(
            title: err,
            description: desc,
            imagePath: 'assets/images/other_devices.png'));
  } else {
    return showDialog(
        context: context,
        builder: (context) => CustomAlertDialog(
            title: err,
            description: desc,
            imagePath: 'assets/images/access_denied.png'));
  }
}
