# Clockwork UX Redesign

## Vision

Clockwork is a **universal game timer** - not just chess, but Go (byo-yomi), party games, sports, and any timed activity. The UX must:

1. **Feel organized, not cluttered** - Even with 100+ timers, finding what you need is instant
2. **Support power users** - Batch operations, duplicating, custom folders
3. **Be delightful** - Smooth animations, satisfying interactions, beautiful design
4. **Scale gracefully** - Works great with 5 presets or 500

---

## Information Architecture

### Hierarchy

```
┌─────────────────────────────────────────────────────┐
│  LIBRARY (main screen)                              │
│  ├── 🔍 Search                                      │
│  ├── ⭐ Favorites (pinned section)                  │
│  ├── 📁 Folders (user-created)                     │
│  │   ├── My Go Timers                              │
│  │   ├── Tournament Settings                        │
│  │   └── Party Games                               │
│  ├── 🏷️ Categories (system)                        │
│  │   ├── Chess                                      │
│  │   ├── Go / Baduk                                │
│  │   ├── Board Games                               │
│  │   └── Sports                                    │
│  └── 📋 All Presets (flat view option)             │
├─────────────────────────────────────────────────────┤
│  TIMER EDITOR (create/edit)                         │
│  ├── Basic: Name, Players, Total Time              │
│  ├── Type: Countdown, Reset, Fischer, Byo-yomi     │
│  ├── Advanced: Increment, Delay, Overtime          │
│  └── Organization: Folder, Tags, Color             │
├─────────────────────────────────────────────────────┤
│  SETTINGS (gear icon)                               │
│  ├── Appearance: Theme, Display                    │
│  ├── Sound & Haptics                               │
│  ├── Timer Defaults                                │
│  ├── Data: Export/Import/Backup                    │
│  └── About                                         │
└─────────────────────────────────────────────────────┘
```

---

## Screen Designs

### 1. Library Screen (Home)

**Header**
- App title "Clockwork" with timer icon
- Settings gear (top right)
- Search bar below header

**Layout Options** (toggle in header)
- Grid view (cards) - default
- List view (compact)

**Sections**
Each section is collapsible with:
- Section header (icon, title, count, collapse chevron)
- Section actions (+ add, ⋮ more)

**Section Order**
1. **⭐ Favorites** - Always first, cannot be hidden
2. **📁 User Folders** - Custom organization
3. **🏷️ Categories** - System categories (collapsible)
4. **🗂️ Uncategorized** - Orphan custom presets

**Empty States**
- Favorites empty: "Star your most-used timers for quick access"
- Category empty: "No [category] timers yet. Create one?"

**FAB**
- Primary: "+ New Timer"
- Expandable options: "New Folder", "Import"

---

### 2. Preset Card

**Card Content**
```
┌────────────────────────────────┐
│ ⭐ Timer Name              [⋮] │  ← Star, name, context menu
│ Optional description           │
│                                │
│ [5:00] [+3s] [2P]             │  ← Time, increment, players
│ [Fischer] [Chess]              │  ← Type badge, category badge
└────────────────────────────────┘
```

**Interactions**
- Tap → Start timer
- Long press → Context menu
- Star icon → Toggle favorite
- ⋮ menu → Edit, Duplicate, Move, Delete

**Context Menu**
- ✏️ Edit
- ⭐ Add/Remove Favorite
- 📋 Duplicate
- 📁 Move to Folder...
- 🎨 Change Color
- 🗑️ Delete

---

### 3. Timer Editor (Bottom Sheet / Full Screen)

**Compact Mode** (bottom sheet for quick creation)
```
┌─────────────────────────────────────┐
│ Quick Timer                    [✕]  │
├─────────────────────────────────────┤
│ Name: [                          ]  │
│                                     │
│ Time:  [5] min [0] sec              │
│ Players: [2] [3] [4] [5] [6]        │
│                                     │
│ Type: [Countdown ▾]                 │
│   □ Add increment (+X sec/move)     │
│                                     │
│ [Cancel]              [Start Now]   │
│                    [Save & Start]   │
└─────────────────────────────────────┘
```

**Full Editor** (for complex timers)
- **Basic Tab**
  - Name (required)
  - Description (optional)
  - Icon/Color picker
  - Folder assignment
  
- **Time Tab**
  - Timer Type selector (visual cards)
    - ⏱️ Countdown - Standard countdown
    - 🔄 Reset per Move - Resets after each turn
    - ⚡ Fischer - Time + increment per move
    - 🇯🇵 Byo-yomi - Overtime periods
    - ⏸️ Bronstein - Delay before countdown
  - Time inputs (contextual to type)
  - Player count
  
- **Advanced Tab**
  - Timeout behavior
  - Turn order
  - Sound profile
  - Tags

**Timer Type Explanations** (inline help)
- Each type has "Learn more" that shows example use cases
- Go players understand byo-yomi, chess players understand Fischer

---

### 4. Folder Management

**Create Folder**
- Name
- Icon (emoji picker or icon set)
- Color

**Folder View**
- Shows all presets in folder
- Drag to reorder
- Batch select mode

**Folder Actions**
- Rename
- Change icon/color
- Delete (moves presets to Uncategorized)

---

### 5. Settings Screen

**Sections**

