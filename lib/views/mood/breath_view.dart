import 'package:flutter/material.dart';
import '../shared/widgets/custom_bottom_nav_bar.dart';
import 'breath_session_view.dart';

class BreathView extends StatelessWidget {
  const BreathView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MindEase', style: TextStyle(fontFamily: 'Poppins', color: Color(0xFF010221))),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFF010221)),
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16),
            Text('BREATH', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold, fontSize: 32, color: Color(0xFF010221)), textAlign: TextAlign.center),
            SizedBox(height: 32),
            Center(
              child: Image.asset(
                'lib/assets/icons/air.png',
                height: 180,
                width: 180,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 48),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const BreathSessionView()),
                );
              },
              child: Text('Start'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF010221),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                padding: EdgeInsets.symmetric(vertical: 16),
                textStyle: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 1,
        onTap: (i) {
          // TODO: Page transition
        },
      ),
    );
  }
} 