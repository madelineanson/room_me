import 'package:flutter/material.dart';

class RoommateEvent {
  final String title;
  final String description;
  final String priority;
  final String assignedTo;
  final String assignedBy;
  final DateTime date;

  RoommateEvent({
    required this.title,
    required this.description,
    required this.priority,
    required this.assignedTo,
    required this.assignedBy,
    required this.date,
  });

  @override
  String toString() => title;
}

class EventDetailsPage extends StatelessWidget {
  final RoommateEvent event;

  const EventDetailsPage({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    String priority = event.priority; // Get the event's priority value

    Color priorityColor;
    switch (priority.toLowerCase()) {
      case 'high':
        priorityColor = Colors.red;
        break;
      case 'medium':
        priorityColor = Colors.orange;
        break;
      case 'low':
        priorityColor = Colors.green;
        break;
      default:
        priorityColor = Colors.black; // Default to black if no match
    }

    return Scaffold(
      appBar: AppBar(title: Text(event.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Description: ${event.description}"),
            Text("Date: ${event.date.toLocal()}"),
            Text(
              "Priority: ${event.priority}",
              style: TextStyle(color: priorityColor),
            ),
            Text("Assigned To: ${event.assignedTo}"),
            Text("Assigned By: ${event.assignedBy}"),
          ],
        ),
      ),
    );
  }
}
