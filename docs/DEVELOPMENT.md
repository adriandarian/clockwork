# Development Guide

This guide covers how to set up your development environment and run Clockwork on different platforms.

---

## Prerequisites

- **Flutter SDK** 3.10+
- **Dart SDK** 3.10+
- **Xcode** 16+ (for iOS development)
- **CocoaPods** (for iOS dependencies)

---

## Initial Setup

```bash
# Clone the repository
git clone https://github.com/adriandarian/clockwork.git
cd clockwork

# Get Flutter dependencies
flutter pub get

# Generate freezed models (for Preset class)
dart run build_runner build
```

---

## Running on macOS

The simplest way to test the app:

```bash
flutter run -d macos
```

---

## Running on iOS Simulator

### 1. Install CocoaPods

If you don't have CocoaPods installed:

```bash
brew install cocoapods
```

### 2. Install iOS Dependencies

```bash
cd ios
pod install
cd ..
```

### 3. List Available Simulators

```bash
xcrun simctl list devices available
```

This shows all available simulator devices. Look for iOS devices like:
```
-- iOS 26.2 --
    iPhone 17 Pro (86667636-FE54-4DFD-BC5F-7BEA0AB75DEA) (Shutdown)
    iPhone 16e (B7F01843-22A7-45B6-9B0A-3F00D7FC7ED4) (Shutdown)
```

### 4. Create a Simulator (Optional)

If the device you want doesn't exist, create it:

```bash
# List available device types
xcrun simctl list devicetypes

# List available runtimes
xcrun simctl list runtimes

# Create a simulator
xcrun simctl create "iPhone 17 Pro" \
  com.apple.CoreSimulator.SimDeviceType.iPhone-17-Pro \
  com.apple.CoreSimulator.SimRuntime.iOS-26-2
```

### 5. Boot the Simulator

```bash
# Boot by UUID
xcrun simctl boot <SIMULATOR_UUID>

# Or boot by name (if unique)
xcrun simctl boot "iPhone 17 Pro"

# Open the Simulator app to see the UI
open -a Simulator
```

### 6. Run the App

```bash
# Run on a specific simulator by UUID
flutter run -d <SIMULATOR_UUID>

# Or let Flutter pick an available iOS simulator
flutter run -d ios
```

### 7. Hot Reload

While the app is running in the terminal:

| Key | Action |
|-----|--------|
| `r` | Hot reload - Apply code changes instantly |
| `R` | Hot restart - Restart app, reset state |
| `h` | Show all commands |
| `d` | Detach (keep app running, exit CLI) |
| `q` | Quit (stop the app) |

---

## Simulator Management

### Check Booted Simulators

```bash
xcrun simctl list devices booted
```

### Shutdown a Simulator

```bash
xcrun simctl shutdown <SIMULATOR_UUID>

# Or shutdown all
xcrun simctl shutdown all
```

### Delete a Simulator

```bash
xcrun simctl delete <SIMULATOR_UUID>
```

---

## Troubleshooting

### "CocoaPods not installed"

```bash
brew install cocoapods
cd ios && pod install && cd ..
```

### "No supported devices connected"

Make sure a simulator is booted:
```bash
xcrun simctl boot "iPhone 17 Pro"
open -a Simulator
```

### "Unable to boot device in current state: Booted"

The simulator is already running. Check with:
```bash
xcrun simctl list devices booted
```

### Simulator Won't Boot (launchd_sim error)

Restart the Simulator service:
```bash
killall Simulator
open -a Simulator
xcrun simctl boot <SIMULATOR_UUID>
```

### Multiple Simulator Windows

Multiple simulators may be booted. Shut down unwanted ones:
```bash
# List booted simulators
xcrun simctl list devices booted

# Shut down specific one
xcrun simctl shutdown <UNWANTED_UUID>
```

---

## Running on Physical iOS Device

1. Connect your iPhone via USB
2. Trust the computer on your device
3. Open Xcode and configure signing:
   - Open `ios/Runner.xcworkspace`
   - Select Runner target → Signing & Capabilities
   - Select your Team
4. Run:
   ```bash
   flutter run -d <DEVICE_ID>
   ```

---

## Code Generation

After modifying `preset.dart` or other freezed classes:

```bash
# One-time build
dart run build_runner build

# Watch mode (rebuilds on changes)
dart run build_runner watch
```

---

## Static Analysis

```bash
# Run Dart analyzer
flutter analyze

# Auto-fix issues
dart fix --apply
```

---

## Testing

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage
```
