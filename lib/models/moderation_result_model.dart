class ModerationResult {
  final bool isAllowed;
  final String? reason;
  final DateTime checkedAt;
  final String content;

  ModerationResult({
    required this.isAllowed,
    this.reason,
    required this.checkedAt,
    required this.content,
  });
} 