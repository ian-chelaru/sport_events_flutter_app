import 'package:flutter/material.dart';
import 'package:sport_events_app/pages/add_event.dart';
import '../model/event.dart';
import '../widgets/event_card.dart';
import 'package:sport_events_app/dao/event_dao.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  EventDao eventDao = EventDao();

  List<Event> events;

  Event defaultEvent = Event(
      name: "Sport0",
      location: "Location0",
      startTime: TimeOfDay(hour: 0, minute: 0),
      endTime: TimeOfDay(hour: 0, minute: 0));

  @override
  Widget build(BuildContext context) {
    if (events == null) {
      events = List<Event>();
      _getAllEvents();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('SportEventsApp'),
      ),
      body: ListView(
        shrinkWrap: true,
        children: events
            .map((event) => EventCard(
                event: event,
                update: () async {
                  Event updatedEvent = await _navigateToAddEventPage(event);
                  updatedEvent.id = event.id;
                  await eventDao.updateEvent(updatedEvent);
                  _updateEvent(event, updatedEvent);
                },
                delete: () async {
                  await eventDao.deleteEvent(event.id);
                  _deleteEvent(event);
                }))
            .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Event newEvent = await _navigateToAddEventPage(defaultEvent);
          await eventDao.insertEvent(newEvent);
          _addEvent(newEvent);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<Event> _navigateToAddEventPage(event) {
    return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddEventPage(event: event),
        ));
  }

  void _addEvent(event) {
    if (event != null) {
      setState(() {
        events.add(event);
      });
    }
  }

  void _updateEvent(Event oldEvent, Event newEvent) {
    if (newEvent != null) {
      setState(() {
        oldEvent.name = newEvent.name;
        oldEvent.location = newEvent.location;
        oldEvent.startTime = newEvent.startTime;
        oldEvent.endTime = newEvent.endTime;
      });
    }
  }

  void _deleteEvent(event) {
    setState(() {
      events.remove(event);
    });
  }

  void _getAllEvents() async {
    List<Event> events = await eventDao.getEvents();
    setState(() {
      this.events = events;
    });
  }
}
