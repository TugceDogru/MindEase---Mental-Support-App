import 'package:flutter/material.dart';
import '../../services/notification_service.dart';
import '../../app/locator.dart';

class ReminderSettingsView extends StatefulWidget {
  const ReminderSettingsView({super.key});

  @override
  State<ReminderSettingsView> createState() => _ReminderSettingsViewState();
}

class _ReminderSettingsViewState extends State<ReminderSettingsView> {
  TimeOfDay _selectedTime = const TimeOfDay(hour: 20, minute: 0);
  final NotificationService _notificationService =
      locator<NotificationService>();

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Future<void> _saveReminder() async {
    await _notificationService.scheduleCustomDailyReminder(_selectedTime);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Reminder set')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reminder Setting')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Select reminder time:', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _pickTime,
              child: Text('Selected Time: ${_selectedTime.format(context)}'),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: _saveReminder,
              icon: const Icon(Icons.alarm),
              label: const Text('Set Reminder'),
            ),
          ],
        ),
      ),
    );
  }
}
