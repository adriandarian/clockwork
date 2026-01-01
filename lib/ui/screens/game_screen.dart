/// Game screen - the main timer interface during gameplay
/// Cyber-Industrial styled game screen
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../engine/engine.dart';
import '../../providers/providers.dart';
import '../theme/app_theme.dart';
import '../widgets/player_tap_zone.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({super.key});

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  @override
  void initState() {
    super.initState();
    // Keep screen on during game
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }
  
  @override
  void dispose() {
    // Restore system UI
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gameControllerProvider);
    final preset = ref.watch(selectedPresetProvider);
    final controller = ref.read(gameControllerProvider.notifier);
    
    if (gameState == null || preset == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    
    final isPaused = gameState.status == GameStatus.paused;
    final isNotStarted = gameState.status == GameStatus.notStarted;
    final isFinished = gameState.status == GameStatus.finished;
    
    return Scaffold(
      body: Stack(
        children: [
          // Player tap zones
          if (gameState.players.length == 2)
            _TwoPlayerLayout(
              gameState: gameState,
              isPaused: isPaused,
              onTap: controller.tap,
            )
          else
            _MultiPlayerLayout(
              gameState: gameState,
              isPaused: isPaused,
              onTap: controller.tap,
            ),
          
          // Control bar overlay
          _ControlBar(
            isPaused: isPaused,
            isNotStarted: isNotStarted,
            isFinished: isFinished,
            canUndo: gameState.canUndo,
            presetName: preset.name,
            moveCount: gameState.moveCount,
            onPause: controller.togglePause,
            onUndo: controller.undo,
            onReset: controller.reset,
            onExit: () => _confirmExit(context, controller),
          ),
          
          // Start overlay
          if (isNotStarted)
            _StartOverlay(
              onStart: () => controller.dispatch(const StartGameEvent()),
            ),
          
          // Paused overlay
          if (isPaused)
            _PausedOverlay(
              onResume: controller.resume,
            ),
          
          // Game ended overlay
          if (isFinished)
            _GameEndedOverlay(
              gameState: gameState,
              onNewGame: controller.reset,
              onExit: () => Navigator.of(context).pop(),
            ),
        ],
      ),
    );
  }
  
  Future<void> _confirmExit(BuildContext context, GameController controller) async {
    final gameState = ref.read(gameControllerProvider);
    if (gameState == null || gameState.status == GameStatus.notStarted) {
      Navigator.of(context).pop();
      return;
    }
    
    // Pause during dialog
    if (gameState.status == GameStatus.running) {
      controller.pause();
    }
    
    final shouldExit = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit Game?'),
        content: const Text('Your current game will be lost.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Exit'),
          ),
        ],
      ),
    );
    
    if (shouldExit == true && context.mounted) {
      Navigator.of(context).pop();
    }
  }
}

/// Two player layout - split screen vertically
class _TwoPlayerLayout extends StatelessWidget {
  final GameState gameState;
  final bool isPaused;
  final void Function(int) onTap;
  
  const _TwoPlayerLayout({
    required this.gameState,
    required this.isPaused,
    required this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Column(
      children: [
        // Player 2 (top, flipped so they can read it from across the table)
        Expanded(
          child: PlayerTapZone(
            player: gameState.players[1],
            isActive: gameState.activePlayerId == 1,
            isPaused: isPaused,
            isFlipped: true,
            onTap: () => onTap(1),
          ),
        ),
        
        // Divider
        Container(
          height: 2,
          color: isDark ? Colors.white24 : Colors.black12,
        ),
        
        // Player 1 (bottom)
        Expanded(
          child: PlayerTapZone(
            player: gameState.players[0],
            isActive: gameState.activePlayerId == 0,
            isPaused: isPaused,
            onTap: () => onTap(0),
          ),
        ),
      ],
    );
  }
}

/// Multi-player layout (3-6 players)
class _MultiPlayerLayout extends StatelessWidget {
  final GameState gameState;
  final bool isPaused;
  final void Function(int) onTap;
  
  const _MultiPlayerLayout({
    required this.gameState,
    required this.isPaused,
    required this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Column(
      children: gameState.players.map((player) {
        return Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: isDark ? Colors.white24 : Colors.black12,
                  width: 1,
                ),
              ),
            ),
            child: PlayerTapZone(
              player: player,
              isActive: gameState.activePlayerId == player.id,
              isPaused: isPaused,
              onTap: () => onTap(player.id),
            ),
          ),
        );
      }).toList(),
    );
  }
}

