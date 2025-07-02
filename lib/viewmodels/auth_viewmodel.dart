import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../app/locator.dart';

enum AuthState { idle, busy, success, error }

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = locator<AuthService>();

  // Controllers to be bound from UI
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  AuthState _state = AuthState.idle;
  String? _errorMessage;

  AuthState get state => _state;
  String? get errorMessage => _errorMessage;

  void _setState(AuthState s) {
    _state = s;
    notifyListeners();
  }

  /// Login process
  Future<bool> login() async {
    _setState(AuthState.busy);
    try {
      final user = await _authService.login(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      if (user != null) {
        _setState(AuthState.success);
        return true;
      } else {
        _errorMessage = 'Kullanıcı bulunamadı.';
        _setState(AuthState.error);
        return false;
      }
    } on AuthException catch (e) {
      _errorMessage = e.message;
      _setState(AuthState.error);
      return false;
    } catch (e) {
      _errorMessage = 'Beklenmeyen bir hata oluştu.';
      _setState(AuthState.error);
      return false;
    }
  }

  /// Register process
  Future<bool> register() async {
    _setState(AuthState.busy);
    try {
      final user = await _authService.register(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      if (user != null) {
        _setState(AuthState.success);
        return true;
      } else {
        _errorMessage = 'Kayıt sırasında sorun oluştu.';
        _setState(AuthState.error);
        return false;
      }
    } on AuthException catch (e) {
      _errorMessage = e.message;
      _setState(AuthState.error);
      return false;
    } catch (e) {
      _errorMessage = 'Beklenmeyen bir hata oluştu.';
      _setState(AuthState.error);
      return false;
    }
  }

  /// Logout process
  Future<void> signOut() async {
    await _authService.signOut();
    _setState(AuthState.idle);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    super.dispose();
  }
}
