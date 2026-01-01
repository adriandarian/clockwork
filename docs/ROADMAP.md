# Development Roadmap

This document tracks the planned development phases for Clockwork.

---

## Current Status: MVP Complete ✅

The basic timer functionality is working with:
- 2-player timer support
- Main time + increment mode
- Reset-per-move mode
- Preset selection UI
- Quick custom timer builder
- Game screen with tap zones

---

## Phase 1: Core Polish (Current)

### Timer Engine
- [x] Basic game state machine
- [x] Tick event handling
- [x] Player time tracking
- [x] Reset-per-move logic
- [x] Increment logic
- [ ] Delay logic (Bronstein style)
- [ ] Proper undo with full state restore

### UI/UX
- [x] Home screen with preset cards
- [x] Game screen with tap zones
- [x] Timer display with animations
- [x] Pause/Resume overlay
- [x] Game ended overlay
- [ ] Sound effects on tap
- [ ] Haptic feedback
- [ ] Low time warnings (visual + audio)
- [ ] Lock mode (prevent accidental exits)

### Persistence
- [x] Default presets
- [ ] Save favorites to Hive
- [ ] Save custom presets
- [ ] Recent games history

---

## Phase 2: Multi-Player & Builder

### Multi-Player Support
- [ ] 3-6 player layouts
- [ ] Circular/sequential turn order
- [ ] Team mode (shared clock)
- [ ] Pass turn option

### Preset Builder (Full)
- [ ] Full preset creation UI
- [ ] All timer behavior options
- [ ] Preset editing
- [ ] Preset duplication
- [ ] Preset deletion with confirmation
- [ ] Import/Export presets (JSON)

### Search & Discovery
- [ ] Search presets by name
- [ ] Filter by tags
- [ ] Sort by recent/popular/favorites

---

## Phase 3: Advanced Features

### Advanced Timer Modes
- [ ] Byo-yomi (main + overtime periods)
- [ ] Hourglass mode (time transfers between players)
- [ ] Game phases (setup → main → overtime)

### Counters & Scoring
- [ ] Point counters per player
- [ ] Capture counters
- [ ] Round counters
- [ ] Custom counter labels

### Match Features
- [ ] Match history with replay
- [ ] Statistics (average move time, etc.)
- [ ] Share match results

---

## Phase 4: Platform Features

### iOS
- [ ] App Store submission
- [ ] Apple Watch companion
- [ ] iOS widgets (quick start)
- [ ] Siri Shortcuts integration

### Android
- [ ] Play Store submission
- [ ] Wear OS companion
- [ ] Android widgets

### Desktop & Web
- [ ] macOS native app
- [ ] Windows native app
- [ ] Web app deployment

---

## Phase 5: Ecosystem

### Cloud & Sync
- [ ] User accounts (optional)
- [ ] Cloud sync for presets/favorites
- [ ] Cross-device sync

### Community
- [ ] Community preset sharing
- [ ] Preset ratings/reviews
- [ ] Featured presets

### Display
- [ ] AirPlay/Chromecast support
- [ ] External display mode
- [ ] Scoreboard view for spectators

---

## Backlog / Ideas

### Accessibility
- [ ] VoiceOver support
- [ ] Dynamic type support
- [ ] High contrast mode
- [ ] Colorblind-friendly palettes
- [ ] Voice announcements ("10 seconds remaining")

### Theming
- [x] Modern Minimalist (default)
- [x] Cyber Industrial (theme pack - code preserved)
- [ ] Theme selection UI
- [ ] Light mode
- [ ] Custom color themes
- [ ] Player color customization

### Advanced
- [ ] Network play (synchronized timers)
- [ ] Tournament mode (multiple games)
- [ ] Arbiter mode (manual adjustments)
- [ ] Time control editor (visual timeline)

---

## Technical Debt

- [ ] Fix remaining `withOpacity` deprecation warnings ✅ Done
- [ ] Extract engine to separate package
- [ ] Add comprehensive unit tests
- [ ] Add widget tests
- [ ] Add integration tests
- [ ] CI/CD pipeline setup
- [ ] Code documentation (dartdoc)

---

## Milestones

| Milestone | Target | Status |
|-----------|--------|--------|
| MVP | Dec 2025 | ✅ Complete |
| Beta Release | Q1 2026 | 🔄 In Progress |
| App Store Launch | Q2 2026 | 📋 Planned |
| Multi-player | Q2 2026 | 📋 Planned |
| Advanced Modes | Q3 2026 | 📋 Planned |

---

## Notes

### Design Decisions

1. **Why Riverpod over Bloc?**
   - More ergonomic API
   - Better code generation support
   - Simpler for this scale of app

2. **Why Hive over Drift/Isar?**
   - Fast to get started
   - No complex queries needed (yet)
   - Easy migration path if needed later

3. **Why pure Dart engine?**
   - Testable without Flutter
   - Reusable across platforms
   - Potentially publishable as package

### Constraints

- Keep game start < 5 seconds from app launch
- Timer accuracy must be < 50ms drift
- Support offline-first operation
- Minimal battery drain during gameplay
