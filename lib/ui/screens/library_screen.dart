/// Library screen - main screen for browsing and selecting presets
/// Clean, simple design with expandable category sections
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';
import 'game_screen.dart';
import 'settings_screen.dart';

/// Local state for section expansion - starts expanded
final _sectionExpandedProvider = StateProvider.family<bool, String>((ref, id) => true);

class LibraryScreen extends ConsumerWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final allPresets = ref.watch(presetsProvider);
    final folders = ref.watch(foldersProvider);
    
    // Organize presets by category
    final goPresets = allPresets.where((p) => p.category == PresetCategory.go).toList();
    final chessPresets = allPresets.where((p) => p.category == PresetCategory.chess).toList();
    final resetPresets = allPresets.where((p) => p.timerType == TimerType.resetPerMove).toList();

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 12, 8),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.timer,
                      size: 24,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Clockwork',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                        Text(
                          'Universal Game Timer',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: isDark ? Colors.white60 : Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.create_new_folder_outlined,
                      color: isDark ? Colors.white70 : Colors.black54,
                    ),
                    tooltip: 'New Folder',
                    onPressed: () => _showCreateFolderDialog(context, ref),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.settings_outlined,
                      color: isDark ? Colors.white70 : Colors.black54,
                    ),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SettingsScreen()),
                    ),
                  ),
                ],
              ),
            ),
            
            // Content
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                children: [
                  // Go / Baduk section
                  if (goPresets.isNotEmpty)
                    _CategorySection(
                      id: 'go',
                      title: 'Go / Baduk',
                      emoji: '⚫',
                      color: Colors.grey[700]!,
                      presets: goPresets,
                      onPresetTap: (p) => _startGame(context, ref, p),
                    ),
                  
                  // Chess section
                  if (chessPresets.isNotEmpty)
                    _CategorySection(
                      id: 'chess',
                      title: 'Chess',
                      emoji: '♟️',
                      color: Colors.deepPurple,
                      presets: chessPresets,
                      onPresetTap: (p) => _startGame(context, ref, p),
                    ),
                  
                  // Reset Timers section
                  if (resetPresets.isNotEmpty)
                    _CategorySection(
                      id: 'reset',
                      title: 'Reset Timers',
                      emoji: '🔄',
                      color: Colors.teal,
                      presets: resetPresets,
                      onPresetTap: (p) => _startGame(context, ref, p),
                    ),
                  
                  // User-created folders
                  ...folders.map((folder) {
                    // Get presets assigned to this folder
                    final folderPresets = allPresets.where((p) => p.folderId == folder.id).toList();
                    return _CategorySection(
                      id: folder.id,
                      title: folder.name,
                      emoji: folder.iconEmoji,
                      color: theme.colorScheme.primary,
                      presets: folderPresets,
                      onPresetTap: (p) => _startGame(context, ref, p),
                      folderId: folder.id,
                      onRename: (folderId, name) => _showRenameFolderDialog(context, ref, folderId, name),
                    );
                  }),
                  
                  // Empty state hint if no content
                  if (goPresets.isEmpty && chessPresets.isEmpty && resetPresets.isEmpty && folders.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 60),
                      child: Column(
                        children: [
                          Icon(
                            Icons.timer_outlined,
                            size: 64,
                            color: isDark ? Colors.white24 : Colors.black26,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No timers yet',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: isDark ? Colors.white54 : Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Tap "New Timer" to create your first timer\nor create a folder to organize presets',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: isDark ? Colors.white38 : Colors.black38,
                            ),
                          ),
                        ],
                      ),
                    ),
                  
                  const SizedBox(height: 100), // Space for FAB
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showQuickTimerDialog(context, ref),
        icon: const Icon(Icons.add),
        label: const Text('New Timer'),
      ),
    );
  }

  void _startGame(BuildContext context, WidgetRef ref, Preset preset) {
    ref.read(gameControllerProvider.notifier).startNewGame(preset);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const GameScreen()),
    );
  }

  void _showQuickTimerDialog(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _QuickTimerSheet(
        onStart: (preset) {
          Navigator.pop(context);
          _startGame(context, ref, preset);
        },
      ),
    );
  }

  void _showCreateFolderDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    String selectedEmoji = '📁';
    
    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Create Folder'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controller,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'Folder name',
                  hintText: 'e.g., Tournament Presets',
                ),
              ),
              const SizedBox(height: 16),
              Text('Choose icon', style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: ['📁', '⭐', '🎮', '🏆', '⚡', '🎯', '🔥', '💎'].map((emoji) {
                  final isSelected = selectedEmoji == emoji;
                  return GestureDetector(
                    onTap: () => setState(() => selectedEmoji = emoji),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isSelected 
                            ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.2)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        border: isSelected 
                            ? Border.all(color: Theme.of(context).colorScheme.primary)
                            : null,
                      ),
                      child: Text(emoji, style: const TextStyle(fontSize: 24)),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  final folder = Folder(
                    id: 'folder-${DateTime.now().millisecondsSinceEpoch}',
                    name: controller.text,
                    iconEmoji: selectedEmoji,
                  );
                  ref.read(foldersProvider.notifier).createFolder(folder);
                  Navigator.pop(dialogContext);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Created folder "${controller.text}"')),
                  );
                }
              },
              child: const Text('Create'),
            ),
          ],
        ),
      ),
    );
  }

  void _showRenameFolderDialog(BuildContext context, WidgetRef ref, String folderId, String currentName) {
    final controller = TextEditingController(text: currentName);
    
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Rename Folder'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(
            labelText: 'Folder name',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(dialogContext);
              _showDeleteFolderConfirmation(context, ref, folderId, currentName);
            },
            child: const Text('Delete'),
          ),
          FilledButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                final folders = ref.read(foldersProvider);
                final folder = folders.firstWhere((f) => f.id == folderId);
                ref.read(foldersProvider.notifier).updateFolder(
                  folder.copyWith(name: controller.text),
                );
                Navigator.pop(dialogContext);
              }
            },
            child: const Text('Rename'),
          ),
        ],
      ),
    );
  }

  void _showDeleteFolderConfirmation(BuildContext context, WidgetRef ref, String folderId, String folderName) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Folder?'),
        content: Text('Are you sure you want to delete "$folderName"? Presets in this folder will be moved to Uncategorized.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              ref.read(foldersProvider.notifier).deleteFolder(folderId);
              Navigator.pop(dialogContext);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Deleted folder "$folderName"')),
              );
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

