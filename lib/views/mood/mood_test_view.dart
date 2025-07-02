import 'package:flutter/material.dart';

class MoodTestView extends StatefulWidget {
  const MoodTestView({super.key});

  @override
  State<MoodTestView> createState() => _MoodTestViewState();
}

class _MoodTestViewState extends State<MoodTestView> {
  int? selected;
  final options = [
    'Very Good',
    'Good',
    'Bad',
    'Very Bad',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.1),
      body: Center(
        child: Container(
          width: 320,
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 16)],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('HOW ARE YOU FEELING TODAY?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(height: 24),
              ...List.generate(options.length, (i) => _buildOption(i)),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: selected != null ? () {} : null,
                child: Text('NEXT'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOption(int i) {
    return GestureDetector(
      onTap: () => setState(() => selected = i),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: selected == i ? Colors.grey[300] : Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Text(String.fromCharCode(65 + i) + '.', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(width: 12),
            Text(options[i]),
          ],
        ),
      ),
    );
  }
}
