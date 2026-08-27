# iOS App — Setup, Build & Run Guide

This guide explains how to set up, build, and run the Native iOS project on macOS.

## 1. Prerequisites

Make sure you have the following installed:

- macOS
- Xcode
- Git
- Apple Developer account (required for running on a physical device)

Verify Git:

```bash
git --version
```

Verify Xcode:

```bash
xcodebuild -version
```

---

## 2. Clone the Repository

Open Terminal and clone the project:

```bash
git clone <YOUR_REPOSITORY_URL>
```

Navigate to the project:

```bash
cd <PROJECT_FOLDER>
```

---

## 3. Open the iOS Project

If the project uses an Xcode workspace:

```bash
open <PROJECT_NAME>.xcworkspace
```

If it uses an Xcode project:

```bash
open <PROJECT_NAME>.xcodeproj
```

> **Note:** If the project contains a `.xcworkspace`, open the workspace instead of the `.xcodeproj`.


---

## 4. Select the Build Scheme

In Xcode:

1. Open the project/workspace.
2. Select the required **Scheme**.
3. Select an iOS Simulator from the device list.

For example:

```text
MyApp
└── iPhone 17 Pro
```

---

## 5. Configure Signing

For running the application on a physical iPhone:

1. Open the project in Xcode.
2. Select the project from the Project Navigator.
3. Select the application target.
4. Open **Signing & Capabilities**.
5. Select your **Team**.
6. Make sure **Automatically manage signing** is enabled.

For the iOS Simulator, signing is generally not required.

---

## 6. Build the Project

From Xcode:

**Product → Build**

Or use:

```text
⌘ + B
```

You can also build from Terminal:

```bash
xcodebuild \
  -project <PROJECT_NAME>.xcodeproj \
  -scheme <SCHEME_NAME> \
  -sdk iphonesimulator \
  build
```

If the project uses a workspace:

```bash
xcodebuild \
  -workspace <PROJECT_NAME>.xcworkspace \
  -scheme <SCHEME_NAME> \
  -sdk iphonesimulator \
  build
```

---

## 7. Run on iOS Simulator

Select an iPhone simulator from the Xcode device selector.

For example:

```text
iPhone 17 Pro
```

Then click:

**▶ Run**

Or press:

```text
⌘ + R
```

Xcode will build and launch the application in the selected simulator.

---

## 8. Run on a Physical iPhone

To run the application on a real iPhone:

1. Connect your iPhone to your Mac using USB or Wi-Fi.
2. Unlock your iPhone.
3. Trust the computer if prompted.
4. Select your iPhone from Xcode's device selector.
5. Select the application target.
6. Go to **Signing & Capabilities**.
7. Select your Apple Developer Team.
8. Press:

```text
⌘ + R
```

The application will be installed and launched on your iPhone.

### Developer Mode

On supported iOS versions, you may need to enable:

**Settings → Privacy & Security → Developer Mode**

Restart the device if requested and confirm Developer Mode.

---

## 9. Clean Build

If you encounter build or compilation issues, try cleaning the build folder:

**Product → Clean Build Folder**

Shortcut:

```text
⌘ + Shift + K
```

Then build again:

```text
⌘ + B
```

---

## 10. Delete Derived Data

If Xcode continues to show unexpected build or indexing issues, remove Derived Data.

From Xcode:

**Xcode → Settings → Locations → Derived Data**

Click the arrow to open the folder and delete the project's Derived Data.

Or use Terminal:

```bash
rm -rf ~/Library/Developer/Xcode/DerivedData
```

Then reopen Xcode and build again.

---

## 11. Common Build Issues

### Code Signing Error

Check:

**Target → Signing & Capabilities**

Make sure:

- Team is selected
- Bundle Identifier is unique
- Automatically manage signing is enabled

### Swift Package Dependency Error

Try:

**File → Packages → Reset Package Caches**

Then:

**File → Packages → Resolve Package Versions**

### Simulator Build Error

Try:

**Product → Clean Build Folder**

Then rebuild the project.

### Xcode Indexing Issues

Close Xcode and remove Derived Data:

```bash
rm -rf ~/Library/Developer/Xcode/DerivedData
```

Then reopen the project.

---

## 12. Run from Command Line

You can list available simulators:

```bash
xcrun simctl list devices
```

Build the application:

```bash
xcodebuild \
  -workspace <PROJECT_NAME>.xcworkspace \
  -scheme <SCHEME_NAME> \
  -sdk iphonesimulator \
  -configuration Debug \
  build
```

---

## 13. Recommended Xcode Workflow

```text
Clone Repository
       ↓
Open .xcodeproj / .xcworkspace
       ↓
Resolve Swift Package Dependencies
       ↓
Select Scheme
       ↓
Select iOS Simulator
       ↓
Build (⌘ + B)
       ↓
Run (⌘ + R)
```

---

## 14. Requirements Summary

| Requirement | Purpose |
|---|---|
| macOS | Development environment |
| Xcode | Build and run iOS application |
| Git | Clone and manage source code |
| Apple Developer Account | Required for physical-device development/signing |
| Swift Package Manager | Dependency management, if used |

> **Note:** The exact setup steps may vary depending on the Xcode version, iOS deployment target, and project configuration.