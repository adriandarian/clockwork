// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AppSettings _$AppSettingsFromJson(Map<String, dynamic> json) {
  return _AppSettings.fromJson(json);
}

/// @nodoc
mixin _$AppSettings {
// Appearance
  @ThemeModeConverter()
  ThemeMode get themeMode => throw _privateConstructorUsedError;
  @SettingsColorConverter()
  Color get accentColor => throw _privateConstructorUsedError;
  LibraryViewMode get libraryViewMode =>
      throw _privateConstructorUsedError; // Sound & Feedback
  bool get soundEnabled => throw _privateConstructorUsedError;
  bool get hapticFeedback => throw _privateConstructorUsedError;
  SoundPack get soundPack => throw _privateConstructorUsedError;
  int get warningSeconds =>
      throw _privateConstructorUsedError; // Seconds before timeout to warn
// Timer Defaults
  int get defaultPlayers => throw _privateConstructorUsedError;
  int get defaultTimeSeconds => throw _privateConstructorUsedError; // 5 minutes
// Quick Start preset IDs (customizable)
  List<String> get quickStartPresetIds =>
      throw _privateConstructorUsedError; // Section expansion state (sectionId -> isExpanded)
  Map<String, bool> get sectionExpansionState =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppSettingsCopyWith<AppSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppSettingsCopyWith<$Res> {
  factory $AppSettingsCopyWith(
          AppSettings value, $Res Function(AppSettings) then) =
      _$AppSettingsCopyWithImpl<$Res, AppSettings>;
  @useResult
  $Res call(
      {@ThemeModeConverter() ThemeMode themeMode,
      @SettingsColorConverter() Color accentColor,
      LibraryViewMode libraryViewMode,
      bool soundEnabled,
      bool hapticFeedback,
      SoundPack soundPack,
      int warningSeconds,
      int defaultPlayers,
      int defaultTimeSeconds,
      List<String> quickStartPresetIds,
      Map<String, bool> sectionExpansionState});
}

/// @nodoc
class _$AppSettingsCopyWithImpl<$Res, $Val extends AppSettings>
    implements $AppSettingsCopyWith<$Res> {
  _$AppSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeMode = null,
    Object? accentColor = null,
    Object? libraryViewMode = null,
    Object? soundEnabled = null,
    Object? hapticFeedback = null,
    Object? soundPack = null,
    Object? warningSeconds = null,
    Object? defaultPlayers = null,
    Object? defaultTimeSeconds = null,
    Object? quickStartPresetIds = null,
    Object? sectionExpansionState = null,
  }) {
    return _then(_value.copyWith(
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
      accentColor: null == accentColor
          ? _value.accentColor
          : accentColor // ignore: cast_nullable_to_non_nullable
              as Color,
      libraryViewMode: null == libraryViewMode
          ? _value.libraryViewMode
          : libraryViewMode // ignore: cast_nullable_to_non_nullable
              as LibraryViewMode,
      soundEnabled: null == soundEnabled
          ? _value.soundEnabled
          : soundEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      hapticFeedback: null == hapticFeedback
          ? _value.hapticFeedback
          : hapticFeedback // ignore: cast_nullable_to_non_nullable
              as bool,
      soundPack: null == soundPack
          ? _value.soundPack
          : soundPack // ignore: cast_nullable_to_non_nullable
              as SoundPack,
      warningSeconds: null == warningSeconds
          ? _value.warningSeconds
          : warningSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      defaultPlayers: null == defaultPlayers
          ? _value.defaultPlayers
          : defaultPlayers // ignore: cast_nullable_to_non_nullable
              as int,
      defaultTimeSeconds: null == defaultTimeSeconds
          ? _value.defaultTimeSeconds
          : defaultTimeSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      quickStartPresetIds: null == quickStartPresetIds
          ? _value.quickStartPresetIds
          : quickStartPresetIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      sectionExpansionState: null == sectionExpansionState
          ? _value.sectionExpansionState
          : sectionExpansionState // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppSettingsImplCopyWith<$Res>
    implements $AppSettingsCopyWith<$Res> {
  factory _$$AppSettingsImplCopyWith(
          _$AppSettingsImpl value, $Res Function(_$AppSettingsImpl) then) =
      __$$AppSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@ThemeModeConverter() ThemeMode themeMode,
      @SettingsColorConverter() Color accentColor,
      LibraryViewMode libraryViewMode,
      bool soundEnabled,
      bool hapticFeedback,
      SoundPack soundPack,
      int warningSeconds,
      int defaultPlayers,
      int defaultTimeSeconds,
      List<String> quickStartPresetIds,
      Map<String, bool> sectionExpansionState});
}

/// @nodoc
class __$$AppSettingsImplCopyWithImpl<$Res>
    extends _$AppSettingsCopyWithImpl<$Res, _$AppSettingsImpl>
    implements _$$AppSettingsImplCopyWith<$Res> {
  __$$AppSettingsImplCopyWithImpl(
      _$AppSettingsImpl _value, $Res Function(_$AppSettingsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeMode = null,
    Object? accentColor = null,
    Object? libraryViewMode = null,
    Object? soundEnabled = null,
    Object? hapticFeedback = null,
    Object? soundPack = null,
    Object? warningSeconds = null,
    Object? defaultPlayers = null,
    Object? defaultTimeSeconds = null,
    Object? quickStartPresetIds = null,
    Object? sectionExpansionState = null,
  }) {
    return _then(_$AppSettingsImpl(
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
      accentColor: null == accentColor
          ? _value.accentColor
          : accentColor // ignore: cast_nullable_to_non_nullable
              as Color,
      libraryViewMode: null == libraryViewMode
          ? _value.libraryViewMode
          : libraryViewMode // ignore: cast_nullable_to_non_nullable
              as LibraryViewMode,
      soundEnabled: null == soundEnabled
          ? _value.soundEnabled
          : soundEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      hapticFeedback: null == hapticFeedback
          ? _value.hapticFeedback
          : hapticFeedback // ignore: cast_nullable_to_non_nullable
              as bool,
      soundPack: null == soundPack
          ? _value.soundPack
          : soundPack // ignore: cast_nullable_to_non_nullable
              as SoundPack,
      warningSeconds: null == warningSeconds
          ? _value.warningSeconds
          : warningSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      defaultPlayers: null == defaultPlayers
          ? _value.defaultPlayers
          : defaultPlayers // ignore: cast_nullable_to_non_nullable
              as int,
      defaultTimeSeconds: null == defaultTimeSeconds
          ? _value.defaultTimeSeconds
          : defaultTimeSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      quickStartPresetIds: null == quickStartPresetIds
          ? _value._quickStartPresetIds
          : quickStartPresetIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      sectionExpansionState: null == sectionExpansionState
          ? _value._sectionExpansionState
          : sectionExpansionState // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppSettingsImpl implements _AppSettings {
  const _$AppSettingsImpl(
      {@ThemeModeConverter() this.themeMode = ThemeMode.system,
      @SettingsColorConverter() this.accentColor = const Color(0xFF6366F1),
      this.libraryViewMode = LibraryViewMode.grid,
      this.soundEnabled = true,
      this.hapticFeedback = true,
      this.soundPack = SoundPack.classic,
      this.warningSeconds = 10,
      this.defaultPlayers = 2,
      this.defaultTimeSeconds = 300,
      final List<String> quickStartPresetIds = const [],
      final Map<String, bool> sectionExpansionState = const {}})
      : _quickStartPresetIds = quickStartPresetIds,
        _sectionExpansionState = sectionExpansionState;

  factory _$AppSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppSettingsImplFromJson(json);

// Appearance
  @override
  @JsonKey()
  @ThemeModeConverter()
  final ThemeMode themeMode;
  @override
  @JsonKey()
  @SettingsColorConverter()
  final Color accentColor;
  @override
  @JsonKey()
  final LibraryViewMode libraryViewMode;
// Sound & Feedback
  @override
  @JsonKey()
  final bool soundEnabled;
  @override
  @JsonKey()
  final bool hapticFeedback;
  @override
  @JsonKey()
  final SoundPack soundPack;
  @override
  @JsonKey()
  final int warningSeconds;
// Seconds before timeout to warn
// Timer Defaults
  @override
  @JsonKey()
  final int defaultPlayers;
  @override
  @JsonKey()
  final int defaultTimeSeconds;
// 5 minutes
// Quick Start preset IDs (customizable)
  final List<String> _quickStartPresetIds;
// 5 minutes
// Quick Start preset IDs (customizable)
  @override
  @JsonKey()
  List<String> get quickStartPresetIds {
    if (_quickStartPresetIds is EqualUnmodifiableListView)
      return _quickStartPresetIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_quickStartPresetIds);
  }

// Section expansion state (sectionId -> isExpanded)
  final Map<String, bool> _sectionExpansionState;
// Section expansion state (sectionId -> isExpanded)
  @override
  @JsonKey()
  Map<String, bool> get sectionExpansionState {
    if (_sectionExpansionState is EqualUnmodifiableMapView)
      return _sectionExpansionState;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_sectionExpansionState);
  }

  @override
  String toString() {
    return 'AppSettings(themeMode: $themeMode, accentColor: $accentColor, libraryViewMode: $libraryViewMode, soundEnabled: $soundEnabled, hapticFeedback: $hapticFeedback, soundPack: $soundPack, warningSeconds: $warningSeconds, defaultPlayers: $defaultPlayers, defaultTimeSeconds: $defaultTimeSeconds, quickStartPresetIds: $quickStartPresetIds, sectionExpansionState: $sectionExpansionState)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppSettingsImpl &&
            (identical(other.themeMode, themeMode) ||
                other.themeMode == themeMode) &&
            (identical(other.accentColor, accentColor) ||
                other.accentColor == accentColor) &&
            (identical(other.libraryViewMode, libraryViewMode) ||
                other.libraryViewMode == libraryViewMode) &&
            (identical(other.soundEnabled, soundEnabled) ||
                other.soundEnabled == soundEnabled) &&
            (identical(other.hapticFeedback, hapticFeedback) ||
                other.hapticFeedback == hapticFeedback) &&
            (identical(other.soundPack, soundPack) ||
                other.soundPack == soundPack) &&
            (identical(other.warningSeconds, warningSeconds) ||
                other.warningSeconds == warningSeconds) &&
            (identical(other.defaultPlayers, defaultPlayers) ||
                other.defaultPlayers == defaultPlayers) &&
            (identical(other.defaultTimeSeconds, defaultTimeSeconds) ||
                other.defaultTimeSeconds == defaultTimeSeconds) &&
            const DeepCollectionEquality()
                .equals(other._quickStartPresetIds, _quickStartPresetIds) &&
            const DeepCollectionEquality()
                .equals(other._sectionExpansionState, _sectionExpansionState));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      themeMode,
      accentColor,
      libraryViewMode,
      soundEnabled,
      hapticFeedback,
      soundPack,
      warningSeconds,
      defaultPlayers,
      defaultTimeSeconds,
      const DeepCollectionEquality().hash(_quickStartPresetIds),
      const DeepCollectionEquality().hash(_sectionExpansionState));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppSettingsImplCopyWith<_$AppSettingsImpl> get copyWith =>
      __$$AppSettingsImplCopyWithImpl<_$AppSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppSettingsImplToJson(
      this,
    );
  }
}

