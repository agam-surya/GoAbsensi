import 'package:flutter/material.dart';

import '../../../../common/common.dart';

class UserPresenceComponent extends StatelessWidget {
  final String userName;
  final String absentTime;
  final String absentDate;
  // final String photoURL;
  final String status;

  UserPresenceComponent({
    required this.userName,
    required this.absentTime,
    required this.absentDate,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    // String time = DateFormat('hh : mm : ss')
    //     .format(DateTime.fromMillisecondsSinceEpoch(absentTime));

    return Container(
      width: deviceWidth(context),
      height: 90,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      decoration: const BoxDecoration(
        color: whiteColor,
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFFEBEBEF),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // if (photoURL == null)
          ClipOval(
            child: Image.asset(
              'assets/images/avatar.png',
              width: 46,
              height: 46,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                userName,
                style: semiBlackFont.copyWith(fontSize: 13),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                absentDate,
                style: semiBlackFont.copyWith(
                  fontSize: 11,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 42,
                    height: 14,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: (status.toLowerCase() == "keluar")
                          ? primaryColor
                          : (status.toLowerCase() == "masuk")
                              ? successColor
                              : ijinColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Center(
                      child: Text(
                        status,
                        style: boldWhiteFont.copyWith(
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    (status.toLowerCase() == "izin")
                        ? ''
                        : (absentTime + " WIB"),
                    style: semiBlackFont.copyWith(
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(
            flex: 1,
          ),
          Image.asset(
            (status.toLowerCase() == "masuk")
                ? 'assets/images/entry.png'
                : (status.toLowerCase() == "keluar")
                    ? "assets/images/ic_absen_pulang.png"
                    : "assets/images/warn.png",
            width: 24,
            height: 24,
          ),
        ],
      ),
    );
  }
}
