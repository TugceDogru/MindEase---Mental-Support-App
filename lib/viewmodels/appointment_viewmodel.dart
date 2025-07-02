import 'package:flutter/material.dart';
import '../app/locator.dart';
import '../models/appointment_model.dart';
import '../services/firestore_service.dart';
import 'package:intl/intl.dart';

enum AppointmentState { idle, picking, booking, success, error }

class AppointmentViewModel extends ChangeNotifier {
  final FirestoreService _db = locator<FirestoreService>();

  AppointmentState _state = AppointmentState.idle;
  String? _error;
  DateTime? selectedDateTime;
  bool isOnline = true;

  AppointmentState get state => _state;
  String? get error => _error;

  void _setState(AppointmentState s, [String? msg]) {
    _state = s;
    _error = msg;
    notifyListeners();
  }

  /// Open date and time picker
  Future<void> pickDateTime(BuildContext context) async {
    _setState(AppointmentState.picking);
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 60)),
    );
    if (date == null) {
      _setState(AppointmentState.idle);
      return;
    }

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 10, minute: 0),
    );
    if (time == null) {
      _setState(AppointmentState.idle);
      return;
    }

    selectedDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    _setState(AppointmentState.idle);
  }

  /// Save appointment
  Future<bool> book({required String expertId, required String userId}) async {
    if (selectedDateTime == null) {
      _setState(AppointmentState.error, 'You must select date and time.');
      return false;
    }
    _setState(AppointmentState.booking);
    try {
      final appt = Appointment(
        id: '', // Comes with Firestore auto-ID
        expertId: expertId,
        userId: userId,
        scheduledAt: selectedDateTime!,
        isOnline: isOnline,
      );
      await _db.createAppointment(appt);
      _setState(AppointmentState.success);
      return true;
    } catch (e) {
      _setState(AppointmentState.error, e.toString());
      return false;
    }
  }

  String get formattedDate =>
      selectedDateTime == null
          ? 'Select'
          : DateFormat('dd MMM yyyy – HH:mm').format(selectedDateTime!);
}
