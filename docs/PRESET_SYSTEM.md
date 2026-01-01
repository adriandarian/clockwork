# Preset System

Presets are the core innovation of Clockwork. Instead of hardcoding game modes, users configure **building blocks** to create any timer format.

---

## What is a Preset?

A Preset is a JSON-serializable configuration that defines:

- Number of players/teams
- Timer behavior(s)
- Tap/turn logic
- Win/lose conditions
- Optional counters

---

## Preset Schema

```dart
@freezed
class Preset with _$Preset {
  const factory Preset({
    required String id,
    required String name,
    String? description,
    required int playerCount,
    required Duration mainTime,
    Duration? moveTime,          // For reset-per-move timers
    Duration? increment,         // Time added after each move
    Duration? delay,             // Delay before clock starts
    @Default(false) bool isFavorite,
    @Default([]) List<String> tags,
  }) = _Preset;
}
```

---

## Timer Behaviors

### 1. Main Time (Countdown)

Standard countdown timer. When it hits zero, player loses.

```
Example: 5 minutes per player
- Player taps → clock switches
- No reset, no increment
```

**Use cases**: Blitz chess, speed games

### 2. Main Time + Increment (Fischer)

Time is added after each move.

```
Example: 5 minutes + 3 seconds per move
- Player taps → +3s added → clock switches
```

**Use cases**: Rapid chess, competitive games

### 3. Main Time + Delay (Bronstein)

A delay period before the clock starts counting.

```
Example: 5 minutes + 10 second delay
- Player taps → 10s grace period → then clock ticks
```

**Use cases**: Classical chess (US rules)

### 4. Move Time (Reset per turn)

Clock resets to a fixed value after each move.

```
Example: 30 seconds per move
- Player taps → clock resets to 30s → clock switches
```

**Use cases**: Party games, trivia, casual board games

### 5. Byo-yomi (Future)

Main time + overtime periods.

```
Example: 10 minutes + 3×30s periods
- Main time runs out → 3 periods of 30s each
- If period expires without move → lose a period
- Lose all periods → lose game
```

**Use cases**: Go, Shogi

---

## Turn Logic Options

| Mode | Description | Use Case |
|------|-------------|----------|
| Alternating | A ↔ B | 2-player games |
| Sequential | A → B → C → D → A | Multi-player |
| Custom order | Configurable | Team games |

---

## Default Presets

Clockwork ships with a curated library:

### Quick Start
| Name | Config | Description |
|------|--------|-------------|
| 5+3 Blitz | 5:00 + 3s | Standard blitz chess |
| 3+2 Bullet | 3:00 + 2s | Fast bullet chess |
| 10+0 Rapid | 10:00, no increment | Rapid games |

### Reset Timers
| Name | Config | Description |
|------|--------|-------------|
| 30s Reset | 30s/move | Quick turns |
| 10s Reset | 10s/move | Very fast |
| 60s Reset | 60s/move | Relaxed pace |

### Classical
| Name | Config | Description |
|------|--------|-------------|
| 60+30 | 60:00 + 30s | Tournament style |
| 90+30 | 90:00 + 30s | Longer format |

---

## Custom Preset Builder

Users can create custom presets via the Quick Custom dialog or (future) full preset builder:

### Parameters

```
┌─────────────────────────────────────┐
│ Timer Settings                      │
├─────────────────────────────────────┤
│ Minutes:        [5]  ▲▼            │
│ Seconds:        [0]  ▲▼            │
├─────────────────────────────────────┤
│ Players:        [2]  ▲▼            │
├─────────────────────────────────────┤
│ ☐ Reset per move                   │
│   (Timer resets after each tap)    │
├─────────────────────────────────────┤
│ Increment (seconds): [0]  ▲▼       │
│   (Only if not reset mode)         │
└─────────────────────────────────────┘
```

---

## Preset Storage

Presets are stored locally using Hive:

```dart
// Save custom preset
await presetsBox.put(preset.id, preset.toJson());

// Load all presets
final presets = presetsBox.values.map(Preset.fromJson).toList();

// Favorites
final favorites = presets.where((p) => p.isFavorite).toList();
```

---

## Preset Tags (Future)

Enable search and filtering:

```dart
tags: ['chess', 'blitz', '2-player', 'increment']
```

Categories:
- **Game type**: Chess, Go, Board game, Party, Sports
- **Speed**: Bullet, Blitz, Rapid, Classical
- **Player count**: 2-player, Multi-player
- **Timer type**: Increment, Delay, Reset, Byo-yomi

---

## Example Preset Configurations

### Blitz Chess (5+3)
```dart
Preset(
  id: 'blitz-5-3',
  name: '5+3 Blitz',
  description: 'Standard blitz: 5 minutes with 3 second increment',
  playerCount: 2,
  mainTime: Duration(minutes: 5),
  increment: Duration(seconds: 3),
)
```

### Party Game (30s Reset)
```dart
Preset(
  id: 'reset-30',
  name: '30s Reset',
  description: 'Each player has 30 seconds per move. Timer resets after each tap.',
  playerCount: 2,
  mainTime: Duration(seconds: 30),
  moveTime: Duration(seconds: 30),  // Reset mode
)
```

### 4-Player Board Game
```dart
Preset(
  id: 'party-4p-60',
  name: '4-Player 60s',
  description: '4 players, 60 seconds per turn',
  playerCount: 4,
  mainTime: Duration(seconds: 60),
  moveTime: Duration(seconds: 60),
)
```
