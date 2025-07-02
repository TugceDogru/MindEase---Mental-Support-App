import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app/locator.dart';
import '../../viewmodels/mood_viewmodel.dart';
import 'package:fl_chart/fl_chart.dart';
import '../shared/widgets/custom_bottom_nav_bar.dart';

class ActivityView extends StatelessWidget {
  const ActivityView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MindEase')),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16),
            Text('Activities', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32), textAlign: TextAlign.center),
            SizedBox(height: 32),
            _buildActivityCard(context, 'Meditation', 'assets/meditation.jpg'),
            SizedBox(height: 24),
            _buildActivityCard(context, 'Breathing Exercise', 'assets/breathing.jpg'),
            SizedBox(height: 24),
            _buildActivityCard(context, 'Be Creative', 'assets/creative.jpg'),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 1,
        onTap: (i) {
          // TODO: Sayfa geçişi
        },
      ),
    );
  }

  Widget _buildActivityCard(BuildContext context, String title, String imagePath) {
    return GestureDetector(
      onTap: () {},
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(imagePath, height: 100, width: double.infinity, fit: BoxFit.cover),
            Container(
              height: 100,
              color: Colors.black.withOpacity(0.4),
              alignment: Alignment.center,
              child: Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22)),
            ),
          ],
        ),
      ),
    );
  }
}
