# UI/UX Design Guidelines

This document outlines the design principles and patterns for Clockwork.

---

## Design Philosophy

### Core Principles

1. **Zero Friction** - Timer ready in < 5 seconds
2. **Big Targets** - Tap zones should be impossible to miss
3. **Clear State** - Always obvious who's turn it is
4. **Minimal Distractions** - Game screen is focused

---

## Screen Flow

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│    Home     │ ──▶ │  Game Setup │ ──▶ │    Game     │
│   Screen    │     │  (optional) │     │   Screen    │
└─────────────┘     └─────────────┘     └─────────────┘
      │                                        │
      │                                        │
      ▼                                        ▼
┌─────────────┐                         ┌─────────────┐
│   Preset    │                         │   Results   │
│   Builder   │                         │   Screen    │
└─────────────┘                         └─────────────┘
```

---

## Home Screen

### Layout

```
┌─────────────────────────────────────┐
│           CLOCKWORK                 │  ← App bar
├─────────────────────────────────────┤
│  ⚡ Quick Start                     │  ← Quick actions
│  ┌─────────┐ ┌─────────┐           │
│  │  5+3    │ │  10+0   │           │
│  │  Blitz  │ │  Rapid  │           │
│  └─────────┘ └─────────┘           │
├─────────────────────────────────────┤
│  | Chess Timers                     │  ← Section header
│    Standard chess time controls     │
│  ┌─────────┐ ┌─────────┐           │
│  │ 5+3     │ │ 3+2     │           │
│  │ ★ ⏱5M  │ │   ⏱3M   │           │
│  └─────────┘ └─────────┘           │
├─────────────────────────────────────┤
│  | Reset Timers                     │
│    Timer resets after each move     │
│  ┌─────────┐ ┌─────────┐           │
│  │ 30s     │ │ 10s     │           │
│  │   ⏱30S │ │   ⏱10S  │           │
│  └─────────┘ └─────────┘           │
└─────────────────────────────────────┘
│  ➕ Custom                          │  ← FAB
└─────────────────────────────────────┘
```

### Preset Card Design

```
┌───────────────────────────────────┐
│ Preset Name                    ★  │  ← Name + Favorite
│ Description text here...          │  ← Description (2 lines max)
│                                   │
│ ┌──────┐ ┌──────┐      ┌──────┐  │
│ │⏱ 5M │ │+ 3S  │      │👥 2  │  │  ← Info chips
│ └──────┘ └──────┘      └──────┘  │
└───────────────────────────────────┘
```

---

## Game Screen

### 2-Player Layout

```
┌───────────────────────────────────┐
│         PLAYER 2                  │  ← Rotated 180°
│                                   │
│           5:00                    │  ← Large timer
│                                   │
│        Tap to End Turn            │
├───────────────────────────────────┤  ← Divider
│ ← X  ↩  | Preset |  ↻  ⏸ →      │  ← Control bar
├───────────────────────────────────┤
│                                   │
│           5:00                    │
│                                   │
│        Tap to End Turn            │
│                                   │
│         PLAYER 1                  │
└───────────────────────────────────┘
```

### Control Bar

| Icon | Action | Position |
|------|--------|----------|
| ✕ | Exit game | Left |
| ↩ | Undo last move | Left-center |
| ↻ | Reset game | Right-center |
| ⏸/▶ | Pause/Resume | Right |

### Active Player Indicator

- Background tint in player color
- Larger timer font size
- "Tap to End Turn" hint visible
- Subtle animation pulse (optional)

### Inactive Player

- Dimmed text color
- Smaller timer font
- No hint text
- No background tint

---

## Timer Display

### Format Rules

| Time Remaining | Display Format | Example |
|----------------|----------------|---------|
| ≥ 1 hour | H:MM:SS | 1:23:45 |
| ≥ 10 seconds | M:SS | 5:00 |
| < 10 seconds | S.t | 9.8 |

### Color Coding

| Condition | Color | Purpose |
|-----------|-------|---------|
| Normal | White/Theme | Default state |
| Warning (< 30s) | Amber/Orange | Attention |
| Critical (< 10s) | Red | Urgency |
| Paused | Gray | Inactive |

---

## Overlays

### Start Overlay

```
┌───────────────────────────────────┐
│                                   │
│            👆                     │  ← Touch icon
│                                   │
│       Tap to Start                │
│                                   │
└───────────────────────────────────┘
```

### Pause Overlay

```
┌───────────────────────────────────┐
│                                   │
│            ⏸                      │  ← Pause icon
│                                   │
│          Paused                   │
│       Tap to Resume               │
│                                   │
└───────────────────────────────────┘
```

### Game Over Overlay

```
┌───────────────────────────────────┐
│                                   │
│            🏆                     │  ← Trophy icon
│                                   │
│     Player 1 Wins!                │
│         12 Moves                  │
│                                   │
│   ┌────────┐  ┌────────────┐     │
│   │  Exit  │  │ Play Again │     │
│   └────────┘  └────────────┘     │
└───────────────────────────────────┘
```

---

## Theme System

### Default Theme (Modern Minimalist)

```dart
// Colors
primary: #3B82F6 (Blue)
secondary: #10B981 (Emerald)
background: #121212
surface: #1E1E1E
error: #EF4444

// Typography
- System font (default)
- Rounded corners (16px)
- Subtle shadows
```

### Cyber Theme (Optional)

```dart
// Colors
primary: #00F0FF (Neon Blue)
secondary: #BC13FE (Neon Purple)
accent: #00FF94 (Neon Green)
background: #050505

// Typography
- RobotoMono font
- Beveled corners
- Neon glow effects
```

---

## Interaction Patterns

### Tap to End Turn
- Entire player zone is tappable
- Immediate visual feedback (color flash)
- Haptic feedback on tap
- Sound effect (optional)

### Long Press to Undo
- Prevents accidental undo
- 500ms hold duration
- Vibration on activation

### Swipe to Exit (Future)
- Swipe down during pause
- Shows exit confirmation

---

## Accessibility

### Requirements
- [ ] Minimum touch target: 44x44pt
- [ ] Color contrast ratio: 4.5:1 (AA)
- [ ] VoiceOver labels for all controls
- [ ] Dynamic Type support
- [ ] Reduce Motion support

### Color Blind Considerations
- Don't rely solely on color to convey state
- Use icons + color together
- Player 1/2 distinguishable by position + label

---

## Responsive Design

### Phone (Portrait)
- Default layout
- Vertical split for 2 players

### Phone (Landscape)
- Horizontal split for 2 players
- Larger timer text

### Tablet
- Larger tap zones
- Potentially side-by-side layout

### Desktop/Web
- Mouse click support
- Keyboard shortcuts (Space = End Turn)
