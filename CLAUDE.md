# CLAUDE.md — Project Intelligence for Claude Code

This file tells Claude Code everything it needs to know about this repository so every session starts with full context.

---

## Repository Overview

This is a personal development portfolio and learning workspace. The main active project is a **Flutter + Firebase food ordering mobile app** (`food_ordering_app/`). The repo also contains web experiments, learning resources, and project documentation.

**Owner level:** Beginner developer, learning as they build. Explanations should be clear, avoid jargon, and include the "why" behind decisions.

---

## Active Project: Food Ordering App

**Location:** `food_ordering_app/`
**Stack:** Flutter (Dart) + Firebase
**Goal:** A modern food/coffee ordering app to replace a dated existing app. MVP scope only.

### What's Already Built
- Full folder structure matching the plan in `FOOD_ORDERING_APP_PLAN.md`
- Theme system: colors, text styles, app theme (`lib/core/theme/`)
- All data models: User, MenuItem, Order, CartItem, Category (`lib/data/models/`)
- All 4 providers: auth, cart, menu, order (`lib/providers/`)
- All screens scaffolded: login, register, home, menu, cart, checkout, orders, search (`lib/presentation/screens/`)
- Shared widgets: buttons, text fields, loading indicator, menu cards (`lib/presentation/widgets/`)
- Routing setup with go_router (`lib/core/routes/app_routes.dart`)
- App entry point (`lib/main.dart`, `lib/app.dart`)

### What Still Needs To Be Done
- Firebase project creation and configuration (see `docs/MAC_IOS_SETUP.md`)
- `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) — NOT committed, added at setup
- Screen implementations (currently scaffolded/placeholder)
- Firebase Auth wiring to auth_provider
- Firestore data wiring to menu_provider and order_provider
- Real cart logic in cart_provider
- Image assets for food items
- iOS signing setup in Xcode (requires Mac)

---

## Key Commands

All commands run from the `food_ordering_app/` directory.

```bash
# Install dependencies
flutter pub get

# Run on connected device or simulator
flutter run

# Run on specific device
flutter run -d <device-id>

# List available devices
flutter devices

# Analyze code for issues
flutter analyze

# Run tests
flutter test

# Build iOS (requires Mac + Xcode)
flutter build ios

# Build Android APK
flutter build apk
```

---

## Project Structure

```
first-repo/
├── CLAUDE.md                    ← You are here
├── AGENTS.md                    ← AI agent roles and responsibilities
├── FOOD_ORDERING_APP_PLAN.md    ← Original feature plan
├── PROJECT_ROADMAP.md           ← Learning roadmap
├── food_ordering_app/           ← Main active project
│   ├── CLAUDE.md                ← App-specific Claude instructions
│   ├── lib/                     ← All Flutter/Dart source code
│   ├── ios/                     ← iOS platform code (Xcode project)
│   ├── android/                 ← Android platform code
│   ├── assets/                  ← Images, fonts, icons
│   ├── test/                    ← Flutter tests
│   └── pubspec.yaml             ← Dependencies
├── docs/
│   └── MAC_IOS_SETUP.md         ← Step-by-step Mac + iPhone setup guide
├── ios-apps/                    ← Future native iOS projects
└── web-applications/            ← Web projects
```

---

## Development Guidelines

- **State management:** Provider (already set up) — don't switch to Riverpod/BLoC for MVP
- **Navigation:** go_router (already configured) — don't change routing strategy mid-build
- **Design system:** Use existing theme colors and text styles from `lib/core/theme/` — don't hardcode colors or font sizes
- **Firebase:** Keep config files (`.plist`, `.json`) out of git — they contain API keys
- **Code style:** Follow existing patterns in the scaffolded files
- **MVP scope:** Refer to `FOOD_ORDERING_APP_PLAN.md` Phase 1-3 only. Don't build Phase 4+ features yet.

---

## Firebase Project Details

Firebase project needs to be created at https://console.firebase.google.com before the app can run.

Services needed:
- Authentication (Email/Password enabled)
- Cloud Firestore (start in test mode for development)
- Firebase Storage (for food images)

Config files go here after download:
- `food_ordering_app/android/app/google-services.json`
- `food_ordering_app/ios/Runner/GoogleService-Info.plist`

---

## Git Workflow

- Main branch: `master`
- Feature branches use prefix: `claude/`
- Always commit to feature branch, never directly to master
- Commit messages should be descriptive and reference the feature/phase

---

## Important Notes for Claude

- The user is on a **Mac** for development (not Linux — the Linux env is the Claude Code server)
- The physical device target is an **iPhone**
- iOS setup requires Xcode on Mac — see `docs/MAC_IOS_SETUP.md` for the full walkthrough
- When suggesting commands, assume the user will run them in Terminal on their Mac
- Keep explanations beginner-friendly
