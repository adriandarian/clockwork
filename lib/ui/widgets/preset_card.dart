/// Preset card widget - displays a preset for selection
/// Cyber-Industrial styled card
library;

import 'package:flutter/material.dart';
import '../../models/preset.dart';

class PresetCard extends StatelessWidget {
  final Preset preset;
  final VoidCallback onTap;
  final VoidCallback? onFavorite;
  
  const PresetCard({
    super.key,
    required this.preset,
    required this.onTap,
    this.onFavorite,
  });
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with name and favorite
              Row(
                children: [
                  Expanded(
                    child: Text(
                      preset.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (onFavorite != null)
                    IconButton(
                      icon: Icon(
                        preset.isFavorite 
                            ? Icons.star_rounded 
                            : Icons.star_outline_rounded,
                        color: preset.isFavorite 
                            ? const Color(0xFFF59E0B) // Amber
                            : Colors.grey,
                        size: 20,
                      ),
                      onPressed: onFavorite,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      style: IconButton.styleFrom(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                ],
              ),
              
              // Description (compact)
              if (preset.description != null) ...[
                const SizedBox(height: 4),
                Expanded(
                  child: Text(
                    preset.description!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.textTheme.bodySmall?.color,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ] else
                const Spacer(),
              
              // Time info - use Wrap for smaller screens
              Wrap(
                spacing: 4,
                runSpacing: 4,
                children: [
                  _buildInfoChip(
                    context,
                    Icons.timer_outlined,
                    _formatDuration(preset.mainTime),
                    theme.colorScheme.primary,
                  ),
                  if (preset.increment != null)
                    _buildInfoChip(
                      context,
                      Icons.add,
                      _formatDuration(preset.increment!),
                      theme.colorScheme.secondary,
                    ),
                  _buildInfoChip(
                    context,
                    Icons.people_outline,
                    '${preset.playerCount}',
                    isDark ? Colors.white70 : Colors.black54,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildInfoChip(BuildContext context, IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 3),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
  
  String _formatDuration(Duration d) {
    if (d.inHours > 0) {
      return '${d.inHours}H ${d.inMinutes.remainder(60)}M';
    }
    if (d.inMinutes > 0) {
      final seconds = d.inSeconds.remainder(60);
      if (seconds > 0) {
        return '${d.inMinutes}M ${seconds}S';
      }
      return '${d.inMinutes}M';
    }
    return '${d.inSeconds}S';
  }
}

