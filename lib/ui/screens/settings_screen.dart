/// Settings screen for app configuration
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/app_settings.dart';
import '../../models/folder.dart';
import '../../providers/settings_provider.dart';
import '../../providers/folders_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final settings = ref.watch(appSettingsProvider);
    final folders = ref.watch(foldersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: false,
      ),
      body: ListView(
        children: [
          // Appearance section
          _SectionHeader(title: 'Appearance'),
          ListTile(
            leading: Icon(
              settings.themeMode == ThemeMode.dark 
                  ? Icons.dark_mode 
                  : settings.themeMode == ThemeMode.light
                      ? Icons.light_mode
                      : Icons.auto_mode,
            ),
            title: const Text('Theme'),
            subtitle: Text(_getThemeModeLabel(settings.themeMode)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showThemePicker(context, ref, settings.themeMode),
          ),
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: const Text('Accent Color'),
            subtitle: Text(_getColorName(settings.accentColor)),
            trailing: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: settings.accentColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isDark ? Colors.white24 : Colors.black12,
                ),
              ),
            ),
            onTap: () => _showColorPicker(context, ref, settings.accentColor),
          ),
          ListTile(
            leading: Icon(
              settings.libraryViewMode == LibraryViewMode.grid
                  ? Icons.grid_view
                  : Icons.view_list,
            ),
            title: const Text('Library View'),
            subtitle: Text(settings.libraryViewMode == LibraryViewMode.grid ? 'Grid' : 'List'),
            trailing: Switch(
              value: settings.libraryViewMode == LibraryViewMode.grid,
              onChanged: (isGrid) {
                ref.read(appSettingsProvider.notifier).setLibraryViewMode(
                  isGrid ? LibraryViewMode.grid : LibraryViewMode.list,
                );
              },
            ),
          ),
          
          const Divider(height: 32),
          
          // Sound & Haptics section
          _SectionHeader(title: 'Sound & Haptics'),
          SwitchListTile(
            secondary: const Icon(Icons.volume_up),
            title: const Text('Sound Effects'),
            subtitle: Text(settings.soundEnabled ? 'Enabled' : 'Disabled'),
            value: settings.soundEnabled,
            onChanged: (enabled) {
              ref.read(appSettingsProvider.notifier).setSoundEnabled(enabled);
            },
          ),
          if (settings.soundEnabled)
            ListTile(
              leading: const Icon(Icons.music_note),
              title: const Text('Sound Pack'),
              subtitle: Text(_getSoundPackName(settings.soundPack)),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _showSoundPackPicker(context, ref, settings.soundPack),
            ),
          SwitchListTile(
            secondary: const Icon(Icons.vibration),
            title: const Text('Haptic Feedback'),
            subtitle: Text(settings.hapticFeedback ? 'Vibrate on actions' : 'Disabled'),
            value: settings.hapticFeedback,
            onChanged: (enabled) {
              ref.read(appSettingsProvider.notifier).setHapticFeedback(enabled);
            },
          ),
          
          const Divider(height: 32),
          
          // Folders section
          _SectionHeader(title: 'Folders'),
          ...folders.map((folder) => ListTile(
            leading: Text(folder.iconEmoji, style: const TextStyle(fontSize: 24)),
            title: Text(folder.name),
            trailing: IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () => _showFolderOptions(context, ref, folder.id, folder.name),
            ),
          )),
          ListTile(
            leading: Icon(Icons.add, color: theme.colorScheme.primary),
            title: Text(
              'Create Folder',
              style: TextStyle(color: theme.colorScheme.primary),
            ),
            onTap: () => _showCreateFolderDialog(context, ref),
          ),
          
          const Divider(height: 32),
          
          // Data section
          _SectionHeader(title: 'Data'),
          ListTile(
            leading: const Icon(Icons.refresh),
            title: const Text('Reset All Settings'),
            subtitle: const Text('Restore default settings'),
            onTap: () => _showResetConfirmation(context, ref, 'settings'),
          ),
          ListTile(
            leading: const Icon(Icons.delete_forever, color: Colors.red),
            title: const Text('Delete All Custom Timers', style: TextStyle(color: Colors.red)),
            subtitle: const Text('This cannot be undone'),
            onTap: () => _showResetConfirmation(context, ref, 'timers'),
          ),
          
          const Divider(height: 32),
          
          // About section
          _SectionHeader(title: 'About'),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Version'),
            subtitle: const Text('1.0.0'),
          ),
          ListTile(
            leading: const Icon(Icons.code),
            title: const Text('Source Code'),
            subtitle: const Text('Open source on GitHub'),
            onTap: () {
              // TODO: Open GitHub link
            },
          ),
          
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  String _getThemeModeLabel(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return 'System default';
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
    }
  }

  String _getColorName(Color color) {
    if (color == Colors.deepPurple) return 'Deep Purple';
    if (color == Colors.blue) return 'Blue';
    if (color == Colors.teal) return 'Teal';
    if (color == Colors.green) return 'Green';
    if (color == Colors.orange) return 'Orange';
    if (color == Colors.pink) return 'Pink';
    if (color == Colors.red) return 'Red';
    if (color == Colors.indigo) return 'Indigo';
    return 'Custom';
  }

  String _getSoundPackName(SoundPack pack) {
    switch (pack) {
      case SoundPack.classic:
        return 'Classic';
      case SoundPack.modern:
        return 'Modern';
      case SoundPack.gentle:
        return 'Gentle';
      case SoundPack.none:
        return 'None';
    }
  }

  void _showThemePicker(BuildContext context, WidgetRef ref, ThemeMode current) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return _ThemePickerSheet(
          current: current,
          onSelected: (mode) {
            ref.read(appSettingsProvider.notifier).setThemeMode(mode);
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void _showColorPicker(BuildContext context, WidgetRef ref, Color current) {
    final colors = [
      Colors.deepPurple,
      Colors.blue,
      Colors.teal,
      Colors.green,
      Colors.orange,
      Colors.pink,
      Colors.red,
      Colors.indigo,
    ];

    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Choose Accent Color', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: colors.map((color) => GestureDetector(
                  onTap: () {
                    ref.read(appSettingsProvider.notifier).setAccentColor(color);
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: current == color 
                          ? Border.all(color: Colors.white, width: 3)
                          : null,
                      boxShadow: current == color
                          ? [BoxShadow(color: color.withValues(alpha: 0.5), blurRadius: 8, spreadRadius: 2)]
                          : null,
                    ),
                    child: current == color 
                        ? const Icon(Icons.check, color: Colors.white)
                        : null,
                  ),
                )).toList(),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  void _showSoundPackPicker(BuildContext context, WidgetRef ref, SoundPack current) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return _SoundPackPickerSheet(
          current: current,
          onSelected: (pack) {
            ref.read(appSettingsProvider.notifier).setSoundPack(pack);
            Navigator.pop(context);
          },
          getSoundPackName: _getSoundPackName,
        );
      },
    );
  }

  void _showFolderOptions(BuildContext context, WidgetRef ref, String folderId, String folderName) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Rename'),
              onTap: () {
                Navigator.pop(context);
                _showRenameFolderDialog(context, ref, folderId, folderName);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Delete', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                ref.read(foldersProvider.notifier).deleteFolder(folderId);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Deleted folder "$folderName"')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showCreateFolderDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Folder'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(
            labelText: 'Folder name',
            hintText: 'e.g., Tournament Presets',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                final folder = Folder(
                  id: 'folder-${DateTime.now().millisecondsSinceEpoch}',
                  name: controller.text,
                );
                ref.read(foldersProvider.notifier).createFolder(folder);
                Navigator.pop(context);
              }
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _showRenameFolderDialog(BuildContext context, WidgetRef ref, String folderId, String currentName) {
    final controller = TextEditingController(text: currentName);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
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
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                final folders = ref.read(foldersProvider);
                final folder = folders.firstWhere((f) => f.id == folderId);
                ref.read(foldersProvider.notifier).updateFolder(
                  folder.copyWith(name: controller.text),
                );
                Navigator.pop(context);
              }
            },
            child: const Text('Rename'),
          ),
        ],
      ),
    );
  }

  void _showResetConfirmation(BuildContext context, WidgetRef ref, String type) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(type == 'settings' ? 'Reset Settings?' : 'Delete All Custom Timers?'),
        content: Text(
          type == 'settings'
              ? 'This will restore all settings to their defaults. Your timers will not be affected.'
              : 'This will permanently delete all your custom timers. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () {
              Navigator.pop(context);
              if (type == 'settings') {
                ref.read(appSettingsProvider.notifier).resetToDefaults();
              } else {
                // TODO: Implement delete all custom timers
              }
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    type == 'settings' 
                        ? 'Settings have been reset'
                        : 'Custom timers deleted',
                  ),
                ),
              );
            },
            child: Text(type == 'settings' ? 'Reset' : 'Delete'),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title.toUpperCase(),
        style: theme.textTheme.labelSmall?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

