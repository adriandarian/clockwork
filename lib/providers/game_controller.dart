/// Game controller - manages the active game session using Riverpod.
/// Connects the pure Dart engine to Flutter's reactive state management.
library;

import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../engine/engine.dart';
import '../models/preset.dart';

/// Provider for the currently selected preset
final selectedPresetProvider = StateProvider<Preset?>((ref) => null);

/// Provider for the game controller
final gameControllerProvider = StateNotifierProvider<GameController, GameState?>((ref) {
  return GameController(ref);
});

/// Game controller manages the active game session
class GameController extends StateNotifier<GameState?> {
  final Ref _ref;
  TimerEngine? _engine;
  Timer? _tickTimer;
  DateTime? _lastTickTime;
  
  GameController(this._ref) : super(null);
  
  /// Start a new game with the given preset
  void startNewGame(Preset preset) {
    // Clean up any existing game
    _tickTimer?.cancel();
    
    // Create engine and initial state
    _engine = TimerEngine(preset);
    state = _engine!.createInitialState();
    
    // Update selected preset
    _ref.read(selectedPresetProvider.notifier).state = preset;
  }
  
  /// Dispatch an event to the engine
  void dispatch(GameEvent event) {
    if (_engine == null || state == null) return;
    
    final result = _engine!.apply(event, state!);
    state = result.state;
    
    // Execute effects
    _executeEffects(result.effects);
    
    // Start/stop tick timer based on game status
    _updateTickTimer();
  }
  
  /// Tap for a specific player
  void tap(int playerId) {
    dispatch(TapPlayerEvent(playerId));
  }
  
  /// Pause the game
  void pause() {
    dispatch(const PauseEvent());
  }
  
  /// Resume the game
  void resume() {
    dispatch(const ResumeEvent());
  }
  
  /// Toggle pause/resume
  void togglePause() {
    if (state?.status == GameStatus.paused) {
      resume();
    } else if (state?.status == GameStatus.running) {
      pause();
    }
  }
  
  /// Undo the last action
  void undo() {
    dispatch(const UndoEvent());
  }
  
  /// Reset the game
  void reset() {
    dispatch(const ResetEvent());
  }
  
  /// Execute side effects produced by the engine
  void _executeEffects(List<GameEffect> effects) {
    for (final effect in effects) {
      switch (effect) {
        case PlaySoundEffect():
          _playSound(effect.sound);
        case HapticEffect():
          _triggerHaptic(effect.type);
        case ShowToastEffect():
          // TODO: Show toast via overlay
          break;
        case AnnounceEffect():
          // TODO: Text-to-speech
          break;
        case GameEndedEffect():
          _handleGameEnded(effect);
      }
    }
  }
  
  /// Play a sound effect
  void _playSound(SoundType sound) {
    // TODO: Implement with audioplayers package
    // For now, just use system sounds
    switch (sound) {
      case SoundType.tap:
        SystemSound.play(SystemSoundType.click);
      case SoundType.timeout:
      case SoundType.warning:
      case SoundType.gameEnd:
        SystemSound.play(SystemSoundType.alert);
      case SoundType.gameStart:
        SystemSound.play(SystemSoundType.click);
    }
  }
  
  /// Trigger haptic feedback
  void _triggerHaptic(HapticType type) {
    switch (type) {
      case HapticType.light:
        HapticFeedback.lightImpact();
      case HapticType.medium:
        HapticFeedback.mediumImpact();
      case HapticType.heavy:
        HapticFeedback.heavyImpact();
      case HapticType.success:
        HapticFeedback.mediumImpact();
      case HapticType.warning:
        HapticFeedback.heavyImpact();
      case HapticType.error:
        HapticFeedback.vibrate();
    }
  }
  
  /// Handle game ended
  void _handleGameEnded(GameEndedEffect effect) {
    _tickTimer?.cancel();
    // Could show a dialog or navigate to results screen
  }
  
  /// Update the tick timer based on game status
  void _updateTickTimer() {
    if (state?.status == GameStatus.running) {
      _startTickTimer();
    } else {
      _stopTickTimer();
    }
  }
  
  /// Start the tick timer for accurate time tracking
  void _startTickTimer() {
    if (_tickTimer?.isActive ?? false) return;
    
    _lastTickTime = DateTime.now();
    
    // Use a high-frequency timer (50ms) for smooth updates
    _tickTimer = Timer.periodic(const Duration(milliseconds: 50), (_) {
      final now = DateTime.now();
      final elapsed = now.difference(_lastTickTime!);
      _lastTickTime = now;
      
      // Dispatch tick event to engine
      if (_engine != null && state != null && state!.status == GameStatus.running) {
        final result = _engine!.apply(TickEvent(elapsed), state!);
        state = result.state;
        _executeEffects(result.effects);
      }
    });
  }
  
  /// Stop the tick timer
  void _stopTickTimer() {
    _tickTimer?.cancel();
    _tickTimer = null;
    _lastTickTime = null;
  }
  
  @override
  void dispose() {
    _tickTimer?.cancel();
    super.dispose();
  }
}

/// Provider to check if game is in progress
final isGameActiveProvider = Provider<bool>((ref) {
  final state = ref.watch(gameControllerProvider);
  return state != null && state.status != GameStatus.finished;
});

/// Provider for current game status
final gameStatusProvider = Provider<GameStatus?>((ref) {
  return ref.watch(gameControllerProvider)?.status;
});
