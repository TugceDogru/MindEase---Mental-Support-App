import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/post_model.dart';
import '../models/user_model.dart';

class PostRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create new post
  Future<Post> createPost({
    required String authorId,
    required String authorName,
    String? authorAvatar,
    required String content,
    List<String> images = const [],
    List<String> tags = const [],
    PostCategory category = PostCategory.general,
    bool isAnonymous = false,
  }) async {
    try {
      final DocumentReference docRef = _firestore.collection('posts').doc();
      
      final Post post = Post(
        id: docRef.id,
        authorId: authorId,
        authorName: authorName,
        authorAvatar: authorAvatar,
        content: content,
        images: images,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        tags: tags,
        category: category,
        isAnonymous: isAnonymous,
      );

      await docRef.set(post.toFirestore());
      return post;
    } catch (e) {
      throw Exception('Failed to create post: $e');
    }
  }

  // Get post by ID
  Future<Post?> getPostById(String postId) async {
    try {
      final DocumentSnapshot doc = await _firestore
          .collection('posts')
          .doc(postId)
          .get();

      if (doc.exists) {
        return Post.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get post: $e');
    }
  }

  // Get posts with pagination
  Future<List<Post>> getPosts({
    int limit = 20,
    DocumentSnapshot? lastDocument,
    PostCategory? category,
    String? authorId,
    List<String>? excludedUserIds,
  }) async {
    try {
      Query query = _firestore
          .collection('posts')
          .where('status', isEqualTo: 'active')
          .where('moderationStatus', isEqualTo: 'approved')
          .orderBy('createdAt', descending: true);

      if (category != null) {
        query = query.where('category', isEqualTo: category.toString().split('.').last);
      }

      if (authorId != null) {
        query = query.where('authorId', isEqualTo: authorId);
      }

      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument);
      }

      query = query.limit(limit);

      final QuerySnapshot result = await query.get();
      List<Post> posts = result.docs.map((doc) => Post.fromFirestore(doc)).toList();

      // Filter out posts from blocked users if excludedUserIds is provided
      if (excludedUserIds != null && excludedUserIds.isNotEmpty) {
        posts = posts.where((post) => !excludedUserIds.contains(post.authorId)).toList();
      }

      return posts;
    } catch (e) {
      throw Exception('Failed to get posts: $e');
    }
  }

  // Get trending posts
  Future<List<Post>> getTrendingPosts({int limit = 20}) async {
    try {
      final DateTime oneWeekAgo = DateTime.now().subtract(Duration(days: 7));
      
      final QuerySnapshot result = await _firestore
          .collection('posts')
          .where('status', isEqualTo: 'active')
          .where('moderationStatus', isEqualTo: 'approved')
          .where('createdAt', isGreaterThan: Timestamp.fromDate(oneWeekAgo))
          .orderBy('createdAt', descending: true)
          .limit(limit * 2) // Get more to filter by engagement
          .get();

      List<Post> posts = result.docs.map((doc) => Post.fromFirestore(doc)).toList();
      
      // Sort by engagement (likes + comments + shares)
      posts.sort((a, b) {
        final int engagementA = a.likeCount + a.commentCount + a.shareCount;
        final int engagementB = b.likeCount + b.commentCount + b.shareCount;
        return engagementB.compareTo(engagementA);
      });

      return posts.take(limit).toList();
    } catch (e) {
      throw Exception('Failed to get trending posts: $e');
    }
  }

  // Update post
  Future<void> updatePost(String postId, Map<String, dynamic> updates) async {
    try {
      await _firestore
          .collection('posts')
          .doc(postId)
          .update({
        ...updates,
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
    } catch (e) {
      throw Exception('Failed to update post: $e');
    }
  }

  // Delete post
  Future<void> deletePost(String postId) async {
    try {
      await _firestore
          .collection('posts')
          .doc(postId)
          .update({
        'status': 'deleted',
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
    } catch (e) {
      throw Exception('Failed to delete post: $e');
    }
  }

  // Like post
  Future<void> likePost(String postId, String userId) async {
    try {
      final DocumentReference postRef = _firestore.collection('posts').doc(postId);
      
      await _firestore.runTransaction((transaction) async {
        final DocumentSnapshot postDoc = await transaction.get(postRef);
        
        if (!postDoc.exists) {
          throw Exception('Post not found');
        }

        final Post post = Post.fromFirestore(postDoc);
        
        if (post.isLikedBy(userId)) {
          // Unlike post
          transaction.update(postRef, {
            'likeCount': FieldValue.increment(-1),
            'likedBy': FieldValue.arrayRemove([userId]),
            'updatedAt': Timestamp.fromDate(DateTime.now()),
          });
        } else {
          // Like post
          transaction.update(postRef, {
            'likeCount': FieldValue.increment(1),
            'likedBy': FieldValue.arrayUnion([userId]),
            'updatedAt': Timestamp.fromDate(DateTime.now()),
          });
        }
      });
    } catch (e) {
      throw Exception('Failed to like/unlike post: $e');
    }
  }

  // Increment comment count
  Future<void> incrementCommentCount(String postId) async {
    try {
      await _firestore
          .collection('posts')
          .doc(postId)
          .update({
        'commentCount': FieldValue.increment(1),
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
    } catch (e) {
      throw Exception('Failed to increment comment count: $e');
    }
  }

  // Increment share count
  Future<void> incrementShareCount(String postId) async {
    try {
      await _firestore
          .collection('posts')
          .doc(postId)
          .update({
        'shareCount': FieldValue.increment(1),
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
    } catch (e) {
      throw Exception('Failed to increment share count: $e');
    }
  }

  // Search posts
  Future<List<Post>> searchPosts(String query, {int limit = 20}) async {
    try {
      // Search in content
      final QuerySnapshot contentResult = await _firestore
          .collection('posts')
          .where('content', isGreaterThanOrEqualTo: query)
          .where('content', isLessThan: query + '\uf8ff')
          .where('status', isEqualTo: 'active')
          .where('moderationStatus', isEqualTo: 'approved')
          .orderBy('content')
          .limit(limit)
          .get();

      // Search in tags
      final QuerySnapshot tagsResult = await _firestore
          .collection('posts')
          .where('tags', arrayContains: query.toLowerCase())
          .where('status', isEqualTo: 'active')
          .where('moderationStatus', isEqualTo: 'approved')
          .orderBy('createdAt', descending: true)
          .limit(limit)
          .get();

      // Combine and deduplicate results
      final Set<String> seenIds = {};
      final List<Post> results = [];

      for (final doc in contentResult.docs) {
        if (!seenIds.contains(doc.id)) {
          seenIds.add(doc.id);
          results.add(Post.fromFirestore(doc));
        }
      }

      for (final doc in tagsResult.docs) {
        if (!seenIds.contains(doc.id)) {
          seenIds.add(doc.id);
          results.add(Post.fromFirestore(doc));
        }
      }

      // Sort by relevance (content matches first, then by date)
      results.sort((a, b) {
        final bool aHasContentMatch = a.content.toLowerCase().contains(query.toLowerCase());
        final bool bHasContentMatch = b.content.toLowerCase().contains(query.toLowerCase());
        
        if (aHasContentMatch && !bHasContentMatch) return -1;
        if (!aHasContentMatch && bHasContentMatch) return 1;
        
        return b.createdAt.compareTo(a.createdAt);
      });

      return results.take(limit).toList();
    } catch (e) {
      throw Exception('Failed to search posts: $e');
    }
  }

  // Get posts by category
  Future<List<Post>> getPostsByCategory(PostCategory category, {int limit = 20}) async {
    try {
      final QuerySnapshot result = await _firestore
          .collection('posts')
          .where('category', isEqualTo: category.toString().split('.').last)
          .where('status', isEqualTo: 'active')
          .where('moderationStatus', isEqualTo: 'approved')
          .orderBy('createdAt', descending: true)
          .limit(limit)
          .get();

      return result.docs.map((doc) => Post.fromFirestore(doc)).toList();
    } catch (e) {
      throw Exception('Failed to get posts by category: $e');
    }
  }

  // Get posts by tags
  Future<List<Post>> getPostsByTags(List<String> tags, {int limit = 20}) async {
    try {
      final List<Post> allPosts = [];
      
      for (final tag in tags) {
        final QuerySnapshot result = await _firestore
            .collection('posts')
            .where('tags', arrayContains: tag.toLowerCase())
            .where('status', isEqualTo: 'active')
            .where('moderationStatus', isEqualTo: 'approved')
            .orderBy('createdAt', descending: true)
            .limit(limit)
            .get();

        allPosts.addAll(result.docs.map((doc) => Post.fromFirestore(doc)));
      }

      // Remove duplicates and sort by date
      final Map<String, Post> uniquePosts = {};
      for (final post in allPosts) {
        uniquePosts[post.id] = post;
      }

      final List<Post> sortedPosts = uniquePosts.values.toList();
      sortedPosts.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      return sortedPosts.take(limit).toList();
    } catch (e) {
      throw Exception('Failed to get posts by tags: $e');
    }
  }

  // Report post
  Future<void> reportPost(String postId, String reporterId, String reason) async {
    try {
      await _firestore
          .collection('post_reports')
          .add({
        'postId': postId,
        'reporterId': reporterId,
        'reason': reason,
        'createdAt': Timestamp.fromDate(DateTime.now()),
        'status': 'pending',
      });
    } catch (e) {
      throw Exception('Failed to report post: $e');
    }
  }

  // Moderate post
  Future<void> moderatePost(String postId, ModerationStatus status, String reason) async {
    try {
      await _firestore
          .collection('posts')
          .doc(postId)
          .update({
        'moderationStatus': status.toString().split('.').last,
        'moderationReason': reason,
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
    } catch (e) {
      throw Exception('Failed to moderate post: $e');
    }
  }

  // Get posts for moderation
  Future<List<Post>> getPostsForModeration({int limit = 50}) async {
    try {
      final QuerySnapshot result = await _firestore
          .collection('posts')
          .where('moderationStatus', isEqualTo: 'pending')
          .orderBy('createdAt', descending: true)
          .limit(limit)
          .get();

      return result.docs.map((doc) => Post.fromFirestore(doc)).toList();
    } catch (e) {
      throw Exception('Failed to get posts for moderation: $e');
    }
  }

  // Get user's liked posts
  Future<List<Post>> getUserLikedPosts(String userId, {int limit = 20}) async {
    try {
      final QuerySnapshot result = await _firestore
          .collection('posts')
          .where('likedBy', arrayContains: userId)
          .where('status', isEqualTo: 'active')
          .orderBy('createdAt', descending: true)
          .limit(limit)
          .get();

      return result.docs.map((doc) => Post.fromFirestore(doc)).toList();
    } catch (e) {
      throw Exception('Failed to get user liked posts: $e');
    }
  }

  // Get post statistics
  Future<Map<String, dynamic>> getPostStatistics(String postId) async {
    try {
      final Post? post = await getPostById(postId);
      if (post == null) {
        throw Exception('Post not found');
      }

      return {
        'likeCount': post.likeCount,
        'commentCount': post.commentCount,
        'shareCount': post.shareCount,
        'totalEngagement': post.likeCount + post.commentCount + post.shareCount,
        'createdAt': post.createdAt,
        'updatedAt': post.updatedAt,
      };
    } catch (e) {
      throw Exception('Failed to get post statistics: $e');
    }
  }

  // Pin post
  Future<void> pinPost(String postId, bool isPinned) async {
    try {
      await _firestore
          .collection('posts')
          .doc(postId)
          .update({
        'isPinned': isPinned,
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
    } catch (e) {
      throw Exception('Failed to pin/unpin post: $e');
    }
  }

  // Get pinned posts
  Future<List<Post>> getPinnedPosts({int limit = 10}) async {
    try {
      final QuerySnapshot result = await _firestore
          .collection('posts')
          .where('isPinned', isEqualTo: true)
          .where('status', isEqualTo: 'active')
          .where('moderationStatus', isEqualTo: 'approved')
          .orderBy('createdAt', descending: true)
          .limit(limit)
          .get();

      return result.docs.map((doc) => Post.fromFirestore(doc)).toList();
    } catch (e) {
      throw Exception('Failed to get pinned posts: $e');
    }
  }
}
