// App-wide constants for MindEase

class AppConstants {
  // App Information
  static const String appName = 'MindEase';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'Mental Health Support App';
  
  // Firebase Collections
  static const String usersCollection = 'users';
  static const String userDetailsCollection = 'user_details';
  static const String postsCollection = 'posts';
  static const String roomsCollection = 'rooms';
  static const String moodLogsCollection = 'mood_logs';
  static const String warningsCollection = 'warnings';
  static const String appointmentsCollection = 'appointments';
  static const String expertProfilesCollection = 'expert_profiles';
  static const String moderationResultsCollection = 'moderation_results';
  static const String notificationsCollection = 'notifications';
  static const String postReportsCollection = 'post_reports';
  static const String roomReportsCollection = 'room_reports';

  // Storage Paths
  static const String userAvatarsPath = 'avatars';
  static const String postImagesPath = 'posts';
  static const String chatImagesPath = 'chat';
  static const String tempPath = 'temp';

  // API Endpoints (if using external APIs)
  static const String baseUrl = 'https://api.mindease.app';
  static const String authEndpoint = '/auth';
  static const String usersEndpoint = '/users';
  static const String postsEndpoint = '/posts';
  static const String roomsEndpoint = '/rooms';

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
  static const int searchLimit = 50;

  // Timeouts
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration requestTimeout = Duration(seconds: 10);

  // Cache
  static const Duration cacheExpiration = Duration(hours: 24);
  static const int maxCacheSize = 100 * 1024 * 1024; // 100MB

  // File Upload
  static const int maxImageSize = 5 * 1024 * 1024; // 5MB
  static const int maxFileSize = 10 * 1024 * 1024; // 10MB
  static const List<String> allowedImageTypes = ['jpg', 'jpeg', 'png', 'gif', 'webp'];
  static const List<String> allowedFileTypes = ['pdf', 'doc', 'docx', 'txt'];

  // Validation
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 128;
  static const int minUsernameLength = 3;
  static const int maxUsernameLength = 30;
  static const int maxBioLength = 500;
  static const int maxPostLength = 2000;
  static const int maxMessageLength = 1000;

  // Mood Test
  static const int moodTestQuestionsCount = 15;
  static const int moodTestMinScore = 1;
  static const int moodTestMaxScore = 5;
  static const Duration moodTestCooldown = Duration(hours: 24);

  // Breathing Exercise
  static const Duration breathingSessionDuration = Duration(minutes: 5);
  static const Duration inhaleDuration = Duration(seconds: 4);
  static const Duration holdDuration = Duration(seconds: 5);
  static const Duration exhaleDuration = Duration(seconds: 6);

  // Notifications
  static const Duration notificationDelay = Duration(seconds: 2);
  static const int maxNotificationRetries = 3;

  // Rate Limiting
  static const int maxPostsPerDay = 10;
  static const int maxMessagesPerMinute = 20;
  static const int maxLoginAttempts = 5;
  static const Duration rateLimitWindow = Duration(minutes: 15);

  // Moderation
  static const int maxReportsPerUser = 10;
  static const Duration moderationResponseTime = Duration(hours: 24);
  static const List<String> bannedWords = [
    'hate', 'kill', 'suicide', 'death', 'violence',
    // Add more banned words as needed
  ];

  // Achievement System
  static const int postsForBronze = 10;
  static const int postsForSilver = 50;
  static const int postsForGold = 100;
  static const int moodLogsForStreak = 7;
  static const int breathingSessionsForAchievement = 10;

  // Support
  static const String supportEmail = 'support@mindease.app';
  static const String feedbackEmail = 'feedback@mindease.app';
  static const String privacyEmail = 'privacy@mindease.app';
  static const String termsUrl = 'https://mindease.app/terms';
  static const String privacyUrl = 'https://mindease.app/privacy';
  static const String helpUrl = 'https://mindease.app/help';

  // Social Media
  static const String twitterUrl = 'https://twitter.com/MindEaseApp';
  static const String instagramUrl = 'https://instagram.com/mindeaseapp';
  static const String facebookUrl = 'https://facebook.com/mindeaseapp';
  static const String linkedinUrl = 'https://linkedin.com/company/mindease';

  // External Services
  static const String crisisHotline = '988'; // US National Suicide Prevention Lifeline
  static const String emergencyNumber = '911';
  static const String crisisTextLine = '741741';

  // Feature Flags
  static const bool enablePushNotifications = true;
  static const bool enableAnalytics = true;
  static const bool enableCrashReporting = true;
  static const bool enableSocialFeatures = true;
  static const bool enableModeration = true;
  static const bool enableAnonymousPosts = true;
  static const bool enableExpertChat = true;
  static const bool enableMoodTracking = true;
  static const bool enableBreathingExercises = true;

  // Debug Settings
  static const bool enableDebugLogging = true;
  static const bool enablePerformanceMonitoring = true;
  static const bool enableNetworkLogging = false;
  static const bool enableMockData = false;

