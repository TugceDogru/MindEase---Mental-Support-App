import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // FCM izinleri
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    print('İzin durumu: ${settings.authorizationStatus}');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('FCM bildirimi alındı: ${message.notification?.title}');
    });

    String? token = await _fcm.getToken();
    print('Firebase token: $token');

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const initSettings = InitializationSettings(android: androidSettings);
    await _localPlugin.initialize(initSettings);
  }

  /// Sabit 20:00'de hatırlatma (günlük)
  Future<void> scheduleDailyReminder() async {
    await _localPlugin.zonedSchedule(
      0,
      'Bugün ruh halini girmedin',
      'Hadi bir notla kendini ifade et!',
      _nextInstanceOfEightPM(),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_mood_channel',
          'Daily Mood Reminder',
          channelDescription: 'Her akşam mood girişini hatırlatır',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle, // NEW
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  /// Kullanıcının belirlediği saate göre hatırlatma
  Future<void> scheduleCustomDailyReminder(TimeOfDay time) async {
    final now = tz.TZDateTime.now(tz.local);
    final scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    await _localPlugin.zonedSchedule(
      0,
      'Bugün ruh halini girmedin',
      'Hadi bir notla kendini ifade et!',
      scheduledDate.isBefore(now)
          ? scheduledDate.add(Duration(days: 1))
          : scheduledDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_mood_channel',
          'Daily Mood Reminder',
          channelDescription: 'Her akşam mood girişini hatırlatır',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle, // NEW
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  tz.TZDateTime _nextInstanceOfEightPM() {
    final now = tz.TZDateTime.now(tz.local);
    final scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      20,
    );
    return scheduledDate.isBefore(now)
        ? scheduledDate.add(const Duration(days: 1))
        : scheduledDate;
  }

  Future<void> cancelAllScheduledNotifications() async {
    await _localPlugin.cancelAll();
    print('Tüm bildirimler iptal edildi');
  }
}
