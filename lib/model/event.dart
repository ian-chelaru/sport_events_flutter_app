import 'package:flutter/material.dart';

class Event {
  String name;
  String location;
  TimeOfDay startTime;
  TimeOfDay endTime;

  Event({this.name, this.location, this.startTime, this.endTime});
}
