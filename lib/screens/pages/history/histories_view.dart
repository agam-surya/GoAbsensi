import 'package:flutter/material.dart';

import '../../../common/common.dart';
import 'components/clock.dart';
import 'components/header.dart';
import 'components/presences_activity.dart';

class HistoriesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: deviceWidth(context),
              height: 140 - statusBarHeight(context),
              decoration: const BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: const Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
            ),
            Column(
              children: [
                const SizedBox(
                  height: 32,
                ),
                HeaderPresenceComponent(),
                const SizedBox(
                  height: 32,
                ),
                ClockPresenceComponent(),
                const SizedBox(
                  height: 24,
                ),
                PresenceActivityComponent(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
