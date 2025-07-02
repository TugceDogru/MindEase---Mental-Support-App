import '../models/moderation_result_model.dart';

class ModerationService {
  // Simulate AI moderation (expand as needed)
  Future<ModerationResult> checkContent(String text) async {
    await Future.delayed(Duration(milliseconds: 300));
    if (text.toLowerCase().contains('badword')) {
      return ModerationResult(
        isAllowed: false,
        reason: "Inappropriate language detected.",
        checkedAt: DateTime.now(),
        content: text,
      );
    }
    if (text.length > 500) {
      return ModerationResult(
        isAllowed: false,
        reason: "Message is too long.",
        checkedAt: DateTime.now(),
        content: text,
      );
    }
    return ModerationResult(
      isAllowed: true,
      checkedAt: DateTime.now(),
      content: text,
    );
  }
}
