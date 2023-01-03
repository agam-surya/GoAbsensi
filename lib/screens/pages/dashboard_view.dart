import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:goAbsensi/common/time_utils.dart';
import 'package:goAbsensi/models/absent_api_res.dart';
import 'package:goAbsensi/models/spk.dart';
import 'package:goAbsensi/screens/pages/history/histories_view.dart';
import 'package:goAbsensi/services/presence_services.dart';
import 'package:intl/intl.dart';

import '../../common/common.dart';
import '../../models/history.dart';
import '../../services/main_services.dart';
import '../login.dart';

class DashboardView extends StatefulWidget {
  Future<Map<String, String>> getLocation;
  bool isMount = true;

  DashboardView({required this.getLocation});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  _HeaderDashboardComponent headerDashboard = _HeaderDashboardComponent();

  List<dynamic>? spk = [];

  int hadir = 0;
  int sakit = 0;
  int izin = 0;
  int wfh = 0;

  getHistory() async {
    HistoryApiResponse res = await showPresence(context);

    final resBody = res.data as List;
    final perm = res.permission as List;
    if (widget.isMount) {
      setState(() {
        for (var i = 0; i < perm.length; i++) {
          izin += 1;
          if (perm[i]['permission_type_id'] == 1) {
            wfh += 1;
          }
          if (perm[i]['permission_type_id'] == 2) {
            sakit += 1;
          }
        }

        // count data hadir
        for (var i = 0; i < resBody.length; i++) {
          if (resBody[i]['presence_enter_time'] != null &&
              resBody[i]['presence_out_time'] != null) {
            hadir += 1;
          }
        }
      });
    }
  }

  getSPK() async {
    SPK rank = await getRank();
    if (widget.isMount) {
      setState(() {
        spk = rank.data;
        rank.data!.sort((a, b) => (b['skor']).compareTo(a['skor']));
      });
    }
  }

