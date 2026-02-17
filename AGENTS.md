# AGENTS.md — AI Agent Roles & Workflows

This file defines how to use Claude Code effectively for this project. Think of these as "modes" or "roles" you can ask Claude to operate in.

---

## How to Use This File

When starting a new Claude Code session, you can say:
> "Act as the [Agent Name] — [task description]"

Or just describe what you want to do and Claude will figure out the right approach. This file is a reference for common workflows.

---

## Agent Roles

### 1. Setup Agent
**When to use:** First time setting up on a new Mac, or when something in the environment breaks.
**Ask:** "Help me set up the development environment on my Mac"

**Responsibilities:**
- Walk through `docs/MAC_IOS_SETUP.md` step by step
- Diagnose `flutter doctor` output
- Fix Xcode signing issues
- Troubleshoot CocoaPods errors
- Get the app running on iPhone for the first time

---

### 2. Feature Builder
**When to use:** Implementing a specific screen or feature from the plan.
**Ask:** "Implement the [screen name] screen" or "Build the cart feature"

**Responsibilities:**
- Read existing scaffolded code first
- Implement one feature at a time
- Follow existing patterns (Provider, go_router, theme system)
- Wire screens to providers and Firebase
- Keep code beginner-readable with comments

**Reference:** `FOOD_ORDERING_APP_PLAN.md` for scope, `food_ordering_app/CLAUDE.md` for patterns

---

### 3. Firebase Agent
**When to use:** Setting up or debugging Firebase integration.
**Ask:** "Help me set up Firebase" or "Fix my Firestore queries"

**Responsibilities:**
- Guide Firebase Console setup
- Write Firestore read/write code
- Set up Firebase Auth flows
- Add Firebase Storage for images
- Write Firestore security rules (when ready)

---

### 4. Debugger
**When to use:** Something is broken and you don't know why.
**Ask:** "The app crashes when I do X — help me debug it"

**Responsibilities:**
- Read error messages and stack traces
- Identify root cause
- Suggest targeted fixes (not rewrites)
- Explain what went wrong in plain language

---

### 5. Code Reviewer
**When to use:** After implementing a feature, before moving on.
**Ask:** "Review the cart_provider.dart I just wrote"

**Responsibilities:**
- Check for bugs and edge cases
- Verify Firebase security (no exposed keys, proper rules)
- Flag performance issues
- Suggest improvements while keeping MVP scope

---

### 6. Design Agent
**When to use:** Implementing UI, making things look good.
**Ask:** "Make the home screen look like the design in the plan"

**Responsibilities:**
- Use the existing theme system (no hardcoded colors/sizes)
- Add loading states and empty states
- Implement animations (shimmer loading, transitions)
- Follow the color palette from `FOOD_ORDERING_APP_PLAN.md`

---

### 7. Explainer
**When to use:** You want to understand code you're looking at.
**Ask:** "Explain how the menu_provider.dart works" or "What does ChangeNotifier do?"

**Responsibilities:**
- Explain code in plain English
- Use analogies when helpful
- Answer "why" questions about architectural decisions
- Teach concepts without being condescending

---

## Recommended Session Workflow

Each coding session should follow this pattern:

### 1. Start the session
Tell Claude what you want to accomplish today:
> "Today I want to implement the login screen and connect it to Firebase Auth"

### 2. Claude reads the code first
Claude should always read existing files before suggesting changes.

### 3. Work on one thing at a time
Complete and test one feature before starting the next.

### 4. Commit when something works
```bash
git add .
git commit -m "Implement login screen with Firebase Auth"
```

### 5. Test on device before moving on
```bash
flutter run
```

---

## Phase Implementation Order

Follow this order to build the app systematically:

### Phase 1 — Get it running (Mac setup day)
1. Follow `docs/MAC_IOS_SETUP.md`
2. Get app launching on iPhone (even with placeholder screens)
3. Firebase project created and connected

### Phase 2 — Auth flow
1. Implement login screen (email/password)
2. Implement register screen
3. Wire to Firebase Auth in `auth_provider.dart`
4. Redirect to home after login
5. Persist login state

### Phase 3 — Menu
1. Add seed data to Firestore (categories + menu items)
2. Wire `menu_provider.dart` to Firestore
3. Implement home screen with categories
4. Implement menu screen with item cards
5. Implement item detail screen with customization

### Phase 4 — Cart & Checkout
1. Implement cart logic in `cart_provider.dart`
2. Implement cart screen
3. Implement checkout flow
4. Create orders in Firestore

### Phase 5 — Orders & Polish
1. Implement order history screen
2. Implement real-time order tracking
3. Add search functionality
4. Add loading states and error handling throughout
5. Polish animations and transitions

---

## Tips for Working with Claude Code

- **Be specific:** "Add a loading spinner to the menu screen while data loads" is better than "improve the menu screen"
- **One feature at a time:** Don't ask for multiple unrelated changes in one message
- **Share errors:** Paste the full error message, not just a description of it
- **Verify before continuing:** Run `flutter run` and test on device before asking for the next feature
- **Ask for explanations:** If Claude writes code you don't understand, ask "can you explain what this does?"
