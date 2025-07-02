// App-wide enums for MindEase

// User roles in the system
enum UserRole {
  user,           // Regular user
  expert,         // Mental health expert
  moderator,      // Content moderator
  admin,          // System administrator
  superAdmin,     // Super administrator
}

// User account status
enum UserStatus {
  active,         // Account is active
  inactive,       // Account is inactive
  suspended,      // Account is suspended
  banned,         // Account is banned
  pending,        // Account is pending approval
  deleted,        // Account is deleted
}

// User verification status
enum VerificationStatus {
  unverified,     // Not verified
  pending,        // Verification pending
  verified,       // Verified
  rejected,       // Verification rejected
}

// Gender options
enum Gender {
  male,
  female,
  nonBinary,
  other,
  preferNotToSay,
  notSpecified,
}

// Post categories
enum PostCategory {
  general,        // General posts
  mentalHealth,   // Mental health related
  anxiety,        // Anxiety specific
  depression,     // Depression specific
  stress,         // Stress management
  mindfulness,    // Mindfulness and meditation
  therapy,        // Therapy related
  support,        // Support and encouragement
  motivation,     // Motivational content
  personal,       // Personal experiences
  question,       // Questions and advice seeking
  advice,         // Advice and tips
  crisis,         // Crisis support
  recovery,       // Recovery stories
  education,      // Educational content
  resources,      // Resources and tools
}

// Post status
enum PostStatus {
  active,         // Post is active and visible
  archived,       // Post is archived
  deleted,        // Post is deleted
  hidden,         // Post is hidden
  draft,          // Post is in draft
  scheduled,      // Post is scheduled for later
}

// Moderation status
enum ModerationStatus {
  pending,        // Awaiting moderation
  approved,       // Approved by moderator
  rejected,       // Rejected by moderator
  flagged,        // Flagged for review
  underReview,    // Currently under review
  autoApproved,   // Automatically approved
  autoRejected,   // Automatically rejected
}

// Room types
enum RoomType {
  private,        // One-on-one private chat
  group,          // Group chat
  support,        // Support group
  public,         // Public room
  emergency,      // Emergency support
  therapy,        // Therapy session
  consultation,   // Expert consultation
}

// Room status
enum RoomStatus {
  active,         // Room is active
  archived,       // Room is archived
  closed,         // Room is closed
  suspended,      // Room is suspended
  pending,        // Room is pending approval
  expired,        // Room has expired
}

// Message types
enum MessageType {
  text,           // Text message
  image,          // Image message
  file,           // File message
  audio,          // Audio message
  video,          // Video message
  location,       // Location message
  system,         // System message
  notification,   // Notification message
}

// Message status
enum MessageStatus {
  sent,           // Message sent
  delivered,      // Message delivered
  read,           // Message read
  failed,         // Message failed to send
  pending,        // Message pending
  deleted,        // Message deleted
}

// Appointment status
enum AppointmentStatus {
  pending,        // Appointment pending
  confirmed,      // Appointment confirmed
  completed,      // Appointment completed
  cancelled,      // Appointment cancelled
  rescheduled,    // Appointment rescheduled
  noShow,         // No show
  expired,        // Appointment expired
}

// Appointment type
enum AppointmentType {
  consultation,   // General consultation
  therapy,        // Therapy session
  emergency,      // Emergency support
  followUp,       // Follow-up session
  assessment,     // Assessment session
  group,          // Group session
}

// Mood levels
enum MoodLevel {
  veryPoor,       // Very poor mood (1)
  poor,           // Poor mood (2)
  fair,           // Fair mood (3)
  good,           // Good mood (4)
  excellent,      // Excellent mood (5)
}

// Mood trend
enum MoodTrend {
  improving,      // Mood is improving
  declining,      // Mood is declining
  stable,         // Mood is stable
  fluctuating,    // Mood is fluctuating
}

// Breathing exercise types
enum BreathingType {
  box,            // Box breathing (4-4-4-4)
  fourSevenEight, // 4-7-8 breathing
  deep,           // Deep breathing
  mindful,        // Mindful breathing
  custom,         // Custom pattern
}

