/// Immutable game state representing the current state of a match.
library;

import 'package:equatable/equatable.dart';

/// The current state of the game
class GameState extends Equatable {
  /// Current status of the game
  final GameStatus status;
  
  /// Index of the currently active player (whose timer is running)
  final int activePlayerId;
  
  /// State for each player
  final List<PlayerState> players;
  
  /// History of previous states for undo functionality
  final List<GameState> history;
  
  /// Total number of moves/turns taken
  final int moveCount;
  
  /// When the game was started
  final DateTime? startTime;
  
  const GameState({
    required this.status,
    required this.activePlayerId,
    required this.players,
    this.history = const [],
    this.moveCount = 0,
    this.startTime,
  });
  
  /// Create initial game state from preset configuration
  factory GameState.initial({
    required int playerCount,
    required Duration initialTime,
    required Duration? moveTime,
  }) {
    return GameState(
      status: GameStatus.notStarted,
      activePlayerId: 0,
      players: List.generate(
        playerCount,
        (i) => PlayerState(
          id: i,
          mainTime: initialTime,
          moveTime: moveTime,
          initialMainTime: initialTime,
          initialMoveTime: moveTime,
        ),
      ),
    );
  }
  
  /// Copy with modifications
  GameState copyWith({
    GameStatus? status,
    int? activePlayerId,
    List<PlayerState>? players,
    List<GameState>? history,
    int? moveCount,
    DateTime? startTime,
  }) {
    return GameState(
      status: status ?? this.status,
      activePlayerId: activePlayerId ?? this.activePlayerId,
      players: players ?? this.players,
      history: history ?? this.history,
      moveCount: moveCount ?? this.moveCount,
      startTime: startTime ?? this.startTime,
    );
  }
  
  /// Get player state by ID
  PlayerState getPlayer(int id) => players[id];
  
  /// Get the active player
  PlayerState get activePlayer => players[activePlayerId];
  
  /// Check if the game is running
  bool get isRunning => status == GameStatus.running;
  
  /// Check if the game can be undone
  bool get canUndo => history.isNotEmpty;
  
  /// Push current state to history and return new state
  GameState withHistory() {
    return copyWith(
      history: [...history, this],
    );
  }
  
  @override
  List<Object?> get props => [
    status,
    activePlayerId,
    players,
    moveCount,
    startTime,
  ];
}

/// Status of the game
enum GameStatus {
  notStarted,
  running,
  paused,
  finished,
}

/// State for a single player
class PlayerState extends Equatable {
  final int id;
  
  /// Main countdown timer (for formats like chess)
  final Duration mainTime;
  
  /// Per-move timer (for reset-per-move formats)
  final Duration? moveTime;
  
  /// Initial main time (for reset purposes)
  final Duration initialMainTime;
  
  /// Initial move time (for reset purposes)
  final Duration? initialMoveTime;
  
  /// Whether this player has timed out
  final bool isTimedOut;
  
  /// Custom counters (points, captures, penalties, etc.)
  final Map<String, int> counters;
  
  const PlayerState({
    required this.id,
    required this.mainTime,
    this.moveTime,
    required this.initialMainTime,
    this.initialMoveTime,
    this.isTimedOut = false,
    this.counters = const {},
  });
  
  /// Get the display time (move time if available, otherwise main time)
  Duration get displayTime => moveTime ?? mainTime;
  
  /// Check if player has time remaining
  bool get hasTimeRemaining => displayTime > Duration.zero;
  
  /// Copy with modifications
  PlayerState copyWith({
    Duration? mainTime,
    Duration? moveTime,
    bool? isTimedOut,
    Map<String, int>? counters,
  }) {
    return PlayerState(
      id: id,
      mainTime: mainTime ?? this.mainTime,
      moveTime: moveTime ?? this.moveTime,
      initialMainTime: initialMainTime,
      initialMoveTime: initialMoveTime,
      isTimedOut: isTimedOut ?? this.isTimedOut,
      counters: counters ?? this.counters,
    );
  }
  
  /// Subtract time from this player
  PlayerState subtractTime(Duration elapsed) {
    if (moveTime != null) {
      final newMoveTime = moveTime! - elapsed;
      return copyWith(
        moveTime: newMoveTime < Duration.zero ? Duration.zero : newMoveTime,
      );
    } else {
      final newMainTime = mainTime - elapsed;
      return copyWith(
        mainTime: newMainTime < Duration.zero ? Duration.zero : newMainTime,
      );
    }
  }
  
  /// Add increment time
  PlayerState addIncrement(Duration increment) {
    if (moveTime != null) {
      return copyWith(moveTime: moveTime! + increment);
    } else {
      return copyWith(mainTime: mainTime + increment);
    }
  }
  
  /// Reset move timer to initial value
  PlayerState resetMoveTime() {
    if (initialMoveTime != null) {
      return copyWith(moveTime: initialMoveTime);
    }
    return this;
  }
  
  @override
  List<Object?> get props => [
    id,
    mainTime,
    moveTime,
    initialMainTime,
    initialMoveTime,
    isTimedOut,
    counters,
  ];
}
