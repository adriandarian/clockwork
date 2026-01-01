# Clockwork - Project Overview

> **A universal, rule-driven game timer engine that supports thousands of game formats**

## Vision

Clockwork is not "just another timer app." It's a **rules engine + timer engine** that can support chess, Go, board games, party games, sports drills, and more—without hardcoding one app per format.

The core insight: most timer apps fail because they're built for specific games. Clockwork takes a different approach—**users assemble presets from modular building blocks**, like LEGO pieces for time.

---

## Core Problem Statement

> "I cannot find a mobile app that works how I want it for a timer. Everything supports specific formats."

Common timer needs that existing apps fail to address:
- **Blitz chess** (5:00 + 3s increment)
- **Classical chess with delay** (Bronstein/US delay style)
- **N-second reset timers** (tap resets to 30s, common in casual games)
- **Multi-player turn timers** (3-6 players, sequential)
- **Byo-yomi periods** (Go/board game variants)

---

## Key Differentiators

| Feature | Other Timer Apps | Clockwork |
|---------|------------------|-----------|
| Game formats | Hardcoded modes | Composable presets |
| Timer types | 1-2 types | 5+ behaviors |
| Players | Usually 2 | 2-6+ players |
| Turn logic | Fixed | Configurable |
| Extensibility | None | Preset builder |

---

## Target Users

1. **Board game enthusiasts** - Need flexible timers for various games
2. **Chess/Go players** - Want proper increment, delay, and byo-yomi support
3. **Party game hosts** - Need quick-reset move timers
4. **Tournament organizers** - Need reliable, configurable timing
5. **Educators** - Classroom activities with timed turns

---

## Project Goals

### MVP (Current Phase)
- [x] 2-player basic timer
- [x] Reset-per-move timer mode
- [x] Main time + increment mode
- [x] Preset selection UI
- [x] Quick custom timer builder
- [ ] Pause/Resume/Undo functionality
- [ ] Sound/haptic feedback

### Phase 2
- [ ] 3-6 player support
- [ ] Full preset builder UI
- [ ] Preset library with search/tags
- [ ] Local persistence (favorites, custom presets)

### Phase 3
- [ ] Advanced timer modes (byo-yomi, delay)
- [ ] Game phases (main time → overtime)
- [ ] Counters (captures, points, rounds)
- [ ] Match history

### Future
- [ ] Theme customization (Cyber theme pack, etc.)
- [ ] Cloud sync
- [ ] Community preset sharing
- [ ] Watch companion app
- [ ] AirPlay/external display support

---

## Technology Choices

| Layer | Technology | Rationale |
|-------|------------|-----------|
| Framework | Flutter | Cross-platform (iOS, Android, Web, Desktop) |
| Language | Dart | Flutter's native language |
| State Management | Riverpod | Modern, ergonomic, testable |
| Models | Freezed | Immutable data classes with unions |
| Serialization | json_serializable | Type-safe JSON handling |
| Persistence | Hive | Fast local storage, easy to start |
| Testing | dart test | Pure Dart engine = fast unit tests |

---

## Success Metrics

1. **Launch speed**: Timer ready in < 5 seconds from app open
2. **Flexibility**: Support 10+ distinct game formats with same engine
3. **Accuracy**: No timer drift even on slow devices
4. **UX**: Zero-friction in-game experience (big tap zones, haptics)
