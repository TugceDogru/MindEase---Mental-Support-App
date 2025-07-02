import 'package:flutter/material.dart';

class FeedItem {
  final String id;
  final String content;
  FeedItem({required this.id, required this.content});
}

class FeedViewModel extends ChangeNotifier {
  List<FeedItem> _feed = [];
  List<FeedItem> get feed => _feed;

  // Fetch feed data (dummy implementation)
  Future<void> fetchFeed() async {
    await Future.delayed(Duration(milliseconds: 500));
    _feed = [
      FeedItem(id: '1', content: 'Welcome to MindEase!'),
      FeedItem(id: '2', content: 'Today is a great day.'),
    ];
    notifyListeners();
  }
}
