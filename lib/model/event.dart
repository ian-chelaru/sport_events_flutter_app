import 'package:flutter/material.dart';
import 'package:sport_events_app/util/converters.dart';

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
      "start_time": startTime.toString().substring(10, 15),
      "end_time": endTime.toString().substring(10, 15),
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'startTime': startTime.toString().substring(10, 15),
      'endTime': endTime.toString().substring(10, 15),
    };
  }

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      startTime: convertStringToTimeOfDay(json['startTime']),
      endTime: convertStringToTimeOfDay(json['endTime']),
    );
  }
}
