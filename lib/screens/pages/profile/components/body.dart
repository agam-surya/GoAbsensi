// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_api_test/common/common.dart';
// import 'package:image_picker/image_picker.dart';

// import '../../../size_config.dart';
// import '../../../common/constant.dart';
// import '../../../models/api_response.dart';
// import '../../../models/user_prof.dart';
// import '../../../services/profile_services.dart';
// import '../../../services/services.dart';
// import '../../login.dart';
// import 'info.dart';

// class Body extends StatefulWidget {
//   const Body({Key? key}) : super(key: key);

//   @override
//   State<Body> createState() => _BodyState();
// }

// class _BodyState extends State<Body> {
//   Userprofile? user;
//   bool loading = true;

//   Future pickImage() async {
//     try {
//       final image = await ImagePicker().pickImage(source: ImageSource.gallery);
//       if (image == null) return;
//       final imageTemp = File(image.path);

//       updateImage(imageTemp);
//       getUser();
//     } on PlatformException catch (e) {
//       print("Failed to pick image: $e");
//     }
//   }

//   void getUser() async {
//     ApiResponse response = await getUserProfile();
//     if (response.error == null) {
//       setState(() {
//         user = response.data as Userprofile;
//         loading = false;
//       });
//     } else if (response.error == unauthorized) {
//       logout().then((value) => {
//             Navigator.of(context).pushAndRemoveUntil(
//                 MaterialPageRoute(builder: (context) => Login()),
//                 (route) => false)
//           });
//     } else {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text('${response.error}')));
//     }
//   }

//   @override
//   void initState() {
//     getUser();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return loading
//         ? Center(child: CircularProgressIndicator())
//         : SingleChildScrollView(
//             child: Column(
//               children: <Widget>[
//                 Info(
//                   image: user!.image != 'image'
//                       ? DecorationImage(
//                           fit: BoxFit.cover,
//                           image: NetworkImage(user!.image),
//                         )
//                       : const DecorationImage(
//                           fit: BoxFit.cover,
//                           image: AssetImage("assets/images/user_pic.png"),
//                         ),
//                   name: user!.name,
//                   position: user!.position,
//                 ),
//                 SizedBox(height: SizeConfig.defaultSize! * 2), //20
//                 ElevatedButton(
//                   onPressed: () => pickImage(),
//                   child: Text('Change Photo'),
//                   style: ButtonStyle(
//                       backgroundColor: MaterialStateProperty.all(primaryColor)),
//                 ),

//                 // Center(child: user!.image == null ? Text("data") : Text(user!.image))

//                 // ProfileMenuItem(
//                 //   iconSrc: "assets/icons/bookmark_fill.svg",
//                 //   title: "Saved Recipes",
//                 //   press: () {},
//                 // ),
//                 // ProfileMenuItem(
//                 //   iconSrc: "assets/icons/chef_color.svg",
//                 //   title: "Super Plan",
//                 //   press: () {},
//                 // ),
//                 // ProfileMenuItem(
//                 //   iconSrc: "assets/icons/language.svg",
//                 //   title: "Change Language",
//                 //   press: () {},
//                 // ),
//                 // ProfileMenuItem(
//                 //   iconSrc: "assets/icons/info.svg",
//                 //   title: "Help",
//                 //   press: () {},
//                 // ),
//               ],
//             ),
//           );
//   }
// }
