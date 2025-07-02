import 'package:flutter/material.dart';
import '../models/moderation_result_model.dart';
import '../services/moderation_service.dart';

class ModerationViewModel extends ChangeNotifier {
  final ModerationService _service = ModerationService();

  ModerationResult? _lastResult;
  List<ModerationResult> _history = [];

  ModerationResult? get lastResult => _lastResult;
  List<ModerationResult> get history => _history;

  Future<bool> moderate(String content) async {
    _lastResult = await _service.checkContent(content);
    _history.add(_lastResult!);
    notifyListeners();
    return _lastResult!.isAllowed;
  }

  void clearWarning() {
    _lastResult = null;
    notifyListeners();
  }
}
