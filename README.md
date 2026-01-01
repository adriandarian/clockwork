# Clockwork ⏱️

A universal game timer app built with Flutter that supports multiple game formats - chess clocks, reset-per-move timers, and more.

## Features

- **Multiple Timer Formats**
  - Reset-per-move (30s, 10s, 60s) - timer resets after each tap
  - Chess timers (Bullet, Blitz, Rapid, Classical)
  - Increment support (Fischer style)
  - Custom timer configurations

- **Clean Architecture**
  - Pure Dart timer engine (no Flutter dependencies)
  - Event-driven state management
  - Riverpod for reactive UI

- **Great UX**
  - Large tap zones for easy turn-ending
  - OLED-friendly dark theme
  - Haptic feedback
  - Pause, undo, and reset controls

## Getting Started

### Prerequisites

- Flutter SDK 3.10+ 
- Dart 3.10+

### Installation

```bash
# Clone the repository
git clone https://github.com/adriandarian/clockwork.git
cd clockwork

# Get dependencies
flutter pub get

# Generate freezed models
dart run build_runner build

# Run the app
flutter run
```

### Running on iOS Simulator

To run the app on an iOS simulator:

```bash
# Install CocoaPods (if not installed)
brew install cocoapods

# Install iOS dependencies
cd ios && pod install && cd ..

# List available simulators
xcrun simctl list devices available

# Create a new simulator (if needed)
xcrun simctl create "iPhone 17 Pro" \
  com.apple.CoreSimulator.SimDeviceType.iPhone-17-Pro \
  com.apple.CoreSimulator.SimRuntime.iOS-26-2

# Boot the simulator
xcrun simctl boot <SIMULATOR_UUID>

# Open Simulator app
open -a Simulator

# Run the app on the simulator
flutter run -d <SIMULATOR_UUID>
```

**Hot Reload Commands** (while app is running):
- `r` - Hot reload (instant code changes)
- `R` - Hot restart (resets app state)
- `q` - Quit

### Running on macOS

```bash
flutter run -d macos
```

## Project Structure

```
lib/
├── engine/           # Pure Dart timer engine (no Flutter)
│   ├── engine.dart   # Core timer logic
│   ├── events.dart   # Event definitions (tap, pause, etc.)
│   ├── effects.dart  # Side effects (sounds, haptics)
│   └── game_state.dart
├── models/           # Data models
│   ├── preset.dart   # Timer preset configuration
│   └── default_presets.dart
├── providers/        # Riverpod state management
│   ├── game_controller.dart
│   └── presets_provider.dart
├── ui/
│   ├── screens/      # App screens
│   ├── widgets/      # Reusable widgets
│   └── theme/        # App theming
└── main.dart
```

## Preset Formats

### Reset Timers
- **30s Reset** - 30 seconds per move, resets on tap
- **10s Reset** - Fast! 10 seconds per move
- **1min Reset** - One minute per move

### Chess Timers
- **Bullet 1+0** - 1 minute total
- **Blitz 3+2** - 3 minutes + 2 second increment
- **Blitz 5+3** - 5 minutes + 3 second increment
- **Rapid 10+5** - 10 minutes + 5 second increment
- **Rapid 15+10** - 15 minutes + 10 second increment
- **Classical 30min** - 30 minutes per player

## Roadmap

- [ ] Custom preset builder
- [ ] Byo-yomi timer support
- [ ] Team mode (shared clock)
- [ ] Audio announcements
- [ ] Apple Watch companion
- [ ] Preset sharing

## License

MIT