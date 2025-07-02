import 'package:flutter/material.dart';

class DailyMoodTestModal extends StatefulWidget {
  final void Function(int totalScore, String moodLevel) onSave;
  const DailyMoodTestModal({super.key, required this.onSave});

  @override
  State<DailyMoodTestModal> createState() => _DailyMoodTestModalState();
}

class _DailyMoodTestModalState extends State<DailyMoodTestModal> {
  int current = 0;
  List<int> answers = List.filled(moodQuestions.length, 3);

  void next() {
    if (current < moodQuestions.length - 1) {
      setState(() => current++);
    } else {
      int total = 0;
      for (int i = 0; i < answers.length; i++) {
        int score = answers[i];
        if (negativeQuestions.contains(i)) score = 6 - score;
        total += score;
      }
      String moodLevel;
      if (total <= 30) {
        moodLevel = "Low";
      } else if (total <= 45) {
        moodLevel = "Medium";
      } else if (total <= 60) {
        moodLevel = "Good";
      } else {
        moodLevel = "Very Good";
      }
      widget.onSave(total, moodLevel);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.black.withOpacity(0.2),
        child: Center(
          child: Container(
            width: 340,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 16)],
            ),
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Color(0xFF010221),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        moodQuestions[current],
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (i) {
                        final selected = answers[current] == i + 1;
                        return GestureDetector(
                          onTap: () => setState(() => answers[current] = i + 1),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            decoration: BoxDecoration(
                              color: selected ? Color(0xFF010221) : Colors.grey[200],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: selected ? Color(0xFF010221) : Colors.grey[400]!,
                                width: 2,
                              ),
                            ),
                            child: Text(
                              '${i + 1}',
                              style: TextStyle(
                                color: selected ? Colors.white : Color(0xFF010221),
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: next,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF010221),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                        textStyle: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                      ),
                      child: Text(current == moodQuestions.length - 1 ? 'Save' : 'Next'),
                    ),
                  ],
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: IconButton(
                    icon: Image.asset('assets/icons/close.png', width: 32, height: 32),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

const List<String> moodQuestions = [
  "I feel energetic today.",
  "I feel mentally tired.",
  "I am confident in myself.",
  "I felt stressed throughout the day.",
  "I want to spend time with others.",
  "I didn't feel like doing anything today.",
  "Even small things made me angry.",
  "I feel peaceful.",
  "I had difficulty controlling my emotions today.",
  "I had trouble focusing on work/school.",
  "There are things going well in my life right now.",
  "I feel anxious or worried.",
  "I need time to relax right now.",
  "There were moments I felt happy today.",
  "I can accept myself as I am right now.",
];

const Set<int> negativeQuestions = {1, 3, 5, 6, 8, 9, 11, 12}; 