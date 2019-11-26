import 'package:flutter/material.dart';
import 'package:sport_events_app/pages/add_event.dart';
import '../model/event.dart';
import '../widgets/event_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Event> events = [
    Event(
        name: "Cycling",
        location: "Location1",
        startTime: TimeOfDay(hour: 16, minute: 0),
        endTime: TimeOfDay(hour: 17, minute: 0)),
    Event(
        name: "Football",
        location: "Location2",
        startTime: TimeOfDay(hour: 20, minute: 30),
        endTime: TimeOfDay(hour: 22, minute: 0)),
    Event(
        name: "Basketball",
        location: "Location3",
        startTime: TimeOfDay(hour: 8, minute: 15),
        endTime: TimeOfDay(hour: 9, minute: 0))
  ];

  Event defaultEvent = Event(
      name: "Sport0",
      location: "Location0",
      startTime: TimeOfDay(hour: 0, minute: 0),
      endTime: TimeOfDay(hour: 0, minute: 0));

  @override
  Widget build(BuildContext context) {
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
                  _updateEvent(event, updatedEvent);
                },
                delete: () {
                  _deleteEvent(event);
                }))
            .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Event newEvent = await _navigateToAddEventPage(defaultEvent);
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
}
