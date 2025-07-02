import 'package:flutter/material.dart';
import '../services/notification_service.dart';
import '../app/locator.dart';

class NotificationViewModel extends ChangeNotifier {
  final _service = locator<NotificationService>();

  TimeOfDay selectedTime = TimeOfDay(hour: 20, minute: 0);

  Future<void> updateReminderTime(BuildContext context) async {
    final time = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (time != null) {
      selectedTime = time;
      notifyListeners();
      await _service.scheduleCustomDailyReminder(time);
    }
  }

  Future<void> disableReminders() async {
    await _service.cancelAllScheduledNotifications();
  }
}
