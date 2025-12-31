/// Player tap zone - large tappable area for ending turns
library;

import 'package:flutter/material.dart';
import '../../engine/game_state.dart';
import '../theme/app_theme.dart';
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
    final playerColor = AppTheme.getPlayerColor(player.id);
    final backgroundColor = isActive 
        ? playerColor.withOpacity(0.15)
        : Colors.transparent;
    
    return GestureDetector(
      onTap: isActive && !isPaused ? onTap : null,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border(
            bottom: isFlipped ? BorderSide.none : BorderSide(
              color: playerColor.withOpacity(0.3),
              width: 1,
            ),
            top: !isFlipped ? BorderSide.none : BorderSide(
              color: playerColor.withOpacity(0.3),
              width: 1,
            ),
          ),
        ),
        child: RotatedBox(
          quarterTurns: isFlipped ? 2 : 0,
          child: SafeArea(
            top: !isFlipped,
            bottom: isFlipped,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Player label
                  Text(
                    'Player ${player.id + 1}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: playerColor.withOpacity(isActive ? 1.0 : 0.5),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Timer display
                  TimerDisplay(
                    duration: player.displayTime,
                    initialDuration: player.moveTime != null 
                        ? player.initialMoveTime 
                        : player.initialMainTime,
                    isActive: isActive,
                    isPaused: isPaused,
                  ),
                  
                  // Timeout indicator
                  if (player.isTimedOut)
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.errorColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'TIME',
                          style: TextStyle(
                            color: AppTheme.errorColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  
                  // Tap hint for active player
                  if (isActive && !isPaused && !player.isTimedOut)
                    Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: Text(
                        'TAP TO END TURN',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withOpacity(0.5),
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
