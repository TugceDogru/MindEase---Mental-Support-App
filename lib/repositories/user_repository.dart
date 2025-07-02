import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../models/user_details.dart';
import '../models/mood_log_model.dart';
import '../models/post_model.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get user by ID
  Future<UserModel?> getUserById(String userId) async {
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
      throw Exception('Failed to get user: $e');
    }
  }

  // Get user details by ID
  Future<UserDetails?> getUserDetailsById(String userId) async {
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

  // Get user by email
  Future<UserModel?> getUserByEmail(String email) async {
    try {
      final QuerySnapshot result = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (result.docs.isNotEmpty) {
        return UserModel.fromFirestore(result.docs.first);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get user by email: $e');
    }
  }

  // Update user profile
  Future<void> updateUserProfile(String userId, Map<String, dynamic> updates) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .update({
        ...updates,
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
    } catch (e) {
      throw Exception('Failed to update user profile: $e');
    }
  }

  // Update user details
  Future<void> updateUserDetails(String userId, Map<String, dynamic> updates) async {
    try {
      await _firestore
          .collection('user_details')
          .doc(userId)
          .update({
        ...updates,
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
    } catch (e) {
      throw Exception('Failed to update user details: $e');
    }
  }

  // Get user posts
  Future<List<Post>> getUserPosts(String userId, {int limit = 20}) async {
    try {
      final QuerySnapshot result = await _firestore
          .collection('posts')
          .where('authorId', isEqualTo: userId)
          .where('status', isEqualTo: 'active')
          .orderBy('createdAt', descending: true)
          .limit(limit)
          .get();

      return result.docs.map((doc) => Post.fromFirestore(doc)).toList();
    } catch (e) {
      throw Exception('Failed to get user posts: $e');
    }
  }

  // Get user mood logs
  Future<List<MoodLog>> getUserMoodLogs(String userId, {
    DateTime? startDate,
    DateTime? endDate,
    int limit = 30,
  }) async {
    try {
      Query query = _firestore
          .collection('mood_logs')
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .limit(limit);

      if (startDate != null) {
        query = query.where('createdAt', isGreaterThanOrEqualTo: Timestamp.fromDate(startDate));
      }

      if (endDate != null) {
        query = query.where('createdAt', isLessThanOrEqualTo: Timestamp.fromDate(endDate));
      }

      final QuerySnapshot result = await query.get();
      return result.docs.map((doc) => MoodLog.fromFirestore(doc)).toList();
    } catch (e) {
      throw Exception('Failed to get user mood logs: $e');
    }
  }

  // Get user mood analytics
  Future<Map<String, dynamic>> getUserMoodAnalytics(String userId, {
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final List<MoodLog> moodLogs = await getUserMoodLogs(
        userId,
        startDate: startDate,
        endDate: endDate,
        limit: 100,
      );

      if (moodLogs.isEmpty) {
        return {
          'averageMood': 0.0,
          'totalEntries': 0,
          'moodDistribution': {},
          'trend': 'stable',
        };
      }

      // Calculate average mood
      final double averageMood = moodLogs
          .map((log) => log.averageScore)
          .reduce((a, b) => a + b) / moodLogs.length;

      // Calculate mood distribution
      final Map<String, int> moodDistribution = {};
      for (final log in moodLogs) {
        final String moodLevel = _getMoodLevel(log.averageScore);
        moodDistribution[moodLevel] = (moodDistribution[moodLevel] ?? 0) + 1;
      }

      // Calculate trend
      final String trend = _calculateMoodTrend(moodLogs);

      return {
        'averageMood': averageMood,
        'totalEntries': moodLogs.length,
        'moodDistribution': moodDistribution,
        'trend': trend,
        'lastEntry': moodLogs.first.createdAt,
        'firstEntry': moodLogs.last.createdAt,
      };
    } catch (e) {
      throw Exception('Failed to get user mood analytics: $e');
    }
  }

  // Get user statistics
  Future<Map<String, dynamic>> getUserStatistics(String userId) async {
    try {
      // Get user posts count
      final QuerySnapshot postsResult = await _firestore
          .collection('posts')
          .where('authorId', isEqualTo: userId)
          .where('status', isEqualTo: 'active')
          .get();

      // Get user mood logs count
      final QuerySnapshot moodLogsResult = await _firestore
          .collection('mood_logs')
          .where('userId', isEqualTo: userId)
          .get();

      // Get user rooms count
      final QuerySnapshot roomsResult = await _firestore
          .collection('rooms')
          .where('userId', isEqualTo: userId)
          .where('status', isEqualTo: 'active')
          .get();

      // Calculate total likes received
      int totalLikes = 0;
      for (final doc in postsResult.docs) {
        final post = Post.fromFirestore(doc);
        totalLikes += post.likeCount;
      }

      return {
        'postsCount': postsResult.docs.length,
        'moodLogsCount': moodLogsResult.docs.length,
        'roomsCount': roomsResult.docs.length,
        'totalLikes': totalLikes,
        'averageLikesPerPost': postsResult.docs.isNotEmpty 
            ? totalLikes / postsResult.docs.length 
            : 0.0,
      };
    } catch (e) {
      throw Exception('Failed to get user statistics: $e');
    }
  }

  // Search users
  Future<List<UserModel>> searchUsers(String query, {int limit = 20}) async {
    try {
      // Search by username (starts with)
      final QuerySnapshot usernameResult = await _firestore
          .collection('users')
          .where('username', isGreaterThanOrEqualTo: query)
          .where('username', isLessThan: query + '\uf8ff')
          .where('isActive', isEqualTo: true)
          .limit(limit)
          .get();

      // Search by full name (contains)
      final QuerySnapshot nameResult = await _firestore
          .collection('users')
          .where('fullName', isGreaterThanOrEqualTo: query)
          .where('fullName', isLessThan: query + '\uf8ff')
          .where('isActive', isEqualTo: true)
          .limit(limit)
          .get();

      // Combine and deduplicate results
      final Set<String> seenIds = {};
      final List<UserModel> results = [];

      for (final doc in usernameResult.docs) {
        if (!seenIds.contains(doc.id)) {
          seenIds.add(doc.id);
          results.add(UserModel.fromFirestore(doc));
        }
      }

      for (final doc in nameResult.docs) {
        if (!seenIds.contains(doc.id)) {
          seenIds.add(doc.id);
          results.add(UserModel.fromFirestore(doc));
        }
      }

      return results.take(limit).toList();
    } catch (e) {
      throw Exception('Failed to search users: $e');
    }
  }

  // Get users by role
  Future<List<UserModel>> getUsersByRole(UserRole role, {int limit = 50}) async {
    try {
      final QuerySnapshot result = await _firestore
          .collection('users')
          .where('role', isEqualTo: role.toString().split('.').last)
          .where('isActive', isEqualTo: true)
          .orderBy('createdAt', descending: true)
          .limit(limit)
          .get();

      return result.docs.map((doc) => UserModel.fromFirestore(doc)).toList();
    } catch (e) {
      throw Exception('Failed to get users by role: $e');
    }
  }

  // Get online users
  Future<List<UserModel>> getOnlineUsers({int limit = 50}) async {
    try {
      final DateTime fiveMinutesAgo = DateTime.now().subtract(Duration(minutes: 5));
      
      final QuerySnapshot result = await _firestore
          .collection('users')
          .where('lastSeenAt', isGreaterThan: Timestamp.fromDate(fiveMinutesAgo))
          .where('isActive', isEqualTo: true)
          .orderBy('lastSeenAt', descending: true)
          .limit(limit)
          .get();

      return result.docs.map((doc) => UserModel.fromFirestore(doc)).toList();
    } catch (e) {
      throw Exception('Failed to get online users: $e');
    }
  }

  // Update user last seen
  Future<void> updateUserLastSeen(String userId) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .update({
        'lastSeenAt': Timestamp.fromDate(DateTime.now()),
      });
    } catch (e) {
      // Silently fail for last seen updates
      print('Failed to update last seen: $e');
    }
  }

  // Block user
  Future<void> blockUser(String userId, String blockedUserId) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .update({
        'blockedUsers': FieldValue.arrayUnion([blockedUserId]),
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
    } catch (e) {
      throw Exception('Failed to block user: $e');
    }
  }

  // Unblock user
  Future<void> unblockUser(String userId, String blockedUserId) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .update({
        'blockedUsers': FieldValue.arrayRemove([blockedUserId]),
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
    } catch (e) {
      throw Exception('Failed to unblock user: $e');
    }
  }

  // Check if user is blocked
  Future<bool> isUserBlocked(String userId, String otherUserId) async {
    try {
      final UserModel? user = await getUserById(userId);
      return user?.blockedUsers.contains(otherUserId) ?? false;
    } catch (e) {
      return false;
    }
  }

  // Get user followers
  Future<List<UserModel>> getUserFollowers(String userId, {int limit = 50}) async {
    try {
      final QuerySnapshot result = await _firestore
          .collection('users')
          .where('following', arrayContains: userId)
          .where('isActive', isEqualTo: true)
          .limit(limit)
          .get();

      return result.docs.map((doc) => UserModel.fromFirestore(doc)).toList();
    } catch (e) {
      throw Exception('Failed to get user followers: $e');
    }
  }

  // Get user following
  Future<List<UserModel>> getUserFollowing(String userId, {int limit = 50}) async {
    try {
      final UserModel? user = await getUserById(userId);
      if (user == null || user.following.isEmpty) return [];

      final QuerySnapshot result = await _firestore
          .collection('users')
          .where(FieldPath.documentId, whereIn: user.following.take(10).toList())
          .where('isActive', isEqualTo: true)
          .limit(limit)
          .get();

      return result.docs.map((doc) => UserModel.fromFirestore(doc)).toList();
    } catch (e) {
      throw Exception('Failed to get user following: $e');
    }
  }

  // Follow user
  Future<void> followUser(String userId, String targetUserId) async {
    try {
      final batch = _firestore.batch();

      // Add to following list
      batch.update(
        _firestore.collection('users').doc(userId),
        {
          'following': FieldValue.arrayUnion([targetUserId]),
          'updatedAt': Timestamp.fromDate(DateTime.now()),
        },
      );

      // Add to followers list
      batch.update(
        _firestore.collection('users').doc(targetUserId),
        {
          'followers': FieldValue.arrayUnion([userId]),
          'updatedAt': Timestamp.fromDate(DateTime.now()),
        },
      );

      await batch.commit();
    } catch (e) {
      throw Exception('Failed to follow user: $e');
    }
  }

  // Unfollow user
  Future<void> unfollowUser(String userId, String targetUserId) async {
    try {
      final batch = _firestore.batch();

      // Remove from following list
      batch.update(
        _firestore.collection('users').doc(userId),
        {
          'following': FieldValue.arrayRemove([targetUserId]),
          'updatedAt': Timestamp.fromDate(DateTime.now()),
        },
      );

      // Remove from followers list
      batch.update(
        _firestore.collection('users').doc(targetUserId),
        {
          'followers': FieldValue.arrayRemove([userId]),
          'updatedAt': Timestamp.fromDate(DateTime.now()),
        },
      );

      await batch.commit();
    } catch (e) {
      throw Exception('Failed to unfollow user: $e');
    }
  }

  // Helper method to get mood level
  String _getMoodLevel(double score) {
    if (score >= 4.0) return 'Excellent';
    if (score >= 3.0) return 'Good';
    if (score >= 2.0) return 'Fair';
    if (score >= 1.0) return 'Poor';
    return 'Very Poor';
  }

  // Helper method to calculate mood trend
  String _calculateMoodTrend(List<MoodLog> moodLogs) {
    if (moodLogs.length < 2) return 'stable';

    final recentLogs = moodLogs.take(7).toList();
    final olderLogs = moodLogs.skip(7).take(7).toList();

    if (recentLogs.length < 2 || olderLogs.length < 2) return 'stable';

    final double recentAverage = recentLogs
        .map((log) => log.averageScore)
        .reduce((a, b) => a + b) / recentLogs.length;

    final double olderAverage = olderLogs
        .map((log) => log.averageScore)
        .reduce((a, b) => a + b) / olderLogs.length;

    final double difference = recentAverage - olderAverage;

    if (difference > 0.5) return 'improving';
    if (difference < -0.5) return 'declining';
    return 'stable';
  }
}
