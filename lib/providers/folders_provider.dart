/// Folder repository - manages user-created folders for organizing presets.
library;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/models.dart';
import 'presets_provider.dart';

/// Provider for all folders
final foldersProvider = StateNotifierProvider<FoldersNotifier, List<Folder>>((ref) {
  return FoldersNotifier();
});

/// Manages the folder list
class FoldersNotifier extends StateNotifier<List<Folder>> {
  FoldersNotifier() : super([]) {
    _loadFolders();
  }
  
  /// Load folders from storage
  void _loadFolders() {
    // TODO: Load from Hive storage
    // For now, start empty - user creates their own folders
    state = [];
  }
  
  /// Create a new folder
  void createFolder(Folder folder) {
    state = [...state, folder.copyWith(
      sortOrder: state.length,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    )];
    // TODO: Save to Hive storage
  }
  
  /// Update a folder
  void updateFolder(Folder folder) {
    state = state.map((f) => f.id == folder.id ? folder : f).toList();
    // TODO: Save to Hive storage
  }
  
  /// Delete a folder
  void deleteFolder(String id) {
    state = state.where((f) => f.id != id).toList();
    // Note: This doesn't delete presets - they become uncategorized
    // TODO: Remove from Hive storage
  }
  
  /// Toggle folder expansion
  void toggleExpansion(String id) {
    state = state.map((f) {
      if (f.id == id) {
        return f.copyWith(isExpanded: !f.isExpanded);
      }
      return f;
    }).toList();
    // TODO: Save to Hive storage
  }
  
  /// Reorder folders
  void reorderFolders(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final folders = [...state];
    final folder = folders.removeAt(oldIndex);
    folders.insert(newIndex, folder);
    
    // Update sort orders
    state = folders.asMap().entries.map((entry) {
      return entry.value.copyWith(sortOrder: entry.key);
    }).toList();
    // TODO: Save to Hive storage
  }
}

/// Provider for presets in a specific folder
final presetsInFolderProvider = Provider.family<List<Preset>, String?>((ref, folderId) {
  final presets = ref.watch(presetsProvider);
  return presets.where((p) => p.folderId == folderId).toList()
    ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
});

/// Provider for uncategorized presets (no folder)
final uncategorizedPresetsProvider = Provider<List<Preset>>((ref) {
  return ref.watch(presetsInFolderProvider(null))
    .where((p) => !p.isBuiltIn)
    .toList();
});
