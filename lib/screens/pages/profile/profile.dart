import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goAbsensi/common/common.dart';
import 'package:goAbsensi/screens/login.dart';
import 'package:image_picker/image_picker.dart';

import '../../../size_config.dart';
import '../../../common/constant.dart';
import '../../../models/api_response.dart';
import '../../../models/user_prof.dart';
import '../../../services/profile_services.dart';
import '../../../services/services.dart';
import 'components/info.dart';
import 'components/profile_menu_item.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Userprofile? user;
  bool loading = true;
  late TextEditingController inputController;
  Image imageFallback = Image.asset(
    "assets/images/user_pic.png",
    fit: BoxFit.cover,
  );

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);

      int update = await updateImage(imageTemp);
      if (update == 200) {
        return ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Update Image Successfully !!')));
      }
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  void getUser() async {
    ApiResponse response = await getUserProfile();
    print(response.error);
    if (response.error == null) {
      if (this.mounted) {
        setState(() {
          user = response.data as Userprofile;
          loading = false;
        });
      }
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Login()),
                (route) => false)
          });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  getProfileImage() {
    Widget img = imageFallback;
    try {
      img = CachedNetworkImage(
        imageUrl: user!.image,
        placeholder: (context, url) => const SizedBox.shrink(),
        errorWidget: (context, url, error) => imageFallback,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover)),
        ),
      );
    } catch (e) {
      print(e);
    }
    return img;
  }

  Future editDialog(
      {required void submit(),
      required String title,
      required String hinttext}) async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(title),
              content: TextField(
                controller: inputController,
                autofocus: true,
                decoration: InputDecoration(hintText: hinttext),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel"),
                ),
                TextButton(onPressed: submit, child: Text('Submit')),
              ],
            ));
  }

  @override
  void initState() {
    getUser();
    inputController = TextEditingController();
    super.initState();
  }

  // @override
  // void dispose() {
  //   inputController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: buildAppBar(),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Info(
                    image: getProfileImage(),
                    name: user!.name,
                    position: user!.position,
                  ),
                  SizedBox(height: SizeConfig.defaultSize! * 2), //20
                  ElevatedButton(
                    onPressed: () =>
                        pickImage().then((value) => setState(() => getUser())),
                    child: Text('Change Photo'),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(primaryColor)),
                  ),

                  const Center(
                      child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "Account Info",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  )),

                  profileMenuItem(
                      icon: Icons.person_rounded,
                      title: "Nama",
                      subtitle: user!.name,
                      editable: true,
                      press: () async {
                        await editDialog(
                          title: "Edit Name",
                          hinttext: user!.name,
                          submit: () async {
                            await updateProfileData(name: inputController.text);
                            inputController.clear();
                            Navigator.of(context).pop();
                          },
                        );
                      }),
                  profileMenuItem(
                      icon: Icons.perm_phone_msg_rounded,
                      title: "No. HP",
                      subtitle: user!.phone,
                      editable: true,
                      press: () async {
                        await editDialog(
                          title: "Edit Phone Number",
                          hinttext: user!.phone,
                          submit: () async {
                            await updateProfileData(
                                phone: inputController.text);
                            inputController.clear();
                            Navigator.of(context).pop();
                          },
                        );
                      }),
                  profileMenuItem(
                    icon: Icons.work_rounded,
                    title: "Jabatan",
                    subtitle: user!.position,
                    press: () {},
                  ),
                  profileMenuItem(
                    icon: Icons.pin_drop_rounded,
                    title: "Alamat",
                    subtitle: user!.address,
                    editable: true,
                    press: () async {
                      await editDialog(
                        title: "Edit Address",
                        hinttext: user!.address,
                        submit: () async {
                          await updateProfileData(
                              address: inputController.text);
                          inputController.clear();
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: primaryColor,
      leading: SizedBox(),
      elevation: 0,
      // On Android it's false by default
      centerTitle: true,
    );
  }
}

profileMenuItem({
  required icon,
  required title,
  required subtitle,
  required press,
  bool editable = false,
}) {
  double? defaultSize = SizeConfig.defaultSize;

  return ListTile(
    title: Text(title),
    subtitle: Text(subtitle),
    leading: CircleAvatar(
      backgroundColor: primaryColor,
      child: Icon(icon, color: screenColor),
    ),
    trailing: editable
        ? const Icon(
            Icons.mode_edit_outline,
            color: primaryColor,
          )
        : null,
    onTap: press,
  );
}
