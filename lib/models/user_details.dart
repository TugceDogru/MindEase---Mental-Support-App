import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetails {
  final String email;
  final String name;

  UserDetails({required this.email, required this.name});

  factory UserDetails.fromMap(Map<String, dynamic> m) {
    return UserDetails(email: m['email'] as String, name: m['name'] as String);
  }

  static Future<UserDetails?> fromFirestore(DocumentSnapshot<Object?> doc) {}
}
