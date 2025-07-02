import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/moderation_viewmodel.dart';

class ModerationView extends StatelessWidget {
  final String lastContent;
  final VoidCallback onRetry;

  const ModerationView({
    super.key,
    required this.lastContent,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ModerationViewModel>(
      builder: (context, vm, child) {
        final result = vm.lastResult;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Content Moderation',
              style: TextStyle(fontFamily: 'Poppins', color: Color(0xFF010221)),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: Color(0xFF010221)),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.warning_amber_rounded, color: Colors.red, size: 64),
                  SizedBox(height: 24),
                  Text(
                    result?.reason ?? "Your content may violate our community guidelines.",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      color: Colors.red[900],
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      lastContent,
                      style: TextStyle(fontFamily: 'Poppins', color: Color(0xFF010221)),
                    ),
                  ),
                  SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: onRetry,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF010221),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                      textStyle: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                    ),
                    child: Text('Try Again'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
