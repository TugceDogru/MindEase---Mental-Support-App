import 'package:cloud_firestore/cloud_firestore.dart';

class MoodLog {
  final String id;
  final String userId;
  final DateTime timestamp;
  final String mood; // e.g. 'happy', 'sad', 'angry'
  final String? note;

  MoodLog({
    required this.id,
    required this.userId,
    required this.timestamp,
    required this.mood,
    this.note,
  });

  Map<String, dynamic> toMap() => {
    'userId': userId,
    'timestamp': timestamp.toUtc(),
    'mood': mood,
    'note': note,
  };

  factory MoodLog.fromDoc(String id, Map<String, dynamic> map) {
    return MoodLog(
      id: id,
      userId: map['userId'] as String,
      timestamp: (map['timestamp'] as Timestamp).toDate(),
      mood: map['mood'] as String,
      note: map['note'] as String?,
    );
  }

  static Future<List<MoodLog>> fromFirestore(QueryDocumentSnapshot<Object?> doc) {}
}
