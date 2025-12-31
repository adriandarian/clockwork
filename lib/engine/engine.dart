/// The pure Dart timer engine.
/// This is the heart of Clockwork - all game logic lives here.
/// No Flutter imports, no UI, no side effects. Just deterministic logic.
library;

import 'events.dart';
import 'effects.dart';
import 'game_state.dart';
import '../models/preset.dart';

export 'events.dart';
export 'effects.dart';
export 'game_state.dart';

/// Result of applying an event to the game state
class EngineResult {
  final GameState state;
  final List<GameEffect> effects;
  
  const EngineResult(this.state, this.effects);
}

/// The timer engine processes events and produces new states + effects
class TimerEngine {
  final Preset preset;
  
  const TimerEngine(this.preset);
  
  /// Create initial game state from the preset
  GameState createInitialState() {
    return GameState.initial(
      playerCount: preset.playerCount,
      initialTime: preset.mainTime,
      moveTime: preset.timerType == TimerType.resetPerMove 
          ? preset.moveTime 
          : null,
    );
  }
  
  /// Apply an event to the current state, returning new state and effects
  EngineResult apply(GameEvent event, GameState state) {
    return switch (event) {
      TickEvent e => _applyTick(e, state),
      TapPlayerEvent e => _applyTap(e, state),
      PauseEvent() => _applyPause(state),
      ResumeEvent() => _applyResume(state),
      StartGameEvent() => _applyStart(state),
      UndoEvent() => _applyUndo(state),
      ResetEvent() => _applyReset(state),
      TimeoutEvent e => _applyTimeout(e, state),
      IncrementCounterEvent e => _applyIncrementCounter(e, state),
    };
  }
  
  /// Process a tick event - update active player's time
  EngineResult _applyTick(TickEvent event, GameState state) {
    if (state.status != GameStatus.running) {
      return EngineResult(state, []);
    }
    
    final effects = <GameEffect>[];
    final activePlayer = state.activePlayer;
    final newPlayerState = activePlayer.subtractTime(event.elapsed);
    
    // Check for timeout
    if (!newPlayerState.hasTimeRemaining && !activePlayer.isTimedOut) {
      effects.add(const PlaySoundEffect(SoundType.timeout));
      effects.add(const HapticEffect(HapticType.error));
      
      final timedOutPlayer = newPlayerState.copyWith(isTimedOut: true);
      final newPlayers = List<PlayerState>.from(state.players);
      newPlayers[state.activePlayerId] = timedOutPlayer;
      
      // Handle timeout based on preset rules
      if (preset.timeoutBehavior == TimeoutBehavior.lose) {
        effects.add(GameEndedEffect(
          winnerId: _getOtherPlayerId(state.activePlayerId, state.players.length),
          reason: GameEndReason.timeout,
        ));
        return EngineResult(
          state.copyWith(
            status: GameStatus.finished,
            players: newPlayers,
          ),
          effects,
        );
      }
      
      return EngineResult(state.copyWith(players: newPlayers), effects);
    }
    
    // Check for warning at 10 seconds
    if (newPlayerState.displayTime <= const Duration(seconds: 10) &&
        activePlayer.displayTime > const Duration(seconds: 10)) {
      effects.add(const PlaySoundEffect(SoundType.warning));
      effects.add(const HapticEffect(HapticType.warning));
    }
    
    // Update player state
    final newPlayers = List<PlayerState>.from(state.players);
    newPlayers[state.activePlayerId] = newPlayerState;
    
    return EngineResult(state.copyWith(players: newPlayers), effects);
  }
  
