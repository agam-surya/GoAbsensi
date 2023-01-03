import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String getSystemTime() {
  DateTime currenTime = DateTime.now();

  return DateFormat('HH : mm : ss').format(currenTime);
}

Future<DateTime?> pickDate(BuildContext context, {int dayLong = 0}) async {
  DateTime currentDate = DateTime.now();
  DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(currentDate.year, currentDate.month,
          currentDate.day + dayLong, 0, 0, 0, 0, 0));

  return pickedDate;
}
