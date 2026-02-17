# Mac + iPhone Setup Guide

Complete step-by-step guide for getting the food ordering app running on your iPhone. Do this once when you first sit down at your Mac.

**Time estimate:** 45–90 minutes (most of it is waiting for downloads)

---

## Overview of Steps

1. Install Flutter on Mac
2. Install Xcode
3. Install CocoaPods
4. Create Firebase project
5. Open project in Xcode for signing
6. Run the app on iPhone

---

## Step 1: Install Flutter on Mac

Open **Terminal** on your Mac (press `Cmd + Space`, type "Terminal").

```bash
# Install Homebrew first (if you don't have it)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Flutter via Homebrew
brew install --cask flutter

# Verify Flutter is installed
flutter --version
```

If you see a Flutter version number, you're good.

```bash
# Run Flutter's diagnostic tool — it tells you exactly what's missing
flutter doctor
```

You'll see checkmarks and X marks. Work through the X marks using the steps below.

---

## Step 2: Install Xcode

1. Open the **App Store** on your Mac
2. Search for **Xcode**
3. Click **Get** / **Install** (it's free, ~15GB — this takes a while)
4. Once installed, open Xcode at least once to accept the license agreement

Then in Terminal:

```bash
# Install Xcode command line tools
xcode-select --install

# Accept the Xcode license (run if flutter doctor asks)
sudo xcodebuild -license accept
```

---

## Step 3: Install CocoaPods

Flutter iOS projects use CocoaPods to manage native iOS dependencies.

```bash
# Install CocoaPods
sudo gem install cocoapods

# Verify
pod --version
```

If you get a Ruby error, try:
```bash
brew install cocoapods
```

---

## Step 4: Clone the Repo on Mac

```bash
# Navigate to where you want the project
cd ~/Documents

# Clone the repo
git clone <your-github-repo-url> first-repo

# Navigate into the app
cd first-repo/food_ordering_app

# Install Flutter dependencies
flutter pub get

# Install iOS CocoaPods dependencies
cd ios
pod install
cd ..
```

---

## Step 5: Create Firebase Project

> **You only do this once.** The Firebase project is shared across iOS and Android.

1. Go to **https://console.firebase.google.com**
2. Click **Add project**
3. Name it something like `food-ordering-app`
4. Disable Google Analytics for now (you can add it later)
5. Click **Create project**

### Enable Authentication

1. In Firebase Console, go to **Build → Authentication**
2. Click **Get started**
3. Under **Sign-in method**, enable **Email/Password**
4. Click Save

### Enable Firestore Database

1. Go to **Build → Firestore Database**
2. Click **Create database**
3. Choose **Start in test mode** (for development — we'll secure it later)
4. Select your region (choose closest to you)

### Enable Storage

1. Go to **Build → Storage**
2. Click **Get started**
3. Accept the default security rules for now

### Add iOS App to Firebase

1. In Firebase Console, click the **iOS icon** (looks like an Apple logo)
2. **iOS bundle ID:** Enter `com.yourname.foodorderingapp` (make it unique — use your name)
   - Example: `com.johndoe.foodorderingapp`
   - **Write this down — you'll need it again in Xcode**
3. App nickname: `Food Ordering App`
4. Leave App Store ID blank for now
5. Click **Register app**
6. **Download `GoogleService-Info.plist`**
7. Click through the remaining steps (you'll add the file manually below)

### Add the Config File to the Project

```bash
# Copy the downloaded file into the iOS Runner folder
cp ~/Downloads/GoogleService-Info.plist \
   ~/Documents/first-repo/food_ordering_app/ios/Runner/
```

Or drag it in Finder to: `food_ordering_app/ios/Runner/GoogleService-Info.plist`

> **Important:** This file contains your Firebase API keys. It is in `.gitignore` and will NOT be committed to git. Keep a copy in a safe place (like your Downloads folder or a password manager).

---

## Step 6: Open in Xcode for Signing

```bash
# Open the iOS workspace (always use .xcworkspace, not .xcodeproj)
open ~/Documents/first-repo/food_ordering_app/ios/Runner.xcworkspace
```

In Xcode:

1. Click **Runner** in the left panel (the top-level blue icon)
2. Click **Runner** under **TARGETS** (not PROJECT)
3. Go to the **Signing & Capabilities** tab
4. Check **Automatically manage signing**
5. Under **Team**, select your Apple ID (you may need to add it first via **Xcode → Settings → Accounts → + → Apple ID**)
6. Under **Bundle Identifier**, change it to match what you used in Firebase:
   - Example: `com.johndoe.foodorderingapp`

If you see a red error about signing, make sure your Apple ID is added and the Team is selected.

---

## Step 7: Connect Your iPhone

1. Plug your iPhone into your Mac with a USB cable
2. On your iPhone, tap **Trust** when the "Trust This Computer?" popup appears
3. Enter your iPhone passcode if prompted
4. In Xcode, click the device selector at the top (it says something like "iPhone 15 Pro")
   - Your iPhone should appear in the list — select it

---

## Step 8: First Run

```bash
# In Terminal, from the food_ordering_app directory:
flutter devices
```

You should see your iPhone listed. Note the device ID.

```bash
# Run the app
flutter run
```

Or press the **Play button** in Xcode.

### If you get an "Untrusted Developer" error on iPhone:
1. On iPhone: **Settings → General → VPN & Device Management**
2. Find your Apple ID under "Developer App"
3. Tap it and tap **Trust**

---

## Troubleshooting

### `flutter doctor` shows issues
Run `flutter doctor -v` for verbose output and follow the suggestions.

### CocoaPods issues
```bash
cd food_ordering_app/ios
pod deintegrate
pod install
```

### Build fails with signing errors
- Make sure you're in `Runner.xcworkspace` not `Runner.xcodeproj`
- Check that your Apple ID is added in Xcode → Settings → Accounts
- Make sure Bundle ID matches Firebase exactly

### App crashes immediately on launch
- Most likely `GoogleService-Info.plist` is missing or in the wrong place
- It must be at: `food_ordering_app/ios/Runner/GoogleService-Info.plist`
- In Xcode, it should appear under `Runner/Runner/` in the file tree

### `flutter run` can't find device
```bash
flutter devices        # Lists connected devices
flutter run -d <id>    # Run on specific device
```

---

## After First Successful Run

Once the app launches on your phone, you're set up! Next steps:

1. Open the app — you'll see placeholder screens
2. Start implementing screens one by one (see `food_ordering_app/CLAUDE.md`)
3. Add seed data to Firestore via the Firebase Console
4. Ask Claude Code to help implement each feature

---

## Quick Reference Card

```bash
# Daily development commands (run from food_ordering_app/)
flutter run          # Run app on iPhone
flutter hot reload   # Press 'r' in terminal while running
flutter hot restart  # Press 'R' in terminal while running
flutter analyze      # Check for code errors
flutter clean        # Fix weird build errors
```

**Firebase Console:** https://console.firebase.google.com
**Flutter Docs:** https://docs.flutter.dev
**Firebase Flutter Docs:** https://firebase.flutter.dev
