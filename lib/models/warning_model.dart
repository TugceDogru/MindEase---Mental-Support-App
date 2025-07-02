import 'package:cloud_firestore/cloud_firestore.dart';

class Warning {
  final String id;
  final String userId;
  final String userName;
  final String moderatorId;
  final String moderatorName;
  final String reason;
  final String description;
  final WarningType type;
  final WarningSeverity severity;
  final WarningStatus status;
  final DateTime issuedAt;
  final DateTime? expiresAt;
  final DateTime? reviewedAt;
  final String? reviewedBy;
  final String? appealReason;
  final DateTime? appealedAt;
  final AppealStatus appealStatus;
  final String? appealResponse;
  final DateTime? appealRespondedAt;
  final String? appealRespondedBy;
  final List<String> relatedContentIds;
  final Map<String, dynamic> evidence;
  final Map<String, dynamic> metadata;

  Warning({
    required this.id,
    required this.userId,
    required this.userName,
    required this.moderatorId,
    required this.moderatorName,
    required this.reason,
    required this.description,
    required this.type,
    required this.severity,
    this.status = WarningStatus.active,
    required this.issuedAt,
    this.expiresAt,
    this.reviewedAt,
    this.reviewedBy,
    this.appealReason,
    this.appealedAt,
    this.appealStatus = AppealStatus.none,
    this.appealResponse,
    this.appealRespondedAt,
    this.appealRespondedBy,
    this.relatedContentIds = const [],
    this.evidence = const {},
    this.metadata = const {},
  });

