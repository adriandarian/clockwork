/// Home screen - preset selection and quick start
/// Cyber-Industrial styled home screen
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';

import '../widgets/preset_card.dart';
import 'game_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final presets = ref.watch(presetsProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.timer_outlined,
                          size: 32,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Clockwork',
                          style: theme.textTheme.headlineLarge?.copyWith(
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: theme.colorScheme.primary,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Text(
                        'Universal Game Timer',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: isDark ? Colors.white70 : Colors.black54,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Quick start section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quick Start',
                      style: theme.textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _QuickStartButton(
                            label: '30s Reset',
                            icon: Icons.refresh,
                            color: theme.colorScheme.primary,
                            onTap: () => _startGame(
                              context, 
                              ref, 
                              DefaultPresets.reset30,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _QuickStartButton(
                            label: '5+3 Blitz',
                            icon: Icons.bolt,
                            color: theme.colorScheme.secondary,
                            onTap: () => _startGame(
                              context, 
                              ref, 
                              DefaultPresets.blitz5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            const SliverToBoxAdapter(
              child: SizedBox(height: 32),
            ),
            
            // Reset timers section
            _PresetSection(
              title: 'Reset Timers',
              subtitle: 'Timer resets after each move',
              color: theme.colorScheme.error,
              presets: presets.where((p) => 
                p.timerType == TimerType.resetPerMove
              ).toList(),
              onPresetTap: (preset) => _startGame(context, ref, preset),
              onFavorite: (preset) => ref.read(presetsProvider.notifier).toggleFavorite(preset.id),
            ),
            
            // Chess timers section
            _PresetSection(
              title: 'Chess',
              subtitle: 'Traditional chess clock formats',
              color: Colors.purple,
              presets: presets.where((p) => 
                p.category == PresetCategory.chess
              ).toList(),
              onPresetTap: (preset) => _startGame(context, ref, preset),
              onFavorite: (preset) => ref.read(presetsProvider.notifier).toggleFavorite(preset.id),
            ),
            
            const SliverToBoxAdapter(
              child: SizedBox(height: 100),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showCustomPresetDialog(context, ref);
        },
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text(
          'Custom',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
  
  void _startGame(BuildContext context, WidgetRef ref, Preset preset) {
    ref.read(gameControllerProvider.notifier).startNewGame(preset);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const GameScreen(),
      ),
    );
  }
  
  void _showCustomPresetDialog(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: theme.scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _QuickCustomPresetSheet(
        onStart: (preset) {
          Navigator.pop(context);
          _startGame(context, ref, preset);
        },
      ),
    );
  }
}

class _QuickStartButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  
  const _QuickStartButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PresetSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;
  final List<Preset> presets;
  final void Function(Preset) onPresetTap;
  final void Function(Preset) onFavorite;
  
  const _PresetSection({
    required this.title,
    required this.subtitle,
    required this.color,
    required this.presets,
    required this.onPresetTap,
    required this.onFavorite,
  });
  
  @override
  Widget build(BuildContext context) {
    if (presets.isEmpty) return const SliverToBoxAdapter(child: SizedBox.shrink());
    
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 4,
                  height: 24,
                  color: color,
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: isDark ? Colors.white : Colors.black,
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, top: 4, bottom: 16),
              child: Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isDark ? Colors.white54 : Colors.black54,
                  fontSize: 12,
                ),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.1,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: presets.length,
              itemBuilder: (context, index) {
                return PresetCard(
                  preset: presets[index],
                  onTap: () => onPresetTap(presets[index]),
                  onFavorite: () => onFavorite(presets[index]),
                );
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _QuickCustomPresetSheet extends StatefulWidget {
  final void Function(Preset) onStart;
  
  const _QuickCustomPresetSheet({required this.onStart});
  
  @override
  State<_QuickCustomPresetSheet> createState() => _QuickCustomPresetSheetState();
}

class _QuickCustomPresetSheetState extends State<_QuickCustomPresetSheet> {
  int _minutes = 5;
  int _seconds = 0;
  int _incrementSeconds = 0;
  int _playerCount = 2;
  bool _resetPerMove = false;
  
  @override
  Widget build(BuildContext context) {
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
            Text(
              'Quick Custom Timer',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 24),
            
            // Time selection
            Text(
              'Time per player',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _NumberPicker(
                    label: 'Minutes',
                    value: _minutes,
                    min: 0,
                    max: 60,
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
            
            const SizedBox(height: 24),
            
            // Timer type
            SwitchListTile(
              title: const Text(
                'Reset per move',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text('Timer resets after each tap'),
              value: _resetPerMove,
              activeTrackColor: Theme.of(context).colorScheme.primary,
              onChanged: (v) => setState(() => _resetPerMove = v),
              contentPadding: EdgeInsets.zero,
            ),
            
            // Increment (only for non-reset mode)
            if (!_resetPerMove) ...[
              const SizedBox(height: 12),
              _NumberPicker(
                label: 'Increment (seconds)',
                value: _incrementSeconds,
                min: 0,
                max: 30,
                onChanged: (v) => setState(() => _incrementSeconds = v),
              ),
            ],
            
            const SizedBox(height: 24),
            
            // Player count
            Text(
              'Players',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 2, label: Text('2')),
                ButtonSegment(value: 3, label: Text('3')),
                ButtonSegment(value: 4, label: Text('4')),
              ],
              selected: {_playerCount},
              onSelectionChanged: (v) => setState(() => _playerCount = v.first),
            ),
            
            const SizedBox(height: 32),
            
            // Start button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _minutes == 0 && _seconds == 0 
                    ? null 
                    : () {
                        final time = Duration(
                          minutes: _minutes,
                          seconds: _seconds,
                        );
                        final preset = Preset(
                          id: 'custom-${DateTime.now().millisecondsSinceEpoch}',
                          name: 'Custom ${_formatDuration(time)}',
                          playerCount: _playerCount,
                          timerType: _resetPerMove 
                              ? TimerType.resetPerMove 
                              : TimerType.countdown,
                          mainTime: time,
                          moveTime: _resetPerMove ? time : null,
                          increment: !_resetPerMove && _incrementSeconds > 0
                              ? Duration(seconds: _incrementSeconds)
                              : null,
                          timeoutBehavior: _resetPerMove 
                              ? TimeoutBehavior.continuePlay 
                              : TimeoutBehavior.lose,
                        );
                        widget.onStart(preset);
                      },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text('Start Game'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  String _formatDuration(Duration d) {
    if (d.inMinutes > 0) {
      final seconds = d.inSeconds.remainder(60);
      if (seconds > 0) {
        return '${d.inMinutes}:${seconds.toString().padLeft(2, '0')}';
      }
      return '${d.inMinutes}m';
    }
    return '${d.inSeconds}s';
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.grey,
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
                onPressed: value > min 
                    ? () => onChanged(value - 1)
                    : null,
                icon: const Icon(Icons.remove),
              ),
              Expanded(
                child: Text(
                  value.toString(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              IconButton(
                onPressed: value < max 
                    ? () => onChanged(value + 1)
                    : null,
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
