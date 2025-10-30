# Groovix - Music App

A modern Flutter music application demonstrating clean architecture, state management, and best practices for beginner developers.

### Standard Practices
- **Clean Architecture**: The project follows clean architecture principles, separating concerns into distinct layers (presentation, domain, and data).
- **Dependency Injection**: Utilizes dependency injection for better management of dependencies and easier testing.
- **State Management**: Implements the BLoC (Business Logic Component) pattern for effective state management, ensuring a clear separation between UI and business logic.
- **Responsive Design**: Adapts to various screen sizes and orientations, providing a consistent user experience across devices.

### API Call Methods
- **Service Layer**: The application uses a service layer to handle API calls, encapsulating the logic for making requests and processing responses.
- **Data Sources**: Implements remote data sources for fetching data from APIs, ensuring that the application can easily switch between local and remote data as needed.
- **Error Handling**: Centralized error handling to manage API errors and provide user-friendly feedback.

### Functionalities
- **Music Streaming Interface**: Allows users to stream music from various sources.
- **User Authentication**: Provides user login and registration functionalities.
- **Explore Music**: Users can explore new music and playlists.
- **Library Management**: Users can manage their music library, including liked and recently played songs.
- **Search Functionality**: Enables users to search for songs, artists, and albums.
- **Player Controls**: Includes controls for playing, pausing, and skipping tracks.

### Core Functionalities
- **BLoC Pattern**: Manages the state of the application, ensuring that UI components react to changes in the underlying data.
- **Data Models**: Defines data models for songs, playlists, and user profiles, ensuring type safety and clarity.
- **Use Cases**: Implements use cases for various operations, such as fetching songs, updating user preferences, and managing playlists.


## 🚀 Features

- 🎵 Music streaming interface
- 🎨 Modern Material Design 3 UI
- 🏗️ Clean Architecture with SOLIDS
- 🏗️ Data - Domain - Presentation
- 🔄 Multi-flavor support (dev, local, prod)
- ⭐️ Responsive design
- 🎯 Educational codebase for beginners
- 💉 Dependency Injections

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

### 4. Run the App
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
