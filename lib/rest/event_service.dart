import 'dart:core';
import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sport_events_app/model/event.dart';

class EventService {
  static const String _API_URL = 'http://10.0.2.2:8080/api/events';

  Future<Event> insertEvent(Event event) async {
    Map<String, String> headers = {"Content-type": "application/json"};
    Map<String, dynamic> jsonBody = event.toJson();
    jsonBody['id'] = 0;
    final response =
        await http.post(_API_URL, headers: headers, body: jsonEncode(jsonBody));
    if (response.statusCode == 200) {
      return Event.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to insert event");
    }
  }

  Future<List<Event>> getAllEvents() async {
    final response = await http.get(_API_URL);
    if (response.statusCode == 200) {
      Iterable responseJson = json.decode(response.body);
      return responseJson.map((e) => Event.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load events');
    }
  }

  Future<void> updateEvent(Event event) async {
    Map<String, String> headers = {"Content-type": "application/json"};
    Map<String, dynamic> jsonBody = event.toJson();
    final response =
        await http.put(_API_URL, headers: headers, body: jsonEncode(jsonBody));
    if (response.statusCode == 200) {
    } else {
      throw Exception("Failed to update event");
    }
  }

  Future<void> deleteEvent(int id) async {
    final response = await http.delete(_API_URL + "/" + id.toString());
    if (response.statusCode == 200) {
    } else {
      throw Exception("Failed to delete event");
    }
  }
}
