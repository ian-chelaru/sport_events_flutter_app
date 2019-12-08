import 'package:flutter/material.dart';
import 'package:sport_events_app/model/event.dart';
import 'package:sport_events_app/util/converters.dart';

class AddEventPage extends StatefulWidget {
  final Event event;

  AddEventPage({this.event});

  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  TextEditingController nameController;
  TextEditingController locationController;
  TextEditingController startTimeController;
  TextEditingController endTimeController;

  @override
  void initState() {
    nameController = TextEditingController(text: '${widget.event.name}');
    locationController =
        TextEditingController(text: '${widget.event.location}');
    startTimeController = TextEditingController(
        text: '${widget.event.startTime.toString().substring(10, 15)}');
    endTimeController = TextEditingController(
        text: '${widget.event.endTime.toString().substring(10, 15)}');
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    locationController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.pop(context, _createEventFromInputs());
            },
            child: Text(
              widget.event.name == "Sport0" ? "Create" : "Update",
              style: TextStyle(fontSize: 20.0),
            ),
            textColor: Colors.white,
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(14.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                  labelText: "Name", border: OutlineInputBorder()),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              controller: locationController,
              decoration: InputDecoration(
                  labelText: "Location", border: OutlineInputBorder()),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              controller: startTimeController,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                  labelText: "Start time", border: OutlineInputBorder()),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              controller: endTimeController,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                  labelText: "End time", border: OutlineInputBorder()),
            ),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }

  Event _createEventFromInputs() {
    return Event(
      name: nameController.text,
      location: locationController.text,
      startTime: convertStringToTimeOfDay(startTimeController.text),
      endTime: convertStringToTimeOfDay(endTimeController.text),
    );
  }
}
