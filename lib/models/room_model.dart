import 'package:cloud_firestore/cloud_firestore.dart';

class Room {
  final String id;
  final String name;
  final String description;
  final String expertId;
  final String expertName;
  final String? expertAvatar;
  final String userId;
  final String userName;
  final String? userAvatar;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? lastMessageAt;
  final String? lastMessage;
  final String? lastMessageSenderId;
  final int messageCount;
  final RoomStatus status;
  final RoomType type;
  final bool isActive;
  final bool isPrivate;
  final List<String> participants;
  final List<String> moderators;
  final Map<String, dynamic> settings;
  final Map<String, dynamic> metadata;

  Room({
    required this.id,
    required this.name,
    required this.description,
    required this.expertId,
    required this.expertName,
    this.expertAvatar,
    required this.userId,
    required this.userName,
    this.userAvatar,
    required this.createdAt,
    required this.updatedAt,
    this.lastMessageAt,
    this.lastMessage,
    this.lastMessageSenderId,
    this.messageCount = 0,
    this.status = RoomStatus.active,
    this.type = RoomType.private,
    this.isActive = true,
    this.isPrivate = true,
    this.participants = const [],
    this.moderators = const [],
    this.settings = const {},
    this.metadata = const {},
  });

  // Factory constructor to create Room from Firestore document
  factory Room.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    
    return Room(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      expertId: data['expertId'] ?? '',
      expertName: data['expertName'] ?? '',
      expertAvatar: data['expertAvatar'],
      userId: data['userId'] ?? '',
      userName: data['userName'] ?? '',
      userAvatar: data['userAvatar'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
      lastMessageAt: data['lastMessageAt'] != null 
          ? (data['lastMessageAt'] as Timestamp).toDate() 
          : null,
      lastMessage: data['lastMessage'],
      lastMessageSenderId: data['lastMessageSenderId'],
      messageCount: data['messageCount'] ?? 0,
      status: RoomStatus.values.firstWhere(
        (e) => e.toString() == 'RoomStatus.${data['status']}',
        orElse: () => RoomStatus.active,
      ),
      type: RoomType.values.firstWhere(
        (e) => e.toString() == 'RoomType.${data['type']}',
        orElse: () => RoomType.private,
      ),
      isActive: data['isActive'] ?? true,
      isPrivate: data['isPrivate'] ?? true,
      participants: List<String>.from(data['participants'] ?? []),
      moderators: List<String>.from(data['moderators'] ?? []),
      settings: Map<String, dynamic>.from(data['settings'] ?? {}),
      metadata: Map<String, dynamic>.from(data['metadata'] ?? {}),
    );
  }

