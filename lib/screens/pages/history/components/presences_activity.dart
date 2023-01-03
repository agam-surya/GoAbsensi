import 'package:flutter/material.dart';
import 'package:goAbsensi/screens/pages/history/components/user_presences.dart';

import '../../../../common/common.dart';
import '../../../../models/history.dart';
import '../../../../services/presence_services.dart';

class PresenceActivityComponent extends StatefulWidget {
  bool isMount = true;
  @override
  State<PresenceActivityComponent> createState() =>
      _PresenceActivityComponentState();
}

class _PresenceActivityComponentState extends State<PresenceActivityComponent> {
  List dataHistory = [];
  String username = 'null';

  getHistory() async {
    HistoryApiResponse res = await showPresence();

    final resBody = res.data as List;
    final perm = res.permission as List;
    if (widget.isMount) {
      setState(() {
        if (perm.length > 0) {
          for (var i = 0; i < perm.length; i++) {
            dataHistory.add({
              "jenis": "Izin",
              "waktu": "${perm[i]['tanggal_start_izin']}",
              "absentDate": "${perm[i]['tanggal_end_izin']}",
              "status": "${perm[i]['aksi']}",
            });
          }
        }
        for (var i = 0; i < resBody.length; i++) {
          if (resBody[i]['presence_enter_time'] != null) {
            dataHistory.add({
              "jenis": "Masuk",
              "absentDate": "${resBody[i]['presence_date']}",
              "waktu": "${resBody[i]['presence_enter_time']}",
            });
          }
          if (resBody[i]['presence_out_time'] != null) {
            dataHistory.add({
              "jenis": "Keluar",
              "absentDate": "${resBody[i]['presence_date']}",
              "waktu": "${resBody[i]['presence_out_time']}",
            });
          } else if (resBody[i]['presence_enter_time'] == null &&
              resBody[i]['presence_out_time'] == null) {}
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
              "Riwayat Kehadiran $username",
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

                  return datas.length == 0
                      ? Center(
                          child: Text("Data History Kehadiran Anda Kosong"),
                        )
                      : UserPresenceComponent(
                          userName: username,
                          absentTime: data['waktu'],
                          absentDate: data['absentDate'],
                          jenis: data['jenis'],
                          status: data['status'] ?? '',
                        );
                }),
          )
        ],
      ),
    );
  }
}
