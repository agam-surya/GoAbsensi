import 'dart:async';

import 'package:flutter/material.dart';
import 'package:goAbsensi/models/absent_api_res.dart';
import 'package:goAbsensi/services/presence_services.dart';
import 'package:goAbsensi/utils/login_utils.dart';

import '../../common/common.dart';
import '../../services/services.dart';
import '../login.dart';

class DashboardView extends StatelessWidget {
  _HeaderDashboardComponent headerDashboard = _HeaderDashboardComponent();
  _InformationsComponent information = _InformationsComponent();
  _MenuActivityComponent menuActivity = _MenuActivityComponent();
  _AnnouncementComponent announcement = _AnnouncementComponent();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            width: deviceWidth(context),
            height: 205 - statusBarHeight(context),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 32,
              ),
              headerDashboard,
              SizedBox(
                height: 32,
              ),
              information,
              SizedBox(
                height: 20,
              ),
              menuActivity,
              SizedBox(
                height: 20,
              ),
              announcement,
              SizedBox(
                height: 95,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeaderDashboardComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: defaultMargin,
        ),
        Container(
          width: 50,
          height: 50,
          margin: EdgeInsets.only(right: 14),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/secondary_logo.png'),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "GoAbsensi",
              style: boldWhiteFont.copyWith(fontSize: 22),
            ),
            Text(
              "Modern Presence App",
              style: regularWhiteFont.copyWith(fontSize: 11),
            ),
          ],
        ),
        Spacer(
          flex: 1,
        ),
        Container(
          width: 38,
          height: 38,
          child: RaisedButton(
            color: maroonColor,
            elevation: 0,
            hoverElevation: 0,
            focusElevation: 0,
            highlightElevation: 0,
            padding: EdgeInsets.zero,
            splashColor: Colors.black.withOpacity(0.3),
            visualDensity: VisualDensity.comfortable,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            child: Image.asset(
              'assets/images/ic_logout.png',
              width: 18,
              height: 18,
            ),
            onPressed: () {
              logout().then((value) => Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const Login()),
                  (route) => false));
            },
          ),
        ),
        SizedBox(
          width: defaultMargin,
        ),
      ],
    );
  }
}

class _LogoutAlertComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: defaultMargin,
        vertical: 25,
      ),
      content: Container(
        height: 290,
        child: Column(
          children: [
            Container(
              height: 120,
              margin: EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/logout.png'),
                ),
              ),
            ),
            Text(
              "Logout Dari Akun Ini",
              textAlign: TextAlign.center,
              style: boldBlackFont.copyWith(fontSize: 20),
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              "Akunmu akan bisa dilogin dari\nperangkat mana saja!",
              textAlign: TextAlign.center,
              style: semiGreyFont.copyWith(fontSize: 13),
            ),
            Spacer(
              flex: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 105,
                  height: 40,
                  child: FlatButton(
                    color: Color(0xFFCDCBCB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      "Batalkan",
                      style: semiWhiteFont.copyWith(fontSize: 14),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Container(
                  width: 105,
                  height: 40,
                  child: FlatButton(
                    color: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      "Logout",
                      style: semiWhiteFont.copyWith(fontSize: 14),
                    ),
                    onPressed: () async {
                      // await AuthServices.logOut();
                      // Navigator.pushReplacementNamed(context, Wrapper.routeName);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InformationsComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return Consumer<UserProvider>(
    //   builder: (context, userProvider, _) {
    // if (imageFileToUpload != null) {
    //   uploadImage(imageFileToUpload!).then((downloadURL) {
    //     imageFileToUpload = null;
    //     Provider.of<UserProvider>(context, listen: false).updateUser(photoURL: downloadURL);
    //   });
    // }

    // if (userProvider.user == null) {
    //   return Padding(
    //     padding: const EdgeInsets.symmetric(vertical: 18),
    //     child: CircularProgressIndicator(
    //       color: whiteColor,
    //       // size: 50,
    //     ),
    //   );
    // }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Selamat Beraktivitas, ",
          style: semiWhiteFont.copyWith(fontSize: 14),
        ),
        SizedBox(
          height: 12,
        ),
        Container(
          width: defaultWidth(context),
          padding: EdgeInsets.only(
            top: 16,
            bottom: 8,
            left: 25,
            right: 25,
          ),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Color(0xFFEEEEEE),
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _PresenceInfoComponent(
                presenceType: "Hadir",
                totalPresence: 12,
                iconPath: 'assets/images/ic_presence.png',
              ),
              _PresenceInfoComponent(
                presenceType: "Sakit",
                totalPresence: 1,
                iconPath: 'assets/images/ic_sick.png',
              ),
              _PresenceInfoComponent(
                presenceType: "Izin",
                totalPresence: 1,
                iconPath: 'assets/images/ic_cuti.png',
              ),
              _PresenceInfoComponent(
                presenceType: "Alfa",
                totalPresence: 2,
                iconPath: 'assets/images/ic_alfa.png',
              ),
            ],
          ),
        ),
      ],
    );
    //   }
    // );
  }
}

