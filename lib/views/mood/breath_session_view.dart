import 'package:flutter/material.dart';
import '../shared/widgets/custom_bottom_nav_bar.dart';
import 'dart:async';

class BreathSessionView extends StatefulWidget {
  const BreathSessionView({super.key});

  @override
  State<BreathSessionView> createState() => _BreathSessionViewState();
}

class _BreathSessionViewState extends State<BreathSessionView> {
  static const int totalSeconds = 300; // 5 dakika
  static const List<_BreathPhase> phases = [
    _BreathPhase('Breath In', 4),
    _BreathPhase('Hold It', 5),
    _BreathPhase('Breath Out', 6),
  ];

  int elapsed = 0;
  int phaseIndex = 0;
  int phaseElapsed = 0;
  Timer? timer;
  bool finished = false;

  @override
  void initState() {
    super.initState();
    startSession();
  }

  void startSession() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (elapsed >= totalSeconds) {
        setState(() {
          finished = true;
        });
        timer?.cancel();
        return;
      }
      setState(() {
        elapsed++;
        phaseElapsed++;
        if (phaseElapsed >= phases[phaseIndex].duration) {
          phaseIndex = (phaseIndex + 1) % phases.length;
          phaseElapsed = 0;
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final phase = phases[phaseIndex];
    final phaseProgress = phaseElapsed / phase.duration;
    final remaining = totalSeconds - elapsed;
    final min = (remaining ~/ 60).toString().padLeft(2, '0');
    final sec = (remaining % 60).toString().padLeft(2, '0');

    return Scaffold(
      appBar: AppBar(
        title: Text('MindEase', style: TextStyle(fontFamily: 'Poppins', color: Color(0xFF010221))),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFF010221)),
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Center(
          child: finished
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle, color: Colors.green, size: 80),
                    SizedBox(height: 24),
                    Text('Session Complete!', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold, fontSize: 28, color: Color(0xFF010221))),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 8),
                    Text('$min:$sec', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold, fontSize: 32, color: Color(0xFF010221)), textAlign: TextAlign.center),
                    SizedBox(height: 32),
                    Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 180,
                            height: 180,
                            child: CircularProgressIndicator(
                              value: 1 - (elapsed / totalSeconds),
                              strokeWidth: 10,
                              backgroundColor: Colors.grey[200],
                              color: Color(0xFF010221),
                            ),
                          ),
                          Image.asset(
                            'lib/assets/icons/air.png',
                            height: 120,
                            width: 120,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 32),
                    LinearProgressIndicator(
                      value: phaseProgress,
                      minHeight: 10,
                      backgroundColor: Colors.grey[300],
                      color: Color(0xFF010221),
                    ),
                    SizedBox(height: 32),
                    Text(phase.label, style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold, fontSize: 22, color: Color(0xFF010221)), textAlign: TextAlign.center),
                  ],
                ),
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
}

class _BreathPhase {
  final String label;
  final int duration;
  const _BreathPhase(this.label, this.duration);
} 