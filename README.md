# Groovix - Music App

A modern Flutter music application demonstrating clean architecture, state management, and best practices for beginner developers.

## 🚀 Features

- 🎵 Music streaming interface
- 🎨 Modern Material Design 3 UI
- 🏗️ Clean Architecture with dependency injection
- 🔄 Multi-flavor support (dev, local, prod)
- 🔥 Firebase integration
-  Responsive design
- 🎯 Educational codebase for beginners

## 📋 Prerequisites

- Flutter SDK (>=3.3.1)
- Dart SDK (>=3.3.1)
- Android Studio / VS Code
- Firebase project

## 🛠️ Setup Instructions

### 1. Clone the Repository
```bash
git clone https://github.com/yourusername/groovix.git
cd groovix
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Firebase Setup

#### Create Firebase Project
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Create a new project
3. Add Android and iOS apps

#### Configure Firebase
1. **Android Setup:**
   - Download `google-services.json` from Firebase Console
   - Place it in `android/app/google-services.json`

2. **iOS Setup:**
   - Download `GoogleService-Info.plist` from Firebase Console
   - Place it in `ios/Runner/GoogleService-Info.plist`

3. **Generate Firebase Options:**
   ```bash
   dart pub global activate flutterfire_cli
   flutterfire configure
   ```

### 4. Environment Configuration
1. Copy template files:
   ```bash
   cp lib/firebase_options.template.dart lib/firebase_options.dart
   cp android/app/google-services.template.json android/app/google-services.json
   cp ios/Runner/GoogleService-Info.template.plist ios/Runner/GoogleService-Info.plist
   ```

2. Update the files with your Firebase configuration

### 5. Run the App
```bash
# Development
flutter run -t lib/main/main_dev.dart

# Production
flutter run -t lib/main/main_prod.dart

# Local
flutter run -t lib/main/main_local.dart
```

## 🏗️ Architecture

This project follows Clean Architecture principles:
