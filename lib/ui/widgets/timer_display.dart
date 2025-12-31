/// Timer display widget - shows time in a large, readable format
library;

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class TimerDisplay extends StatelessWidget {
  final Duration duration;
  final Duration? initialDuration;
  final bool isActive;
  final bool isPaused;
  final Color? color;
  final double? fontSize;
  
  const TimerDisplay({
    super.key,
    required this.duration,
    this.initialDuration,
    this.isActive = false,
    this.isPaused = false,
    this.color,
    this.fontSize,
  });
  
  @override
  Widget build(BuildContext context) {
    final textColor = color ?? _getColor();
    final size = fontSize ?? (isActive ? 72 : 56);
    
    return AnimatedDefaultTextStyle(
      duration: const Duration(milliseconds: 200),
      style: TextStyle(
        fontSize: size,
        fontWeight: FontWeight.bold,
        color: textColor,
        fontFeatures: const [FontFeature.tabularFigures()],
      ),
      child: Text(
        _formatDuration(duration),
        textAlign: TextAlign.center,
      ),
    );
  }
  
  Color _getColor() {
    if (isPaused) return Colors.grey;
    if (!isActive) return Colors.white54;
    
    if (initialDuration != null) {
      return AppTheme.getTimerColor(duration, initialDuration!);
    }
    
    // Default color based on remaining time
    if (duration <= const Duration(seconds: 10)) {
      return AppTheme.timerCritical;
    }
    if (duration <= const Duration(seconds: 30)) {
      return AppTheme.timerWarning;
    }
    return AppTheme.timerNormal;
  }
  
  String _formatDuration(Duration d) {
    if (d.isNegative || d == Duration.zero) return '0:00';
    
    final hours = d.inHours;
    final minutes = d.inMinutes.remainder(60);
    final seconds = d.inSeconds.remainder(60);
    final tenths = (d.inMilliseconds.remainder(1000) / 100).floor();
    
    // Show hours if >= 1 hour
    if (hours > 0) {
      return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
    
    // Show tenths for under 10 seconds
    if (d.inSeconds < 10) {
      return '$seconds.$tenths';
    }
    
    // Standard minutes:seconds format
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}
