import 'package:flutter/material.dart';
import '../model/event.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final Function update;
  final Function delete;

  EventCard({this.event, this.update, this.delete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  event.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 3.0),
                Text(event.startTime.toString().substring(10, 15) +
                    "-" +
                    event.endTime.toString().substring(10, 15)),
                SizedBox(height: 3.0),
                Text(event.location)
              ],
            ),
            Row(
              children: <Widget>[
                FlatButton.icon(
                    onPressed: update, icon: Icon(Icons.edit), label: Text("")),
                FlatButton.icon(
                    onPressed: delete,
                    icon: Icon(Icons.delete),
                    label: Text("")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
