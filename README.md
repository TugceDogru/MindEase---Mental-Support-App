# MindEase – Mental Health Support App

<div align="center">

![MindEase Logo](assets/icons/mental-disorder.png)

**A comprehensive Flutter-based mobile application designed to provide mental health support through innovative features and user-friendly interface.**

[![Flutter](https://img.shields.io/badge/Flutter-3.16.0-blue.svg)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.2.0-blue.svg)](https://dart.dev/)
[![Firebase](https://img.shields.io/badge/Firebase-10.7.0-orange.svg)](https://firebase.google.com/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

</div>

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Screenshots](#screenshots)
- [Architecture](#architecture)
- [Getting Started](#getting-started)
- [Project Structure](#project-structure)
- [API Documentation](#api-documentation)
- [Testing](#testing)
- [Deployment](#deployment)
- [Contributing](#contributing)
- [Support](#support)
- [License](#license)

## Overview

MindEase is a comprehensive mental health support application built with Flutter that provides users with tools for mood tracking, expert consultation, breathing exercises, and personalized mental health activities. The app features a modern, accessible design with a focus on user privacy and mental well-being.

### Key Highlights

- ** Secure Authentication** - Firebase Auth integration with email/password and social login options
- **📊 Mood Analytics** - Daily mood assessments with detailed analytics and trends
- ** Breathing Exercises** - Guided meditation sessions with customizable timers
- ** Expert Chat** - Real-time messaging with certified mental health professionals
- ** Content Moderation** - AI-powered safety features for community protection
- ** Cross-Platform** - Works seamlessly on iOS and Android devices

##  Features

### Authentication & Security
- **Multi-factor Authentication** - Enhanced security with SMS/email verification
- **Social Login Integration** - Google, Apple, and Facebook login options
- **Biometric Authentication** - Fingerprint and Face ID support
- **Session Management** - Automatic token refresh and secure logout

### Mood Tracking & Analytics
- **Daily Mood Assessment** - 15-question comprehensive mood evaluation
- **Likert Scale Responses** - 1-5 scale for precise mood measurement
- **Mood History Visualization** - Interactive charts and trend analysis
- **Personalized Insights** - AI-driven recommendations based on mood patterns
- **Mood Reminders** - Customizable notification schedules

### Breathing & Meditation
- **Guided Breathing Sessions** - 5-minute structured breathing exercises
- **Customizable Patterns** - 4s inhale, 5s hold, 6s exhale cycles
- **Visual Feedback** - Animated progress indicators and phase transitions
- **Session History** - Track progress and consistency over time
- **Multiple Techniques** - Box breathing, 4-7-8, and custom patterns

### Expert Communication
- **Real-time Chat** - Instant messaging with mental health professionals
- **Video Consultations** - Secure video calling integration
- **Appointment Scheduling** - Calendar integration with availability management
- **Chat History** - Persistent conversation storage
- **File Sharing** - Secure document and image sharing

### Content Moderation
- **AI-Powered Filtering** - Machine learning-based content analysis
- **Keyword Detection** - Customizable sensitive content filtering
- **User Reporting** - Community-driven safety features
- **Moderation Dashboard** - Admin tools for content management
- **Appeal System** - Fair review process for flagged content

### Profile & Personalization
- **Comprehensive Profiles** - Detailed user information and preferences
- **Progress Tracking** - Visual representation of mental health journey
- **Goal Setting** - Personalized mental health objectives
- **Achievement System** - Gamified progress rewards
- **Privacy Controls** - Granular data sharing permissions

## Screenshots

<div align="center">

| Login Screen | Home Dashboard | Mood Test |
|:---:|:---:|:---:|
| ![Login](screenshots/login.png) | ![Home](screenshots/home.png) | ![Mood Test](screenshots/mood_test.png) |

| Breathing Exercise | Expert Chat | Profile |
|:---:|:---:|:---:|
| ![Breathing](screenshots/breathing.png) | ![Chat](screenshots/chat.png) | ![Profile](screenshots/profile.png) |

*Screenshots will be added as the app development progresses*

</div>

## Architecture

MindEase follows a clean architecture pattern with clear separation of concerns:

```
┌─────────────────────────────────────────────────────────────┐
│                        Presentation Layer                   │
├─────────────────────────────────────────────────────────────┤
│  Views (UI)  │  ViewModels (State Management)  │  Widgets   │
├─────────────────────────────────────────────────────────────┤
│                      Business Logic Layer                   │
├─────────────────────────────────────────────────────────────┤
│  Services  │  Repositories  │  Use Cases  │  Validators    │
├─────────────────────────────────────────────────────────────┤
│                      Data Layer                            │
├─────────────────────────────────────────────────────────────┤
│  Models  │  Local Storage  │  Remote APIs  │  Firebase     │
└─────────────────────────────────────────────────────────────┘
```

### Design Patterns Used

- **MVVM (Model-View-ViewModel)** - For state management and UI logic
- **Repository Pattern** - For data access abstraction
- **Dependency Injection** - For service management
- **Observer Pattern** - For real-time updates
- **Factory Pattern** - For object creation

## Getting Started

### Prerequisites

Before you begin, ensure you have the following installed:

- **Flutter SDK** (3.16.0 or higher)
- **Dart SDK** (3.2.0 or higher)
- **Android Studio** or **VS Code** with Flutter extensions
- **Git** for version control
- **Firebase CLI** (optional, for deployment)

### System Requirements

- **Android**: API level 21 (Android 5.0) or higher
- **iOS**: iOS 12.0 or higher
- **Development**: 8GB RAM, 2GB free disk space

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/mind_ease.git
   cd mind_ease
   ```

2. **Install Flutter dependencies:**
   ```bash
   flutter pub get
   ```

3. **Install platform-specific dependencies:**
   ```bash
   # For iOS
   cd ios && pod install && cd ..
   
   # For Android
   # No additional steps required
   ```

4. **Configure Firebase:**
   
   a. Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
   
   b. Enable Authentication and Firestore services
   
   c. Download configuration files:
      - `google-services.json` → `android/app/`
      - `GoogleService-Info.plist` → `ios/Runner/`
   
   d. Update `lib/firebase_options.dart` with your project settings

5. **Configure environment variables:**
   ```bash
   # Create .env file
   cp .env.example .env
   
   # Edit .env with your configuration
   FIREBASE_API_KEY=your_api_key
   FIREBASE_PROJECT_ID=your_project_id
   ```

6. **Run the application:**
   ```bash
   # For development
   flutter run
   
   # For specific platform
   flutter run -d android
   flutter run -d ios
   ```

### Development Setup

1. **Code formatting:**
   ```bash
   dart format lib/
   ```

2. **Static analysis:**
   ```bash
   flutter analyze
   ```

3. **Run tests:**
   ```bash
   flutter test
   ```

## Project Structure

```
mind_ease/
├── android/                    # Android-specific configuration
├── ios/                       # iOS-specific configuration
├── lib/                       # Main application code
│   ├── app/                   # App configuration
│   │   ├── app.dart          # Main app widget
│   │   ├── locator.dart      # Dependency injection
│   │   └── routes.dart       # Navigation routes
│   ├── assets/icons/         # Custom app icons
│   ├── models/               # Data models
│   │   ├── user_model.dart
│   │   ├── mood_log_model.dart
│   │   ├── post_model.dart
│   │   └── ...
│   ├── repositories/         # Data access layer
│   │   ├── auth_repository.dart
│   │   ├── user_repository.dart
│   │   ├── post_repository.dart
│   │   └── ...
│   ├── services/             # Business logic services
│   │   ├── auth_service.dart
│   │   ├── firestore_service.dart
│   │   ├── moderation_service.dart
│   │   ├── notification_service.dart
│   │   └── ...
│   ├── theme/                # App theming
│   │   └── app_theme.dart
│   ├── utils/                # Helper utilities
│   │   ├── constants.dart
│   │   ├── enums.dart
│   │   └── helpers.dart
│   ├── viewmodels/           # State management
│   │   ├── auth_viewmodel.dart
│   │   ├── mood_viewmodel.dart
│   │   ├── profile_viewmodel.dart
│   │   └── ...
│   ├── views/                # UI screens
│   │   ├── auth/            # Authentication screens
│   │   ├── home/            # Main app screens
│   │   ├── mood/            # Mood tracking screens
│   │   ├── moderation/      # Moderation screens
│   │   ├── profile/         # Profile screens
│   │   ├── rooms/           # Chat room screens
│   │   └── shared/widgets/  # Reusable widgets
│   ├── firebase_options.dart # Firebase configuration
│   └── main.dart            # Application entry point
├── test/                     # Unit and widget tests
├── assets/                   # Static assets
├── pubspec.yaml             # Dependencies and configuration
├── analysis_options.yaml    # Dart analyzer configuration
└── README.md               # This file
```

## Key Dependencies

### Core Framework
- **Flutter** (3.16.0) - UI framework
- **Dart** (3.2.0) - Programming language

### State Management
- **Provider** (6.1.1) - State management solution
- **Change Notifier** - Reactive state updates

### Backend Services
- **Firebase Auth** (4.15.3) - User authentication
- **Firebase Firestore** (4.13.6) - NoSQL database
- **Firebase Storage** (11.5.6) - File storage
- **Firebase Messaging** (14.7.10) - Push notifications

### UI/UX
- **Poppins Font** - Typography
- **Custom Icons** - App-specific iconography
- **Material Design 3** - Design system

### Utilities
- **intl** (0.18.1) - Internationalization
- **shared_preferences** (2.2.2) - Local storage
- **image_picker** (1.0.4) - Image selection
- **permission_handler** (11.1.0) - Permission management

## API Documentation

### Authentication Endpoints

```dart
// User registration
Future<UserCredential> registerUser({
  required String email,
  required String password,
  required String username,
});

// User login
Future<UserCredential> loginUser({
  required String email,
  required String password,
});

// Password reset
Future<void> resetPassword(String email);

// User logout
Future<void> logout();
```

### Mood Tracking API

```dart
// Submit daily mood test
Future<void> submitMoodTest({
  required List<int> answers,
  required DateTime timestamp,
});

// Get mood history
Future<List<MoodLog>> getMoodHistory({
  required DateTime startDate,
  required DateTime endDate,
});

// Get mood analytics
Future<MoodAnalytics> getMoodAnalytics();
```

### Chat API

```dart
// Create chat room
Future<Room> createRoom({
  required String expertId,
  required String userId,
});

// Send message
Future<void> sendMessage({
  required String roomId,
  required String message,
  required String senderId,
});

// Get room messages
Stream<List<Message>> getRoomMessages(String roomId);
```

## Testing

### Running Tests

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/auth_service_test.dart

# Run tests in verbose mode
flutter test --verbose
```

### Test Structure

```
test/
├── unit/                    # Unit tests
│   ├── services/           # Service layer tests
│   ├── repositories/       # Repository layer tests
│   └── viewmodels/        # ViewModel tests
├── widget/                 # Widget tests
│   ├── auth/              # Authentication widget tests
│   ├── home/              # Home screen tests
│   └── shared/            # Shared widget tests
└── integration/           # Integration tests
    ├── app_test.dart      # Full app flow tests
    └── firebase_test.dart # Firebase integration tests
```

### Test Coverage

We aim to maintain at least 80% test coverage across the codebase:

- **Unit Tests**: 90% coverage
- **Widget Tests**: 75% coverage
- **Integration Tests**: 70% coverage

## Deployment

### Android Deployment

1. **Build release APK:**
   ```bash
   flutter build apk --release
   ```

2. **Build App Bundle (recommended):**
   ```bash
   flutter build appbundle --release
   ```

3. **Sign the app:**
   ```bash
   # Generate keystore (first time only)
   keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
   
   # Configure signing in android/app/build.gradle
   ```

4. **Upload to Google Play Console**

### iOS Deployment

1. **Build for release:**
   ```bash
   flutter build ios --release
   ```

2. **Archive in Xcode:**
   - Open `ios/Runner.xcworkspace`
   - Select "Any iOS Device" as target
   - Product → Archive

3. **Upload to App Store Connect**

### Firebase Deployment

```bash
# Deploy Firebase functions
firebase deploy --only functions

# Deploy Firestore rules
firebase deploy --only firestore:rules

# Deploy hosting (if applicable)
firebase deploy --only hosting
```

## Contributing

We welcome contributions from the community! Please follow these guidelines:

### Development Workflow

1. **Fork the repository**
2. **Create a feature branch:**
   ```bash
   git checkout -b feature/amazing-feature
   ```
3. **Make your changes** following our coding standards
4. **Write tests** for new functionality
5. **Commit your changes:**
   ```bash
   git commit -m 'feat: add amazing feature'
   ```
6. **Push to your branch:**
   ```bash
   git push origin feature/amazing-feature
   ```
7. **Open a Pull Request**

### Coding Standards

- Follow [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Use meaningful variable and function names
- Add comments for complex logic
- Write unit tests for all new features
- Update documentation as needed

### Commit Message Format

We use [Conventional Commits](https://www.conventionalcommits.org/):

```
type(scope): description

feat(auth): add biometric authentication
fix(chat): resolve message ordering issue
docs(readme): update installation instructions
```

## Known Issues

- [Issue #123] - Memory leak in chat screen (in progress)
- [Issue #124] - iOS notification permissions (planned)
- [Issue #125] - Offline mode support (planned)

## Support

### Getting Help

- **Documentation**: Check this README and inline code comments
- **Issues**: Create an issue on GitHub for bugs or feature requests
- **Discussions**: Use GitHub Discussions for questions and ideas
- **Email**: support@mindease.app

### Community

- **Discord**: Join our [Discord server](https://discord.gg/mindease)
- **Twitter**: Follow [@MindEaseApp](https://twitter.com/MindEaseApp)
- **Blog**: Read our [development blog](https://blog.mindease.app)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

```
MIT License

Copyright (c) 2024 MindEase Team

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

## Acknowledgments

### Open Source Contributors
- **Flutter Team** - For the amazing cross-platform framework
- **Firebase Team** - For robust backend services
- **Material Design Team** - For beautiful design guidelines

### Mental Health Professionals
- **Dr. Sarah Johnson** - Clinical psychology consultation
- **Dr. Michael Chen** - Cognitive behavioral therapy expertise
- **Dr. Emily Rodriguez** - Mindfulness and meditation guidance

### Design & UX
- **Design Studio XYZ** - UI/UX design consultation
- **Accessibility Experts** - Inclusive design guidance
- **User Research Team** - User feedback and testing

---

<div align="center">

**Made with heart for mental health awareness**

[Privacy Policy](https://mindease.app/privacy) | [Terms of Service](https://mindease.app/terms) | [Contact Us](mailto:hello@mindease.app)

</div>
