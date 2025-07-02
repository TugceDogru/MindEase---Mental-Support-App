class ExpertProfile {
  final String uid;
  final String fullName;
  final String specialization;
  final String? photoUrl;

  ExpertProfile({
    required this.uid,
    required this.fullName,
    required this.specialization,
    this.photoUrl,
  });

  factory ExpertProfile.fromMap(Map<String, dynamic> map, String docId) {
    return ExpertProfile(
      uid: docId,
      fullName: map['fullName'] as String,
      specialization: map['specialization'] as String,
      photoUrl: map['photoUrl'] as String?,
    );
  }
}