/// A collapsible category section
class _CategorySection extends ConsumerWidget {
  final String id;
  final String title;
  final String emoji;
  final Color color;
  final List<Preset> presets;
  final void Function(Preset) onPresetTap;
  final String? folderId; // If set, this is a user folder that can be renamed
  final void Function(String folderId, String currentName)? onRename;

  const _CategorySection({
    required this.id,
    required this.title,
    required this.emoji,
    required this.color,
    required this.presets,
    required this.onPresetTap,
    this.folderId,
    this.onRename,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isExpanded = ref.watch(_sectionExpandedProvider(id));
    final canRename = folderId != null && onRename != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        GestureDetector(
          onLongPress: canRename ? () => onRename!(folderId!, title) : null,
          child: InkWell(
            onTap: () => ref.read(_sectionExpandedProvider(id).notifier).state = !isExpanded,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
              child: Row(
                children: [
                  AnimatedRotation(
                    duration: const Duration(milliseconds: 200),
                    turns: isExpanded ? 0.25 : 0,
                    child: Icon(
                      Icons.chevron_right,
                      color: isDark ? Colors.white54 : Colors.black45,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(emoji, style: const TextStyle(fontSize: 20)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${presets.length}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ),
                  if (canRename) ...[
                    const SizedBox(width: 4),
                    Icon(
                      Icons.more_horiz,
                      size: 16,
                      color: isDark ? Colors.white38 : Colors.black26,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
        
        // Preset cards (animated)
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 250),
          crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          firstChild: const SizedBox(width: double.infinity, height: 0),
          secondChild: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: presets.map((preset) => SizedBox(
                width: (MediaQuery.of(context).size.width - 44) / 2,
                child: _PresetTile(
                  preset: preset,
                  accentColor: color,
                  onTap: () => onPresetTap(preset),
                ),
              )).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

/// Individual preset tile with clean design
class _PresetTile extends StatelessWidget {
  final Preset preset;
  final Color accentColor;
  final VoidCallback onTap;

  const _PresetTile({
    required this.preset,
    required this.accentColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Material(
      color: isDark ? Colors.grey[900] : Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark ? Colors.white10 : Colors.black12,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Timer type icon
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  _getTimerIcon(preset.timerType),
                  size: 18,
                  color: accentColor,
                ),
              ),
              const SizedBox(height: 12),
              
              // Name
              Text(
                preset.name,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              
              // Time info
              Text(
                _formatTime(preset),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: isDark ? Colors.white70 : Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),
              
              const SizedBox(height: 8),
              
              // Players badge
              Row(
                children: [
                  Icon(
                    Icons.people_outline,
                    size: 14,
                    color: isDark ? Colors.white54 : Colors.black45,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${preset.playerCount} players',
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? Colors.white54 : Colors.black45,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getTimerIcon(TimerType type) {
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

  String _formatTime(Preset preset) {
    final minutes = preset.mainTime.inMinutes;
    final seconds = preset.mainTime.inSeconds % 60;
    
    String time = '';
    if (minutes > 0) {
      time = '${minutes}m';
      if (seconds > 0) time += ' ${seconds}s';
    } else {
      time = '${seconds}s';
    }
    
    if (preset.increment != null && preset.increment!.inSeconds > 0) {
      time += ' +${preset.increment!.inSeconds}s';
    }
    
    if (preset.byoyomiPeriods > 0 && preset.byoyomiTime != null) {
      time += ' (${preset.byoyomiPeriods}×${preset.byoyomiTime!.inSeconds}s)';
    }
    
    return time;
  }
}

/// Quick timer creation bottom sheet
class _QuickTimerSheet extends StatefulWidget {
  final void Function(Preset) onStart;

  const _QuickTimerSheet({required this.onStart});

  @override
  State<_QuickTimerSheet> createState() => _QuickTimerSheetState();
}

class _QuickTimerSheetState extends State<_QuickTimerSheet> {
  int _minutes = 5;
  int _seconds = 0;
  int _increment = 0;
  int _players = 2;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: EdgeInsets.fromLTRB(
        24, 16, 24,
        16 + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle bar
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          
          Text(
            'Quick Timer',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          
          // Time selection
          Text('Time', style: theme.textTheme.titleSmall),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: _buildNumberField('Minutes', _minutes, (v) => setState(() => _minutes = v))),
              const SizedBox(width: 12),
              Expanded(child: _buildNumberField('Seconds', _seconds, (v) => setState(() => _seconds = v))),
            ],
          ),
          const SizedBox(height: 16),
          
          // Increment
          Text('Increment (per move)', style: theme.textTheme.titleSmall),
          const SizedBox(height: 8),
          _buildNumberField('Seconds', _increment, (v) => setState(() => _increment = v)),
          const SizedBox(height: 16),
          
          // Players
          Text('Players', style: theme.textTheme.titleSmall),
          const SizedBox(height: 8),
          SegmentedButton<int>(
            segments: const [
              ButtonSegment(value: 2, label: Text('2')),
              ButtonSegment(value: 3, label: Text('3')),
              ButtonSegment(value: 4, label: Text('4')),
            ],
            selected: {_players},
            onSelectionChanged: (v) => setState(() => _players = v.first),
          ),
          const SizedBox(height: 24),
          
          // Start button
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: (_minutes > 0 || _seconds > 0) ? _start : null,
              icon: const Icon(Icons.play_arrow),
              label: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text('Start Timer', style: TextStyle(fontSize: 16)),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildNumberField(String label, int value, void Function(int) onChanged) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: value > 0 ? () => onChanged(value - 1) : null,
          ),
          Expanded(
            child: Text(
              '$value',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => onChanged(value + 1),
          ),
        ],
      ),
    );
  }

  void _start() {
    final preset = Preset(
      id: 'quick-${DateTime.now().millisecondsSinceEpoch}',
      name: _generateName(),
      playerCount: _players,
      timerType: _increment > 0 ? TimerType.fischer : TimerType.countdown,
      mainTime: Duration(minutes: _minutes, seconds: _seconds),
      increment: _increment > 0 ? Duration(seconds: _increment) : null,
      timeoutBehavior: TimeoutBehavior.lose,
      isBuiltIn: false,
      category: PresetCategory.custom,
    );
    widget.onStart(preset);
  }

  String _generateName() {
    final time = _minutes > 0 ? '${_minutes}m' : '${_seconds}s';
    if (_increment > 0) {
      return '$time + ${_increment}s';
    }
    return time;
  }
}
