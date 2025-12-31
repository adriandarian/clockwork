/// Preset repository - manages loading and saving presets.
library;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/models.dart';

/// Provider for all available presets
final presetsProvider = StateNotifierProvider<PresetsNotifier, List<Preset>>((ref) {
  return PresetsNotifier();
});

/// Manages the preset list
class PresetsNotifier extends StateNotifier<List<Preset>> {
  PresetsNotifier() : super([]) {
    _loadPresets();
  }
  
  /// Load presets (built-in + custom from storage)
  void _loadPresets() {
    // Start with built-in presets
    state = [...DefaultPresets.all];
    
    // TODO: Load custom presets from Hive storage
  }
  
  /// Add a custom preset
  void addPreset(Preset preset) {
    state = [...state, preset];
    // TODO: Save to Hive storage
  }
  
  /// Update a preset
  void updatePreset(Preset preset) {
    state = state.map((p) => p.id == preset.id ? preset : p).toList();
    // TODO: Save to Hive storage
  }
  
  /// Delete a preset (only custom presets can be deleted)
  void deletePreset(String id) {
    final preset = state.firstWhere((p) => p.id == id, orElse: () => throw Exception('Preset not found'));
    if (preset.isBuiltIn) {
      throw Exception('Cannot delete built-in presets');
    }
    state = state.where((p) => p.id != id).toList();
    // TODO: Remove from Hive storage
  }
  
  /// Toggle favorite status
  void toggleFavorite(String id) {
    state = state.map((p) {
      if (p.id == id) {
        return p.copyWith(isFavorite: !p.isFavorite);
      }
      return p;
    }).toList();
    // TODO: Save to Hive storage
  }
}

/// Provider for favorite presets
final favoritePresetsProvider = Provider<List<Preset>>((ref) {
  return ref.watch(presetsProvider).where((p) => p.isFavorite).toList();
});

/// Provider for presets by category
final presetsByCategoryProvider = Provider.family<List<Preset>, PresetCategory>((ref, category) {
  return ref.watch(presetsProvider).where((p) => p.category == category).toList();
});

/// Provider for chess presets
final chessPresetsProvider = Provider<List<Preset>>((ref) {
  return ref.watch(presetsByCategoryProvider(PresetCategory.chess));
});

/// Provider for party presets
final partyPresetsProvider = Provider<List<Preset>>((ref) {
  return ref.watch(presetsByCategoryProvider(PresetCategory.party));
});

/// Search presets by name or tags
final presetSearchProvider = Provider.family<List<Preset>, String>((ref, query) {
  if (query.isEmpty) return ref.watch(presetsProvider);
  
  final lowercaseQuery = query.toLowerCase();
  return ref.watch(presetsProvider).where((p) {
    return p.name.toLowerCase().contains(lowercaseQuery) ||
           p.tags.any((tag) => tag.toLowerCase().contains(lowercaseQuery)) ||
           (p.description?.toLowerCase().contains(lowercaseQuery) ?? false);
  }).toList();
});
