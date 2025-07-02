import 'package:flutter/material.dart';
import '../app/locator.dart';
import '../services/firestore_service.dart';
import '../models/mood_log_model.dart';
import '../services/auth_service.dart';
import 'package:intl/intl.dart';
import '../utils/helpers.dart';

enum MoodState { idle, loading, saving, error }

class MoodViewModel extends ChangeNotifier {
  final FirestoreService _db = locator<FirestoreService>();
  final AuthService _auth = locator<AuthService>();

  MoodState _state = MoodState.idle;
  String? _errorMessage;
  List<MoodLog> _moodLogs = [];

  // User inputs
  String? selectedMood;
  final TextEditingController noteController = TextEditingController();

  MoodState get state => _state;
  String? get errorMessage => _errorMessage;
  List<MoodLog> get moodLogs => _moodLogs;

  void _setState(MoodState s, [String? error]) {
    _state = s;
    _errorMessage = error;
    notifyListeners();
  }

  /// Save mood log
  Future<bool> saveOrUpdateMood() async {
    if (selectedMood == null) {
      _setState(MoodState.error, "Please select a mood.");
      return false;
    }

    _setState(MoodState.saving);
    try {
      final log = MoodLog(
        id: todayLog?.id ?? '', // if empty, new record
        userId: _auth.currentUser!.uid,
        timestamp: DateTime.now(),
        mood: selectedMood!,
        note:
            noteController.text.trim().isEmpty
                ? null
                : noteController.text.trim(),
      );

      if (todayLog != null) {
        await _db.updateMoodLog(log); // 🔁 update if exists
      } else {
        await _db.saveMoodLog(log); // 🆕 save if not exists
      }

      _setState(MoodState.idle);
      return true;
    } catch (e) {
      _setState(MoodState.error, e.toString());
      return false;
    }
  }

  /// Fetch previous mood logs of the user
  Future<void> fetchMoodLogs() async {
    _setState(MoodState.loading);
    try {
      final uid = _auth.currentUser!.uid;
      _moodLogs = await _db.getMoodLogs(uid);
      
      // ➕ Autofill form
      final log = todayLog;
      if (log != null) {
        selectedMood = log.mood;
        noteController.text = log.note ?? '';
      }

      _setState(MoodState.idle);
    } catch (e) {
      _setState(MoodState.error, e.toString());
    }
  }

  void selectMood(String mood) {
    selectedMood = mood;
    notifyListeners();
  }

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  Map<String, double> get moodScoreByDay {
    final now = DateTime.now();
    final Map<String, double> scores = {
      'Mon': 0,
      'Tue': 0,
      'Wed': 0,
      'Thu': 0,
      'Fri': 0,
      'Sat': 0,
      'Sun': 0,
    };

    for (final log in _moodLogs) {
      final date = log.timestamp.toLocal();
      if (now.difference(date).inDays <= 6) {
        final day = DateFormat.E('tr_TR').format(date); // e.g. "Mon"
        scores[day] = getMoodScore(log.mood).toDouble();
      }
    }

    return scores;
  }

  bool get hasLoggedToday {
    final today = DateTime.now();
    return _moodLogs.any((log) {
      final logDate = log.timestamp.toLocal();
      return logDate.year == today.year &&
          logDate.month == today.month &&
          logDate.day == today.day;
    });
  }

  MoodLog? get todayLog {
    final today = DateTime.now();
    try {
      return _moodLogs.firstWhere(
        (log) =>
            log.timestamp.year == today.year &&
            log.timestamp.month == today.month &&
            log.timestamp.day == today.day,
      );
    } catch (_) {
      return null;
    }
  }
}
