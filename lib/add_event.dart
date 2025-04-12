import 'package:flutter/material.dart';
import 'package:room_me/utils.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _assignedToController = TextEditingController();
  final TextEditingController _assignedByController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _priority = 'Medium';
  DateTime? _selectedDate;

  void _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _saveEvent() {
    if (_titleController.text.isEmpty ||
        _assignedToController.text.isEmpty ||
        _assignedByController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill out all fields.")),
      );
      return;
    }

    final newEvent = Event(
      title: _titleController.text,
      assignedTo: _assignedToController.text,
      assignedBy: _assignedByController.text,
      description: _descriptionController.text,
      priority: _priority,
    );

    Navigator.pop(context, {'date': _selectedDate, 'event': newEvent});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Event")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: "Event Title"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _assignedToController,
              decoration: const InputDecoration(labelText: "Assigned To"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _assignedByController,
              decoration: const InputDecoration(labelText: "Assigned By"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: "Description",
                alignLabelWithHint: true,
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _priority,
              items:
                  ['Low', 'Medium', 'High']
                      .map(
                        (level) =>
                            DropdownMenuItem(value: level, child: Text(level)),
                      )
                      .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _priority = value;
                  });
                }
              },
              decoration: const InputDecoration(labelText: "Priority"),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _pickDate,
                  child: const Text("Pick Date"),
                ),
                const SizedBox(width: 12),
                Text(
                  _selectedDate == null
                      ? "No date selected"
                      : "${_selectedDate!.month}/${_selectedDate!.day}/${_selectedDate!.year}",
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _saveEvent,
              child: const Text("Save Event"),
            ),
          ],
        ),
      ),
    );
  }
}
