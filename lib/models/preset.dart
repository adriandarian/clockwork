/// Preset model - defines the configuration for a game timer format.
/// This uses freezed for immutability and JSON serialization.
library;

import 'package:flutter/material.dart' show Color;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'preset.freezed.dart';
part 'preset.g.dart';

/// Type of timer behavior
enum TimerType {
  /// Standard countdown (chess-style)
  countdown,
  
  /// Reset to move time after each tap (speed games)
  resetPerMove,
  
  /// Fischer - Base time + increment after each move
  fischer,
  
  /// Countdown with delay before time starts ticking (Bronstein)
  delay,
  
  /// Byo-yomi style (overtime periods) - Japanese
  byoyomi,
  
  /// Canadian byo-yomi (X moves in Y time)
  canadianByoyomi,
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
  go,
  board,
  party,
  sports,
  custom,
}

/// JSON converter for Color
class ColorConverter implements JsonConverter<Color?, int?> {
  const ColorConverter();

  @override
  Color? fromJson(int? json) => json != null ? Color(json) : null;

  @override
  int? toJson(Color? color) => color?.toARGB32();
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
    
    /// Folder ID for organization (null = uncategorized)
    String? folderId,
    
    /// Custom emoji icon
    String? iconEmoji,
    
    /// Accent color for the preset card
    @ColorConverter() Color? color,
    
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
    
    /// Byo-yomi periods count
    @Default(0) int byoyomiPeriods,
    
    /// Byo-yomi time per period
    Duration? byoyomiTime,
    
    /// Canadian byo-yomi: moves required per period
    @Default(0) int canadianMoves,
    
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
    
    /// Manual sort order within folder
    @Default(0) int sortOrder,
    
    /// Creation timestamp (milliseconds since epoch)
    int? createdAt,
    
    /// Last used timestamp (milliseconds since epoch)
    int? lastUsedAt,
    
    /// Number of times this preset was used
    @Default(0) int useCount,
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
