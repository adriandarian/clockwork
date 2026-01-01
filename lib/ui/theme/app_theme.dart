/// App theme configuration
/// Supports multiple themes: Standard (Modern Minimalist) and Cyber (Retro/Industrial)
library;

import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  
  // --- Standard Theme Colors ---
  static const Color standardPrimary = Color(0xFF3B82F6); // Blue
  static const Color standardSecondary = Color(0xFF10B981); // Emerald
  static const Color standardBackground = Color(0xFF121212);
  static const Color standardSurface = Color(0xFF1E1E1E);
  static const Color standardError = Color(0xFFEF4444);
  
  // --- Cyber Theme Colors ---
  static const Color cyberBlack = Color(0xFF050505);
  static const Color cyberBlue = Color(0xFF00F0FF);
  static const Color cyberPurple = Color(0xFFBC13FE);
  static const Color cyberRed = Color(0xFFFF2A2A);
  static const Color cyberYellow = Color(0xFFFAFF00);
  static const Color cyberGreen = Color(0xFF00FF94);
  
  // --- Shared Colors ---
  static const List<Color> playerColors = [
    Color(0xFF3B82F6), // Blue
    Color(0xFFEF4444), // Red
    Color(0xFF10B981), // Green
    Color(0xFFF59E0B), // Yellow
    Color(0xFF8B5CF6), // Purple
    Color(0xFFEC4899), // Pink
  ];
  
  // --- Standard Dark Theme (Default) ---
  static final ThemeData standardDark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: standardBackground,
    colorScheme: ColorScheme.dark(
      primary: standardPrimary,
      secondary: standardSecondary,
      error: standardError,
      surface: standardSurface,
      onSurface: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: standardBackground,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    ),
    cardTheme: CardThemeData(
      color: standardSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: standardPrimary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 72,
        fontWeight: FontWeight.bold,
        letterSpacing: -1.0,
        fontFeatures: [FontFeature.tabularFigures()],
      ),
      displayMedium: TextStyle(
        fontSize: 56,
        fontWeight: FontWeight.bold,
        letterSpacing: -1.0,
        fontFeatures: [FontFeature.tabularFigures()],
      ),
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        height: 1.5,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        height: 1.5,
        color: Colors.white70,
      ),
    ),
  );

  // --- Cyber Theme (Optional) ---
  static final ThemeData cyberTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: cyberBlack,
    colorScheme: ColorScheme.dark(
      primary: cyberBlue,
      secondary: cyberPurple,
      error: cyberRed,
      surface: const Color(0xFF121212),
      onSurface: Colors.white,
      outline: Colors.white24,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: cyberBlack,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: 'RobotoMono',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.5,
      ),
    ),
    cardTheme: CardThemeData(
      color: const Color(0xFF1E1E1E),
      elevation: 0,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Colors.white10, width: 1),
      ),
    ),
    // ... (Rest of cyber theme properties would go here if needed fully)
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'RobotoMono',
        fontSize: 72,
        fontWeight: FontWeight.bold,
        letterSpacing: -2,
        fontFeatures: [FontFeature.tabularFigures()],
      ),
      // ...
    ),
  );
  
  // --- Standard Light Theme ---
  static final ThemeData standardLight = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.grey[100],
    colorScheme: ColorScheme.light(
      primary: standardPrimary,
      secondary: standardSecondary,
      error: standardError,
      surface: Colors.white,
      onSurface: Colors.black87,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[100],
      foregroundColor: Colors.black87,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
        color: Colors.black87,
      ),
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    listTileTheme: const ListTileThemeData(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    ),
    dividerTheme: DividerThemeData(
      color: Colors.grey[300],
      thickness: 1,
    ),
  );

  // Getters for main.dart
  static ThemeData get darkTheme => standardDark;
  static ThemeData get lightTheme => standardLight;
  
  // Helper to check if current theme is Cyber (for widgets)
  static bool isCyber(BuildContext context) {
    // For now, we are hardcoding to Standard, so this is false.
    // In the future, we can check Theme.of(context).primaryColor == cyberBlue
    return false; 
  }

  /// Get color for player by index
  static Color getPlayerColor(int index) {
    return playerColors[index % playerColors.length];
  }
  
  /// Get timer color based on remaining time
  static Color getTimerColor(Duration remaining, Duration total) {
    final ratio = remaining.inMilliseconds / total.inMilliseconds;
    if (ratio <= 0.1) return standardError;
    if (ratio <= 0.25) return const Color(0xFFF59E0B); // Warning
    return Colors.white;
  }
}
