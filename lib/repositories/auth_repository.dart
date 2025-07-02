import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mind_ease/utils/enums.dart';
import '../models/user_model.dart';
import '../models/user_details.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Get current user stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Check if user is logged in
  bool get isLoggedIn => _auth.currentUser != null;

  // Register new user
  Future<UserCredential> registerUser({
    required String email,
    required String password,
    required String username,
    required String fullName,
  }) async {
    try {
      // Create user with email and password
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Create user profile in Firestore
      final UserModel userModel = UserModel(
        id: userCredential.user!.uid,
        email: email,
        username: username,
        fullName: fullName,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isActive: true,
        role: UserRole.user,
        profileCompleted: false, uid: '',
      );

      await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(userModel.toFirestore());

      // Create user details document
      final UserDetails userDetails = UserDetails(
        userId: userCredential.user!.uid,
        bio: '',
        avatar: '',
        phoneNumber: '',
        dateOfBirth: null,
        gender: Gender.notSpecified,
        location: '',
        interests: [],
        emergencyContact: '',
        emergencyPhone: '',
        preferences: {},
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(), email: '', name: '',
      );

      await _firestore
          .collection('user_details')
          .doc(userCredential.user!.uid)
          .set(userDetails.toFirestore());

      return userCredential;
    } catch (e) {
      throw _handleAuthError(e);
    }
  }

  // Login user
  Future<UserCredential> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update last login time
      await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .update({
        'lastLoginAt': Timestamp.fromDate(DateTime.now()),
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });

      return userCredential;
    } catch (e) {
      throw _handleAuthError(e);
    }
  }

  // Login with Google
  Future<UserCredential> loginWithGoogle() async {
    try {
      // This would require google_sign_in package
      // For now, we'll throw an error
      throw Exception('Google sign-in not implemented yet');
    } catch (e) {
      throw _handleAuthError(e);
    }
  }

  // Logout user
  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw _handleAuthError(e);
    }
  }

  // Reset password
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw _handleAuthError(e);
    }
  }

  // Update password
  Future<void> updatePassword(String newPassword) async {
    try {
      await _auth.currentUser!.updatePassword(newPassword);
    } catch (e) {
      throw _handleAuthError(e);
    }
  }

  // Update email
  Future<void> updateEmail(String newEmail) async {
    try {
      await _auth.currentUser!.updateEmail(newEmail);
      
      // Update email in Firestore
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .update({
        'email': newEmail,
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
    } catch (e) {
      throw _handleAuthError(e);
    }
  }

  // Get user model from Firestore
  Future<UserModel?> getUserModel(String userId) async {
    try {
      final DocumentSnapshot doc = await _firestore
          .collection('users')
          .doc(userId)
          .get();

      if (doc.exists) {
        return UserModel.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get user model: $e');
    }
  }

  // Get current user model
  Future<UserModel?> getCurrentUserModel() async {
    if (!isLoggedIn) return null;
    return await getUserModel(_auth.currentUser!.uid);
  }

  // Get user details from Firestore
  Future<UserDetails?> getUserDetails(String userId) async {
    try {
      final DocumentSnapshot doc = await _firestore
          .collection('user_details')
          .doc(userId)
          .get();

      if (doc.exists) {
        return UserDetails.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get user details: $e');
    }
  }

  // Get current user details
  Future<UserDetails?> getCurrentUserDetails() async {
    if (!isLoggedIn) return null;
    return await getUserDetails(_auth.currentUser!.uid);
  }

  // Update user profile
  Future<void> updateUserProfile({
    String? username,
    String? fullName,
    String? bio,
    String? avatar,
    String? phoneNumber,
    DateTime? dateOfBirth,
    Gender? gender,
    String? location,
    List<String>? interests,
    String? emergencyContact,
    String? emergencyPhone,
    Map<String, dynamic>? preferences,
  }) async {
    if (!isLoggedIn) throw Exception('User not logged in');

    try {
      final String userId = _auth.currentUser!.uid;
      final batch = _firestore.batch();

      // Update user model
      final Map<String, dynamic> userUpdates = {
        'updatedAt': Timestamp.fromDate(DateTime.now()),
        'profileCompleted': true,
      };

      if (username != null) userUpdates['username'] = username;
      if (fullName != null) userUpdates['fullName'] = fullName;

      batch.update(
        _firestore.collection('users').doc(userId),
        userUpdates,
      );

      // Update user details
      final Map<String, dynamic> detailsUpdates = {
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      };

      if (bio != null) detailsUpdates['bio'] = bio;
      if (avatar != null) detailsUpdates['avatar'] = avatar;
      if (phoneNumber != null) detailsUpdates['phoneNumber'] = phoneNumber;
      if (dateOfBirth != null) detailsUpdates['dateOfBirth'] = Timestamp.fromDate(dateOfBirth);
      if (gender != null) detailsUpdates['gender'] = gender.toString().split('.').last;
      if (location != null) detailsUpdates['location'] = location;
      if (interests != null) detailsUpdates['interests'] = interests;
      if (emergencyContact != null) detailsUpdates['emergencyContact'] = emergencyContact;
      if (emergencyPhone != null) detailsUpdates['emergencyPhone'] = emergencyPhone;
      if (preferences != null) detailsUpdates['preferences'] = preferences;

      batch.update(
        _firestore.collection('user_details').doc(userId),
        detailsUpdates,
      );

      await batch.commit();
    } catch (e) {
      throw Exception('Failed to update user profile: $e');
    }
  }

  // Delete user account
  Future<void> deleteUserAccount() async {
    if (!isLoggedIn) throw Exception('User not logged in');

    try {
      final String userId = _auth.currentUser!.uid;

      // Delete user data from Firestore
      final batch = _firestore.batch();
      
      batch.delete(_firestore.collection('users').doc(userId));
      batch.delete(_firestore.collection('user_details').doc(userId));
      
      // Delete user posts
      final QuerySnapshot posts = await _firestore
          .collection('posts')
          .where('authorId', isEqualTo: userId)
          .get();
      
      for (final doc in posts.docs) {
        batch.delete(doc.reference);
      }

      // Delete user rooms
      final QuerySnapshot rooms = await _firestore
          .collection('rooms')
          .where('userId', isEqualTo: userId)
          .get();
      
      for (final doc in rooms.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();

      // Delete Firebase Auth user
      await _auth.currentUser!.delete();
    } catch (e) {
      throw Exception('Failed to delete user account: $e');
    }
  }

  // Check if username is available
  Future<bool> isUsernameAvailable(String username) async {
    try {
      final QuerySnapshot result = await _firestore
          .collection('users')
          .where('username', isEqualTo: username)
          .get();

      return result.docs.isEmpty;
    } catch (e) {
      throw Exception('Failed to check username availability: $e');
    }
  }

  // Get user by username
  Future<UserModel?> getUserByUsername(String username) async {
    try {
      final QuerySnapshot result = await _firestore
          .collection('users')
          .where('username', isEqualTo: username)
          .limit(1)
          .get();

      if (result.docs.isNotEmpty) {
        return UserModel.fromFirestore(result.docs.first);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get user by username: $e');
    }
  }

  // Handle authentication errors
  Exception _handleAuthError(dynamic error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'user-not-found':
          return Exception('No user found with this email address.');
        case 'wrong-password':
          return Exception('Wrong password provided.');
        case 'email-already-in-use':
          return Exception('An account already exists with this email address.');
        case 'weak-password':
          return Exception('The password provided is too weak.');
        case 'invalid-email':
          return Exception('The email address is not valid.');
        case 'user-disabled':
          return Exception('This user account has been disabled.');
        case 'too-many-requests':
          return Exception('Too many requests. Please try again later.');
        case 'operation-not-allowed':
          return Exception('This operation is not allowed.');
        default:
          return Exception('Authentication failed: ${error.message}');
      }
    }
    return Exception('Authentication failed: $error');
  }
}
