import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String authorId;
  final String authorName;
  final String? authorAvatar;
  final String content;
  final List<String> images;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int likeCount;
  final int commentCount;
  final int shareCount;
  final List<String> likedBy;
  final List<String> tags;
  final PostCategory category;
  final PostStatus status;
  final ModerationStatus moderationStatus;
  final String? moderationReason;
  final bool isAnonymous;
  final bool isPinned;
  final Map<String, dynamic> metadata;

  Post({
    required this.id,
    required this.authorId,
    required this.authorName,
    this.authorAvatar,
    required this.content,
    this.images = const [],
    required this.createdAt,
    required this.updatedAt,
    this.likeCount = 0,
    this.commentCount = 0,
    this.shareCount = 0,
    this.likedBy = const [],
    this.tags = const [],
    this.category = PostCategory.general,
    this.status = PostStatus.active,
    this.moderationStatus = ModerationStatus.pending,
    this.moderationReason,
    this.isAnonymous = false,
    this.isPinned = false,
    this.metadata = const {},
  });

  // Factory constructor to create Post from Firestore document
  factory Post.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    
    return Post(
      id: doc.id,
      authorId: data['authorId'] ?? '',
      authorName: data['authorName'] ?? '',
      authorAvatar: data['authorAvatar'],
      content: data['content'] ?? '',
      images: List<String>.from(data['images'] ?? []),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
      likeCount: data['likeCount'] ?? 0,
      commentCount: data['commentCount'] ?? 0,
      shareCount: data['shareCount'] ?? 0,
      likedBy: List<String>.from(data['likedBy'] ?? []),
      tags: List<String>.from(data['tags'] ?? []),
      category: PostCategory.values.firstWhere(
        (e) => e.toString() == 'PostCategory.${data['category']}',
        orElse: () => PostCategory.general,
      ),
      status: PostStatus.values.firstWhere(
        (e) => e.toString() == 'PostStatus.${data['status']}',
        orElse: () => PostStatus.active,
      ),
      moderationStatus: ModerationStatus.values.firstWhere(
        (e) => e.toString() == 'ModerationStatus.${data['moderationStatus']}',
        orElse: () => ModerationStatus.pending,
      ),
      moderationReason: data['moderationReason'],
      isAnonymous: data['isAnonymous'] ?? false,
      isPinned: data['isPinned'] ?? false,
      metadata: Map<String, dynamic>.from(data['metadata'] ?? {}),
    );
  }

  // Convert Post to Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'authorId': authorId,
      'authorName': authorName,
      'authorAvatar': authorAvatar,
      'content': content,
      'images': images,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'likeCount': likeCount,
      'commentCount': commentCount,
      'shareCount': shareCount,
      'likedBy': likedBy,
      'tags': tags,
      'category': category.toString().split('.').last,
      'status': status.toString().split('.').last,
      'moderationStatus': moderationStatus.toString().split('.').last,
      'moderationReason': moderationReason,
      'isAnonymous': isAnonymous,
      'isPinned': isPinned,
      'metadata': metadata,
    };
  }

  // Create a copy of Post with updated fields
  Post copyWith({
    String? id,
    String? authorId,
    String? authorName,
    String? authorAvatar,
    String? content,
    List<String>? images,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? likeCount,
    int? commentCount,
    int? shareCount,
    List<String>? likedBy,
    List<String>? tags,
    PostCategory? category,
    PostStatus? status,
    ModerationStatus? moderationStatus,
    String? moderationReason,
    bool? isAnonymous,
    bool? isPinned,
    Map<String, dynamic>? metadata,
  }) {
    return Post(
      id: id ?? this.id,
      authorId: authorId ?? this.authorId,
      authorName: authorName ?? this.authorName,
      authorAvatar: authorAvatar ?? this.authorAvatar,
      content: content ?? this.content,
      images: images ?? this.images,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
      shareCount: shareCount ?? this.shareCount,
      likedBy: likedBy ?? this.likedBy,
      tags: tags ?? this.tags,
      category: category ?? this.category,
      status: status ?? this.status,
      moderationStatus: moderationStatus ?? this.moderationStatus,
      moderationReason: moderationReason ?? this.moderationReason,
      isAnonymous: isAnonymous ?? this.isAnonymous,
      isPinned: isPinned ?? this.isPinned,
      metadata: metadata ?? this.metadata,
    );
  }

  // Check if user has liked the post
  bool isLikedBy(String userId) {
    return likedBy.contains(userId);
  }

  // Add like to post
  Post addLike(String userId) {
    if (!likedBy.contains(userId)) {
      return copyWith(
        likeCount: likeCount + 1,
        likedBy: [...likedBy, userId],
        updatedAt: DateTime.now(),
      );
    }
    return this;
  }

  // Remove like from post
  Post removeLike(String userId) {
    if (likedBy.contains(userId)) {
      return copyWith(
        likeCount: likeCount - 1,
        likedBy: likedBy.where((id) => id != userId).toList(),
        updatedAt: DateTime.now(),
      );
    }
    return this;
  }

  // Increment comment count
  Post incrementCommentCount() {
    return copyWith(
      commentCount: commentCount + 1,
      updatedAt: DateTime.now(),
    );
  }

  // Increment share count
  Post incrementShareCount() {
    return copyWith(
      shareCount: shareCount + 1,
      updatedAt: DateTime.now(),
    );
  }

  // Check if post is moderated
  bool get isModerated => moderationStatus != ModerationStatus.pending;

  // Check if post is approved
  bool get isApproved => moderationStatus == ModerationStatus.approved;

  // Check if post is rejected
  bool get isRejected => moderationStatus == ModerationStatus.rejected;

  // Check if post is flagged
  bool get isFlagged => moderationStatus == ModerationStatus.flagged;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Post && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Post(id: $id, authorId: $authorId, content: ${content.substring(0, content.length > 50 ? 50 : content.length)}...)';
  }
}

enum PostCategory {
  general,
  mentalHealth,
  anxiety,
  depression,
  stress,
  mindfulness,
  therapy,
  support,
  motivation,
  personal,
  question,
  advice,
}

enum PostStatus {
  active,
  archived,
  deleted,
  hidden,
}

enum ModerationStatus {
  pending,
  approved,
  rejected,
  flagged,
  underReview,
}
