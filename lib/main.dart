import 'package:flutter/material.dart';
import 'model/event.dart';
import 'widgets/event_card.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SportEventsApp'),
      ),
      body: Column(
        children: events
            .map((event) => EventCard(
                event: event,
                delete: () {
                  setState(() {
                    events.remove(event);
                  });
                }))
            .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
