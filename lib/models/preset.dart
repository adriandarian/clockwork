/// Preset model - defines the configuration for a game timer format.
/// This uses freezed for immutability and JSON serialization.
library;

import 'package:freezed_annotation/freezed_annotation.dart';

part 'preset.freezed.dart';
part 'preset.g.dart';

/// Type of timer behavior
enum TimerType {
  /// Standard countdown (chess-style)
  countdown,
  
  /// Reset to move time after each tap (speed games)
  resetPerMove,
  
  /// Countdown with delay before time starts ticking
  delay,
  
  /// Byo-yomi style (overtime periods)
  byoyomi,
}

/// What happens when time runs out
enum TimeoutBehavior {
  /// Player loses the game
  lose,
  
  /// Player gets a penalty point but game continues
  penalty,
  
  /// Just buzz and continue
  continuePlay,
}

/// Turn order style
enum TurnOrder {
  /// Alternating turns (A → B → A → B)
  alternating,
  
  /// Sequential turns (A → B → C → D → A)
  sequential,
}

/// Category for preset organization
enum PresetCategory {
  chess,
  board,
  party,
  sports,
  custom,
}

@freezed
class Preset with _$Preset {
  const factory Preset({
    /// Unique identifier
    required String id,
    
    /// Display name
    required String name,
    
    /// Optional description
    String? description,
    
    /// Category for organization
    @Default(PresetCategory.custom) PresetCategory category,
    
    /// Number of players (2-6)
    @Default(2) int playerCount,
    
    /// Type of timer
    @Default(TimerType.countdown) TimerType timerType,
    
    /// Main time per player
    required Duration mainTime,
    
    /// Move time for reset-per-move formats
    Duration? moveTime,
    
    /// Increment added after each move
    Duration? increment,
    
    /// Delay before time starts ticking
    Duration? delay,
    
    /// Timeout behavior
    @Default(TimeoutBehavior.lose) TimeoutBehavior timeoutBehavior,
    
    /// Turn order
    @Default(TurnOrder.alternating) TurnOrder turnOrder,
    
    /// Whether this is a built-in preset
    @Default(false) bool isBuiltIn,
    
    /// Whether this is a favorite
    @Default(false) bool isFavorite,
    
    /// Tags for search
    @Default([]) List<String> tags,
  }) = _Preset;
  
  factory Preset.fromJson(Map<String, dynamic> json) => _$PresetFromJson(json);
}

/// Extension for Duration JSON serialization
extension DurationJson on Duration {
  Map<String, dynamic> toJson() => {'microseconds': inMicroseconds};
  
  static Duration fromJson(Map<String, dynamic> json) {
    return Duration(microseconds: json['microseconds'] as int);
  }
}
