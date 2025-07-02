import 'package:firebase_auth/firebase_auth.dart';
import 'native_channel_service.dart';
import '../models/user_details.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final NativeChannelService _native = NativeChannelService();

  /// Logs in with email/password and also fetches user details from native.
  Future<User?> login({required String email, required String password}) async {
    try {
      // 1) Sign in with Firebase
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user == null) {
        throw AuthException(
          code: 'NO_USER',
          message: 'Giriş yapıldı ama kullanıcı bilgisi boş döndü.',
        );
      }

      // 2) Get details via native channel
      final map = await _native.getUserDetails(uid: user.uid);
      final details = UserDetails.fromMap(map);

      // 3) Optionally print to console or log
      print(
        'Native’den gelen kullanıcı → email: ${details.email}, name: ${details.name}',
      );

      return user;
    } on FirebaseAuthException catch (e) {
      throw AuthException(
        code: e.code,
        message: e.message ?? 'Giriş başarısız',
      );
    } catch (e) {
      throw AuthException(code: 'unknown', message: e.toString());
    }
  }

  /// Registers with email/password and also fetches user details from native.
  Future<User?> register({
    required String email,
    required String password,
  }) async {
    try {
      // 1) Create new account with Firebase
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user == null) {
        throw AuthException(
          code: 'NO_USER',
          message: 'Kayıt yapıldı ama kullanıcı bilgisi boş döndü.',
        );
      }

      // 2) Get details via native channel
      final map = await _native.getUserDetails(uid: user.uid);
      final details = UserDetails.fromMap(map);

      print(
        'Native’den gelen yeni kullanıcı → email: ${details.email}, name: ${details.name}',
      );

      return user;
    } on FirebaseAuthException catch (e) {
      throw AuthException(
        code: e.code,
        message: e.message ?? 'Kayıt başarısız',
      );
    } catch (e) {
      throw AuthException(code: 'unknown', message: e.toString());
    }
  }

  /// Returns the current Firebase user.
  User? get currentUser => _auth.currentUser;

  /// Signs out.
  Future<void> signOut() async {
    await _auth.signOut();
  }
}

/// Simple exception carrying errors caught in AuthService
class AuthException implements Exception {
  final String code;
  final String message;
  AuthException({required this.code, required this.message});

  @override
  String toString() => 'AuthException($code): $message';
}
