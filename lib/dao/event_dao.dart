import 'package:sqflite/sqflite.dart';
import 'package:sport_events_app/model/event.dart';
import 'package:sport_events_app/dao/db_connection.dart';

class EventDao {
  Future<void> insertEvent(Event event) async {
    final Database db = await DatabaseConnection().database;

    await db.insert(
      'events',
      event.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Event>> getEvents() async {
    final Database db = await DatabaseConnection().database;

    final List<Map<String, dynamic>> maps = await db.query("events");

    return List.generate(maps.length, (i) {
      return Event(
        id: maps[i]['id'],
        name: maps[i]['name'],
        location: maps[i]['location'],
        startTime: maps[i]['start_time'],
        endTime: maps[i]['end_time'],
      );
    });
  }

  Future<void> updateEvent(Event event) async {
    final Database db = await DatabaseConnection().database;

    await db.update(
      "events",
      event.toMap(),
      // Ensure that the Event has a matching id.
      where: "id = ?",
      // Pass the Event's id as a whereArg to prevent SQL injection.
      whereArgs: [event.id],
    );
  }

  Future<void> deleteEvent(int id) async {
    final Database db = await DatabaseConnection().database;

    await db.delete(
      "events",
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
