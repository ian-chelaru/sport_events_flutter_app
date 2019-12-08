import 'package:flutter/material.dart';

class Event {
  int id;
  String name;
  String location;
  TimeOfDay startTime;
  TimeOfDay endTime;

  Event({this.id, this.name, this.location, this.startTime, this.endTime});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "location": location,
      "start_time": startTime,
      "end_time": endTime,
    };
  }
}
