import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/room_model.dart';
import '../models/user_model.dart';

class RoomRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create new room
  Future<Room> createRoom({
    required String expertId,
    required String expertName,
    String? expertAvatar,
    required String userId,
    required String userName,
    String? userAvatar,
    String name = '',
    String description = '',
    RoomType type = RoomType.private,
    bool isPrivate = true,
  }) async {
    try {
      final DocumentReference docRef = _firestore.collection('rooms').doc();
      
      final Room room = Room(
        id: docRef.id,
        name: name.isEmpty ? 'Chat with $expertName' : name,
        description: description,
        expertId: expertId,
        expertName: expertName,
        expertAvatar: expertAvatar,
        userId: userId,
        userName: userName,
        userAvatar: userAvatar,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        type: type,
        isPrivate: isPrivate,
        participants: [expertId, userId],
      );

      await docRef.set(room.toFirestore());
      return room;
    } catch (e) {
      throw Exception('Failed to create room: $e');
    }
  }

  // Get room by ID
  Future<Room?> getRoomById(String roomId) async {
    try {
      final DocumentSnapshot doc = await _firestore
          .collection('rooms')
          .doc(roomId)
          .get();

      if (doc.exists) {
        return Room.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get room: $e');
    }
  }

  // Get user's rooms
  Future<List<Room>> getUserRooms(String userId, {int limit = 20}) async {
    try {
      final QuerySnapshot result = await _firestore
          .collection('rooms')
          .where('participants', arrayContains: userId)
          .where('status', isEqualTo: 'active')
          .orderBy('lastMessageAt', descending: true)
          .limit(limit)
          .get();

      return result.docs.map((doc) => Room.fromFirestore(doc)).toList();
    } catch (e) {
      throw Exception('Failed to get user rooms: $e');
    }
  }

  // Get expert's rooms
  Future<List<Room>> getExpertRooms(String expertId, {int limit = 20}) async {
    try {
      final QuerySnapshot result = await _firestore
          .collection('rooms')
          .where('expertId', isEqualTo: expertId)
          .where('status', isEqualTo: 'active')
          .orderBy('lastMessageAt', descending: true)
          .limit(limit)
          .get();

      return result.docs.map((doc) => Room.fromFirestore(doc)).toList();
    } catch (e) {
      throw Exception('Failed to get expert rooms: $e');
    }
  }

  // Get room between user and expert
  Future<Room?> getRoomBetweenUserAndExpert(String userId, String expertId) async {
    try {
      final QuerySnapshot result = await _firestore
          .collection('rooms')
          .where('userId', isEqualTo: userId)
          .where('expertId', isEqualTo: expertId)
          .where('status', isEqualTo: 'active')
          .limit(1)
          .get();

      if (result.docs.isNotEmpty) {
        return Room.fromFirestore(result.docs.first);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get room between user and expert: $e');
    }
  }

  // Update room
  Future<void> updateRoom(String roomId, Map<String, dynamic> updates) async {
    try {
      await _firestore
          .collection('rooms')
          .doc(roomId)
          .update({
        ...updates,
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
    } catch (e) {
      throw Exception('Failed to update room: $e');
    }
  }

  // Update last message in room
  Future<void> updateRoomLastMessage(String roomId, String message, String senderId) async {
    try {
      await _firestore
          .collection('rooms')
          .doc(roomId)
          .update({
        'lastMessage': message,
        'lastMessageSenderId': senderId,
        'lastMessageAt': Timestamp.fromDate(DateTime.now()),
        'messageCount': FieldValue.increment(1),
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
    } catch (e) {
      throw Exception('Failed to update room last message: $e');
    }
  }

  // Archive room
  Future<void> archiveRoom(String roomId) async {
    try {
      await _firestore
          .collection('rooms')
          .doc(roomId)
          .update({
        'status': 'archived',
        'isActive': false,
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
    } catch (e) {
      throw Exception('Failed to archive room: $e');
    }
  }

  // Close room
  Future<void> closeRoom(String roomId) async {
    try {
      await _firestore
          .collection('rooms')
          .doc(roomId)
          .update({
        'status': 'closed',
        'isActive': false,
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
    } catch (e) {
      throw Exception('Failed to close room: $e');
    }
  }

  // Add participant to room
  Future<void> addParticipant(String roomId, String participantId) async {
    try {
      await _firestore
          .collection('rooms')
          .doc(roomId)
          .update({
        'participants': FieldValue.arrayUnion([participantId]),
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
    } catch (e) {
      throw Exception('Failed to add participant: $e');
    }
  }

  // Remove participant from room
  Future<void> removeParticipant(String roomId, String participantId) async {
    try {
      await _firestore
          .collection('rooms')
          .doc(roomId)
          .update({
        'participants': FieldValue.arrayRemove([participantId]),
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
    } catch (e) {
      throw Exception('Failed to remove participant: $e');
    }
  }

  // Add moderator to room
  Future<void> addModerator(String roomId, String moderatorId) async {
    try {
      await _firestore
          .collection('rooms')
          .doc(roomId)
          .update({
        'moderators': FieldValue.arrayUnion([moderatorId]),
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
    } catch (e) {
      throw Exception('Failed to add moderator: $e');
    }
  }

  // Remove moderator from room
  Future<void> removeModerator(String roomId, String moderatorId) async {
    try {
      await _firestore
          .collection('rooms')
          .doc(roomId)
          .update({
        'moderators': FieldValue.arrayRemove([moderatorId]),
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
    } catch (e) {
      throw Exception('Failed to remove moderator: $e');
    }
  }

  // Get room messages
  Stream<List<Map<String, dynamic>>> getRoomMessages(String roomId) {
    return _firestore
        .collection('rooms')
        .doc(roomId)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .limit(50)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => {
                  'id': doc.id,
                  ...doc.data(),
                  'createdAt': (doc.data()['createdAt'] as Timestamp).toDate(),
                })
            .toList());
  }

  // Send message to room
  Future<void> sendMessage(String roomId, {
    required String senderId,
    required String senderName,
    String? senderAvatar,
    required String content,
    String? messageType = 'text',
    Map<String, dynamic>? metadata,
  }) async {
    try {
      final batch = _firestore.batch();

      // Add message to room's messages subcollection
      final DocumentReference messageRef = _firestore
          .collection('rooms')
          .doc(roomId)
          .collection('messages')
          .doc();

      batch.set(messageRef, {
        'senderId': senderId,
        'senderName': senderName,
        'senderAvatar': senderAvatar,
        'content': content,
        'messageType': messageType,
        'metadata': metadata ?? {},
        'createdAt': Timestamp.fromDate(DateTime.now()),
        'isRead': false,
      });

      // Update room's last message
      batch.update(_firestore.collection('rooms').doc(roomId), {
        'lastMessage': content,
        'lastMessageSenderId': senderId,
        'lastMessageAt': Timestamp.fromDate(DateTime.now()),
        'messageCount': FieldValue.increment(1),
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });

      await batch.commit();
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }

  // Mark messages as read
  Future<void> markMessagesAsRead(String roomId, String userId) async {
    try {
      final QuerySnapshot unreadMessages = await _firestore
          .collection('rooms')
          .doc(roomId)
          .collection('messages')
          .where('senderId', isNotEqualTo: userId)
          .where('isRead', isEqualTo: false)
          .get();

      final batch = _firestore.batch();
      for (final doc in unreadMessages.docs) {
        batch.update(doc.reference, {'isRead': true});
      }

      await batch.commit();
    } catch (e) {
      throw Exception('Failed to mark messages as read: $e');
    }
  }

  // Get unread message count
  Future<int> getUnreadMessageCount(String roomId, String userId) async {
    try {
      final QuerySnapshot result = await _firestore
          .collection('rooms')
          .doc(roomId)
          .collection('messages')
          .where('senderId', isNotEqualTo: userId)
          .where('isRead', isEqualTo: false)
          .get();

      return result.docs.length;
    } catch (e) {
      throw Exception('Failed to get unread message count: $e');
    }
  }

  // Delete message
  Future<void> deleteMessage(String roomId, String messageId) async {
    try {
      await _firestore
          .collection('rooms')
          .doc(roomId)
          .collection('messages')
          .doc(messageId)
          .delete();
    } catch (e) {
      throw Exception('Failed to delete message: $e');
    }
  }

  // Get room participants
  Future<List<UserModel>> getRoomParticipants(String roomId) async {
    try {
      final Room? room = await getRoomById(roomId);
      if (room == null) return [];

      final List<UserModel> participants = [];
      
      for (final participantId in room.participants) {
        final UserModel? user = await _getUserById(participantId);
        if (user != null) {
          participants.add(user);
        }
      }

      return participants;
    } catch (e) {
      throw Exception('Failed to get room participants: $e');
    }
  }

  // Get room moderators
  Future<List<UserModel>> getRoomModerators(String roomId) async {
    try {
      final Room? room = await getRoomById(roomId);
      if (room == null) return [];

      final List<UserModel> moderators = [];
      
      for (final moderatorId in room.moderators) {
        final UserModel? user = await _getUserById(moderatorId);
        if (user != null) {
          moderators.add(user);
        }
      }

      return moderators;
    } catch (e) {
      throw Exception('Failed to get room moderators: $e');
    }
  }

  // Search rooms
  Future<List<Room>> searchRooms(String query, String userId, {int limit = 20}) async {
    try {
      // Search in room names
      final QuerySnapshot nameResult = await _firestore
          .collection('rooms')
          .where('participants', arrayContains: userId)
          .where('name', isGreaterThanOrEqualTo: query)
          .where('name', isLessThan: query + '\uf8ff')
          .where('status', isEqualTo: 'active')
          .limit(limit)
          .get();

      // Search in expert names
      final QuerySnapshot expertResult = await _firestore
          .collection('rooms')
          .where('participants', arrayContains: userId)
          .where('expertName', isGreaterThanOrEqualTo: query)
          .where('expertName', isLessThan: query + '\uf8ff')
          .where('status', isEqualTo: 'active')
          .limit(limit)
          .get();

      // Combine and deduplicate results
      final Set<String> seenIds = {};
      final List<Room> results = [];

      for (final doc in nameResult.docs) {
        if (!seenIds.contains(doc.id)) {
          seenIds.add(doc.id);
          results.add(Room.fromFirestore(doc));
        }
      }

      for (final doc in expertResult.docs) {
        if (!seenIds.contains(doc.id)) {
          seenIds.add(doc.id);
          results.add(Room.fromFirestore(doc));
        }
      }

      return results.take(limit).toList();
    } catch (e) {
      throw Exception('Failed to search rooms: $e');
    }
  }

  // Get room statistics
  Future<Map<String, dynamic>> getRoomStatistics(String roomId) async {
    try {
      final Room? room = await getRoomById(roomId);
      if (room == null) {
        throw Exception('Room not found');
      }

      // Get message count
      final QuerySnapshot messagesResult = await _firestore
          .collection('rooms')
          .doc(roomId)
          .collection('messages')
          .get();

      // Get unread messages count
      final QuerySnapshot unreadResult = await _firestore
          .collection('rooms')
          .doc(roomId)
          .collection('messages')
          .where('isRead', isEqualTo: false)
          .get();

      return {
        'messageCount': messagesResult.docs.length,
        'unreadCount': unreadResult.docs.length,
        'participantCount': room.participantCount,
        'createdAt': room.createdAt,
        'lastMessageAt': room.lastMessageAt,
        'isActive': room.isActive,
      };
    } catch (e) {
      throw Exception('Failed to get room statistics: $e');
    }
  }

  // Helper method to get user by ID
  Future<UserModel?> _getUserById(String userId) async {
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
      return null;
    }
  }

  // Get rooms for moderation
  Future<List<Room>> getRoomsForModeration({int limit = 50}) async {
    try {
      final QuerySnapshot result = await _firestore
          .collection('rooms')
          .where('status', isEqualTo: 'suspended')
          .orderBy('updatedAt', descending: true)
          .limit(limit)
          .get();

      return result.docs.map((doc) => Room.fromFirestore(doc)).toList();
    } catch (e) {
      throw Exception('Failed to get rooms for moderation: $e');
    }
  }

  // Suspend room
  Future<void> suspendRoom(String roomId, String reason) async {
    try {
      await _firestore
          .collection('rooms')
          .doc(roomId)
          .update({
        'status': 'suspended',
        'isActive': false,
        'suspensionReason': reason,
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
    } catch (e) {
      throw Exception('Failed to suspend room: $e');
    }
  }

  // Reactivate room
  Future<void> reactivateRoom(String roomId) async {
    try {
      await _firestore
          .collection('rooms')
          .doc(roomId)
          .update({
        'status': 'active',
        'isActive': true,
        'suspensionReason': null,
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
    } catch (e) {
      throw Exception('Failed to reactivate room: $e');
    }
  }
}
