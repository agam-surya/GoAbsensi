// import 'package:flutter/material.dart';
// import 'package:flutter_api_test/common/constant.dart';
// import 'package:flutter_api_test/models/api_response.dart';
// import 'package:flutter_api_test/services/services.dart';

// import 'home.dart';
// import 'login.dart';

// class Loading extends StatefulWidget {
//   static String routeName = '/loading';
//   const Loading({Key? key}) : super(key: key);

//   @override
//   State<Loading> createState() => _LoadingState();
// }

// class _LoadingState extends State<Loading> {
//   void _loadUserInfo() async {
//     String token = await getToken();
//     if (token == '') {
//       Navigator.of(context).pushAndRemoveUntil(
//           MaterialPageRoute(builder: (context) => const Login()),
//           (route) => false);
//     } else {
//       ApiResponse response = await getUserDetail();
//       if (response.error == null) {
//         Navigator.of(context).pushAndRemoveUntil(
//             MaterialPageRoute(builder: (context) => const Home()),
//             (route) => false);
//       } else if (response.error == unauthorized) {
//         Navigator.of(context).pushAndRemoveUntil(
//             MaterialPageRoute(builder: (context) => const Login()),
//             (route) => false);
//       } else {
//         // ScaffoldMessenger.of(context)
//         //     .showSnackBar(SnackBar(content: Text('${response.error}')));
//         Navigator.of(context).pushAndRemoveUntil(
//             MaterialPageRoute(builder: (context) => const Login()),
//             (route) => false);
//       }
//     }
//   }

//   @override
//   void initState() {
//     _loadUserInfo();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('After Splash Screen'),
//       ),
//     );
//   }
// }
