import 'package:flutter/material.dart';
import 'package:mind_ease/services/auth_service.dart';
import 'package:provider/provider.dart';
import '../../app/locator.dart';
import '../../viewmodels/profile_viewmodel.dart';
import '../../app/routes.dart';
import '../shared/widgets/custom_bottom_nav_bar.dart';
import '../../repositories/auth_repository.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final AuthRepository _authRepository = AuthRepository();
  Map<String, dynamic>? _userData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final userModel = await _authRepository.getCurrentUserModel();
      final userDetails = await _authRepository.getCurrentUserDetails();
      
      if (mounted) {
        setState(() {
          _userData = {
            'fullName': userModel?.fullName ?? 'User',
            'username': userModel?.username ?? 'username',
            'avatar': userDetails?.avatar ?? 'assets/avatar.png',
          };
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _userData = {
            'fullName': 'User',
            'username': 'username',
            'avatar': 'assets/avatar.png',
          };
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text('MindEase')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

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
              backgroundImage: AssetImage(_userData?['avatar'] ?? 'assets/avatar.png'),
            ),
            SizedBox(height: 16),
            Text(_userData?['fullName'] ?? 'User', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
            Text(_userData?['username'] ?? 'username', style: TextStyle(color: Colors.grey[700])),
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
