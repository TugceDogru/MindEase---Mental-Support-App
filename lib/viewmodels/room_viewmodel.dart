import 'package:flutter/material.dart';

class Room {
  final String id;
  final String name;
  Room({required this.id, required this.name});
}

class RoomViewModel extends ChangeNotifier {
  List<Room> _rooms = [];
  List<Room> get rooms => _rooms;

  // Fetch room list (dummy data for now)
  Future<void> fetchRooms() async {
    await Future.delayed(Duration(milliseconds: 500));
    _rooms = [
      Room(id: '1', name: 'General'),
      Room(id: '2', name: 'Support'),
      Room(id: '3', name: 'Random'),
    ];
    notifyListeners();
  }

  // Send a message to a room (dummy implementation)
  Future<void> sendMessage(String roomId, String message) async {
    // Here you would send the message to Firestore or your backend
    await Future.delayed(Duration(milliseconds: 200));
    // For now, just print
    print('Message sent to room $roomId: $message');
  }
}
