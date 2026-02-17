# Food Ordering App

A modern, beautiful food and coffee ordering application built with Flutter and Firebase.

## Features

- 🔐 User Authentication (Email/Password, Guest Checkout)
- 🍕 Menu Browsing with Categories
- 🔍 Search & Filters
- 🛒 Shopping Cart
- 💳 Checkout Flow
- 📦 Real-time Order Tracking
- 📱 Cross-platform (iOS, Android, Web)

## Tech Stack

- **Framework:** Flutter
- **Backend:** Firebase (Auth, Firestore, Storage)
- **State Management:** Provider
- **Navigation:** go_router

## Getting Started

### Prerequisites

- Flutter SDK (>=3.2.0)
- Firebase project setup
- Android Studio / Xcode for mobile development

### Installation

1. Clone the repository
2. Navigate to the project directory:
   ```bash
   cd food_ordering_app
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Configure Firebase:
   - Add your `google-services.json` to `android/app/`
   - Add your `GoogleService-Info.plist` to `ios/Runner/`

5. Run the app:
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── core/              # Core functionality (theme, constants, utils)
├── data/              # Data layer (models, repositories, services)
├── presentation/      # UI layer (screens, widgets)
└── providers/         # State management
```

## Development Timeline

See [FOOD_ORDERING_APP_PLAN.md](../FOOD_ORDERING_APP_PLAN.md) for detailed implementation plan.

## License

See LICENSE file in root directory.
