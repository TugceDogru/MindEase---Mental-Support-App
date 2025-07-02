# MindEase – Mental Health Support App

MindEase is a Flutter-based mobile application focused on providing mental health support through mood tracking, expert chat, daily activities, breathing exercises, and more.

## Features

- **User Authentication:** Secure login and registration with Firebase Auth
- **Mood Test:** Daily 15-question mood assessment with Likert scale
- **Activities:** Personalized mental health activities and exercises
- **Breathing Exercise:** Guided 5-minute breathing sessions with animated progress
- **Expert Chat:** Real-time chat with mental health experts
- **Moderation System:** AI/keyword-based moderation for safe communication
- **Profile Management:** User profile, history, and progress tracking
- **Custom UI/UX:** Modern design with Poppins font and consistent color scheme (#010221)

## Screenshots

*Add screenshots of your main screens here (login, home, mood test, activities, etc.)*

## Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio / VS Code
- Firebase project setup

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/mind_ease.git
   cd mind_ease
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase:**
   - Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
   - Add your `google-services.json` (Android) to `android/app/`
   - Add your `GoogleService-Info.plist` (iOS) to `ios/Runner/`
   - Enable Authentication and Firestore in Firebase Console

4. **Run the app:**
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── app/                    # App configuration and routing
├── assets/icons/          # Custom app icons
├── models/                # Data models
├── repositories/          # Data access layer
├── services/              # Business logic services
├── theme/                 # App theme and styling
├── utils/                 # Helper functions and constants
├── viewmodels/            # State management
├── views/                 # UI screens
│   ├── auth/             # Authentication screens
│   ├── home/             # Main app screens
│   ├── mood/             # Mood and activity screens
│   ├── moderation/       # Moderation system screens
│   ├── profile/          # User profile screens
│   ├── rooms/            # Chat room screens
│   └── shared/widgets/   # Reusable widgets
└── main.dart             # App entry point
```

## Key Dependencies

- **Flutter:** UI framework
- **Firebase Auth:** User authentication
- **Firebase Firestore:** Database
- **Provider:** State management
- **Poppins Font:** Typography

## Features in Detail

### Mood Tracking
- Daily mood assessment with 15 questions
- Likert scale responses (1-5)
- Mood history and trends
- Personalized recommendations

### Breathing Exercises
- 5-minute guided sessions
- 4s inhale, 5s hold, 6s exhale cycles
- Animated progress indicators
- Session history tracking

### Expert Chat
- Real-time messaging with mental health experts
- Room-based chat system
- Moderation and safety features
- Appointment scheduling

### Moderation System
- AI-powered content filtering
- Keyword-based detection
- User feedback integration
- Moderation history tracking

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Testing

Run tests with:
```bash
flutter test
```

For coverage:
```bash
flutter test --coverage
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

For support, email support@mindease.app or create an issue in this repository.

## Acknowledgments

- Flutter team for the amazing framework
- Firebase for backend services
- Mental health professionals for domain expertise 