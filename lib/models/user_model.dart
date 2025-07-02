import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  String? displayName;
  String? photoUrl;
  final bool isExpert;

  UserModel({
    required this.uid,
    required this.email,
    this.displayName,
    this.photoUrl,
    this.isExpert = false, required String username, required DateTime createdAt, required DateTime updatedAt, required bool profileCompleted, required role, required bool isActive, required String id,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      email: map['email'] as String,
      displayName: map['displayName'] as String?,
      photoUrl: map['photoUrl'] as String?,
      isExpert: map['isExpert'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'isExpert': isExpert,
    };
  }

  Map<String, dynamic> toFirestore() {}

  static Future<UserModel?> fromFirestore(DocumentSnapshot<Object?> doc) {}
}