  // Convert Room to Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'expertId': expertId,
      'expertName': expertName,
      'expertAvatar': expertAvatar,
      'userId': userId,
      'userName': userName,
      'userAvatar': userAvatar,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'lastMessageAt': lastMessageAt != null 
          ? Timestamp.fromDate(lastMessageAt!) 
          : null,
      'lastMessage': lastMessage,
      'lastMessageSenderId': lastMessageSenderId,
      'messageCount': messageCount,
      'status': status.toString().split('.').last,
      'type': type.toString().split('.').last,
      'isActive': isActive,
      'isPrivate': isPrivate,
      'participants': participants,
      'moderators': moderators,
      'settings': settings,
      'metadata': metadata,
    };
  }

  // Create a copy of Room with updated fields
  Room copyWith({
    String? id,
    String? name,
    String? description,
    String? expertId,
    String? expertName,
    String? expertAvatar,
    String? userId,
    String? userName,
    String? userAvatar,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastMessageAt,
    String? lastMessage,
    String? lastMessageSenderId,
    int? messageCount,
    RoomStatus? status,
    RoomType? type,
    bool? isActive,
    bool? isPrivate,
    List<String>? participants,
    List<String>? moderators,
    Map<String, dynamic>? settings,
    Map<String, dynamic>? metadata,
  }) {
    return Room(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      expertId: expertId ?? this.expertId,
      expertName: expertName ?? this.expertName,
      expertAvatar: expertAvatar ?? this.expertAvatar,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userAvatar: userAvatar ?? this.userAvatar,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastMessageAt: lastMessageAt ?? this.lastMessageAt,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageSenderId: lastMessageSenderId ?? this.lastMessageSenderId,
      messageCount: messageCount ?? this.messageCount,
      status: status ?? this.status,
      type: type ?? this.type,
      isActive: isActive ?? this.isActive,
      isPrivate: isPrivate ?? this.isPrivate,
      participants: participants ?? this.participants,
      moderators: moderators ?? this.moderators,
      settings: settings ?? this.settings,
      metadata: metadata ?? this.metadata,
    );
  }

  // Check if user is participant in the room
  bool isParticipant(String userId) {
    return participants.contains(userId);
  }

  // Check if user is moderator in the room
  bool isModerator(String userId) {
    return moderators.contains(userId);
  }

  // Check if user is expert in the room
  bool isExpert(String userId) {
    return expertId == userId;
  }

  // Add participant to room
  Room addParticipant(String userId) {
    if (!participants.contains(userId)) {
      return copyWith(
        participants: [...participants, userId],
        updatedAt: DateTime.now(),
      );
    }
    return this;
  }

  // Remove participant from room
  Room removeParticipant(String userId) {
    if (participants.contains(userId)) {
      return copyWith(
        participants: participants.where((id) => id != userId).toList(),
        updatedAt: DateTime.now(),
      );
    }
    return this;
  }

  // Add moderator to room
  Room addModerator(String userId) {
    if (!moderators.contains(userId)) {
      return copyWith(
        moderators: [...moderators, userId],
        updatedAt: DateTime.now(),
      );
    }
    return this;
  }

  // Remove moderator from room
  Room removeModerator(String userId) {
    if (moderators.contains(userId)) {
      return copyWith(
        moderators: moderators.where((id) => id != userId).toList(),
        updatedAt: DateTime.now(),
      );
    }
    return this;
  }

  // Update last message
  Room updateLastMessage(String message, String senderId) {
    return copyWith(
      lastMessage: message,
      lastMessageSenderId: senderId,
      lastMessageAt: DateTime.now(),
      messageCount: messageCount + 1,
      updatedAt: DateTime.now(),
    );
  }

  // Archive room
  Room archive() {
    return copyWith(
      status: RoomStatus.archived,
      isActive: false,
      updatedAt: DateTime.now(),
    );
  }

  // Activate room
  Room activate() {
    return copyWith(
      status: RoomStatus.active,
      isActive: true,
      updatedAt: DateTime.now(),
    );
  }

  // Close room
  Room close() {
    return copyWith(
      status: RoomStatus.closed,
      isActive: false,
      updatedAt: DateTime.now(),
    );
  }

  // Get room display name
  String get displayName {
    if (type == RoomType.group) {
      return name;
    }
    return expertName;
  }

  // Get room avatar
  String? get displayAvatar {
    if (type == RoomType.group) {
      return null; // Use default group avatar
    }
    return expertAvatar;
  }

  // Check if room has unread messages (for notifications)
  bool hasUnreadMessages(String userId) {
    // This would typically be implemented with a separate unread messages tracking
    // For now, we'll use a simple heuristic based on last message sender
    return lastMessageSenderId != null && lastMessageSenderId != userId;
  }

  // Get room participants count
  int get participantCount => participants.length + 2; // +2 for expert and user

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Room && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Room(id: $id, name: $name, expertId: $expertId, userId: $userId)';
  }
}

enum RoomStatus {
  active,
  archived,
  closed,
  suspended,
  pending,
}

enum RoomType {
  private,    // One-on-one chat between user and expert
  group,      // Group chat with multiple participants
  support,    // Support group chat
  public,     // Public room (read-only for most users)
}
