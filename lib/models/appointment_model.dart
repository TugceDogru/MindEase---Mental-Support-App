import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  final String id;
  final String expertId;
  final String userId;
  final DateTime scheduledAt;
  final bool isOnline;

  Appointment({
    required this.id,
    required this.expertId,
    required this.userId,
    required this.scheduledAt,
    this.isOnline = true,
  });

  Map<String, dynamic> toMap() => {
    'expertId': expertId,
    'userId': userId,
    'scheduledAt': scheduledAt.toUtc(),
    'isOnline': isOnline,
  };

  factory Appointment.fromDoc(String id, Map<String, dynamic> map) {
    return Appointment(
      id: id,
      expertId: map['expertId'] as String,
      userId: map['userId'] as String,
      scheduledAt:
          (map['scheduledAt'] as Timestamp).toDate(), // import cloud_firestore
      isOnline: map['isOnline'] as bool? ?? true,
    );
  }
}