  @override
  void initState() {
    getSPK();
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
    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            width: deviceWidth(context),
            height: 205 - statusBarHeight(context),
            decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
          ),
          Column(
            children: [
              const SizedBox(
                height: 32,
              ),
              headerDashboard,
              const SizedBox(
                height: 32,
              ),
              _InformationsComponent(
                  hadir: hadir, sakit: sakit, izin: izin, wfh: wfh),
              const SizedBox(
                height: 20,
              ),
              _MenuActivityComponent(getLocation: widget.getLocation),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: Text(
                      "Ranking 5 Dosen Paling Rajin",
                      style: semiBlackFont.copyWith(fontSize: 14),
                    ),
                  ),
                  Container(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      itemCount: spk!.length >= 5 ? 5 : spk!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: _RankComponent(
                            rank: "${index + 1}",
                            name: spk![index]["nama"],
                            position: spk![index]["jabatan"],
                            value: spk![index]["skor"].toString(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
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
  int hadir = 0;
  int sakit = 0;
  int izin = 0;
  int wfh = 0;

  _InformationsComponent({
    required this.hadir,
    required this.sakit,
    required this.izin,
    required this.wfh,
  });
  @override
  Widget build(BuildContext context) {
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
                totalPresence: hadir,
                iconPath: 'assets/images/ic_presence.png',
              ),
              _PresenceInfoComponent(
                presenceType: "Sakit",
                totalPresence: sakit,
                iconPath: 'assets/images/ic_sick.png',
              ),
              _PresenceInfoComponent(
                presenceType: "Izin",
                totalPresence: izin,
                iconPath: 'assets/images/ic_cuti.png',
              ),
              _PresenceInfoComponent(
                presenceType: "WFH",
                totalPresence: wfh,
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

class _MenuActivityComponent extends StatefulWidget {
  Future<Map<String, String>> getLocation;

  _MenuActivityComponent({required this.getLocation});

  @override
  State<_MenuActivityComponent> createState() => _MenuActivityComponentState();
}

class _MenuActivityComponentState extends State<_MenuActivityComponent> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController desC = TextEditingController();
  TextEditingController dateC = TextEditingController();
  TextEditingController fileC = TextEditingController();
  bool loading = false;

  File filePickerVal = File("");

  selectFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null) {
      setState(() {
        fileC.text = result.files.single.name;
        filePickerVal = File(result.files.single.path.toString());
      });
    } else {
      // User canceled the picker
    }
  }

  Future editDialog(
      {required void Function() submit,
      required String title,
      required String hinttext}) async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(title),
              content: Container(
                height: 300,
                width: deviceWidth(context) * 0.6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Form(
                        key: formKey,
                        child: ListView(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: fileC,
                                    // validator: (val) => val!.isEmpty
                                    //     ? 'File Harus Diisi'
                                    //     : null,
                                    decoration: inputDecoration('File'),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                ElevatedButton.icon(
                                  icon: const Icon(
                                    Icons.upload_file,
                                    color: Colors.white,
                                    size: 24.0,
                                  ),
                                  label: const Text(''),
                                  onPressed: () {
                                    selectFile();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: primaryColor,
                                    minimumSize: const Size(76, 48),
                                    maximumSize: const Size(100, 48),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: defaultMargin),
                            TextFormField(
                              controller: desC,
                              validator: (val) => val!.isEmpty
                                  ? 'Description Harus Diisi'
                                  : null,
                              decoration: inputDecoration('Description'),
                            ),
                            const SizedBox(height: defaultMargin),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: dateC,
                                    // validator: (val) => val!.isEmpty
                                    //     ? 'Tanggal Harus Diisi'
                                    //     : null,
                                    decoration:
                                        inputDecoration("Tanggal Akhir Izin"),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                ElevatedButton.icon(
                                  icon: const Icon(
                                    Icons.calendar_today,
                                    color: Colors.white,
                                    size: 24.0,
                                  ),
                                  label: const Text(''),
                                  onPressed: () async {
                                    DateTime d = DateTime.now();
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());

                                    DateTime? date =
                                        await pickDate(context, dayLong: 3);

                                    dateC.text =
                                        DateFormat('yyyy-MM-dd').format(date!);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: primaryColor,
                                    minimumSize: const Size(76, 48),
                                    maximumSize: const Size(100, 48),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                AbsenApiResponse i = await izin(
                                    desc: desC.text,
                                    // tgl: dateC.text,
                                    // filePickerVal: filePickerVal,
                                    permTypeId: '1');
                                if (i.error == '') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Izin Berhasil !!')));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('Gagal melakukan izin !!')));
                                }
                                desC.clear();
                                dateC.clear();
                                fileC.clear();
                                Navigator.of(context).pop();
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => primaryColor),
                              fixedSize: MaterialStateProperty.all(
                                  const Size(100, 50)),
                            ),
                            child: const Text("WFH"),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                AbsenApiResponse i = await izin(
                                    desc: desC.text, permTypeId: '2');

                                if (i.error == '') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Izin Berhasil !!')));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('Gagal melakukan izin !!')));
                                }
                                desC.clear();
                                dateC.clear();
                                fileC.clear();
                                Navigator.of(context).pop();
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => primaryColor),
                              fixedSize: MaterialStateProperty.all(
                                  const Size(100, 50)),
                            ),
                            child: const Text("Sakit"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

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
                var lok = await widget.getLocation;
                AbsenApiResponse absen =
                    await formMasuk(lat: lok["lat"]!, long: lok["long"]!);
                absenAlertdialog(
                    err: absen.error,
                    context: context,
                    desc: absen.description);
              },
            ),
            _MenuComponent(
              titleMenu: "Absen Pulang",
              iconPath: 'assets/images/ic_absen_pulang.png',
              onTap: () async {
                var lok = await widget.getLocation;
                AbsenApiResponse absen =
                    await formKeluar(lat: lok["lat"]!, long: lok["long"]!);
                absenAlertdialog(
                    err: absen.error,
                    context: context,
                    desc: absen.description);
              },
            ),
            _MenuComponent(
              titleMenu: "Riwayat",
              iconPath: 'assets/images/ic_history.png',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => HistoriesView(),
                  ),
                );
              },
            ),
            _MenuComponent(
              titleMenu: "Izin",
              iconPath: 'assets/images/ic_letter.png',
              onTap: () async {
                await editDialog(
                    submit: () {}, title: "Izin", hinttext: "Izin");
              },
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

class _RankComponent extends StatelessWidget {
  String rank;
  String name;
  String position;
  String value;
  final Random _random = Random();
  _RankComponent(
      {required this.rank,
      required this.name,
      required this.position,
      required this.value});
  @override
  Widget build(BuildContext context) {
    String nilai = value;
    if (value.length > 2) {
      nilai = value.substring(0, 2);
      if (value.substring(2, 3) != '.') {
        nilai = value.substring(0, 3);
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 16,
          ),
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width * 0.85,
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: primaryColor),
              boxShadow: const [
                BoxShadow(
                    color: Color.fromARGB(255, 232, 143, 143),
                    blurRadius: 15.0,
                    offset: Offset(-5, 10)),
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 20),
                  child: CircleAvatar(
                    backgroundColor: primaryColor,
                    child: Text(
                      rank,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: whiteColor),
                    ),
                  ),
                ),
                Center(
                  child: ListTile(
                    leading: const CircleAvatar(
                        radius: 50,
                        child: Image(
                          image: AssetImage("assets/images/user_pic.png"),
                          fit: BoxFit.cover,
                        )),
                    title: Text(
                      name,
                      style: boldBlackFont,
                    ),
                    subtitle: Text(position),
                    trailing: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: primaryColor),
                      ),
                      child: Text(
                        // substring
                        "$nilai%",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
