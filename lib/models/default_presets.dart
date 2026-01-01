/// Default presets that ship with the app.
library;

import 'preset.dart';

/// Built-in presets covering common game formats
class DefaultPresets {
  DefaultPresets._();
  
  /// 30-second reset timer (the one you wanted!)
  static const reset30 = Preset(
    id: 'reset-30',
    name: '30s Reset',
    description: 'Each player has 30 seconds per move. Timer resets after each tap.',
    category: PresetCategory.party,
    playerCount: 2,
    timerType: TimerType.resetPerMove,
    mainTime: Duration(seconds: 30),
    moveTime: Duration(seconds: 30),
    timeoutBehavior: TimeoutBehavior.continuePlay,
    isBuiltIn: true,
    tags: ['quick', 'reset', 'party'],
  );
  
  /// 10-second blitz reset
  static const reset10 = Preset(
    id: 'reset-10',
    name: '10s Reset',
    description: 'Fast! 10 seconds per move.',
    category: PresetCategory.party,
    playerCount: 2,
    timerType: TimerType.resetPerMove,
    mainTime: Duration(seconds: 10),
    moveTime: Duration(seconds: 10),
    timeoutBehavior: TimeoutBehavior.continuePlay,
    isBuiltIn: true,
    tags: ['blitz', 'reset', 'fast'],
  );
  
  /// 1-minute reset
  static const reset60 = Preset(
    id: 'reset-60',
    name: '1min Reset',
    description: 'One minute per move.',
    category: PresetCategory.board,
    playerCount: 2,
    timerType: TimerType.resetPerMove,
    mainTime: Duration(minutes: 1),
    moveTime: Duration(minutes: 1),
    timeoutBehavior: TimeoutBehavior.continuePlay,
    isBuiltIn: true,
    tags: ['standard', 'reset', 'board'],
  );
  
  /// Bullet chess (1+0)
  static const bullet = Preset(
    id: 'bullet-1-0',
    name: 'Bullet 1+0',
    description: '1 minute total, no increment. Fastest chess.',
    category: PresetCategory.chess,
    playerCount: 2,
    timerType: TimerType.countdown,
    mainTime: Duration(minutes: 1),
    timeoutBehavior: TimeoutBehavior.lose,
    isBuiltIn: true,
    tags: ['chess', 'bullet', 'fast'],
  );
  
  /// Blitz chess (3+2)
  static const blitz3 = Preset(
    id: 'blitz-3-2',
    name: 'Blitz 3+2',
    description: '3 minutes with 2 second increment.',
    category: PresetCategory.chess,
    playerCount: 2,
    timerType: TimerType.countdown,
    mainTime: Duration(minutes: 3),
    increment: Duration(seconds: 2),
    timeoutBehavior: TimeoutBehavior.lose,
    isBuiltIn: true,
    tags: ['chess', 'blitz'],
  );
  
  /// Blitz chess (5+3)
  static const blitz5 = Preset(
    id: 'blitz-5-3',
    name: 'Blitz 5+3',
    description: '5 minutes with 3 second increment. Classic blitz.',
    category: PresetCategory.chess,
    playerCount: 2,
    timerType: TimerType.countdown,
    mainTime: Duration(minutes: 5),
    increment: Duration(seconds: 3),
    timeoutBehavior: TimeoutBehavior.lose,
    isBuiltIn: true,
    tags: ['chess', 'blitz', 'popular'],
  );
  
  /// Rapid chess (10+5)
  static const rapid10 = Preset(
    id: 'rapid-10-5',
    name: 'Rapid 10+5',
    description: '10 minutes with 5 second increment.',
    category: PresetCategory.chess,
    playerCount: 2,
    timerType: TimerType.countdown,
    mainTime: Duration(minutes: 10),
    increment: Duration(seconds: 5),
    timeoutBehavior: TimeoutBehavior.lose,
    isBuiltIn: true,
    tags: ['chess', 'rapid'],
  );
  
  /// Rapid chess (15+10)
  static const rapid15 = Preset(
    id: 'rapid-15-10',
    name: 'Rapid 15+10',
    description: '15 minutes with 10 second increment.',
    category: PresetCategory.chess,
    playerCount: 2,
    timerType: TimerType.countdown,
    mainTime: Duration(minutes: 15),
    increment: Duration(seconds: 10),
    timeoutBehavior: TimeoutBehavior.lose,
    isBuiltIn: true,
    tags: ['chess', 'rapid', 'popular'],
  );
  
  /// Classical chess (30 minutes)
  static const classical = Preset(
    id: 'classical-30',
    name: 'Classical 30min',
    description: '30 minutes per player. No increment.',
    category: PresetCategory.chess,
    playerCount: 2,
    timerType: TimerType.countdown,
    mainTime: Duration(minutes: 30),
    timeoutBehavior: TimeoutBehavior.lose,
    isBuiltIn: true,
    tags: ['chess', 'classical', 'long'],
  );
  
