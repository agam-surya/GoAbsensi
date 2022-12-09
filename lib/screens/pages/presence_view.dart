import 'package:flutter/material.dart';
import 'package:goAbsensi/services/presence_services.dart';
import 'package:timer_builder/timer_builder.dart';

import '../../common/common.dart';
import '../../models/history.dart';

class PresenceView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
              _HeaderPresenceComponent(),
              const SizedBox(
                height: 32,
              ),
              _ClockPresenceComponent(),
              const SizedBox(
                height: 24,
              ),
              _PresenceActivityComponent(),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeaderPresenceComponent extends StatelessWidget {
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

class _ClockPresenceComponent extends StatelessWidget {
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

// ignore: must_be_immutable
class _PresenceActivityComponent extends StatefulWidget {
  bool isMount = true;
  @override
  State<_PresenceActivityComponent> createState() =>
      _PresenceActivityComponentState();
}

class _PresenceActivityComponentState
    extends State<_PresenceActivityComponent> {
  List dataHistory = [];
  String username = 'null';

  getHistory() async {
    HistoryApiResponse res = await showPresence();

    final resBody = res.data as List;
    if (widget.isMount) {
      setState(() {
        for (var i = 0; i < resBody.length; i++) {
          if (resBody[i]['presence_enter_time'] != null) {
            dataHistory.add({
              "status": "Masuk",
              "absentDate": "${resBody[i]['presence_date']}",
              "waktu": "${resBody[i]['presence_enter_time']}",
            });
          }
          if (resBody[i]['presence_out_time'] != null) {
            dataHistory.add({
              "status": "Keluar",
              "absentDate": "${resBody[i]['presence_date']}",
              "waktu": "${resBody[i]['presence_out_time']}",
            });
          } else {
            dataHistory.add({
              "status": "Izin",
              "absentDate": "${resBody[i]['presence_date']}",
              "waktu": "${resBody[i]['presence_date']}",
            });
          }
        }
        username = res.name!;
      });
    }
  }

  @override
  void initState() {
    getHistory();
    super.initState();
  }

  @override
  void dispose() {
    widget.isMount = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int startTimeToday = DateTime.now()
        .subtract(const Duration(hours: 12))
        .millisecondsSinceEpoch;
    int endTimeToday =
        DateTime.now().add(const Duration(hours: 12)).millisecondsSinceEpoch;

    return Padding(
      padding: EdgeInsets.only(bottom: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: defaultMargin),
            child: Text(
              "Kehadiran Hari Ini ${dataHistory.length}",
              textAlign: TextAlign.left,
              style: semiBlackFont.copyWith(fontSize: 14),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            height: (10 * 74).toDouble(),
            margin: const EdgeInsets.symmetric(horizontal: defaultMargin),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Color(0xFFEEEEEE),
                  width: 3,
                  style: BorderStyle.solid,
                ),
                left: BorderSide(
                  color: Color(0xFFEEEEEE),
                  width: 3,
                  style: BorderStyle.solid,
                ),
                right: BorderSide(
                  color: Color(0xFFEEEEEE),
                  width: 3,
                  style: BorderStyle.solid,
                ),
              ),
            ),
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: dataHistory.length,
                itemBuilder: (context, index) {
                  var datas = dataHistory;
                  var data = datas[index];

                  return _UserPresenceComponent(
                    userName: username,
                    absentTime: data['waktu'],
                    absentDate: data['absentDate'],
                    status: data['status'],
                  );
                }),
          )
        ],
      ),
    );
  }
}

class _UserPresenceComponent extends StatelessWidget {
  final String userName;
  final String absentTime;
  final String absentDate;
  // final String photoURL;
  final String status;

  _UserPresenceComponent({
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
                    absentTime + " WIB",
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
            'assets/images/entry.png',
            width: 24,
            height: 24,
          ),
        ],
      ),
    );
  }
}
