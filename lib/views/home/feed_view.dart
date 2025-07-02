import 'package:flutter/material.dart';
import '../shared/widgets/custom_bottom_nav_bar.dart';

class FeedView extends StatelessWidget {
  const FeedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MindEase'),
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle_outline, size: 32),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/avatar.png'),
                radius: 24,
              ),
              SizedBox(width: 12),
              Text('asli_deniz', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ],
          ),
          SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset('assets/meditation.jpg', height: 220, width: double.infinity, fit: BoxFit.cover),
          ),
          SizedBox(height: 12),
          Text('Meditation...', style: TextStyle(fontSize: 16)),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 0,
        onTap: (i) {
          // TODO: Sayfa geçişi
        },
      ),
    );
  }
}
