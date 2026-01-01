/// Library screen - main screen for browsing and selecting presets
/// Redesigned with collapsible sections, search, and better organization
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';
import '../widgets/collapsible_section.dart';
import '../widgets/preset_card.dart';
import '../widgets/preset_search_bar.dart';
import '../widgets/preset_context_menu.dart';
import 'game_screen.dart';
import 'settings_screen.dart';

/// Provider for search query
final searchQueryProvider = StateProvider<String>((ref) => '');

class LibraryScreen extends ConsumerWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final searchQuery = ref.watch(searchQueryProvider);
    final settings = ref.watch(appSettingsProvider);
    
    // Get presets based on search
    final allPresets = searchQuery.isEmpty
        ? ref.watch(presetsProvider)
        : ref.watch(presetSearchProvider(searchQuery));
    
    // Organize presets
    final favorites = allPresets.where((p) => p.isFavorite).toList();
    final folders = ref.watch(foldersProvider);
    final goPresets = allPresets.where((p) => p.category == PresetCategory.go).toList();
    final chessPresets = allPresets.where((p) => p.category == PresetCategory.chess).toList();
    final resetPresets = allPresets.where((p) => p.timerType == TimerType.resetPerMove).toList();
    final partyPresets = allPresets.where((p) => p.category == PresetCategory.party && p.timerType != TimerType.resetPerMove).toList();
    final customPresets = allPresets.where((p) => !p.isBuiltIn && p.folderId == null).toList();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App header with settings
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 12, 8),
                child: Row(
                  children: [
                    Icon(
                      Icons.timer_outlined,
                      size: 28,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Clockwork',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        settings.libraryViewMode == LibraryViewMode.grid
                            ? Icons.grid_view
                            : Icons.view_list,
                        color: isDark ? Colors.white70 : Colors.black54,
                      ),
                      onPressed: () {
                        ref.read(appSettingsProvider.notifier).setLibraryViewMode(
                          settings.libraryViewMode == LibraryViewMode.grid
                              ? LibraryViewMode.list
                              : LibraryViewMode.grid,
                        );
                      },
                      tooltip: 'Toggle view',
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.settings_outlined,
                        color: isDark ? Colors.white70 : Colors.black54,
                      ),
                      onPressed: () => _openSettings(context),
                      tooltip: 'Settings',
                    ),
                  ],
                ),
              ),
            ),
            
            // Search bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: PresetSearchBar(
                  onChanged: (query) {
                    ref.read(searchQueryProvider.notifier).state = query;
                  },
                  onClear: () {
                    ref.read(searchQueryProvider.notifier).state = '';
                  },
                ),
              ),
            ),
            
            // Search results or organized sections
            if (searchQuery.isNotEmpty) ...[
              // Show flat search results
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    '${allPresets.length} results for "$searchQuery"',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: isDark ? Colors.white54 : Colors.black54,
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: _buildPresetGrid(context, ref, allPresets, settings.libraryViewMode),
              ),
            ] else ...[
              // Favorites section (always first)
              if (favorites.isNotEmpty)
                SliverToBoxAdapter(
                  child: CollapsibleSection(
                    sectionId: 'favorites',
                    title: 'Favorites',
                    icon: Icons.star,
                    accentColor: Colors.amber,
                    itemCount: favorites.length,
                    isExpanded: settings.sectionExpansionState['favorites'] ?? true,
                    onToggle: () => ref.read(appSettingsProvider.notifier).toggleSectionExpansion('favorites'),
                    child: _buildPresetGridWidget(context, ref, favorites, settings.libraryViewMode),
                  ),
                ),
              
              // User folders
              ...folders.map((folder) {
                final folderPresets = allPresets.where((p) => p.folderId == folder.id).toList();
                if (folderPresets.isEmpty) return const SliverToBoxAdapter(child: SizedBox.shrink());
                
                return SliverToBoxAdapter(
                  child: CollapsibleSection(
                    sectionId: 'folder-${folder.id}',
                    title: folder.name,
                    iconEmoji: folder.iconEmoji,
                    accentColor: folder.color,
                    itemCount: folderPresets.length,
                    isExpanded: settings.sectionExpansionState['folder-${folder.id}'] ?? true,
                    onToggle: () => ref.read(appSettingsProvider.notifier).toggleSectionExpansion('folder-${folder.id}'),
                    onMore: () => _showFolderOptions(context, ref, folder),
                    child: _buildPresetGridWidget(context, ref, folderPresets, settings.libraryViewMode),
                  ),
                );
              }),
              
              // Go section
              if (goPresets.isNotEmpty)
                SliverToBoxAdapter(
                  child: CollapsibleSection(
                    sectionId: 'go',
                    title: 'Go / Baduk',
                    iconEmoji: '⚫',
                    accentColor: Colors.grey[800],
                    subtitle: 'Byo-yomi and Canadian overtime formats',
                    itemCount: goPresets.length,
                    isExpanded: settings.sectionExpansionState['go'] ?? true,
                    onToggle: () => ref.read(appSettingsProvider.notifier).toggleSectionExpansion('go'),
                    child: _buildPresetGridWidget(context, ref, goPresets, settings.libraryViewMode),
                  ),
                ),
              
              // Chess section
              if (chessPresets.isNotEmpty)
                SliverToBoxAdapter(
                  child: CollapsibleSection(
                    sectionId: 'chess',
                    title: 'Chess',
                    iconEmoji: '♟️',
                    accentColor: Colors.purple,
                    subtitle: 'Bullet, Blitz, Rapid, and Classical formats',
                    itemCount: chessPresets.length,
                    isExpanded: settings.sectionExpansionState['chess'] ?? true,
                    onToggle: () => ref.read(appSettingsProvider.notifier).toggleSectionExpansion('chess'),
                    child: _buildPresetGridWidget(context, ref, chessPresets, settings.libraryViewMode),
                  ),
                ),
              
              // Reset timers section
              if (resetPresets.isNotEmpty)
                SliverToBoxAdapter(
                  child: CollapsibleSection(
                    sectionId: 'reset',
                    title: 'Reset Timers',
                    icon: Icons.refresh,
                    accentColor: Colors.teal,
                    subtitle: 'Timer resets after each move',
                    itemCount: resetPresets.length,
                    isExpanded: settings.sectionExpansionState['reset'] ?? true,
                    onToggle: () => ref.read(appSettingsProvider.notifier).toggleSectionExpansion('reset'),
                    child: _buildPresetGridWidget(context, ref, resetPresets, settings.libraryViewMode),
                  ),
                ),
              
              // Party/Other section
              if (partyPresets.isNotEmpty)
                SliverToBoxAdapter(
                  child: CollapsibleSection(
                    sectionId: 'party',
                    title: 'Party & Board Games',
                    iconEmoji: '🎲',
                    accentColor: Colors.orange,
                    subtitle: 'Multi-player and casual formats',
                    itemCount: partyPresets.length,
                    isExpanded: settings.sectionExpansionState['party'] ?? true,
                    onToggle: () => ref.read(appSettingsProvider.notifier).toggleSectionExpansion('party'),
                    child: _buildPresetGridWidget(context, ref, partyPresets, settings.libraryViewMode),
                  ),
                ),
              
              // Custom presets (uncategorized)
              if (customPresets.isNotEmpty)
                SliverToBoxAdapter(
                  child: CollapsibleSection(
                    sectionId: 'custom',
                    title: 'My Timers',
                    icon: Icons.person,
                    accentColor: theme.colorScheme.primary,
                    subtitle: 'Your custom timer configurations',
                    itemCount: customPresets.length,
                    isExpanded: settings.sectionExpansionState['custom'] ?? true,
                    onToggle: () => ref.read(appSettingsProvider.notifier).toggleSectionExpansion('custom'),
                    child: _buildPresetGridWidget(context, ref, customPresets, settings.libraryViewMode),
                  ),
                ),
            ],
            
            // Bottom padding for FAB
            const SliverToBoxAdapter(
              child: SizedBox(height: 100),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCreateTimerSheet(context, ref),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text(
          'New Timer',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
  
  Widget _buildPresetGridWidget(
    BuildContext context,
    WidgetRef ref,
    List<Preset> presets,
    LibraryViewMode viewMode,
  ) {
    if (viewMode == LibraryViewMode.list) {
      return Column(
        children: presets.map((preset) => _buildListTile(context, ref, preset)).toList(),
      );
    }
    
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.1,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: presets.length,
      itemBuilder: (context, index) => _buildPresetCard(context, ref, presets[index]),
    );
  }
  
  SliverGrid _buildPresetGrid(
    BuildContext context,
    WidgetRef ref,
    List<Preset> presets,
    LibraryViewMode viewMode,
  ) {
    if (viewMode == LibraryViewMode.list) {
      return SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisExtent: 72,
          mainAxisSpacing: 8,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) => _buildListTile(context, ref, presets[index]),
          childCount: presets.length,
        ),
      );
    }
    
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.1,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) => _buildPresetCard(context, ref, presets[index]),
        childCount: presets.length,
      ),
    );
  }
  
  Widget _buildPresetCard(BuildContext context, WidgetRef ref, Preset preset) {
    return GestureDetector(
      onLongPressStart: (details) => _showContextMenu(context, ref, preset, details.globalPosition),
      child: PresetCard(
        preset: preset,
        onTap: () => _startGame(context, ref, preset),
        onFavorite: () => ref.read(presetsProvider.notifier).toggleFavorite(preset.id),
      ),
    );
  }
  
  Widget _buildListTile(BuildContext context, WidgetRef ref, Preset preset) {
    final theme = Theme.of(context);
    
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        onTap: () => _startGame(context, ref, preset),
        onLongPress: () {
          // Get approximate position for context menu
          final box = context.findRenderObject() as RenderBox?;
          final position = box?.localToGlobal(Offset.zero) ?? Offset.zero;
          _showContextMenu(context, ref, preset, position);
        },
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
          child: Icon(
            _getTimerTypeIcon(preset.timerType),
            color: theme.colorScheme.primary,
            size: 20,
          ),
        ),
        title: Text(
          preset.name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(_formatPresetSubtitle(preset)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (preset.isFavorite)
              const Icon(Icons.star, color: Colors.amber, size: 20),
            IconButton(
              icon: const Icon(Icons.play_arrow),
              onPressed: () => _startGame(context, ref, preset),
            ),
          ],
        ),
      ),
    );
  }
  
  IconData _getTimerTypeIcon(TimerType type) {
    switch (type) {
      case TimerType.countdown:
        return Icons.timer_outlined;
      case TimerType.resetPerMove:
        return Icons.refresh;
      case TimerType.fischer:
        return Icons.add_circle_outline;
      case TimerType.delay:
        return Icons.hourglass_empty;
      case TimerType.byoyomi:
        return Icons.replay;
      case TimerType.canadianByoyomi:
        return Icons.replay_circle_filled;
    }
  }
  
  String _formatPresetSubtitle(Preset preset) {
    final parts = <String>[];
    
    // Main time
    parts.add(_formatDuration(preset.mainTime));
    
    // Increment or byo-yomi info
    if (preset.increment != null) {
      parts.add('+${_formatDuration(preset.increment!)}');
    }
    if (preset.byoyomiPeriods > 0 && preset.byoyomiTime != null) {
      parts.add('${preset.byoyomiPeriods}×${_formatDuration(preset.byoyomiTime!)}');
    }
    
    // Players
    parts.add('${preset.playerCount}P');
    
    return parts.join(' • ');
  }
  
  String _formatDuration(Duration d) {
    if (d.inHours > 0) {
      return '${d.inHours}h${d.inMinutes.remainder(60)}m';
    }
    if (d.inMinutes > 0) {
      final seconds = d.inSeconds.remainder(60);
      if (seconds > 0) {
        return '${d.inMinutes}m${seconds}s';
      }
      return '${d.inMinutes}m';
    }
    return '${d.inSeconds}s';
  }
  
  void _startGame(BuildContext context, WidgetRef ref, Preset preset) {
    // Record usage for analytics
    ref.read(presetsProvider.notifier).recordUsage(preset.id);
    
    ref.read(gameControllerProvider.notifier).startNewGame(preset);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const GameScreen(),
      ),
    );
  }
  
  void _openSettings(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }
  
  void _showContextMenu(BuildContext context, WidgetRef ref, Preset preset, Offset position) async {
    final action = await showPresetContextMenu(
      context: context,
      preset: preset,
      position: position,
    );
    
    if (action == null || !context.mounted) return;
    
    switch (action) {
      case PresetAction.start:
        _startGame(context, ref, preset);
        break;
      case PresetAction.favorite:
      case PresetAction.unfavorite:
        ref.read(presetsProvider.notifier).toggleFavorite(preset.id);
        break;
      case PresetAction.duplicate:
        ref.read(presetsProvider.notifier).duplicatePreset(preset.id);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Duplicated "${preset.name}"')),
        );
        break;
      case PresetAction.edit:
        _showEditTimerSheet(context, ref, preset);
        break;
      case PresetAction.rename:
        final newName = await showRenameDialog(
          context: context,
          currentName: preset.name,
        );
        if (newName != null && newName.isNotEmpty) {
          ref.read(presetsProvider.notifier).renamePreset(preset.id, newName);
        }
        break;
      case PresetAction.moveToFolder:
        final folders = ref.read(foldersProvider);
        final folderId = await showFolderSelectionDialog(
          context: context,
          folders: folders,
          currentFolderId: preset.folderId,
        );
        if (folderId != null) {
          ref.read(presetsProvider.notifier).moveToFolder(
            preset.id, 
            folderId.isEmpty ? null : folderId,
          );
        }
        break;
      case PresetAction.delete:
        final confirmed = await showDeleteConfirmation(
          context: context,
          presetName: preset.name,
        );
        if (confirmed) {
          ref.read(presetsProvider.notifier).deletePreset(preset.id);
        }
        break;
    }
  }
  
  void _showFolderOptions(BuildContext context, WidgetRef ref, Folder folder) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Rename Folder'),
              onTap: () async {
                Navigator.pop(context);
                final newName = await showRenameDialog(
                  context: context,
                  currentName: folder.name,
                );
                if (newName != null && newName.isNotEmpty) {
                  ref.read(foldersProvider.notifier).updateFolder(
                    folder.copyWith(name: newName),
                  );
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Delete Folder', style: TextStyle(color: Colors.red)),
              onTap: () async {
                Navigator.pop(context);
                final confirmed = await showDeleteConfirmation(
                  context: context,
                  presetName: folder.name,
                );
                if (confirmed) {
                  ref.read(foldersProvider.notifier).deleteFolder(folder.id);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
  
  void _showCreateTimerSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => QuickTimerSheet(
        onSave: (preset) {
          Navigator.pop(context);
          ref.read(presetsProvider.notifier).addPreset(preset);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Created "${preset.name}"')),
          );
        },
        onSaveAndStart: (preset) {
          Navigator.pop(context);
          ref.read(presetsProvider.notifier).addPreset(preset);
          _startGame(context, ref, preset);
        },
      ),
    );
  }
  
  void _showEditTimerSheet(BuildContext context, WidgetRef ref, Preset preset) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => QuickTimerSheet(
        preset: preset,
        onSave: (updatedPreset) {
          Navigator.pop(context);
          ref.read(presetsProvider.notifier).updatePreset(updatedPreset);
        },
      ),
    );
  }
}

