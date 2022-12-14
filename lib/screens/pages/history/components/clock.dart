import 'package:flutter/material.dart';
import 'package:timer_builder/timer_builder.dart';

import '../../../../common/common.dart';

class ClockPresenceComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 40,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          const BoxShadow(
            color: const Color(0xFFEEEEEE),
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/clock.png',
            width: 31,
            height: 31,
          ),
          const SizedBox(
            width: 16,
          ),
          TimerBuilder.periodic(
            const Duration(seconds: 1),
            builder: (context) {
              return Text(
                '16:30:12',
                style: boldBlackFont.copyWith(
                  color: primaryColor,
                  fontSize: 24,
                ),
              );
            },
          ),
          const SizedBox(
            width: 16,
          ),
          Text(
            "WIB",
            style: boldBlackFont.copyWith(
              color: primaryColor,
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}