/// Control bar at the center of the screen
class _ControlBar extends StatelessWidget {
  final bool isPaused;
  final bool isNotStarted;
  final bool isFinished;
  final bool canUndo;
  final String presetName;
  final int moveCount;
  final VoidCallback onPause;
  final VoidCallback onUndo;
  final VoidCallback onReset;
  final VoidCallback onExit;
  
  const _ControlBar({
    required this.isPaused,
    required this.isNotStarted,
    required this.isFinished,
    required this.canUndo,
    required this.presetName,
    required this.moveCount,
    required this.onPause,
    required this.onUndo,
    required this.onReset,
    required this.onExit,
  });
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      bottom: 0,
      child: Center(
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          color: theme.cardColor.withValues(alpha: 0.9),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Exit button
                _ControlButton(
                  onPressed: onExit,
                  icon: Icons.close,
                  tooltip: 'Exit',
                  color: Colors.red,
                ),
                
                // Undo button
                _ControlButton(
                  onPressed: canUndo ? onUndo : null,
                  icon: Icons.undo,
                  tooltip: 'Undo',
                  color: isDark ? Colors.amber : Colors.orange,
                ),
                
                // Preset name & move count
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        presetName,
                        style: theme.textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (moveCount > 0)
                        Text(
                          'Move $moveCount',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.primary,
                          ),
                        ),
                    ],
                  ),
                ),
                
                // Reset button
                _ControlButton(
                  onPressed: onReset,
                  icon: Icons.refresh,
                  tooltip: 'Reset',
                  color: isDark ? Colors.purpleAccent : Colors.purple,
                ),
                
                // Pause button
                _ControlButton(
                  onPressed: isNotStarted || isFinished ? null : onPause,
                  icon: isPaused ? Icons.play_arrow : Icons.pause,
                  tooltip: isPaused ? 'Resume' : 'Pause',
                  color: theme.colorScheme.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final String tooltip;
  final Color color;
  
  const _ControlButton({
    required this.onPressed,
    required this.icon,
    required this.tooltip,
    required this.color,
  });
  
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, size: 24),
      tooltip: tooltip,
      color: color,
    );
  }
}

/// Overlay shown before game starts
class _StartOverlay extends StatelessWidget {
  final VoidCallback onStart;
  
  const _StartOverlay({required this.onStart});
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return GestureDetector(
      onTap: onStart,
      child: Container(
        color: Colors.black.withValues(alpha: 0.4),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.touch_app_outlined,
                size: 64,
                color: Colors.white.withValues(alpha: 0.9),
              ),
              const SizedBox(height: 24),
              Text(
                'Tap to Start',
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Overlay shown when game is paused
class _PausedOverlay extends StatelessWidget {
  final VoidCallback onResume;
  
  const _PausedOverlay({required this.onResume});
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return GestureDetector(
      onTap: onResume,
      child: Container(
        color: Colors.black.withValues(alpha: 0.4),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.pause_circle_outline,
                size: 64,
                color: Colors.white.withValues(alpha: 0.9),
              ),
              const SizedBox(height: 24),
              Text(
                'Paused',
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Tap to Resume',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Overlay shown when game ends
class _GameEndedOverlay extends StatelessWidget {
  final GameState gameState;
  final VoidCallback onNewGame;
  final VoidCallback onExit;
  
  const _GameEndedOverlay({
    required this.gameState,
    required this.onNewGame,
    required this.onExit,
  });
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Find the winner (non-timed-out player) or null if no clear winner
    final timedOutPlayers = gameState.players.where((p) => p.isTimedOut).toList();
    final winnerId = timedOutPlayers.length == gameState.players.length - 1
        ? gameState.players.firstWhere((p) => !p.isTimedOut).id
        : null;
    
    final winnerColor = winnerId != null 
        ? AppTheme.getPlayerColor(winnerId) 
        : Colors.white;
    
    return Container(
      color: Colors.black.withValues(alpha: 0.8),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (winnerId != null) ...[
              Icon(
                Icons.emoji_events_outlined,
                size: 64,
                color: winnerColor,
              ),
              const SizedBox(height: 16),
              Text(
                'Player ${winnerId + 1} Wins!',
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ] else ...[
              const Icon(
                Icons.timer_off_outlined,
                size: 64,
                color: Colors.white54,
              ),
              const SizedBox(height: 16),
              Text(
                'Game Over',
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
            const SizedBox(height: 8),
            Text(
              '${gameState.moveCount} Moves',
              style: theme.textTheme.titleMedium?.copyWith(
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                OutlinedButton(
                  onPressed: onExit,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white54),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Text('Exit'),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: onNewGame,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: winnerId != null ? winnerColor : theme.colorScheme.primary,
                    foregroundColor: Colors.black,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Text('Play Again'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