/// Quick timer creation/editing sheet
class QuickTimerSheet extends StatefulWidget {
  final Preset? preset;
  final void Function(Preset)? onSave;
  final void Function(Preset)? onSaveAndStart;

  const QuickTimerSheet({
    super.key,
    this.preset,
    this.onSave,
    this.onSaveAndStart,
  });

  @override
  State<QuickTimerSheet> createState() => _QuickTimerSheetState();
}

class _QuickTimerSheetState extends State<QuickTimerSheet> {
  late TextEditingController _nameController;
  late int _minutes;
  late int _seconds;
  late int _incrementSeconds;
  late int _playerCount;
  late TimerType _timerType;
  late int _byoyomiPeriods;
  late int _byoyomiSeconds;

  bool get isEditing => widget.preset != null;

  @override
  void initState() {
    super.initState();
    final p = widget.preset;
    _nameController = TextEditingController(text: p?.name ?? '');
    _minutes = p?.mainTime.inMinutes ?? 5;
    _seconds = (p?.mainTime.inSeconds ?? 0) % 60;
    _incrementSeconds = p?.increment?.inSeconds ?? 0;
    _playerCount = p?.playerCount ?? 2;
    _timerType = p?.timerType ?? TimerType.countdown;
    _byoyomiPeriods = p?.byoyomiPeriods ?? 3;
    _byoyomiSeconds = p?.byoyomiTime?.inSeconds ?? 30;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Text(
                  isEditing ? 'Edit Timer' : 'New Timer',
                  style: theme.textTheme.headlineSmall,
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Name
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Timer Name',
                hintText: 'e.g., My Go Timer',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            
            // Timer type
            Text('Timer Type', style: theme.textTheme.titleMedium),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildTypeChip(TimerType.countdown, 'Standard', Icons.timer),
                _buildTypeChip(TimerType.resetPerMove, 'Reset', Icons.refresh),
                _buildTypeChip(TimerType.fischer, 'Fischer', Icons.add_circle_outline),
                _buildTypeChip(TimerType.byoyomi, 'Byo-yomi', Icons.replay),
              ],
            ),
            const SizedBox(height: 24),
            
