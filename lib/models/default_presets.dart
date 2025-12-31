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
  
  /// All built-in presets
  static const List<Preset> all = [
    reset30,
    reset10,
    reset60,
    bullet,
    blitz3,
    blitz5,
    rapid10,
    rapid15,
    classical,
    fourPlayer,
  ];
  
  /// Get presets by category
  static List<Preset> byCategory(PresetCategory category) {
    return all.where((p) => p.category == category).toList();
  }
  
  /// Get chess presets
  static List<Preset> get chess => byCategory(PresetCategory.chess);
  
  /// Get party presets (including reset timers)
  static List<Preset> get party => byCategory(PresetCategory.party);
  
  /// Get board game presets
  static List<Preset> get board => byCategory(PresetCategory.board);
}
