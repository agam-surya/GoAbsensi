import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_api_test/common/common.dart';
import 'package:flutter_api_test/screens/login.dart';
import 'package:image_picker/image_picker.dart';

import '../../../size_config.dart';
import '../../../common/constant.dart';
import '../../../models/api_response.dart';
import '../../../models/user_prof.dart';
import '../../../services/profile_services.dart';
import '../../../services/services.dart';
import 'components/info.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Userprofile? user;
  bool loading = true;
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
    if (response.error == null) {
      setState(() {
        user = response.data as Userprofile;
        loading = false;
      });
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

  @override
  void initState() {
    getUser();
    super.initState();
  }

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

                  // Center(child: user!.image == null ? Text("data") : Text(user!.image))

                  // ProfileMenuItem(
                  //   iconSrc: "assets/icons/bookmark_fill.svg",
                  //   title: "Saved Recipes",
                  //   press: () {},
                  // ),
                  // ProfileMenuItem(
                  //   iconSrc: "assets/icons/chef_color.svg",
                  //   title: "Super Plan",
                  //   press: () {},
                  // ),
                  // ProfileMenuItem(
                  //   iconSrc: "assets/icons/language.svg",
                  //   title: "Change Language",
                  //   press: () {},
                  // ),
                  // ProfileMenuItem(
                  //   iconSrc: "assets/icons/info.svg",
                  //   title: "Help",
                  //   press: () {},
                  // ),
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
      // actions: <Widget>[
      //   IconButton(
      //     onPressed: () {},
      //     iconSize: 30,
      //     icon: Icon(
      //       Icons.settings_outlined,
      //       color: darkColor,
      //     ),
      //   ),
      // ],
    );
  }
}
