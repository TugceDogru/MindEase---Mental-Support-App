import 'package:flutter/material.dart';
import 'package:mind_ease/views/home/appointment_view.dart';
import 'package:mind_ease/views/home/expert_list_view.dart';
import 'package:mind_ease/views/mood/activity_view.dart';
import 'package:mind_ease/views/profile/profile_view.dart';
import 'package:mind_ease/views/mood/reminder_settings_view.dart';
import 'package:mind_ease/views/rooms/room_list_view.dart';

// Auth
import '../views/auth/login_view.dart';
import '../views/auth/register_view.dart';

// Home
import '../views/home/home_view.dart';

class Routes {
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String experts = '/experts';
  static const String appointment = '/appointment';
  static const String moodActivity = '/mood';
  static const String reminderSettings = '/reminder';
  static const String roomList = '/rooms';

  static final Map<String, WidgetBuilder> routes = {
    login: (context) => LoginView(),
    register: (context) => RegisterView(),
    home: (context) => HomeView(),
    profile: (context) => ProfileView(),
    experts: (c) => ExpertListView(),
    appointment: (c) => AppointmentView(),
    moodActivity: (context) => ActivityView(),
    reminderSettings: (context) => const ReminderSettingsView(),

    roomList: (context) => RoomListView(),
  };
}
