import 'package:flutter/material.dart';

const baseUrl = 'http://192.168.1.8:8000/api';
const loginUrl = baseUrl + '/login';
const registerUrl = baseUrl + '/register';
const logoutUrl = baseUrl + '/logout';
const userUrl = baseUrl + '/user';
const profileUrl = baseUrl + '/profile';

// --------ERROR---------
const serverError = 'Server error';
const unauthorized = 'unauthorized';
const somethingwentwrong = 'Something went wrong, Try Again!';

// Input Decoration Form

InputDecoration inputDecoration(String label) {
  return InputDecoration(
      labelText: label,
      contentPadding: EdgeInsets.all(10),
      border: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.black)));
}

// Text Button

TextButton kTextButton(String label, Function onPressed, Color color) {
  return TextButton(
    onPressed: () => onPressed(),
    child: Text(
      label,
      style: TextStyle(color: Colors.white),
    ),
    style: ButtonStyle(
        backgroundColor: MaterialStateColor.resolveWith((states) => color),
        padding: MaterialStateProperty.resolveWith(
            (states) => EdgeInsets.symmetric(vertical: 15))),
  );
}
