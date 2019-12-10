import 'package:flutter/material.dart';
import 'package:sport_events_app/pages/add_event.dart';
import 'package:sport_events_app/rest/event_service.dart';
import '../model/event.dart';
import '../widgets/event_card.dart';
import 'package:sport_events_app/dao/event_dao.dart';
import 'package:toast/toast.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  EventDao eventDao = EventDao();
  EventService eventService = EventService();

  List<Event> events;

  Event defaultEvent = Event(
      name: "Sport0",
      location: "Location0",
      startTime: TimeOfDay(hour: 0, minute: 0),
      endTime: TimeOfDay(hour: 0, minute: 0));

  @override
  void initState() {
    super.initState();
    events = List<Event>();
    _getAllEvents();
//    Future<List<Event>> eventList = eventService.getAllEvents();
  }

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
                delete: () async {
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

  void _addEvent(event) async {
    if (event != null) {
      try {
        event = await eventService.insertEvent(event);
      } catch (e) {
        _showToast("No internet connection. Data persisted locally.");
      }
      eventDao.insertEvent(event);
      setState(() {
        events.add(event);
      });
    }
  }

  void _updateEvent(Event oldEvent, Event newEvent) async {
    if (newEvent != null) {
      newEvent.id = oldEvent.id;
      try {
        await eventService.updateEvent(newEvent);
        eventDao.updateEvent(newEvent);
        setState(() {
          oldEvent.name = newEvent.name;
          oldEvent.location = newEvent.location;
          oldEvent.startTime = newEvent.startTime;
          oldEvent.endTime = newEvent.endTime;
        });
      } catch (e) {
        _showToast("No internet connection. Update operation not available.");
      }
    }
  }

  void _deleteEvent(event) async {
    try {
      await eventService.deleteEvent(event.id);
      eventDao.deleteEvent(event.id);
      setState(() {
        events.remove(event);
      });
    } catch (e) {
      _showToast("No internet connection. Delete operation not available.");
    }
  }

  void _getAllEvents() async {
    List<Event> events;
    try {
      events = await eventService.getAllEvents();
      await eventDao.deleteAllEvents();
      for (var event in events) {
        await eventDao.insertEvent(event);
      }
    } catch (e) {
      events = await eventDao.getEvents();
      _showToast("No internet connection. Local data displayed.");
    }
    setState(() {
      this.events = events;
    });
  }

  void _showToast(String message) {
    Toast.show(message, context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  }
}
