# Flutter App — Setup, Build & Run Guide

A complete guide to setting up a Flutter development environment from scratch, running the application on Android/iOS, and creating production builds.

---

## 📋 Table of Contents

- [Prerequisites](#prerequisites)
- [Flutter Installation](#flutter-installation)
- [Verify Flutter Installation](#verify-flutter-installation)
- [iOS Setup](#ios-setup)
- [Android Setup](#android-setup)
- [VS Code Setup](#vs-code-setup)
- [Create a Flutter Project](#create-a-flutter-project)
- [Project Structure](#project-structure)
- [Install Dependencies](#install-dependencies)
- [Run the Application](#run-the-application)
- [Run on iOS](#run-on-ios)
- [Run on Android](#run-on-android)
- [Hot Reload & Hot Restart](#hot-reload--hot-restart)
- [Code Analysis & Testing](#code-analysis--testing)
- [Clean Project](#clean-project)
- [Build Android](#build-android)
- [Build iOS](#build-ios)
- [Version & Build Number](#version--build-number)
- [Android Release Signing](#android-release-signing)
- [iOS App Store Release](#ios-app-store-release)
- [Recommended Development Workflow](#recommended-development-workflow)
- [Production Checklist](#production-checklist)

---

## Prerequisites

Before starting, install the following:

- Flutter SDK
- Dart SDK (included with Flutter)
- Xcode — required for iOS development
- Android Studio — required for Android development
- CocoaPods — required for many iOS dependencies
- VS Code or Android Studio
- Git

---

# Flutter Installation

Download and install Flutter from the official documentation:

https://docs.flutter.dev/get-started/install

For macOS, extract Flutter to:

```bash
~/development/flutter
```

Add Flutter to your PATH:

```bash
nano ~/.zshrc
```

Add:

```bash
export PATH="$HOME/development/flutter/bin:$PATH"
```

Reload the shell:

```bash
source ~/.zshrc
```

Verify the installation:

```bash
flutter --version
```

---

# Verify Flutter Installation

Run:

```bash
flutter doctor
```

For detailed information:

```bash
flutter doctor -v
```

Flutter Doctor should ideally show:

```text
[✓] Flutter
[✓] Android toolchain
[✓] Xcode
[✓] Chrome
[✓] Android Studio
[✓] VS Code
```

If anything is marked with `[!]` or `[✗]`, follow the instructions provided by `flutter doctor`.

---

# iOS Setup

## Install Xcode

Install Xcode from the Mac App Store.

Configure Xcode:

```bash
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
```

Run the first-time setup:

```bash
sudo xcodebuild -runFirstLaunch
```

Accept the Xcode license if required:

```bash
sudo xcodebuild -license
```

Verify:

```bash
flutter doctor
```

---

## Install CocoaPods

Using Homebrew:

```bash
brew install cocoapods
```

Verify:

```bash
pod --version
```

---

# Android Setup

Download Android Studio:

https://developer.android.com/studio

Open:

**Android Studio → Settings → Languages & Frameworks → Android SDK**

Make sure the following are installed:

- Android SDK
- Android SDK Platform
- Android SDK Command-line Tools
- Android SDK Build-Tools
- Android Emulator

---

## Configure Android SDK

The default Android SDK location on macOS is usually:

```text
~/Library/Android/sdk
```

Add the following to `~/.zshrc`:

```bash
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$ANDROID_HOME/platform-tools:$PATH"
export PATH="$ANDROID_HOME/emulator:$PATH"
```

Reload:

```bash
source ~/.zshrc
```

Verify:

```bash
adb --version
```

---

## Accept Android Licenses

Run:

```bash
flutter doctor --android-licenses
```

Accept all required licenses by entering:

```text
y
```

Then verify:

```bash
flutter doctor
```

---

# VS Code Setup

Download VS Code:

https://code.visualstudio.com/

Install the following extensions:

- Flutter
- Dart

Open your project:

```bash
code .
```

---

# Create a Flutter Project

Create a new project:

```bash
flutter create my_app
```

Navigate to the project:

```bash
cd my_app
```

Open in VS Code:

```bash
code .
```

---

# Project Structure

A standard Flutter project looks like:

```text
my_app/
│
├── android/
├── ios/
├── lib/
│   └── main.dart
├── test/
├── web/
├── macos/
├── windows/
├── pubspec.yaml
└── README.md
```

### Important Files

#### `lib/main.dart`

The main entry point of the Flutter application.

```dart
void main() {
  runApp(const MyApp());
}
```

#### `pubspec.yaml`

Contains:

- Project information
- Dependencies
- Assets
- Fonts
- Version/build number

Example:

```yaml
dependencies:
  flutter:
    sdk: flutter

  dio: ^5.0.0
  flutter_bloc: ^8.0.0
```

#### `android/`

Contains the native Android project and configuration.

#### `ios/`

Contains the native iOS project and configuration.

---

# Install Dependencies

After cloning an existing project or changing `pubspec.yaml`, run:

```bash
flutter pub get
```

---

# Run the Application

Check available devices:

```bash
flutter devices
```

Example:

```text
Chrome
iPhone 16 Pro
sdk gphone64 arm64
macOS
```

Run the application:

```bash
flutter run
```

Or specify a device:

```bash
flutter run -d <device-id>
```

---

# Run on iOS

## iOS Simulator

Open the Simulator:

```bash
open -a Simulator
```

Check available devices:

```bash
flutter devices
```

Run:

```bash
flutter run
```

Or:

```bash
flutter run -d "iPhone 16 Pro"
```

---

## Run on Physical iPhone

Connect the iPhone to your Mac.

Check:

```bash
flutter devices
```

Your iPhone should appear in the device list.

Run:

```bash
flutter run -d <device-id>
```

---

# iOS Signing Configuration

Open the iOS workspace:

```bash
open ios/Runner.xcworkspace
```

> **Important:** Open `Runner.xcworkspace` instead of `Runner.xcodeproj` when using CocoaPods.

In Xcode:

**Runner → Signing & Capabilities**

Enable:

```text
Automatically manage signing
```

Select your Apple Developer Team.

Set a unique Bundle Identifier:

```text
com.yourcompany.myapp
```

---

# Run on Android

## Android Emulator

Open Android Studio:

**Device Manager → Create Virtual Device**

Create and start an emulator.

Check:

```bash
flutter devices
```

Run:

```bash
flutter run
```

---

## Physical Android Device

Enable:

**Developer Options → USB Debugging**

Connect the Android device.

Check:

```bash
adb devices
```

Then:

```bash
flutter devices
```

Run:

```bash
flutter run
```

---

# Hot Reload & Hot Restart

While the application is running in the terminal:

### Hot Reload

Press:

```text
r
```

Hot Reload updates the application without restarting the entire app and generally preserves the current state.

### Hot Restart

Press:

```text
R
```

Hot Restart restarts the Dart application state.

| Feature | Hot Reload | Hot Restart |
|---|---|---|
| Update UI | ✅ | ✅ |
| Preserve State | ✅ | ❌ |
| Restart Dart State | ❌ | ✅ |
| Speed | Faster | Slower |

---

# Code Analysis & Testing

## Analyze Code

Run:

```bash
flutter analyze
```

Expected result:

```text
No issues found!
```

---

## Run Tests

Run all tests:

```bash
flutter test
```

Run a specific test:

```bash
flutter test test/widget_test.dart
```

---

# Clean Project

When facing build or dependency issues:

```bash
flutter clean
```

Then:

```bash
flutter pub get
```

For iOS, if required:

```bash
cd ios
pod deintegrate
pod install
cd ..
```

Then:

```bash
flutter run
```

---

# Build Android

## Build Release APK

```bash
flutter build apk --release
```

APK location:

```text
build/app/outputs/flutter-apk/app-release.apk
```

---

## Build Android App Bundle

For Google Play Store distribution:

```bash
flutter build appbundle --release
```

AAB location:

```text
build/app/outputs/bundle/release/app-release.aab
```

The **AAB** format is generally preferred for Google Play distribution.

---

# Android Release Signing

For production releases, configure an Android upload keystore.

Generate a keystore:

```bash
keytool -genkeypair \
  -v \
  -keystore ~/upload-keystore.jks \
  -keyalg RSA \
  -keysize 2048 \
  -validity 10000 \
  -alias upload
```

Create:

```text
android/key.properties
```

Configure your Gradle signing settings accordingly.

### Important

Never commit your keystore or passwords to Git.

Add the following to `.gitignore`:

```text
android/key.properties
*.jks
*.keystore
```

---

# Build iOS

Build an iOS release:

```bash
flutter build ios --release
```

For App Store distribution, open:

```bash
open ios/Runner.xcworkspace
```

Then in Xcode:

```text
Product → Archive
```

---

# iOS App Store Release

After creating the archive:

```text
Xcode
  ↓
Product → Archive
  ↓
Organizer
  ↓
Distribute App
  ↓
App Store Connect
  ↓
Upload
```

Manage your application through App Store Connect:

https://appstoreconnect.apple.com/

---

# Version & Build Number

Flutter version information is configured in:

```text
pubspec.yaml
```

Example:

```yaml
version: 1.0.0+1
```

Where:

```text
1.0.0 = Version Name
1     = Build Number
```

Example:

```yaml
version: 1.2.0+15
```

Means:

```text
Version: 1.2.0
Build:   15
```

Every new store build should generally use an incremented build number.

---

# Flutter Build Modes

Flutter supports three primary build modes.

## Debug

```bash
flutter run
```

Used during development.

## Profile

```bash
flutter run --profile
```

Used for performance analysis.

## Release

```bash
flutter run --release
```

Used for production testing.

For release builds:

```bash
flutter build apk --release
```

or:

```bash
flutter build appbundle --release
```

---

# Clone an Existing Flutter Project

When working with an existing repository:

```bash
git clone <repository-url>
```

Navigate to the project:

```bash
cd <project-directory>
```

Check Flutter:

```bash
flutter --version
```

Install dependencies:

```bash
flutter pub get
```

For iOS:

```bash
cd ios
pod install
cd ..
```

Check available devices:

```bash
flutter devices
```

Run:

```bash
flutter run
```

---

# Recommended Development Workflow

A typical development workflow:

```bash
# Get latest source code
git pull

# Install dependencies
flutter pub get

# Check code quality
flutter analyze

# Run tests
flutter test

# Check available devices
flutter devices

# Run application
flutter run
```

During development:

```text
Code Changes
     ↓
Hot Reload
     ↓
Test
     ↓
flutter analyze
     ↓
flutter test
```

---

# Production Build Workflow

Before creating a production release:

```bash
flutter clean
flutter pub get
flutter analyze
flutter test
```

### Android

```bash
flutter build appbundle --release
```

### iOS

```bash
flutter build ios --release
```

Then create an Archive using Xcode.

---

# Complete Flutter Workflow

```text
┌──────────────────────────┐
│      Install Flutter     │
└────────────┬─────────────┘
             ↓
┌──────────────────────────┐
│      flutter doctor      │
└────────────┬─────────────┘
             ↓
┌──────────────────────────┐
│ Install Xcode / Android  │
│ Studio / CocoaPods       │
└────────────┬─────────────┘
             ↓
┌──────────────────────────┐
│    Create / Clone App    │
└────────────┬─────────────┘
             ↓
┌──────────────────────────┐
│     flutter pub get      │
└────────────┬─────────────┘
             ↓
┌──────────────────────────┐
│      flutter devices     │
└────────────┬─────────────┘
             ↓
┌──────────────────────────┐
│       flutter run        │
└────────────┬─────────────┘
             ↓
       ┌─────┴─────┐
       ↓           ↓
    Android       iOS
       ↓           ↓
     Test        Test
       ↓           ↓
       └─────┬─────┘
             ↓
┌──────────────────────────┐
│    flutter analyze       │
│    flutter test          │
└────────────┬─────────────┘
             ↓
       ┌─────┴─────┐
       ↓           ↓
    Android       iOS
       ↓           ↓
    AAB Build     Archive
       ↓           ↓
  Play Console   App Store
```

---

# Production Checklist

Before submitting the application:

- [ ] `flutter doctor` passes
- [ ] `flutter pub get`
- [ ] `flutter analyze`
- [ ] `flutter test`
- [ ] Test on iOS Simulator
- [ ] Test on physical iPhone
- [ ] Test on Android Emulator
- [ ] Test on physical Android device
- [ ] Verify API configuration
- [ ] Verify app permissions
- [ ] Verify app icon
- [ ] Verify splash/launch screen
- [ ] Verify Bundle Identifier
- [ ] Verify Android Application ID
- [ ] Verify version number
- [ ] Increment build number
- [ ] Configure Android signing
- [ ] Configure iOS signing
- [ ] Build Android AAB
- [ ] Create iOS Archive
- [ ] Test production build
- [ ] Upload to Google Play Console
- [ ] Upload to App Store Connect

---

## Useful Commands

```bash
# Flutter version
flutter --version

# Flutter diagnostics
flutter doctor -v

# Get dependencies
flutter pub get

# Analyze project
flutter analyze

# Run tests
flutter test

# List devices
flutter devices

# Run app
flutter run

# Clean project
flutter clean

# Build APK
flutter build apk --release

# Build AAB
flutter build appbundle --release

# Build iOS
flutter build ios --release
```

---

## Official Documentation

- Flutter: https://flutter.dev/
- Flutter Documentation: https://docs.flutter.dev/
- Android Studio: https://developer.android.com/studio
- Xcode: https://developer.apple.com/xcode/
- App Store Connect: https://appstoreconnect.apple.com/