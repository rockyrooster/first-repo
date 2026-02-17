# CLAUDE.md — Food Ordering App

App-specific instructions for Claude Code. See root `CLAUDE.md` for repo-wide context.

---

## App Status: In Development

**Current phase:** Foundation complete, core features next
**Target platform:** iOS (iPhone) — primary. Android secondary.

---

## What's Done vs. What's Next

### Done (Scaffolded)
| Area | Files | Status |
|------|-------|--------|
| Theme | `core/theme/` | Complete — colors, text, theme |
| Constants | `core/constants/app_constants.dart` | Complete |
| Routes | `core/routes/app_routes.dart` | Scaffolded — needs screen wiring |
| Utils | `core/utils/` | Scaffolded |
| Models | `data/models/*.dart` | Complete — all 5 models |
| Providers | `providers/*.dart` | Scaffolded — needs Firebase wiring |
| Auth screens | `screens/auth/` | Scaffolded — needs real logic |
| Home screen | `screens/home/` | Scaffolded |
| Menu screen | `screens/menu/` | Scaffolded |
| Cart screen | `screens/cart/` | Scaffolded |
| Checkout screen | `screens/checkout/` | Scaffolded |
| Order screens | `screens/orders/` | Scaffolded |
| Search screen | `screens/search/` | Scaffolded |
| Widgets | `widgets/` | Scaffolded |

### Not Yet Done (Needs Mac + Firebase)
- [ ] Firebase project creation
- [ ] Add `GoogleService-Info.plist` to `ios/Runner/`
- [ ] iOS signing in Xcode
- [ ] Wire Firebase Auth → `auth_provider.dart`
- [ ] Wire Firestore → `menu_provider.dart`
- [ ] Wire Firestore → `order_provider.dart`
- [ ] Implement real cart logic in `cart_provider.dart`
- [ ] Populate Firestore with seed menu data
- [ ] Add food images to `assets/images/`
- [ ] Build and run on iPhone

---

## Architecture

```
lib/
├── main.dart               ← App entry, Firebase.initializeApp()
├── app.dart                ← MaterialApp, theme, router
├── core/
│   ├── theme/              ← Colors, text styles, ThemeData
│   ├── constants/          ← App-wide constants (strings, dimensions)
│   ├── routes/             ← go_router configuration
│   └── utils/              ← Validators, helper functions
├── data/
│   ├── models/             ← Plain Dart classes (User, MenuItem, Order, etc.)
│   ├── repositories/       ← Firebase data access layer (not yet created)
│   └── services/           ← Firebase service wrapper (not yet created)
├── presentation/
│   ├── screens/            ← One folder per feature (auth, home, menu, etc.)
│   └── widgets/            ← Reusable UI components
└── providers/              ← ChangeNotifier providers for state management
```

---

## State Management Pattern

Using **Provider** with `ChangeNotifier`. Pattern to follow:

```dart
// In a provider:
class MenuProvider extends ChangeNotifier {
  List<MenuItem> _items = [];
  List<MenuItem> get items => _items;

  Future<void> fetchItems() async {
    // Fetch from Firestore
    notifyListeners();
  }
}

// In a screen:
final menuProvider = context.watch<MenuProvider>();
```

Providers are registered in `app.dart` via `MultiProvider`.

---

## Navigation Pattern

Using **go_router**. Routes defined in `core/routes/app_routes.dart`.

```dart
// Navigate to a screen:
context.go('/home');
context.push('/menu/item/${item.id}');
context.pop();
```

---

## Design System

Always use theme values — never hardcode colors or text sizes:

```dart
// Colors (from AppColors):
Theme.of(context).colorScheme.primary   // Coffee brown #6B4226
Theme.of(context).colorScheme.secondary // Fresh green #4CAF50

// Text (from AppTextStyles):
Theme.of(context).textTheme.headlineLarge
Theme.of(context).textTheme.bodyMedium

// Custom button widget:
CustomButton(text: 'Add to Cart', onPressed: () {})
```

---

## Firebase Collections Structure

Firestore database layout (to be created):

```
/users/{userId}
  - email, name, phone, addresses[], createdAt

/categories/{categoryId}
  - name, imageUrl, order

/menuItems/{itemId}
  - name, description, price, imageUrl, categoryId, available, tags[]

/orders/{orderId}
  - userId, items[], status, total, deliveryAddress, type, createdAt

/cart/{userId}   ← optional, can use local state instead
  - items[]
```

---

## Seed Data (Add to Firestore on First Run)

Categories to create:
- Coffee
- Food
- Cold Drinks
- Pastries
- Specials

Sample menu items per category (add manually via Firebase Console or via a seed script).

---

## Known Issues / Watch Out For

- `main.dart` calls `Firebase.initializeApp()` — this will crash until `GoogleService-Info.plist` is added
- `go_router` version 13 has a slightly different API than older tutorials — use `context.go()` not `Navigator.push()`
- Firebase emulator can be used for local development without a real Firebase project (advanced — skip for MVP)

---

## Useful Flutter Commands (run from this directory)

```bash
flutter pub get          # After changing pubspec.yaml
flutter analyze          # Check for code issues
flutter run              # Run on connected device
flutter run --debug      # Explicit debug mode (default)
flutter logs             # View device logs
flutter clean            # Clear build cache (fixes weird build errors)
flutter pub upgrade      # Update dependencies
```
