# Clockwork Documentation

Welcome to the Clockwork documentation. This folder contains comprehensive documentation for understanding, developing, and extending the project.

---

## Documents

| Document | Description |
|----------|-------------|
| [PROJECT_OVERVIEW.md](PROJECT_OVERVIEW.md) | Vision, goals, and high-level project description |
| [ARCHITECTURE.md](ARCHITECTURE.md) | Technical architecture and system design |
| [PRESET_SYSTEM.md](PRESET_SYSTEM.md) | How presets work, timer behaviors, and examples |
| [ROADMAP.md](ROADMAP.md) | Development phases, milestones, and backlog |
| [UI_UX_GUIDELINES.md](UI_UX_GUIDELINES.md) | Design principles, layouts, and interaction patterns |

---

## Quick Start

### What is Clockwork?

Clockwork is a **universal game timer** that supports thousands of game formats through a modular preset system. Instead of hardcoding specific game modes, users configure timer behaviors from building blocks.

### Core Concepts

1. **Engine** - Pure Dart rules engine (no Flutter dependencies)
2. **Presets** - JSON-configurable timer formats
3. **Events** - User actions (tap, pause, undo)
4. **State** - Current game state (times, active player, status)
5. **Effects** - Side effects (sounds, haptics)

### Architecture (TL;DR)

```
UI Layer (Flutter) 
    ↓
App State (Riverpod)
    ↓
Engine (Pure Dart)
```

---

## Key Files

### Engine
- `lib/engine/engine.dart` - Main engine controller
- `lib/engine/game_state.dart` - State model
- `lib/engine/events.dart` - Event types
- `lib/engine/effects.dart` - Side effects

### Models
- `lib/models/preset.dart` - Preset data model
- `lib/models/default_presets.dart` - Built-in presets

### Providers
- `lib/providers/game_controller.dart` - Game state provider
- `lib/providers/presets_provider.dart` - Preset management

### UI
- `lib/ui/screens/home_screen.dart` - Main menu
- `lib/ui/screens/game_screen.dart` - In-game UI
- `lib/ui/theme/app_theme.dart` - Theme definitions

---

## Development

### Prerequisites
- Flutter 3.x
- Dart 3.x

### Setup
```bash
flutter pub get
flutter run
```

### Build
```bash
flutter build apk      # Android
flutter build ios      # iOS
flutter build web      # Web
flutter build macos    # macOS
```

### Analyze
```bash
flutter analyze
```

### Test
```bash
flutter test
```

---

## Contributing

1. Read the architecture docs before making changes
2. Keep the engine pure (no Flutter imports)
3. Follow the existing code style
4. Write tests for new functionality
5. Update documentation as needed

---

## Project Origin

This project was conceived to solve a common problem: **existing timer apps are too rigid**. They support specific formats (chess clocks, countdown timers) but can't handle the variety of timing needs across board games, party games, and sports.

The solution: a rules engine that lets users configure any timer format from composable building blocks.

See [PROJECT_OVERVIEW.md](PROJECT_OVERVIEW.md) for the full vision and [ROADMAP.md](ROADMAP.md) for current status.