abstract class _AppSettings implements AppSettings {
  const factory _AppSettings(
      {@ThemeModeConverter() final ThemeMode themeMode,
      @SettingsColorConverter() final Color accentColor,
      final LibraryViewMode libraryViewMode,
      final bool soundEnabled,
      final bool hapticFeedback,
      final SoundPack soundPack,
      final int warningSeconds,
      final int defaultPlayers,
      final int defaultTimeSeconds,
      final List<String> quickStartPresetIds,
      final Map<String, bool> sectionExpansionState}) = _$AppSettingsImpl;

  factory _AppSettings.fromJson(Map<String, dynamic> json) =
      _$AppSettingsImpl.fromJson;

  @override // Appearance
  @ThemeModeConverter()
  ThemeMode get themeMode;
  @override
  @SettingsColorConverter()
  Color get accentColor;
  @override
  LibraryViewMode get libraryViewMode;
  @override // Sound & Feedback
  bool get soundEnabled;
  @override
  bool get hapticFeedback;
  @override
  SoundPack get soundPack;
  @override
  int get warningSeconds;
  @override // Seconds before timeout to warn
// Timer Defaults
  int get defaultPlayers;
  @override
  int get defaultTimeSeconds;
  @override // 5 minutes
// Quick Start preset IDs (customizable)
  List<String> get quickStartPresetIds;
  @override // Section expansion state (sectionId -> isExpanded)
  Map<String, bool> get sectionExpansionState;
  @override
  @JsonKey(ignore: true)
  _$$AppSettingsImplCopyWith<_$AppSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