  // Factory constructor to create Warning from Firestore document
  factory Warning.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    
    return Warning(
      id: doc.id,
      userId: data['userId'] ?? '',
      userName: data['userName'] ?? '',
      moderatorId: data['moderatorId'] ?? '',
      moderatorName: data['moderatorName'] ?? '',
      reason: data['reason'] ?? '',
      description: data['description'] ?? '',
      type: WarningType.values.firstWhere(
        (e) => e.toString() == 'WarningType.${data['type']}',
        orElse: () => WarningType.general,
      ),
      severity: WarningSeverity.values.firstWhere(
        (e) => e.toString() == 'WarningSeverity.${data['severity']}',
        orElse: () => WarningSeverity.low,
      ),
      status: WarningStatus.values.firstWhere(
        (e) => e.toString() == 'WarningStatus.${data['status']}',
        orElse: () => WarningStatus.active,
      ),
      issuedAt: (data['issuedAt'] as Timestamp).toDate(),
      expiresAt: data['expiresAt'] != null 
          ? (data['expiresAt'] as Timestamp).toDate() 
          : null,
      reviewedAt: data['reviewedAt'] != null 
          ? (data['reviewedAt'] as Timestamp).toDate() 
          : null,
      reviewedBy: data['reviewedBy'],
      appealReason: data['appealReason'],
      appealedAt: data['appealedAt'] != null 
          ? (data['appealedAt'] as Timestamp).toDate() 
          : null,
      appealStatus: AppealStatus.values.firstWhere(
        (e) => e.toString() == 'AppealStatus.${data['appealStatus']}',
        orElse: () => AppealStatus.none,
      ),
      appealResponse: data['appealResponse'],
      appealRespondedAt: data['appealRespondedAt'] != null 
          ? (data['appealRespondedAt'] as Timestamp).toDate() 
          : null,
      appealRespondedBy: data['appealRespondedBy'],
      relatedContentIds: List<String>.from(data['relatedContentIds'] ?? []),
      evidence: Map<String, dynamic>.from(data['evidence'] ?? {}),
      metadata: Map<String, dynamic>.from(data['metadata'] ?? {}),
    );
  }

  // Convert Warning to Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'userName': userName,
      'moderatorId': moderatorId,
      'moderatorName': moderatorName,
      'reason': reason,
      'description': description,
      'type': type.toString().split('.').last,
      'severity': severity.toString().split('.').last,
      'status': status.toString().split('.').last,
      'issuedAt': Timestamp.fromDate(issuedAt),
      'expiresAt': expiresAt != null ? Timestamp.fromDate(expiresAt!) : null,
      'reviewedAt': reviewedAt != null ? Timestamp.fromDate(reviewedAt!) : null,
      'reviewedBy': reviewedBy,
      'appealReason': appealReason,
      'appealedAt': appealedAt != null ? Timestamp.fromDate(appealedAt!) : null,
      'appealStatus': appealStatus.toString().split('.').last,
      'appealResponse': appealResponse,
      'appealRespondedAt': appealRespondedAt != null 
          ? Timestamp.fromDate(appealRespondedAt!) 
          : null,
      'appealRespondedBy': appealRespondedBy,
      'relatedContentIds': relatedContentIds,
      'evidence': evidence,
      'metadata': metadata,
    };
  }

  // Create a copy of Warning with updated fields
  Warning copyWith({
    String? id,
    String? userId,
    String? userName,
    String? moderatorId,
    String? moderatorName,
    String? reason,
    String? description,
    WarningType? type,
    WarningSeverity? severity,
    WarningStatus? status,
    DateTime? issuedAt,
    DateTime? expiresAt,
    DateTime? reviewedAt,
    String? reviewedBy,
    String? appealReason,
    DateTime? appealedAt,
    AppealStatus? appealStatus,
    String? appealResponse,
    DateTime? appealRespondedAt,
    String? appealRespondedBy,
    List<String>? relatedContentIds,
    Map<String, dynamic>? evidence,
    Map<String, dynamic>? metadata,
  }) {
    return Warning(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      moderatorId: moderatorId ?? this.moderatorId,
      moderatorName: moderatorName ?? this.moderatorName,
      reason: reason ?? this.reason,
      description: description ?? this.description,
      type: type ?? this.type,
      severity: severity ?? this.severity,
      status: status ?? this.status,
      issuedAt: issuedAt ?? this.issuedAt,
      expiresAt: expiresAt ?? this.expiresAt,
      reviewedAt: reviewedAt ?? this.reviewedAt,
      reviewedBy: reviewedBy ?? this.reviewedBy,
      appealReason: appealReason ?? this.appealReason,
      appealedAt: appealedAt ?? this.appealedAt,
      appealStatus: appealStatus ?? this.appealStatus,
      appealResponse: appealResponse ?? this.appealResponse,
      appealRespondedAt: appealRespondedAt ?? this.appealRespondedAt,
      appealRespondedBy: appealRespondedBy ?? this.appealRespondedBy,
      relatedContentIds: relatedContentIds ?? this.relatedContentIds,
      evidence: evidence ?? this.evidence,
      metadata: metadata ?? this.metadata,
    );
  }

  // Check if warning is expired
  bool get isExpired {
    if (expiresAt == null) return false;
    return DateTime.now().isAfter(expiresAt!);
  }

  // Check if warning is active
  bool get isActive {
    return status == WarningStatus.active && !isExpired;
  }

  // Check if warning can be appealed
  bool get canBeAppealed {
    return appealStatus == AppealStatus.none && 
           status == WarningStatus.active &&
           !isExpired;
  }

  // Check if warning has been appealed
  bool get hasBeenAppealed {
    return appealStatus != AppealStatus.none;
  }

  // Check if appeal is pending
  bool get isAppealPending {
    return appealStatus == AppealStatus.pending;
  }

  // Check if appeal was approved
  bool get isAppealApproved {
    return appealStatus == AppealStatus.approved;
  }

  // Check if appeal was rejected
  bool get isAppealRejected {
    return appealStatus == AppealStatus.rejected;
  }

  // Get warning duration in days
  int? get durationInDays {
    if (expiresAt == null) return null;
    return expiresAt!.difference(issuedAt).inDays;
  }

  // Get remaining days until expiration
  int? get remainingDays {
    if (expiresAt == null) return null;
    final remaining = expiresAt!.difference(DateTime.now()).inDays;
    return remaining > 0 ? remaining : 0;
  }

  // Submit appeal
  Warning submitAppeal(String appealReason) {
    if (!canBeAppealed) {
      throw Exception('Warning cannot be appealed');
    }
    
    return copyWith(
      appealReason: appealReason,
      appealedAt: DateTime.now(),
      appealStatus: AppealStatus.pending,
    );
  }

  // Review appeal
  Warning reviewAppeal(AppealStatus newStatus, String response, String reviewerId) {
    if (appealStatus != AppealStatus.pending) {
      throw Exception('Appeal is not pending review');
    }
    
    return copyWith(
      appealStatus: newStatus,
      appealResponse: response,
      appealRespondedAt: DateTime.now(),
      appealRespondedBy: reviewerId,
    );
  }

  // Extend warning duration
  Warning extendDuration(int additionalDays) {
    final newExpiresAt = expiresAt?.add(Duration(days: additionalDays)) ?? 
                        issuedAt.add(Duration(days: additionalDays));
    
    return copyWith(
      expiresAt: newExpiresAt,
    );
  }

  // Reduce warning severity
  Warning reduceSeverity(WarningSeverity newSeverity) {
    return copyWith(
      severity: newSeverity,
      reviewedAt: DateTime.now(),
    );
  }

  // Dismiss warning
  Warning dismiss() {
    return copyWith(
      status: WarningStatus.dismissed,
      reviewedAt: DateTime.now(),
    );
  }

  // Get warning color based on severity
  String get severityColor {
    switch (severity) {
      case WarningSeverity.low:
        return '#FFA500'; // Orange
      case WarningSeverity.medium:
        return '#FF6B35'; // Dark Orange
      case WarningSeverity.high:
        return '#FF0000'; // Red
      case WarningSeverity.critical:
        return '#8B0000'; // Dark Red
    }
  }

  // Get warning icon based on type
  String get typeIcon {
    switch (type) {
      case WarningType.harassment:
        return '🚫';
      case WarningType.spam:
        return '📧';
      case WarningType.inappropriate:
        return '⚠️';
      case WarningType.violence:
        return '⚔️';
      case WarningType.fraud:
        return '💳';
      case WarningType.general:
        return '⚠️';
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Warning && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Warning(id: $id, userId: $userId, type: $type, severity: $severity)';
  }
}

enum WarningType {
  harassment,      // Harassment or bullying
  spam,           // Spam or unwanted content
  inappropriate,  // Inappropriate content
  violence,       // Violence or threats
  fraud,          // Fraud or scams
  general,        // General violation
}

enum WarningSeverity {
  low,        // Minor violation
  medium,     // Moderate violation
  high,       // Serious violation
  critical,   // Critical violation
}

enum WarningStatus {
  active,     // Warning is active
  expired,    // Warning has expired
  dismissed,  // Warning was dismissed
  suspended,  // Warning is suspended
}

enum AppealStatus {
  none,       // No appeal submitted
  pending,    // Appeal is pending review
  approved,   // Appeal was approved
  rejected,   // Appeal was rejected
}