```
APPEARANCE
├── Theme: [System ▾] Light / Dark / System
├── Accent Color: [Purple ▾] Color picker
└── Display: Compact / Comfortable / Spacious

SOUND & FEEDBACK
├── Timer Sounds: [On ▾]
├── End Warning: [10 seconds before ▾]
├── Haptic Feedback: [On]
└── Sound Pack: [Classic ▾]

TIMER DEFAULTS
├── Default Players: [2]
├── Default Time: [5:00]
└── Quick Start Timers: [Configure...]

DATA
├── Export Presets → JSON file
├── Import Presets → File picker
├── Backup to iCloud: [Off]
└── Reset to Defaults

ABOUT
├── Version 1.0.0
├── Rate Clockwork
├── Send Feedback
└── Open Source Licenses
```

---

### 6. Batch Operations

**Entering Batch Mode**
- Long press on card → "Select" option
- Header action "Select Multiple"

**Batch Mode UI**
- Checkboxes appear on cards
- Bottom action bar slides up:
  ```
  [3 selected]  [⭐ Favorite] [📁 Move] [📋 Duplicate] [🗑️ Delete]
  ```

**Batch Create**
- "Create Variations" feature
- Input: Base timer + variations
- Example: "Create 1min, 3min, 5min, 10min reset timers"

---

## Timer Types Deep Dive

### Countdown (Standard)
- Total time per player
- Optional increment after each move
- Used by: Chess, most board games

### Reset per Move  
- Fixed time per move, resets on tap
- Used by: Speed games, party games

### Fischer (Increment)
- Base time + increment per move
- Increment added AFTER move
- Used by: Modern chess

### Byo-yomi (Japanese)
- Main time + overtime periods
- Example: 30min + 3×30sec byo-yomi
- Used by: Go, Shogi

### Bronstein (Delay)
- Delay before countdown starts each turn
- Time "given back" up to delay amount
- Used by: Some tournaments

### Canadian Byo-yomi
- X moves in Y time periods
- Example: 25 moves in 5 minutes
- Used by: Go tournaments

---

## Data Model Updates

### Preset (updated)
```dart
class Preset {
  String id;
  String name;
  String? description;
  String? folderId;        // NEW: folder assignment
  String? iconEmoji;       // NEW: custom emoji icon
  Color? color;            // NEW: accent color
  List<String> tags;       // NEW: searchable tags
  int sortOrder;           // NEW: manual ordering
  DateTime createdAt;      // NEW: creation date
  DateTime? lastUsedAt;    // NEW: for "Recent" sorting
  int useCount;            // NEW: for "Most Used" sorting
  // ... existing fields
}
```

### Folder (new)
```dart
class Folder {
  String id;
  String name;
  String? iconEmoji;
  Color color;
  int sortOrder;
  bool isExpanded;         // UI state
  DateTime createdAt;
}
```

### Settings (new)
```dart
class AppSettings {
  ThemeMode themeMode;
  Color accentColor;
  bool hapticFeedback;
  bool soundEnabled;
  String soundPack;
  int warningSeconds;
  int defaultPlayers;
  Duration defaultTime;
  List<String> quickStartPresetIds;
  ViewMode libraryViewMode;  // grid / list
}
```

---

## Implementation Phases

### Phase 1: Foundation
- [ ] Update Preset model with new fields
- [ ] Create Folder model
- [ ] Create AppSettings model
- [ ] Set up Hive boxes for persistence
- [ ] Add more timer types (byo-yomi, bronstein)

### Phase 2: Library Redesign
- [ ] New home screen layout
- [ ] Collapsible sections
- [ ] Search functionality
- [ ] Grid/List view toggle
- [ ] Improved preset cards

### Phase 3: Organization
- [ ] Folder CRUD operations
- [ ] Drag-to-reorder
- [ ] Move presets between folders
- [ ] Favorites functionality (improved)

### Phase 4: Timer Editor
- [ ] Bottom sheet quick creator
- [ ] Full-screen editor
- [ ] Timer type selector with explanations
- [ ] Byo-yomi configuration UI

### Phase 5: Settings & Polish
- [ ] Settings screen
- [ ] Theme customization
- [ ] Sound settings
- [ ] Export/Import
- [ ] Batch operations

### Phase 6: Advanced Features
- [ ] Batch timer creation
- [ ] iCloud sync
- [ ] Widgets
- [ ] Watch app

---

## UX Principles

### 1. Progressive Disclosure
- Simple by default, powerful when needed
- Quick create for "5min timer"
- Full editor for "tournament byo-yomi with Canadian overtime"

### 2. Muscle Memory
- Tap to start (always)
- Long press for options (always)
- Swipe to favorite (everywhere)

### 3. Zero Configuration
- Sensible defaults
- Works great out of the box
- Customization is optional

### 4. Recoverable
- Undo delete
- "Recently Deleted" folder
- Confirm destructive batch operations

### 5. Delightful
- Smooth 60fps animations
- Satisfying haptics
- Subtle sound feedback
- Easter eggs for power users

---

## Open Questions

1. **Should folders nest?** (folders within folders)
   - Probably not for v1 - adds complexity

2. **Smart folders?** (auto-populated by rules)
   - "Recently Used", "Most Used" could be smart sections

3. **Sharing?** (share presets with friends)
   - Export as link / QR code
   - Phase 2 feature

4. **Templates vs Presets?**
   - Templates = starting points to customize
   - Presets = ready to use
   - Might be overcomplication - skip for v1
