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
    ).showSnackBar(const SnackBar(content: Text('Hatırlatma ayarlandı')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hatırlatma Ayarı')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Hatırlatma saati seç:', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _pickTime,
              child: Text('Seçili Saat: ${_selectedTime.format(context)}'),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: _saveReminder,
              icon: const Icon(Icons.alarm),
              label: const Text('Hatırlatma Ayarla'),
            ),
          ],
        ),
      ),
    );
  }
}
