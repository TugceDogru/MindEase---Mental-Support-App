import 'package:flutter/material.dart';
import 'package:mind_ease/services/auth_service.dart';
import 'package:provider/provider.dart';
import '../../app/locator.dart';
import '../../viewmodels/profile_viewmodel.dart';
import '../../app/routes.dart';
import '../shared/widgets/custom_bottom_nav_bar.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
          return Scaffold(
      appBar: AppBar(title: Text('MindEase')),
      body: Padding(
        padding: EdgeInsets.all(24),
                      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 24),
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/avatar.png'),
            ),
            SizedBox(height: 16),
            Text('Seda Öz', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
            Text('seda_oz', style: TextStyle(color: Colors.grey[700])),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                _buildStat('Posts', '0'),
                SizedBox(width: 32),
                _buildStat('Followers', '0'),
                SizedBox(width: 32),
                _buildStat('Following', '0'),
              ],
                          ),
            SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Edit Profile'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
                              ),
                        ],
                      ),
                    ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 4,
        onTap: (i) {
          // TODO: Sayfa geçişi
        },
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        Text(label, style: TextStyle(color: Colors.grey[700])),
      ],
    );
  }
}
