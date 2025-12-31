/// Preset card widget - displays a preset for selection
library;

import 'package:flutter/material.dart';
import '../../models/preset.dart';
import '../theme/app_theme.dart';

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
    
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with name and favorite
              Row(
                children: [
                  Expanded(
                    child: Text(
                      preset.name,
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                  if (onFavorite != null)
                    IconButton(
                      icon: Icon(
                        preset.isFavorite 
                            ? Icons.star_rounded 
                            : Icons.star_outline_rounded,
                        color: preset.isFavorite 
                            ? AppTheme.warningColor 
                            : Colors.grey,
                      ),
                      onPressed: onFavorite,
                    ),
                ],
              ),
              
              // Description
              if (preset.description != null) ...[
                const SizedBox(height: 8),
                Text(
                  preset.description!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              
              const SizedBox(height: 12),
              
              // Time info
              Row(
                children: [
                  _buildInfoChip(
                    context,
                    Icons.timer_outlined,
                    _formatDuration(preset.mainTime),
                  ),
                  if (preset.increment != null) ...[
                    const SizedBox(width: 8),
                    _buildInfoChip(
                      context,
                      Icons.add,
                      _formatDuration(preset.increment!),
                    ),
                  ],
                  const Spacer(),
                  _buildInfoChip(
                    context,
                    Icons.people_outline,
                    '${preset.playerCount}',
                  ),
                ],
              ),
              
              // Tags
              if (preset.tags.isNotEmpty) ...[
                const SizedBox(height: 12),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: preset.tags.take(3).map((tag) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        tag,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildInfoChip(BuildContext context, IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.grey),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
  
  String _formatDuration(Duration d) {
    if (d.inHours > 0) {
      return '${d.inHours}h ${d.inMinutes.remainder(60)}m';
    }
    if (d.inMinutes > 0) {
      final seconds = d.inSeconds.remainder(60);
      if (seconds > 0) {
        return '${d.inMinutes}m ${seconds}s';
      }
      return '${d.inMinutes}m';
    }
    return '${d.inSeconds}s';
  }
}