class _PresenceInfoComponent extends StatelessWidget {
  final String iconPath;
  final String presenceType;
  final int totalPresence;

  _PresenceInfoComponent(
      {required this.iconPath,
      required this.presenceType,
      this.totalPresence = 0});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(iconPath),
            ),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          presenceType,
          style: regularBlackFont.copyWith(fontSize: 12),
        ),
        SizedBox(
          height: 2,
        ),
        Text(
          totalPresence.toString(),
          style: boldBlackFont.copyWith(fontSize: 18),
        ),
      ],
    );
  }
}

class _MenuActivityComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Menu Aktivitas",
          style: semiBlackFont.copyWith(fontSize: 14),
        ),
        SizedBox(
          height: 16,
        ),
        Wrap(
          spacing: 24,
          runSpacing: 20,
          children: [
            _MenuComponent(
              titleMenu: "Absen Masuk",
              iconPath: 'assets/images/ic_absen_masuk.png',
              onTap: () async {
                await createPresence();

                AbsenApiResponse absen = await formMasuk();
                if (absen.error == null) {
                  print(absen.description);
                  alertLogin(absen.description, context, '');
                } else {
                  alertLogin(absen.description, context, '');
                }
              },
            ),
            _MenuComponent(
              titleMenu: "Absen Pulang",
              iconPath: 'assets/images/ic_absen_pulang.png',
              onTap: () async {
                formKeluar();
              },
            ),
            _MenuComponent(
              titleMenu: "Riwayat",
              iconPath: 'assets/images/ic_history.png',
              onTap: () {},
            ),
            _MenuComponent(
              titleMenu: "Surat Izin",
              iconPath: 'assets/images/ic_letter.png',
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}

class _MenuComponent extends StatelessWidget {
  final String titleMenu;
  final String iconPath;
  final void Function()? onTap;

  _MenuComponent(
      {required this.titleMenu, required this.iconPath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Ink(
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: InkWell(
          onTap: onTap,
          splashColor: Colors.black.withOpacity(0.4),
          borderRadius: BorderRadius.circular(6),
          child: Container(
            width: deviceWidth(context) / 2 - 1.5 * defaultMargin,
            height: 54,
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  titleMenu,
                  style: boldWhiteFont.copyWith(fontSize: 13),
                ),
                Image.asset(
                  iconPath,
                  width: 24,
                  height: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AnnouncementComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Pemberitahuan",
          style: semiBlackFont.copyWith(fontSize: 14),
        ),
        SizedBox(
          height: 16,
        ),
        Container(
          width: defaultWidth(context),
          height: 70,
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Color(0xFFEEEEEE),
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/megaphone.png',
                width: 35,
                height: 35,
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Perubahan Sistem Absensi",
                    style: semiWhiteFont.copyWith(fontSize: 14),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    "Absensi menggunakan aplikasi GoAbsensi",
                    style: semiBlackFont.copyWith(
                      fontSize: 11.5,
                      color: Color(0xFFEEEEEE),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