  /// 4-player party timer
  static const fourPlayer = Preset(
    id: 'four-player-30',
    name: '4 Player 30s',
    description: '4 players, 30 seconds each per turn.',
    category: PresetCategory.party,
    playerCount: 4,
    timerType: TimerType.resetPerMove,
    mainTime: Duration(seconds: 30),
    moveTime: Duration(seconds: 30),
    timeoutBehavior: TimeoutBehavior.continuePlay,
    isBuiltIn: true,
    tags: ['party', 'multiplayer', 'reset'],
  );
  
  // ============================================
  // GO / BADUK PRESETS
  // ============================================
  
  /// Go: Casual 10 minutes per side
  static const goCasual = Preset(
    id: 'go-casual-10',
    name: 'Go Casual 10min',
    description: '10 minutes per player. Great for casual games.',
    category: PresetCategory.go,
    playerCount: 2,
    timerType: TimerType.countdown,
    mainTime: Duration(minutes: 10),
    timeoutBehavior: TimeoutBehavior.lose,
    isBuiltIn: true,
    tags: ['go', 'baduk', 'weiqi', 'casual'],
  );
  
  /// Go: 30 min + 5×30s byo-yomi (common online format)
  static const goByoyomi30 = Preset(
    id: 'go-byoyomi-30-5x30',
    name: 'Go 30min + 5×30s',
    description: '30 min main time, then 5 periods of 30 seconds byo-yomi.',
    category: PresetCategory.go,
    playerCount: 2,
    timerType: TimerType.byoyomi,
    mainTime: Duration(minutes: 30),
    byoyomiPeriods: 5,
    byoyomiTime: Duration(seconds: 30),
    timeoutBehavior: TimeoutBehavior.lose,
    isBuiltIn: true,
    tags: ['go', 'baduk', 'byo-yomi', 'online'],
  );
  
  /// Go: 60 min + 3×30s byo-yomi (longer games)
  static const goByoyomi60 = Preset(
    id: 'go-byoyomi-60-3x30',
    name: 'Go 60min + 3×30s',
    description: '60 min main time with 3 periods of 30 seconds overtime.',
    category: PresetCategory.go,
    playerCount: 2,
    timerType: TimerType.byoyomi,
    mainTime: Duration(minutes: 60),
    byoyomiPeriods: 3,
    byoyomiTime: Duration(seconds: 30),
    timeoutBehavior: TimeoutBehavior.lose,
    isBuiltIn: true,
    tags: ['go', 'baduk', 'byo-yomi', 'tournament'],
  );
  
  /// Go: Blitz 5 min + 3×10s (fast games)
  static const goBlitz = Preset(
    id: 'go-blitz-5-3x10',
    name: 'Go Blitz 5min + 3×10s',
    description: 'Fast! 5 min main time with 3 periods of 10 seconds.',
    category: PresetCategory.go,
    playerCount: 2,
    timerType: TimerType.byoyomi,
    mainTime: Duration(minutes: 5),
    byoyomiPeriods: 3,
    byoyomiTime: Duration(seconds: 10),
    timeoutBehavior: TimeoutBehavior.lose,
    isBuiltIn: true,
    tags: ['go', 'baduk', 'blitz', 'fast'],
  );
  
  /// Go: Canadian - 25 moves in 10 minutes
  static const goCanadian = Preset(
    id: 'go-canadian-25-10',
    name: 'Go Canadian 25/10min',
    description: '10 min main, then 25 moves per 10 minute overtime period.',
    category: PresetCategory.go,
    playerCount: 2,
    timerType: TimerType.canadianByoyomi,
    mainTime: Duration(minutes: 10),
    byoyomiTime: Duration(minutes: 10),
    canadianMoves: 25,
    timeoutBehavior: TimeoutBehavior.lose,
    isBuiltIn: true,
    tags: ['go', 'baduk', 'canadian', 'tournament'],
  );
  
  /// All built-in presets
  static const List<Preset> all = [
    // Reset timers
    reset30,
    reset10,
    reset60,
    // Chess
    bullet,
    blitz3,
    blitz5,
    rapid10,
    rapid15,
    classical,
    // Go
    goCasual,
    goByoyomi30,
    goByoyomi60,
    goBlitz,
    goCanadian,
    // Party
    fourPlayer,
  ];
  
  /// Get presets by category
  static List<Preset> byCategory(PresetCategory category) {
    return all.where((p) => p.category == category).toList();
  }
  
  /// Get chess presets
  static List<Preset> get chess => byCategory(PresetCategory.chess);
  
  /// Get go presets
  static List<Preset> get go => byCategory(PresetCategory.go);
  
  /// Get party presets (including reset timers)
  static List<Preset> get party => byCategory(PresetCategory.party);
  
  /// Get board game presets
  static List<Preset> get board => byCategory(PresetCategory.board);
}
