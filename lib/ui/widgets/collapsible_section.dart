/// Collapsible section widget for organizing presets into expandable groups
library;

import 'package:flutter/material.dart';

class CollapsibleSection extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String sectionId;
  final IconData? icon;
  final String? iconEmoji;
  final Color? accentColor;
  final int itemCount;
  final bool isExpanded;
  final VoidCallback onToggle;
  final VoidCallback? onAdd;
  final VoidCallback? onMore;
  final Widget child;

  const CollapsibleSection({
    super.key,
    required this.title,
    this.subtitle,
    required this.sectionId,
    this.icon,
    this.iconEmoji,
    this.accentColor,
    required this.itemCount,
    required this.isExpanded,
    required this.onToggle,
    this.onAdd,
    this.onMore,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final color = accentColor ?? theme.colorScheme.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        InkWell(
          onTap: onToggle,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                // Expand/collapse icon
                AnimatedRotation(
                  duration: const Duration(milliseconds: 200),
                  turns: isExpanded ? 0.25 : 0,
                  child: Icon(
                    Icons.chevron_right,
                    size: 20,
                    color: isDark ? Colors.white54 : Colors.black54,
                  ),
                ),
                const SizedBox(width: 8),
                
                // Icon or emoji
                if (iconEmoji != null) ...[
                  Text(iconEmoji!, style: const TextStyle(fontSize: 18)),
                  const SizedBox(width: 8),
                ] else if (icon != null) ...[
                  Icon(icon, size: 20, color: color),
                  const SizedBox(width: 8),
                ],
                
                // Title and count
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '$itemCount',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: color,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Action buttons
                if (onAdd != null)
                  IconButton(
                    icon: const Icon(Icons.add, size: 20),
                    onPressed: onAdd,
                    tooltip: 'Add to $title',
                    visualDensity: VisualDensity.compact,
                  ),
                if (onMore != null)
                  IconButton(
                    icon: const Icon(Icons.more_horiz, size: 20),
                    onPressed: onMore,
                    tooltip: 'More options',
                    visualDensity: VisualDensity.compact,
                  ),
              ],
            ),
          ),
        ),
        
        // Subtitle
        if (subtitle != null && isExpanded)
          Padding(
            padding: const EdgeInsets.only(left: 52, bottom: 8),
            child: Text(
              subtitle!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: isDark ? Colors.white38 : Colors.black38,
              ),
            ),
          ),
        
        // Content with animation
        AnimatedCrossFade(
          firstChild: const SizedBox(width: double.infinity),
          secondChild: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: child,
          ),
          crossFadeState: isExpanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 200),
        ),
      ],
    );
  }
}