// Notification types
enum NotificationType {
  message,        // New message
  like,           // Post liked
  comment,        // New comment
  follow,         // New follower
  appointment,    // Appointment reminder
  mood,           // Mood check reminder
  breathing,      // Breathing exercise reminder
  system,         // System notification
  emergency,      // Emergency notification
  moderation,     // Moderation notification
}

// Notification priority
enum NotificationPriority {
  low,            // Low priority
  normal,         // Normal priority
  high,           // High priority
  urgent,         // Urgent priority
  emergency,      // Emergency priority
}

// Warning types
enum WarningType {
  harassment,     // Harassment or bullying
  spam,           // Spam or unwanted content
  inappropriate,  // Inappropriate content
  violence,       // Violence or threats
  fraud,          // Fraud or scams
  general,        // General violation
  impersonation,  // Impersonation
  copyright,      // Copyright violation
  privacy,        // Privacy violation
}

// Warning severity
enum WarningSeverity {
  low,            // Minor violation
  medium,         // Moderate violation
  high,           // Serious violation
  critical,       // Critical violation
}

// Warning status
enum WarningStatus {
  active,         // Warning is active
  expired,        // Warning has expired
  dismissed,      // Warning was dismissed
  suspended,      // Warning is suspended
  appealed,       // Warning is being appealed
}

// Appeal status
enum AppealStatus {
  none,           // No appeal submitted
  pending,        // Appeal is pending review
  approved,       // Appeal was approved
  rejected,       // Appeal was rejected
  underReview,    // Appeal is under review
}

// Expert specialization
enum ExpertSpecialization {
  general,        // General mental health
  anxiety,        // Anxiety disorders
  depression,     // Depression
  trauma,         // Trauma and PTSD
  addiction,      // Addiction
  eating,         // Eating disorders
  personality,    // Personality disorders
  child,          // Child and adolescent
  family,         // Family therapy
  couples,        // Couples therapy
  grief,          // Grief and loss
  stress,         // Stress management
  mindfulness,    // Mindfulness
  cbt,            // Cognitive Behavioral Therapy
  dbt,            // Dialectical Behavior Therapy
  emdr,           // EMDR therapy
  other,          // Other specializations
}

// Expert certification
enum ExpertCertification {
  licensed,       // Licensed professional
  certified,      // Certified professional
  registered,     // Registered professional
  intern,         // Intern or trainee
  student,        // Student
  unverified,     // Not verified
}

// Expert availability
enum ExpertAvailability {
  available,      // Available for sessions
  busy,           // Currently busy
  offline,        // Offline
  onBreak,        // On break
  unavailable,    // Unavailable
}

// Payment status
enum PaymentStatus {
  pending,        // Payment pending
  completed,      // Payment completed
  failed,         // Payment failed
  refunded,       // Payment refunded
  cancelled,      // Payment cancelled
  disputed,       // Payment disputed
}

// Payment method
enum PaymentMethod {
  creditCard,     // Credit card
  debitCard,      // Debit card
  bankTransfer,   // Bank transfer
  paypal,         // PayPal
  applePay,       // Apple Pay
  googlePay,      // Google Pay
  crypto,         // Cryptocurrency
  other,          // Other methods
}

// Subscription type
enum SubscriptionType {
  free,           // Free tier
  basic,          // Basic subscription
  premium,        // Premium subscription
  professional,   // Professional subscription
  enterprise,     // Enterprise subscription
}

// Subscription status
enum SubscriptionStatus {
  active,         // Subscription active
  expired,        // Subscription expired
  cancelled,      // Subscription cancelled
  pending,        // Subscription pending
  trial,          // Trial period
  grace,          // Grace period
}

// Theme mode
enum ThemeMode {
  light,          // Light theme
  dark,           // Dark theme
  system,         // System theme
  auto,           // Auto theme
}

