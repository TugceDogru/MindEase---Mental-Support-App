import 'package:flutter/material.dart';
import '../app/locator.dart';
import '../models/user_model.dart';
import '../services/firestore_service.dart';

enum ProfileState { idle, busy, success, error }

class ProfileViewModel extends ChangeNotifier {
  final FirestoreService _db = locator<FirestoreService>();

  ProfileState _state = ProfileState.idle;
  String? _errorMessage;

  ProfileState get state => _state;
  String? get errorMessage => _errorMessage;

  UserModel? user;
  final TextEditingController displayNameController = TextEditingController();

  void _setState(ProfileState s, [String? msg]) {
    _state = s;
    _errorMessage = msg;
    notifyListeners();
  }

  /// Loads the user and assigns to controller.
  /// Calls the update method.
  Future<void> loadUser(String uid) async {
    _setState(ProfileState.busy);
    try {
      user = await _db.getUserProfile(uid);
      displayNameController.text = user?.displayName ?? '';
      _setState(ProfileState.idle);
    } catch (e) {
      _setState(ProfileState.error, e.toString());
    }
  }

  /// Calls the update method.
  Future<bool> updateProfile() async {
    if (user == null) return false;
    _setState(ProfileState.busy);
    try {
      user!.displayName = displayNameController.text.trim();
      await _db.updateUserProfile(user!);
      _setState(ProfileState.success);
      return true;
    } catch (e) {
      _setState(ProfileState.error, e.toString());
      return false;
    }
  }

  @override
  void dispose() {
    displayNameController.dispose();
    super.dispose();
  }
}