  /// Process a tap event - end turn and switch players
  EngineResult _applyTap(TapPlayerEvent event, GameState state) {
    // Only the active player can tap (or tap to start)
    if (state.status == GameStatus.notStarted) {
      return _applyStart(state);
    }
    
    if (state.status != GameStatus.running) {
      return EngineResult(state, []);
    }
    
    if (event.playerId != state.activePlayerId) {
      return EngineResult(state, []);
    }
    
    final effects = <GameEffect>[
      const PlaySoundEffect(SoundType.tap),
      const HapticEffect(HapticType.light),
    ];
    
    // Save state for undo
    final stateWithHistory = state.withHistory();
    
    // Apply increment or reset based on timer type
    var currentPlayer = stateWithHistory.activePlayer;
    
    if (preset.timerType == TimerType.resetPerMove) {
      currentPlayer = currentPlayer.resetMoveTime();
    } else if (preset.increment != null && preset.increment! > Duration.zero) {
      currentPlayer = currentPlayer.addIncrement(preset.increment!);
    }
    
    // Update players
    final newPlayers = List<PlayerState>.from(stateWithHistory.players);
    newPlayers[state.activePlayerId] = currentPlayer;
    
    // Switch to next player
    final nextPlayerId = (state.activePlayerId + 1) % state.players.length;
    
    return EngineResult(
      stateWithHistory.copyWith(
        players: newPlayers,
        activePlayerId: nextPlayerId,
        moveCount: stateWithHistory.moveCount + 1,
      ),
      effects,
    );
  }
  
  /// Pause the game
  EngineResult _applyPause(GameState state) {
    if (state.status != GameStatus.running) {
      return EngineResult(state, []);
    }
    
    return EngineResult(
      state.copyWith(status: GameStatus.paused),
      [const HapticEffect(HapticType.medium)],
    );
  }
  
  /// Resume the game
  EngineResult _applyResume(GameState state) {
    if (state.status != GameStatus.paused) {
      return EngineResult(state, []);
    }
    
    return EngineResult(
      state.copyWith(status: GameStatus.running),
      [const HapticEffect(HapticType.light)],
    );
  }
  
  /// Start the game
  EngineResult _applyStart(GameState state) {
    if (state.status != GameStatus.notStarted) {
      return EngineResult(state, []);
    }
    
    return EngineResult(
      state.copyWith(
        status: GameStatus.running,
        startTime: DateTime.now(),
      ),
      [
        const PlaySoundEffect(SoundType.gameStart),
        const HapticEffect(HapticType.success),
      ],
    );
  }
  
  /// Undo the last move
  EngineResult _applyUndo(GameState state) {
    if (!state.canUndo) {
      return EngineResult(state, []);
    }
    
    final previousState = state.history.last;
    return EngineResult(
      previousState,
      [const HapticEffect(HapticType.light)],
    );
  }
  
  /// Reset the game to initial state
  EngineResult _applyReset(GameState state) {
    return EngineResult(
      createInitialState(),
      [const HapticEffect(HapticType.medium)],
    );
  }
  
  /// Handle timeout for a player
  EngineResult _applyTimeout(TimeoutEvent event, GameState state) {
    final player = state.getPlayer(event.playerId);
    if (player.isTimedOut) {
      return EngineResult(state, []);
    }
    
    final newPlayer = player.copyWith(isTimedOut: true);
    final newPlayers = List<PlayerState>.from(state.players);
    newPlayers[event.playerId] = newPlayer;
    
    return EngineResult(
      state.copyWith(players: newPlayers),
      [
        const PlaySoundEffect(SoundType.timeout),
        const HapticEffect(HapticType.error),
      ],
    );
  }
  
  /// Increment a counter for a player
  EngineResult _applyIncrementCounter(IncrementCounterEvent event, GameState state) {
    final player = state.getPlayer(event.playerId);
    final newCounters = Map<String, int>.from(player.counters);
    newCounters[event.counterKey] = (newCounters[event.counterKey] ?? 0) + event.delta;
    
    final newPlayer = player.copyWith(counters: newCounters);
    final newPlayers = List<PlayerState>.from(state.players);
    newPlayers[event.playerId] = newPlayer;
    
    return EngineResult(
      state.copyWith(players: newPlayers),
      [const HapticEffect(HapticType.light)],
    );
  }
  
  /// Get the other player ID (for 2-player games)
  int? _getOtherPlayerId(int currentId, int playerCount) {
    if (playerCount == 2) {
      return currentId == 0 ? 1 : 0;
    }
    return null;
  }
}
