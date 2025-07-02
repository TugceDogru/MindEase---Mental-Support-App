import 'package:flutter/material.dart';
import '../shared/widgets/custom_bottom_nav_bar.dart';
import '../../repositories/auth_repository.dart';

class FeedView extends StatefulWidget {
  const FeedView({super.key});

  @override
  State<FeedView> createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
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
                backgroundImage: AssetImage(_userData?['avatar'] ?? 'assets/avatar.png'),
                radius: 24,
              ),
              SizedBox(width: 12),
              Text(_userData?['username'] ?? 'username', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
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
          // TODO: Page transition
        },
      ),
    );
  }
}
