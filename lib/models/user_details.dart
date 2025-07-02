class UserDetails {
  final String email;
  final String name;

  UserDetails({required this.email, required this.name});

  factory UserDetails.fromMap(Map<String, dynamic> m) {
    return UserDetails(email: m['email'] as String, name: m['name'] as String);
  }
}
