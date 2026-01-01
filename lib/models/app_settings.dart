/// App settings model - stores user preferences
library;

import 'package:flutter/material.dart' show Color, ThemeMode;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_settings.freezed.dart';
part 'app_settings.g.dart';

/// Library view mode
enum LibraryViewMode {
  grid,
  list,
}

/// Sound pack options
enum SoundPack {
  classic,
  modern,
  gentle,
  none,
}

/// JSON converter for Color
class SettingsColorConverter implements JsonConverter<Color, int> {
  const SettingsColorConverter();

  @override
  Color fromJson(int json) => Color(json);

  @override
  int toJson(Color color) => color.toARGB32();
}

/// JSON converter for ThemeMode
class ThemeModeConverter implements JsonConverter<ThemeMode, String> {
  const ThemeModeConverter();

  @override
  ThemeMode fromJson(String json) {
    switch (json) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  @override
  String toJson(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return 'system';
    }
  }
}

@freezed
class AppSettings with _$AppSettings {
  const factory AppSettings({
    // Appearance
    @ThemeModeConverter() @Default(ThemeMode.system) ThemeMode themeMode,
    @SettingsColorConverter() @Default(Color(0xFF6366F1)) Color accentColor,
    @Default(LibraryViewMode.grid) LibraryViewMode libraryViewMode,
    
    // Sound & Feedback
    @Default(true) bool soundEnabled,
    @Default(true) bool hapticFeedback,
    @Default(SoundPack.classic) SoundPack soundPack,
    @Default(10) int warningSeconds, // Seconds before timeout to warn
    
    // Timer Defaults
    @Default(2) int defaultPlayers,
    @Default(300) int defaultTimeSeconds, // 5 minutes
    
    // Quick Start preset IDs (customizable)
    @Default([]) List<String> quickStartPresetIds,
    
    // Section expansion state (sectionId -> isExpanded)
    @Default({}) Map<String, bool> sectionExpansionState,
  }) = _AppSettings;
  
  factory AppSettings.fromJson(Map<String, dynamic> json) => 
      _$AppSettingsFromJson(json);
}
