// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppSettingsImpl _$$AppSettingsImplFromJson(Map<String, dynamic> json) =>
    _$AppSettingsImpl(
      themeMode: json['themeMode'] == null
          ? ThemeMode.system
          : const ThemeModeConverter().fromJson(json['themeMode'] as String),
      accentColor: json['accentColor'] == null
          ? const Color(0xFF6366F1)
          : const SettingsColorConverter()
              .fromJson((json['accentColor'] as num).toInt()),
      libraryViewMode: $enumDecodeNullable(
              _$LibraryViewModeEnumMap, json['libraryViewMode']) ??
          LibraryViewMode.grid,
      soundEnabled: json['soundEnabled'] as bool? ?? true,
      hapticFeedback: json['hapticFeedback'] as bool? ?? true,
      soundPack: $enumDecodeNullable(_$SoundPackEnumMap, json['soundPack']) ??
          SoundPack.classic,
      warningSeconds: (json['warningSeconds'] as num?)?.toInt() ?? 10,
      defaultPlayers: (json['defaultPlayers'] as num?)?.toInt() ?? 2,
      defaultTimeSeconds: (json['defaultTimeSeconds'] as num?)?.toInt() ?? 300,
      quickStartPresetIds: (json['quickStartPresetIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      sectionExpansionState:
          (json['sectionExpansionState'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, e as bool),
              ) ??
              const {},
    );

Map<String, dynamic> _$$AppSettingsImplToJson(_$AppSettingsImpl instance) =>
    <String, dynamic>{
      'themeMode': const ThemeModeConverter().toJson(instance.themeMode),
      'accentColor':
          const SettingsColorConverter().toJson(instance.accentColor),
      'libraryViewMode': _$LibraryViewModeEnumMap[instance.libraryViewMode]!,
      'soundEnabled': instance.soundEnabled,
      'hapticFeedback': instance.hapticFeedback,
      'soundPack': _$SoundPackEnumMap[instance.soundPack]!,
      'warningSeconds': instance.warningSeconds,
      'defaultPlayers': instance.defaultPlayers,
      'defaultTimeSeconds': instance.defaultTimeSeconds,
      'quickStartPresetIds': instance.quickStartPresetIds,
      'sectionExpansionState': instance.sectionExpansionState,
    };

const _$LibraryViewModeEnumMap = {
  LibraryViewMode.grid: 'grid',
  LibraryViewMode.list: 'list',
};

const _$SoundPackEnumMap = {
  SoundPack.classic: 'classic',
  SoundPack.modern: 'modern',
  SoundPack.gentle: 'gentle',
  SoundPack.none: 'none',
};
