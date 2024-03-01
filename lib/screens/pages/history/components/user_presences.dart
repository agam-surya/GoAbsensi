import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../common/common.dart';

class UserPresenceComponent extends StatelessWidget {
  final String userName;
  final String absentTime;
  final String absentDate;
  // final String photoURL;
  final String jenis;
  final String status;

  UserPresenceComponent({
    required this.userName,
    required this.absentTime,
    required this.absentDate,
    required this.jenis,
    this.status = '',
  });

  formatDate(String date) {
    final DateTime dateF = DateFormat('yyyy-MM-dd').parse(date);
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(dateF);
    return formatted;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceWidth(context),
      height: 100,
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
                      color: (jenis.toLowerCase() == "keluar")
                          ? primaryColor
                          : (jenis.toLowerCase() == "masuk")
                              ? successColor
                              : ijinColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Center(
                      child: Text(
                        jenis,
                        style: boldWhiteFont.copyWith(
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    (jenis.toLowerCase() == "izin")
                        ? (absentTime + ' - ' + formatDate(absentDate))
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
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              status == null || status == ''
                  ? const Text('')
                  : Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: status != 'null' && status != ''
                              ? status.toString() == 'reject'
                                  ? primaryColor
                                  : successColor
                              : ijinColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                          )),
                      child: Text(
                          status != 'null' && status != ''
                              ? status
                              : 'menunggu..',
                          style: semiBlackFont.copyWith(fontSize: 10)),
                    ),
              Image.asset(
                (jenis.toLowerCase() == "masuk")
                    ? 'assets/images/entry.png'
                    : (jenis.toLowerCase() == "keluar")
                        ? "assets/images/ic_absen_pulang.png"
                        : "assets/images/warn.png",
                width: 24,
                height: 24,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
