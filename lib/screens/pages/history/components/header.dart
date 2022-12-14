import 'package:flutter/material.dart';

import '../../../../common/common.dart';

class HeaderPresenceComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: defaultMargin,
        ),
        Container(
          width: 50,
          height: 50,
          margin: const EdgeInsets.only(right: 14),
          decoration: const BoxDecoration(
            image: const DecorationImage(
              image: AssetImage('assets/images/secondary_logo.png'),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Aktivitas Kehadiran",
              style: boldWhiteFont.copyWith(fontSize: 22),
            ),
            Text(
              "Realtime Presence App",
              style: regularWhiteFont.copyWith(fontSize: 11),
            ),
          ],
        ),
      ],
    );
  }
}