// Language
enum Language {
  english,        // English
  turkish,        // Turkish
  spanish,        // Spanish
  french,         // French
  german,         // German
  italian,        // Italian
  portuguese,     // Portuguese
  russian,        // Russian
  chinese,        // Chinese
  japanese,       // Japanese
  korean,         // Korean
  arabic,         // Arabic
  hindi,          // Hindi
}

// Privacy level
enum PrivacyLevel {
  public,         // Public profile
  friends,        // Friends only
  private,        // Private profile
  custom,         // Custom privacy settings
}

// Content visibility
enum ContentVisibility {
  public,         // Visible to everyone
  friends,        // Visible to friends only
  private,        // Visible to user only
  selected,       // Visible to selected users
  anonymous,      // Anonymous posting
}

// Report reason
enum ReportReason {
  harassment,     // Harassment or bullying
  spam,           // Spam or unwanted content
  inappropriate,  // Inappropriate content
  violence,       // Violence or threats
  fraud,          // Fraud or scams
  impersonation,  // Impersonation
  copyright,      // Copyright violation
  privacy,        // Privacy violation
  other,          // Other reason
}

// Report status
enum ReportStatus {
  pending,        // Report pending review
  underReview,    // Report under review
  resolved,       // Report resolved
  dismissed,      // Report dismissed
  escalated,      // Report escalated
}

// Achievement type
enum AchievementType {
  posts,          // Post-related achievements
  mood,           // Mood tracking achievements
  breathing,      // Breathing exercise achievements
  social,         // Social interaction achievements
  streak,         // Streak achievements
  special,        // Special achievements
}

// Achievement level
enum AchievementLevel {
  bronze,         // Bronze achievement
  silver,         // Silver achievement
  gold,           // Gold achievement
  platinum,       // Platinum achievement
  diamond,        // Diamond achievement
}

// Activity type
enum ActivityType {
  post,           // Created a post
  like,           // Liked a post
  comment,        // Commented on a post
  follow,         // Followed a user
  mood,           // Logged mood
  breathing,      // Completed breathing exercise
  appointment,    // Scheduled appointment
  achievement,    // Earned achievement
  login,          // Logged in
  logout,         // Logged out
}

// Error type
enum ErrorType {
  network,        // Network error
  server,         // Server error
  authentication, // Authentication error
  authorization,  // Authorization error
  validation,     // Validation error
  notFound,       // Not found error
  timeout,        // Timeout error
  unknown,        // Unknown error
}

// Log level
enum LogLevel {
  debug,          // Debug level
  info,           // Info level
  warning,        // Warning level
  error,          // Error level
  fatal,          // Fatal level
}

// Platform
enum Platform {
  android,        // Android platform
  ios,            // iOS platform
  web,            // Web platform
  desktop,        // Desktop platform
  unknown,        // Unknown platform
}

// Connection type
enum ConnectionType {
  wifi,           // WiFi connection
  mobile,         // Mobile data
  ethernet,       // Ethernet connection
  none,           // No connection
  unknown,        // Unknown connection
}

// File type
enum FileType {
  image,          // Image file
  video,          // Video file
  audio,          // Audio file
  document,       // Document file
  archive,        // Archive file
  other,          // Other file type
}

// Permission status
enum PermissionStatus {
  granted,        // Permission granted
  denied,         // Permission denied
  restricted,     // Permission restricted
  permanentlyDenied, // Permission permanently denied
  notDetermined,  // Permission not determined
}

// Biometric type
enum BiometricType {
  fingerprint,    // Fingerprint
  face,           // Face recognition
  iris,           // Iris recognition
  voice,          // Voice recognition
  none,           // No biometric available
}

// Security level
enum SecurityLevel {
  low,            // Low security
  medium,         // Medium security
  high,           // High security
  maximum,        // Maximum security
}

// Data type
enum DataType {
  personal,       // Personal data
  sensitive,      // Sensitive data
  public,         // Public data
  anonymous,      // Anonymous data
  aggregated,     // Aggregated data
}

// Consent status
enum ConsentStatus {
  granted,        // Consent granted
  denied,         // Consent denied
  pending,        // Consent pending
  withdrawn,      // Consent withdrawn
  expired,        // Consent expired
}
