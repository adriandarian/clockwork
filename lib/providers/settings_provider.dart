/// App settings provider - manages user preferences.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/models.dart';

/// Provider for app settings
final appSettingsProvider = StateNotifierProvider<AppSettingsNotifier, AppSettings>((ref) {
  return AppSettingsNotifier();
});

/// Manages app settings
class AppSettingsNotifier extends StateNotifier<AppSettings> {
  AppSettingsNotifier() : super(const AppSettings()) {
    _loadSettings();
  }
  
  /// Load settings from storage
  void _loadSettings() {
    // TODO: Load from Hive storage
    // For now, use defaults
  }
  
  /// Update theme mode
  void setThemeMode(ThemeMode mode) {
    state = state.copyWith(themeMode: mode);
    _saveSettings();
  }
  
  /// Update accent color
  void setAccentColor(Color color) {
    state = state.copyWith(accentColor: color);
    _saveSettings();
  }
  
  /// Update library view mode
  void setLibraryViewMode(LibraryViewMode mode) {
    state = state.copyWith(libraryViewMode: mode);
    _saveSettings();
  }
  
  /// Toggle sound
  void toggleSound() {
    state = state.copyWith(soundEnabled: !state.soundEnabled);
    _saveSettings();
  }
  
  /// Set sound enabled
  void setSoundEnabled(bool enabled) {
    state = state.copyWith(soundEnabled: enabled);
    _saveSettings();
  }
  
  /// Toggle haptic feedback
  void toggleHaptics() {
    state = state.copyWith(hapticFeedback: !state.hapticFeedback);
    _saveSettings();
  }
  
  /// Set haptic feedback
  void setHapticFeedback(bool enabled) {
    state = state.copyWith(hapticFeedback: enabled);
    _saveSettings();
  }
  
  /// Set sound pack
  void setSoundPack(SoundPack pack) {
    state = state.copyWith(soundPack: pack);
    _saveSettings();
  }
  
  /// Set warning seconds
  void setWarningSeconds(int seconds) {
    state = state.copyWith(warningSeconds: seconds);
    _saveSettings();
  }
  
  /// Set default players
  void setDefaultPlayers(int count) {
    state = state.copyWith(defaultPlayers: count);
    _saveSettings();
  }
  
  /// Set default time
  void setDefaultTime(Duration duration) {
    state = state.copyWith(defaultTimeSeconds: duration.inSeconds);
    _saveSettings();
  }
  
  /// Set quick start preset IDs
  void setQuickStartPresets(List<String> ids) {
    state = state.copyWith(quickStartPresetIds: ids);
    _saveSettings();
  }
  
  /// Toggle section expansion
  void toggleSectionExpansion(String sectionId) {
    final current = state.sectionExpansionState[sectionId] ?? true;
    state = state.copyWith(
      sectionExpansionState: {
        ...state.sectionExpansionState,
        sectionId: !current,
      },
    );
    _saveSettings();
  }
  
  /// Check if section is expanded
  bool isSectionExpanded(String sectionId) {
    return state.sectionExpansionState[sectionId] ?? true;
  }
  
  /// Save settings to storage
  void _saveSettings() {
    // TODO: Save to Hive storage
  }
  
  /// Reset to defaults
  void resetToDefaults() {
    state = const AppSettings();
    _saveSettings();
  }
}

/// Convenience providers

/// Current theme mode
final themeModeProvider = Provider<ThemeMode>((ref) {
  return ref.watch(appSettingsProvider).themeMode;
});

/// Current accent color
final accentColorProvider = Provider<Color>((ref) {
  return ref.watch(appSettingsProvider).accentColor;
});

/// Current library view mode
final libraryViewModeProvider = Provider<LibraryViewMode>((ref) {
  return ref.watch(appSettingsProvider).libraryViewMode;
});

/// Sound enabled
final soundEnabledProvider = Provider<bool>((ref) {
  return ref.watch(appSettingsProvider).soundEnabled;
});

/// Haptic feedback enabled
final hapticsEnabledProvider = Provider<bool>((ref) {
  return ref.watch(appSettingsProvider).hapticFeedback;
});
