/// Preset context menu - shows options when long-pressing a preset card
library;

import 'package:flutter/material.dart';
import '../../models/models.dart';

/// Shows a context menu for preset actions
Future<PresetAction?> showPresetContextMenu({
  required BuildContext context,
  required Preset preset,
  required Offset position,
}) async {
  final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
  
  return showMenu<PresetAction>(
    context: context,
    position: RelativeRect.fromRect(
      Rect.fromLTWH(position.dx, position.dy, 0, 0),
      Offset.zero & overlay.size,
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    items: [
      _buildMenuItem(
        value: PresetAction.start,
        icon: Icons.play_arrow,
        label: 'Start Timer',
        color: Theme.of(context).colorScheme.primary,
      ),
      const PopupMenuDivider(),
      _buildMenuItem(
        value: preset.isFavorite ? PresetAction.unfavorite : PresetAction.favorite,
        icon: preset.isFavorite ? Icons.star : Icons.star_outline,
        label: preset.isFavorite ? 'Remove from Favorites' : 'Add to Favorites',
        color: Colors.amber,
      ),
      _buildMenuItem(
        value: PresetAction.duplicate,
        icon: Icons.copy,
        label: 'Duplicate',
      ),
      if (!preset.isBuiltIn) ...[
        _buildMenuItem(
          value: PresetAction.edit,
          icon: Icons.edit,
          label: 'Edit',
        ),
        _buildMenuItem(
          value: PresetAction.rename,
          icon: Icons.drive_file_rename_outline,
          label: 'Rename',
        ),
        _buildMenuItem(
          value: PresetAction.moveToFolder,
          icon: Icons.folder_open,
          label: 'Move to Folder...',
        ),
        const PopupMenuDivider(),
        _buildMenuItem(
          value: PresetAction.delete,
          icon: Icons.delete_outline,
          label: 'Delete',
          color: Colors.red,
        ),
      ],
    ],
  );
}

PopupMenuItem<PresetAction> _buildMenuItem({
  required PresetAction value,
  required IconData icon,
  required String label,
  Color? color,
}) {
  return PopupMenuItem<PresetAction>(
    value: value,
    child: Row(
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(width: 12),
        Text(
          label,
          style: TextStyle(color: color),
        ),
      ],
    ),
  );
}

/// Actions available in the preset context menu
enum PresetAction {
  start,
  favorite,
  unfavorite,
  edit,
  rename,
  duplicate,
  moveToFolder,
  delete,
}

/// Shows a rename dialog
Future<String?> showRenameDialog({
  required BuildContext context,
  required String currentName,
}) async {
  final controller = TextEditingController(text: currentName);
  
  return showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Rename Timer'),
      content: TextField(
        controller: controller,
        autofocus: true,
        decoration: const InputDecoration(
          labelText: 'Name',
          border: OutlineInputBorder(),
        ),
        onSubmitted: (value) => Navigator.of(context).pop(value),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(controller.text),
          child: const Text('Rename'),
        ),
      ],
    ),
  );
}

/// Shows a delete confirmation dialog
Future<bool> showDeleteConfirmation({
  required BuildContext context,
  required String presetName,
  bool isBatch = false,
  int count = 1,
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(isBatch ? 'Delete $count Timers?' : 'Delete Timer?'),
      content: Text(
        isBatch
            ? 'Are you sure you want to delete $count timers? This cannot be undone.'
            : 'Are you sure you want to delete "$presetName"? This cannot be undone.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: FilledButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: const Text('Delete'),
        ),
      ],
    ),
  );
  
  return result ?? false;
}

/// Shows a folder selection dialog
Future<String?> showFolderSelectionDialog({
  required BuildContext context,
  required List<Folder> folders,
  String? currentFolderId,
}) async {
  return showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Move to Folder'),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView(
          shrinkWrap: true,
          children: [
            // No folder option
            ListTile(
              leading: const Icon(Icons.folder_off_outlined),
              title: const Text('No Folder'),
              selected: currentFolderId == null,
              onTap: () => Navigator.of(context).pop(''),
            ),
            const Divider(),
            // Folder list
            ...folders.map((folder) => ListTile(
              leading: Text(folder.iconEmoji, style: const TextStyle(fontSize: 20)),
              title: Text(folder.name),
              selected: folder.id == currentFolderId,
              onTap: () => Navigator.of(context).pop(folder.id),
            )),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
      ],
    ),
  );
}