            // Main time
            Text('Main Time', style: theme.textTheme.titleMedium),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _NumberPicker(
                    label: 'Minutes',
                    value: _minutes,
                    min: 0,
                    max: 120,
                    onChanged: (v) => setState(() => _minutes = v),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _NumberPicker(
                    label: 'Seconds',
                    value: _seconds,
                    min: 0,
                    max: 59,
                    onChanged: (v) => setState(() => _seconds = v),
                  ),
                ),
              ],
            ),
            
            // Increment (for Fischer)
            if (_timerType == TimerType.fischer || _timerType == TimerType.countdown) ...[
              const SizedBox(height: 24),
              _NumberPicker(
                label: 'Increment (seconds per move)',
                value: _incrementSeconds,
                min: 0,
                max: 60,
                onChanged: (v) => setState(() => _incrementSeconds = v),
              ),
            ],
            
            // Byo-yomi settings
            if (_timerType == TimerType.byoyomi) ...[
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _NumberPicker(
                      label: 'Periods',
                      value: _byoyomiPeriods,
                      min: 1,
                      max: 10,
                      onChanged: (v) => setState(() => _byoyomiPeriods = v),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _NumberPicker(
                      label: 'Seconds/period',
                      value: _byoyomiSeconds,
                      min: 5,
                      max: 120,
                      onChanged: (v) => setState(() => _byoyomiSeconds = v),
                    ),
                  ),
                ],
              ),
            ],
            
            const SizedBox(height: 24),
            
            // Players
            Text('Players', style: theme.textTheme.titleMedium),
            const SizedBox(height: 12),
            SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 2, label: Text('2')),
                ButtonSegment(value: 3, label: Text('3')),
                ButtonSegment(value: 4, label: Text('4')),
                ButtonSegment(value: 5, label: Text('5')),
                ButtonSegment(value: 6, label: Text('6')),
              ],
              selected: {_playerCount},
              onSelectionChanged: (v) => setState(() => _playerCount = v.first),
            ),
            
            const SizedBox(height: 32),
            
            // Action buttons
            Row(
              children: [
                if (!isEditing && widget.onSaveAndStart != null)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _canSave() ? () => widget.onSave?.call(_buildPreset()) : null,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text('Save'),
                      ),
                    ),
                  ),
                if (!isEditing && widget.onSaveAndStart != null)
                  const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: _canSave()
                        ? () {
                            if (isEditing) {
                              widget.onSave?.call(_buildPreset());
                            } else {
                              widget.onSaveAndStart?.call(_buildPreset());
                            }
                          }
                        : null,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(isEditing ? 'Save Changes' : 'Save & Start'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeChip(TimerType type, String label, IconData icon) {
    final isSelected = _timerType == type;
    final theme = Theme.of(context);
    
    return FilterChip(
      selected: isSelected,
      onSelected: (_) => setState(() => _timerType = type),
      avatar: Icon(icon, size: 18),
      label: Text(label),
      selectedColor: theme.colorScheme.primary.withValues(alpha: 0.2),
    );
  }

  bool _canSave() {
    return _minutes > 0 || _seconds > 0;
  }

  Preset _buildPreset() {
    final time = Duration(minutes: _minutes, seconds: _seconds);
    final name = _nameController.text.isEmpty 
        ? _generateName(time)
        : _nameController.text;
    
    return Preset(
      id: widget.preset?.id ?? 'custom-${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      playerCount: _playerCount,
      timerType: _timerType,
      mainTime: time,
      moveTime: _timerType == TimerType.resetPerMove ? time : null,
      increment: _incrementSeconds > 0 ? Duration(seconds: _incrementSeconds) : null,
      byoyomiPeriods: _timerType == TimerType.byoyomi ? _byoyomiPeriods : 0,
      byoyomiTime: _timerType == TimerType.byoyomi ? Duration(seconds: _byoyomiSeconds) : null,
      timeoutBehavior: _timerType == TimerType.resetPerMove 
          ? TimeoutBehavior.continuePlay 
          : TimeoutBehavior.lose,
      isBuiltIn: false,
      isFavorite: widget.preset?.isFavorite ?? false,
      folderId: widget.preset?.folderId,
      category: PresetCategory.custom,
    );
  }

  String _generateName(Duration time) {
    final parts = <String>[];
    if (time.inMinutes > 0) {
      parts.add('${time.inMinutes}m');
    }
    if (time.inSeconds % 60 > 0) {
      parts.add('${time.inSeconds % 60}s');
    }
    
    switch (_timerType) {
      case TimerType.resetPerMove:
        return '${parts.join('')} Reset';
      case TimerType.fischer:
        if (_incrementSeconds > 0) {
          return '${time.inMinutes}+$_incrementSeconds';
        }
        return parts.join('');
      case TimerType.byoyomi:
        return '${parts.join('')} + $_byoyomiPeriods×${_byoyomiSeconds}s';
      default:
        return parts.join('');
    }
  }
}

class _NumberPicker extends StatelessWidget {
  final String label;
  final int value;
  final int min;
  final int max;
  final void Function(int) onChanged;

  const _NumberPicker({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: isDark ? Colors.white54 : Colors.black54,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: isDark ? Colors.white24 : Colors.black12,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: value > min ? () => onChanged(value - 1) : null,
                icon: const Icon(Icons.remove),
              ),
              Expanded(
                child: Text(
                  value.toString(),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleLarge,
                ),
              ),
              IconButton(
                onPressed: value < max ? () => onChanged(value + 1) : null,
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
