/// Game events that can be dispatched to the timer engine.
/// These are user actions or system events that modify game state.
library;

import 'package:equatable/equatable.dart';

/// Base class for all game events
sealed class GameEvent extends Equatable {
  const GameEvent();
  
  @override
  List<Object?> get props => [];
}

/// Tick event - dispatched every frame to update timers
class TickEvent extends GameEvent {
  final Duration elapsed;
  
  const TickEvent(this.elapsed);
  
  @override
  List<Object?> get props => [elapsed];
}

/// Player taps to end their turn
class TapPlayerEvent extends GameEvent {
  final int playerId;
  
  const TapPlayerEvent(this.playerId);
  
  @override
  List<Object?> get props => [playerId];
}

/// Pause the game
class PauseEvent extends GameEvent {
  const PauseEvent();
}

/// Resume the game
class ResumeEvent extends GameEvent {
  const ResumeEvent();
}

/// Start the game (first tap to begin)
class StartGameEvent extends GameEvent {
  const StartGameEvent();
}

/// Undo the last action
class UndoEvent extends GameEvent {
  const UndoEvent();
}

/// Reset the game to initial state
class ResetEvent extends GameEvent {
  const ResetEvent();
}

/// Player's time has expired
class TimeoutEvent extends GameEvent {
  final int playerId;
  
  const TimeoutEvent(this.playerId);
  
  @override
  List<Object?> get props => [playerId];
}

/// Increment a counter for a player
class IncrementCounterEvent extends GameEvent {
  final int playerId;
  final String counterKey;
  final int delta;
  
  const IncrementCounterEvent({
    required this.playerId,
    required this.counterKey,
    this.delta = 1,
  });
  
  @override
  List<Object?> get props => [playerId, counterKey, delta];
}
