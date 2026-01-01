/// Timer display widget - shows time in a large, readable format
/// Cyber-Industrial styled timer
library;

import 'package:flutter/material.dart';

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
    final theme = Theme.of(context);
    final textColor = color ?? _getColor(context);
    final size = fontSize ?? (isActive ? 80.0 : 56.0);
    
    return AnimatedDefaultTextStyle(
      duration: const Duration(milliseconds: 200),
      style: theme.textTheme.displayLarge!.copyWith(
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
  
  Color _getColor(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    if (isPaused) return theme.disabledColor;
    if (!isActive) return theme.disabledColor.withValues(alpha: 0.5);
    
    // Default color based on remaining time
    if (duration <= const Duration(seconds: 10)) {
      return theme.colorScheme.error;
    }
    if (duration <= const Duration(seconds: 30)) {
      return isDark ? Colors.amber : Colors.orange;
    }
    return isDark ? Colors.white : Colors.black87;
  }
  
  String _formatDuration(Duration d) {
    if (d.isNegative || d == Duration.zero) return '0.0';
    
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
