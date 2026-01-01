/// Player tap zone - large tappable area for ending turns
/// Cyber-Industrial styled tap zone
library;

import 'package:flutter/material.dart';
import '../../engine/game_state.dart';
import 'timer_display.dart';

class PlayerTapZone extends StatelessWidget {
  final PlayerState player;
  final bool isActive;
  final bool isPaused;
  final bool isFlipped;
  final VoidCallback onTap;
  
  const PlayerTapZone({
    super.key,
    required this.player,
    required this.isActive,
    required this.isPaused,
    this.isFlipped = false,
    required this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    // Use standard colors based on player ID
    final playerColor = player.id == 0 
        ? (isDark ? Colors.blueAccent : Colors.blue)
        : (isDark ? Colors.redAccent : Colors.red);
    
    // Active state styling
    final backgroundColor = isActive 
        ? playerColor.withValues(alpha: 0.05)
        : Colors.transparent;
        
    return GestureDetector(
      onTap: isActive && !isPaused ? onTap : null,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        color: backgroundColor,
        child: Stack(
          children: [
            RotatedBox(
              quarterTurns: isFlipped ? 2 : 0,
              child: SafeArea(
                top: !isFlipped,
                bottom: isFlipped,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Player label
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: isActive ? playerColor.withValues(alpha: 0.1) : Colors.transparent,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          'Player ${player.id + 1}',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: isActive ? playerColor : theme.disabledColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      // Timer display
                      TimerDisplay(
                        duration: player.displayTime,
                        initialDuration: player.moveTime != null 
                            ? player.initialMoveTime 
                            : player.initialMainTime,
                        isActive: isActive,
                        isPaused: isPaused,
                        color: isActive ? playerColor : theme.disabledColor,
                      ),
                      
                      // Timeout indicator
                      if (player.isTimedOut)
                        Padding(
                          padding: const EdgeInsets.only(top: 24),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.error.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Time Expired',
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: theme.colorScheme.error,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      
                      // Tap hint for active player
                      if (isActive && !isPaused && !player.isTimedOut)
                        Padding(
                          padding: const EdgeInsets.only(top: 32),
                          child: AnimatedOpacity(
                            opacity: isActive ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 500),
                            child: Text(
                              'Tap to End Turn',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: playerColor.withValues(alpha: 0.7),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