/// Stateful theme picker using Radio instead of deprecated RadioListTile APIs
class _ThemePickerSheet extends StatefulWidget {
  final ThemeMode current;
  final void Function(ThemeMode) onSelected;

  const _ThemePickerSheet({
    required this.current,
    required this.onSelected,
  });

  @override
  State<_ThemePickerSheet> createState() => _ThemePickerSheetState();
}

class _ThemePickerSheetState extends State<_ThemePickerSheet> {
  late ThemeMode _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.current;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text('Choose Theme', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          ListTile(
            leading: const Icon(Icons.auto_mode),
            title: const Text('System'),
            subtitle: const Text('Follow device settings'),
            trailing: Radio<ThemeMode>(
              value: ThemeMode.system,
              groupValue: _selected,
              onChanged: (v) {
                if (v != null) widget.onSelected(v);
              },
            ),
            onTap: () => widget.onSelected(ThemeMode.system),
          ),
          ListTile(
            leading: const Icon(Icons.light_mode),
            title: const Text('Light'),
            trailing: Radio<ThemeMode>(
              value: ThemeMode.light,
              groupValue: _selected,
              onChanged: (v) {
                if (v != null) widget.onSelected(v);
              },
            ),
            onTap: () => widget.onSelected(ThemeMode.light),
          ),
          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: const Text('Dark'),
            trailing: Radio<ThemeMode>(
              value: ThemeMode.dark,
              groupValue: _selected,
              onChanged: (v) {
                if (v != null) widget.onSelected(v);
              },
            ),
            onTap: () => widget.onSelected(ThemeMode.dark),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

/// Stateful sound pack picker
class _SoundPackPickerSheet extends StatefulWidget {
  final SoundPack current;
  final void Function(SoundPack) onSelected;
  final String Function(SoundPack) getSoundPackName;

  const _SoundPackPickerSheet({
    required this.current,
    required this.onSelected,
    required this.getSoundPackName,
  });

  @override
  State<_SoundPackPickerSheet> createState() => _SoundPackPickerSheetState();
}

class _SoundPackPickerSheetState extends State<_SoundPackPickerSheet> {
  late SoundPack _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.current;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text('Choose Sound Pack', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          ...SoundPack.values.where((p) => p != SoundPack.none).map((pack) => ListTile(
            title: Text(widget.getSoundPackName(pack)),
            trailing: Radio<SoundPack>(
              value: pack,
              groupValue: _selected,
              onChanged: (v) {
                if (v != null) widget.onSelected(v);
              },
            ),
            onTap: () => widget.onSelected(pack),
          )),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
