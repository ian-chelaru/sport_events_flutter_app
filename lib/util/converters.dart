import 'package:flutter/material.dart';

TimeOfDay convertStringToTimeOfDay(String time) {
  int hour = int.parse(time.substring(0, 2));
  int minute = int.parse(time.substring(3, 5));
  return TimeOfDay(hour: hour, minute: minute);
}