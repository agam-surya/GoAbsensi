import 'package:flutter/material.dart';
import 'package:goAbsensi/models/api_response.dart';
import 'package:goAbsensi/models/User.dart';
import 'package:goAbsensi/services/services.dart';
import 'package:goAbsensi/utils/alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/common.dart';
import '../common/constant.dart';
import 'home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
  bool loading = false;
  bool isHidePassword = true;

  void _loginUser() async {
    ApiResponse response = await login(emailC.text, passC.text);

    try {
      if (response.error == null) {
        _saveAndRedirectToHome(response.data as User);
      } else {
        setState(() {
          loading = false;
        });
        alertdialog(
            err: response.error, context: context, desc: response.description);
      }
    } catch (e) {
      print(e);
    }
  }

  void _saveAndRedirectToHome(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    await pref.setString('token', user.token ?? '');
    await pref.setInt('userId', user.id ?? 0);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const Home()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: deviceHeight(context),
        width: deviceWidth(context),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(50),
              width: deviceWidth(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    margin: const EdgeInsets.only(right: 14),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/primary_logo.png"),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "GoAbsensi",
                        style: boldBlackFont.copyWith(fontSize: 24),
                      ),
                      Text(
                        "Modern Presence App",
                        style: regularGreyFont.copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Form(
                key: formKey,
                child: ListView(
                  padding: const EdgeInsets.all(30),
                  children: [
                    TextFormField(
                      controller: emailC,
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) =>
                          val!.isEmpty ? 'invalid email address' : null,
                      decoration: inputDecoration('Email'),
                    ),
                    const SizedBox(height: defaultMargin),
                    TextFormField(
                      controller: passC,
                      obscureText: isHidePassword,
                      validator: (val) =>
                          val!.length < 6 ? 'Required at least 6 chars' : null,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                isHidePassword = !isHidePassword;
                              });
                            },
                            child: (!isHidePassword)
                                ? const Icon(
                                    Icons.visibility_off,
                                    size: 20,
                                    color: primaryColor,
                                  )
                                : const Icon(
                                    Icons.visibility,
                                    size: 20,
                                    color: Color(0xFFC6C6C6),
                                  ),
                          ),
                          contentPadding: const EdgeInsets.all(10),
                          border: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black))),
                    ),
                    const SizedBox(height: defaultMargin),
                    loading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : kTextButton('Login', () {
                            if (formKey.currentState!.validate()) {
                              setState(() {
                                loading = true;
                                _loginUser();
                              });
                            }
                          }, primaryColor),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
