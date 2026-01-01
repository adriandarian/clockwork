/// Preset repository - manages loading and saving presets.
library;

import 'package:flutter/foundation.dart' show kDebugMode;
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
  
  /// Load presets from storage
  /// In debug mode, loads mock data for testing
  /// In release mode, starts empty (user creates their own)
  void _loadPresets() {
    // TODO: Load user's saved presets from Hive storage
    
    // In debug mode, load mock data for easier testing
    if (kDebugMode) {
      state = [...DefaultPresets.mockData];
    } else {
      // Production: start empty, user creates their own presets
      state = [];
    }
  }
  
  /// Add a custom preset
  void addPreset(Preset preset) {
    final now = DateTime.now().millisecondsSinceEpoch;
    final newPreset = preset.copyWith(
      createdAt: now,
      sortOrder: state.length,
    );
    state = [...state, newPreset];
    // TODO: Save to Hive storage
  }
  
  /// Update a preset
  void updatePreset(Preset preset) {
    state = state.map((p) => p.id == preset.id ? preset : p).toList();
    // TODO: Save to Hive storage
  }
  
  /// Delete a preset
  void deletePreset(String id) {
    state = state.where((p) => p.id != id).toList();
    // TODO: Remove from Hive storage
  }
  
  /// Duplicate a preset
  Preset duplicatePreset(String id, {String? newName}) {
    final original = state.firstWhere((p) => p.id == id);
    final duplicate = original.copyWith(
      id: 'custom-${DateTime.now().millisecondsSinceEpoch}',
      name: newName ?? '${original.name} (Copy)',
      isBuiltIn: false,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      sortOrder: state.length,
      useCount: 0,
      lastUsedAt: null,
    );
    state = [...state, duplicate];
    // TODO: Save to Hive storage
    return duplicate;
  }
  
  /// Move preset to folder
  void moveToFolder(String presetId, String? folderId) {
    state = state.map((p) {
      if (p.id == presetId) {
        return p.copyWith(folderId: folderId);
      }
      return p;
    }).toList();
    // TODO: Save to Hive storage
  }
  
  /// Batch move presets to folder
  void batchMoveToFolder(List<String> presetIds, String? folderId) {
    state = state.map((p) {
      if (presetIds.contains(p.id)) {
        return p.copyWith(folderId: folderId);
      }
      return p;
    }).toList();
    // TODO: Save to Hive storage
  }
  
  /// Batch delete presets
  void batchDelete(List<String> ids) {
    state = state.where((p) => !ids.contains(p.id) || p.isBuiltIn).toList();
    // TODO: Remove from Hive storage
  }
  
  /// Batch toggle favorite
  void batchToggleFavorite(List<String> ids, bool isFavorite) {
    state = state.map((p) {
      if (ids.contains(p.id)) {
        return p.copyWith(isFavorite: isFavorite);
      }
      return p;
    }).toList();
    // TODO: Save to Hive storage
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
  
  /// Record usage (for "recently used" and "most used" sorting)
  void recordUsage(String id) {
    state = state.map((p) {
      if (p.id == id) {
        return p.copyWith(
          useCount: p.useCount + 1,
          lastUsedAt: DateTime.now().millisecondsSinceEpoch,
        );
      }
      return p;
    }).toList();
    // TODO: Save to Hive storage
  }
  
  /// Rename a preset
  void renamePreset(String id, String newName) {
    state = state.map((p) {
      if (p.id == id) {
        return p.copyWith(name: newName);
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

/// Provider for recently used presets
final recentPresetsProvider = Provider<List<Preset>>((ref) {
  final presets = ref.watch(presetsProvider)
    .where((p) => p.lastUsedAt != null)
    .toList()
    ..sort((a, b) => (b.lastUsedAt ?? 0).compareTo(a.lastUsedAt ?? 0));
  return presets.take(5).toList();
});

/// Provider for most used presets
final mostUsedPresetsProvider = Provider<List<Preset>>((ref) {
  final presets = ref.watch(presetsProvider)
    .where((p) => p.useCount > 0)
    .toList()
    ..sort((a, b) => b.useCount.compareTo(a.useCount));
  return presets.take(5).toList();
});

/// Provider for presets by category
final presetsByCategoryProvider = Provider.family<List<Preset>, PresetCategory>((ref, category) {
  return ref.watch(presetsProvider).where((p) => p.category == category).toList();
});

/// Provider for chess presets
final chessPresetsProvider = Provider<List<Preset>>((ref) {
  return ref.watch(presetsByCategoryProvider(PresetCategory.chess));
});

/// Provider for go presets
final goPresetsProvider = Provider<List<Preset>>((ref) {
  return ref.watch(presetsByCategoryProvider(PresetCategory.go));
});

/// Provider for party presets
final partyPresetsProvider = Provider<List<Preset>>((ref) {
  return ref.watch(presetsByCategoryProvider(PresetCategory.party));
});

/// Provider for board game presets
final boardPresetsProvider = Provider<List<Preset>>((ref) {
  return ref.watch(presetsByCategoryProvider(PresetCategory.board));
});

/// Provider for custom presets (user-created)
final customPresetsProvider = Provider<List<Preset>>((ref) {
  return ref.watch(presetsProvider).where((p) => !p.isBuiltIn).toList();
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