  // Local Storage Keys
  static const String authTokenKey = 'auth_token';
  static const String userDataKey = 'user_data';
  static const String userPreferencesKey = 'user_preferences';
  static const String themeKey = 'theme';
  static const String languageKey = 'language';
  static const String onboardingCompletedKey = 'onboarding_completed';
  static const String lastMoodTestKey = 'last_mood_test';
  static const String notificationSettingsKey = 'notification_settings';
  static const String privacySettingsKey = 'privacy_settings';
  static const String cacheTimestampKey = 'cache_timestamp';

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);
  static const Duration breathingAnimation = Duration(seconds: 1);

  // Error Messages
  static const String networkError = 'Network connection error. Please check your internet connection.';
  static const String serverError = 'Server error. Please try again later.';
  static const String authError = 'Authentication error. Please log in again.';
  static const String permissionError = 'Permission denied. Please check your settings.';
  static const String validationError = 'Please check your input and try again.';
  static const String unknownError = 'An unknown error occurred. Please try again.';

  // Success Messages
  static const String profileUpdated = 'Profile updated successfully!';
  static const String postCreated = 'Post created successfully!';
  static const String messageSent = 'Message sent successfully!';
  static const String moodLogged = 'Mood logged successfully!';
  static const String roomCreated = 'Chat room created successfully!';
  static const String passwordChanged = 'Password changed successfully!';
  static const String accountDeleted = 'Account deleted successfully!';

  // Info Messages
  static const String loadingMessage = 'Loading...';
  static const String savingMessage = 'Saving...';
  static const String uploadingMessage = 'Uploading...';
  static const String processingMessage = 'Processing...';
  static const String connectingMessage = 'Connecting...';

  // Warning Messages
  static const String unsavedChanges = 'You have unsaved changes. Are you sure you want to leave?';
  static const String deleteConfirmation = 'Are you sure you want to delete this?';
  static const String logoutConfirmation = 'Are you sure you want to log out?';
  static const String accountDeletionWarning = 'This action cannot be undone. All your data will be permanently deleted.';

  // Placeholder Text
  static const String searchPlaceholder = 'Search...';
  static const String messagePlaceholder = 'Type a message...';
  static const String postPlaceholder = 'What\'s on your mind?';
  static const String bioPlaceholder = 'Tell us about yourself...';
  static const String usernamePlaceholder = 'Enter username';
  static const String emailPlaceholder = 'Enter email address';
  static const String passwordPlaceholder = 'Enter password';
  static const String confirmPasswordPlaceholder = 'Confirm password';

  // Default Values
  static const String defaultAvatar = 'assets/images/default_avatar.png';
  static const String defaultGroupAvatar = 'assets/images/default_group.png';
  static const String defaultPostImage = 'assets/images/default_post.png';
  static const String defaultErrorMessage = 'Something went wrong';
  static const String defaultLoadingMessage = 'Please wait...';
  static const String defaultEmptyMessage = 'No data available';
  static const String defaultRetryMessage = 'Tap to retry';

  // Regex Patterns
  static final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  static final RegExp usernameRegex = RegExp(r'^[a-zA-Z0-9_]{3,30}$');
  static final RegExp passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d@$!%*?&]{8,}$');
  static final RegExp phoneRegex = RegExp(r'^\+?[\d\s\-\(\)]{10,}$');
  static final RegExp urlRegex = RegExp(r'^https?://[^\s/$.?#].[^\s]*$');

  // Date Formats
  static const String dateFormat = 'MMM dd, yyyy';
  static const String timeFormat = 'HH:mm';
  static const String dateTimeFormat = 'MMM dd, yyyy HH:mm';
  static const String shortDateFormat = 'MM/dd/yyyy';
  static const String isoDateFormat = 'yyyy-MM-dd';
  static const String isoDateTimeFormat = 'yyyy-MM-dd HH:mm:ss';

  // Currency
  static const String defaultCurrency = 'USD';
  static const String currencySymbol = '\$';
  static const int decimalPlaces = 2;

  // Localization
  static const String defaultLanguage = 'en';
  static const List<String> supportedLanguages = ['en', 'tr', 'es', 'fr', 'de'];
  static const Map<String, String> languageNames = {
    'en': 'English',
    'tr': 'Türkçe',
    'es': 'Español',
    'fr': 'Français',
    'de': 'Deutsch',
  };

  // Accessibility
  static const double minTouchTargetSize = 44.0;
  static const double minTextSize = 12.0;
  static const double maxTextSize = 24.0;
  static const Duration screenReaderDelay = Duration(milliseconds: 100);

  // Performance
  static const int maxImageCacheSize = 50 * 1024 * 1024; // 50MB
  static const int maxMemoryCacheSize = 100 * 1024 * 1024; // 100MB
  static const Duration imageCacheExpiration = Duration(days: 7);
  static const Duration memoryCacheExpiration = Duration(hours: 1);

  // Security
  static const int passwordMinLength = 8;
  static const int passwordMaxLength = 128;
  static const int sessionTimeoutMinutes = 60;
  static const int maxFailedLoginAttempts = 5;
  static const Duration lockoutDuration = Duration(minutes: 15);
  static const bool requireBiometricAuth = false;
  static const bool enableTwoFactorAuth = false;

  // Privacy
  static const bool collectAnalytics = true;
  static const bool collectCrashReports = true;
  static const bool shareUsageData = false;
  static const bool allowPersonalizedAds = false;
  static const bool allowThirdPartyTracking = false;
  static const Duration dataRetentionPeriod = Duration(days: 365);
  static const bool enableDataExport = true;
  static const bool enableDataDeletion = true;
}
