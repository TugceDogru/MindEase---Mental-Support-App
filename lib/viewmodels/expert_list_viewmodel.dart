import 'package:flutter/material.dart';
import '../app/locator.dart';
import '../models/expert_profile_model.dart';
import '../services/firestore_service.dart';

enum ExpertListState { idle, busy, error }

class ExpertListViewModel extends ChangeNotifier {
  final FirestoreService _db = locator<FirestoreService>();

  ExpertListState _state = ExpertListState.idle;
  String? _error;
  List<ExpertProfile> experts = [];

  ExpertListState get state => _state;
  String? get error => _error;

  void _setState(ExpertListState s, [String? msg]) {
    _state = s;
    _error = msg;
    notifyListeners();
  }

  Future<void> loadExperts() async {
    _setState(ExpertListState.busy);
    try {
      experts = await _db.getExpertProfiles();
      _setState(ExpertListState.idle);
    } catch (e) {
      _setState(ExpertListState.error, e.toString());
    }
  }
}
