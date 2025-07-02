import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mind_ease/models/mood_log_model.dart';
import '../models/user_model.dart';
import '../models/expert_profile_model.dart';
import '../models/appointment_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Fetches user profile.
  Future<UserModel> getUserProfile(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    if (!doc.exists) {
      throw Exception('Username not found');
    }
    return UserModel.fromMap(doc.data()!..['uid'] = uid);
  }

  /// Updates user profile.
  Future<void> updateUserProfile(UserModel user) {
    return _db.collection('users').doc(user.uid).update(user.toMap());
  }

  /// Returns all expert profiles.
  Future<List<ExpertProfile>> getExpertProfiles() async {
    final snap = await _db.collection('expert_profiles').get();
    return snap.docs.map((d) => ExpertProfile.fromMap(d.data(), d.id)).toList();
  }

  /// Creates a new appointment.
  Future<void> createAppointment(Appointment appt) {
    return _db.collection('appointments').add(appt.toMap());
  }

  /// Returns user's appointments (optional).
  Future<List<Appointment>> getUserAppointments(String userId) async {
    final snap =
        await _db
            .collection('appointments')
            .where('userId', isEqualTo: userId)
            .get();
    return snap.docs.map((d) => Appointment.fromDoc(d.id, d.data())).toList();
  }

  /// Saves new mood log
  Future<void> saveMoodLog(MoodLog log) async {
    await _db.collection('mood_logs').add(log.toMap());
  }

  /// Fetches user's mood logs (sorted by date)
  Future<List<MoodLog>> getMoodLogs(String userId) async {
    final snap =
        await _db
            .collection('mood_logs')
            .where('userId', isEqualTo: userId)
            .orderBy('timestamp', descending: true)
            .get();

    return snap.docs.map((d) => MoodLog.fromDoc(d.id, d.data())).toList();
  }
  
  Future<void> updateMoodLog(MoodLog log) async {
    await _db.collection('mood_logs').doc(log.id).update(log.toMap());
  }
  
}
