/// Effects are side effects that the UI layer should execute.
/// The engine produces these; it never executes them directly.
/// This keeps the engine pure and testable.
library;

import 'package:equatable/equatable.dart';

/// Base class for all effects
sealed class GameEffect extends Equatable {
  const GameEffect();
  
  @override
  List<Object?> get props => [];
}

/// Play a sound effect
class PlaySoundEffect extends GameEffect {
  final SoundType sound;
  
  const PlaySoundEffect(this.sound);
  
  @override
  List<Object?> get props => [sound];
}

enum SoundType {
  tap,
  timeout,
  warning,
  gameStart,
  gameEnd,
}

/// Trigger haptic feedback
class HapticEffect extends GameEffect {
  final HapticType type;
  
  const HapticEffect(this.type);
  
  @override
  List<Object?> get props => [type];
}

enum HapticType {
  light,
  medium,
  heavy,
  success,
  warning,
  error,
}

/// Show a toast/notification
class ShowToastEffect extends GameEffect {
  final String message;
  
  const ShowToastEffect(this.message);
  
  @override
  List<Object?> get props => [message];
}

/// Announce via text-to-speech (accessibility)
class AnnounceEffect extends GameEffect {
  final String message;
  
  const AnnounceEffect(this.message);
  
  @override
  List<Object?> get props => [message];
}

/// Game has ended
class GameEndedEffect extends GameEffect {
  final int? winnerId; // null if draw or no winner
  final GameEndReason reason;
  
  const GameEndedEffect({
    this.winnerId,
    required this.reason,
  });
  
  @override
  List<Object?> get props => [winnerId, reason];
}

enum GameEndReason {
  timeout,
  manual,
  completed,
}
