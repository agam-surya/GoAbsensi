part of 'common.dart';

// untuk generate alert dialog ketika login
/*
- diluar lokasi : "assets/images/out_worktime.png"
- akun di perangkat lain : "assets/images/other_devices.png"
- access denied : "assets/images/access_denied.png"
- telat : "assets/images/out_worktime.png"
- success : "assets/images/success.png"
*/
alertdialog(
    {required String? err,
    required BuildContext context,
    required String? desc}) {
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

absenAlertdialog(
    {required String? err,
    required BuildContext context,
    required String? desc}) {
  if (err != '') {
    if (desc!.toLowerCase() == 'akun di perangkat lain') {
      return showDialog(
          context: context,
          builder: (context) => CustomAlertDialog(
              title: desc, imagePath: 'assets/images/other_devices.png'));
    } else if (err == '420') {
//  err code 420 = diluar radius lokasi
      return showDialog(
          context: context,
          builder: (context) => CustomAlertDialog(
              title: desc, imagePath: 'assets/images/radius_office.png'));
    } else {
      return showDialog(
          context: context,
          builder: (context) => CustomAlertDialog(
              title: desc, imagePath: 'assets/images/access_denied.png'));
    }
  } else {
    return showDialog(
        context: context,
        builder: (context) => CustomAlertDialog(
            title: desc, imagePath: "assets/images/success.png"));
  }
}
