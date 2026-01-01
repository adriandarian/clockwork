# Architecture Overview

Clockwork follows a **3-layer architecture** designed for testability, reusability, and clean separation of concerns.

```
┌─────────────────────────────────────────────────────────┐
│                      UI Layer                           │
│   (Flutter Widgets, Screens, Theme)                     │
├─────────────────────────────────────────────────────────┤
│                  App State Layer                        │
│   (Riverpod Providers, Persistence)                     │
├─────────────────────────────────────────────────────────┤
│                Timer/Rules Engine                       │
│   (Pure Dart - No Flutter imports)                      │
└─────────────────────────────────────────────────────────┘
```

---

## Layer 1: Timer/Rules Engine (Pure Dart)

**Location**: `lib/engine/`

The heart of the application. Zero Flutter imports, zero UI, zero async state. Just deterministic logic.

### Core Concepts

```
Input: Preset + Event → Engine → Output: NewState + Effects
```

### Key Files

| File | Purpose |
|------|---------|
| `engine.dart` | Main engine controller, ticker management |
| `game_state.dart` | Immutable state model (players, times, status) |
| `events.dart` | Event types (tap, pause, undo, tick, timeout) |
| `effects.dart` | Side effects (sounds, haptics) |

### Event Types

```dart
sealed class GameEvent {
  StartGameEvent()
  TapEvent(playerId)
  PauseEvent()
  ResumeEvent()
  UndoEvent()
  TickEvent(elapsed)
  TimeoutEvent(playerId)
}
```

### State Model

```dart
class GameState {
  GameStatus status;          // notStarted, running, paused, finished
  List<PlayerState> players;  // Each player's time/state
  int activePlayerId;         // Who's turn it is
  int moveCount;              // Total moves made
  List<GameState> history;    // For undo support
}
```

### Why Pure Dart?

1. **Unit testable** with `dart test` (fast, no emulator)
2. **Reusable** across platforms (web, desktop, CLI)
3. **Deterministic** - same input always produces same output
4. **Portable** - could be extracted as a standalone package

---

## Layer 2: App State + Persistence

**Location**: `lib/providers/`

Bridges the pure engine with Flutter's reactive UI.

### Responsibilities

- Hold current game state
- Manage preset library
- Handle persistence (favorites, custom presets)
- Execute effects (sounds, haptics)

### Key Providers

| Provider | Purpose |
|----------|---------|
| `gameControllerProvider` | Wraps engine, manages game lifecycle |
| `presetsProvider` | Loads/saves preset library |
| `selectedPresetProvider` | Currently selected preset |

### State Management Flow

```
User Tap → Provider → Engine.dispatch(event) → New State → UI rebuilds
```

---

## Layer 3: UI

**Location**: `lib/ui/`

Flutter widgets organized by function.

### Structure

```
lib/ui/
├── screens/
│   ├── home_screen.dart      # Preset selection, quick start
│   └── game_screen.dart      # In-game timer interface
├── widgets/
│   ├── preset_card.dart      # Preset display card
│   ├── player_tap_zone.dart  # Large tappable area
│   └── timer_display.dart    # Animated time display
└── theme/
    └── app_theme.dart        # Colors, typography, themes
```

### Key UI Principles

1. **Big tap zones** - Entire screen regions for player taps
2. **Zero friction** - One tap to end turn
3. **Clear feedback** - Color changes, animations
4. **Accessibility** - Large text, high contrast

---

## Data Flow Diagram

```
┌─────────────────┐
│   User Input    │
│   (tap/gesture) │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│    Provider     │
│  (Riverpod)     │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│     Engine      │
│  (Pure Dart)    │
│                 │
│ dispatch(event) │
│       │         │
│       ▼         │
│   New State     │
│   + Effects     │
└────────┬────────┘
         │
         ├──────────────────┐
         │                  │
         ▼                  ▼
┌─────────────────┐  ┌─────────────────┐
│   UI Update     │  │ Execute Effects │
│ (widget rebuild)│  │ (sound/haptic)  │
└─────────────────┘  └─────────────────┘
```

---

## Timing Accuracy

### The Problem

`Timer.periodic` is unreliable - it can drift if the phone lags.

### The Solution

```dart
// Track real elapsed time
final stopwatch = Stopwatch()..start();
Duration lastElapsed = Duration.zero;

// Every tick (~50ms):
final elapsed = stopwatch.elapsed - lastElapsed;
lastElapsed = stopwatch.elapsed;
engine.dispatch(TickEvent(elapsed));
```

This ensures accurate timing regardless of device performance.

---

## Future Modularization

The codebase is designed to eventually be split:

```
/packages
  /clockwork_engine    (pure Dart package, publishable)
  /clockwork_models    (freezed models + schema)
  /clockwork_storage   (persistence adapters)
  
/apps
  /clockwork           (Flutter app)
```

This enables:
- Publishing the engine as an open-source package
- Building different UIs on the same engine
- CLI tools for testing presets
