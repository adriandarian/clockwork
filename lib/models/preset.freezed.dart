// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'preset.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Preset _$PresetFromJson(Map<String, dynamic> json) {
  return _Preset.fromJson(json);
}

/// @nodoc
mixin _$Preset {
  /// Unique identifier
  String get id => throw _privateConstructorUsedError;

  /// Display name
  String get name => throw _privateConstructorUsedError;

  /// Optional description
  String? get description => throw _privateConstructorUsedError;

  /// Category for organization
  PresetCategory get category => throw _privateConstructorUsedError;

  /// Number of players (2-6)
  int get playerCount => throw _privateConstructorUsedError;

  /// Type of timer
  TimerType get timerType => throw _privateConstructorUsedError;

  /// Main time per player
  Duration get mainTime => throw _privateConstructorUsedError;

  /// Move time for reset-per-move formats
  Duration? get moveTime => throw _privateConstructorUsedError;

  /// Increment added after each move
  Duration? get increment => throw _privateConstructorUsedError;

  /// Delay before time starts ticking
  Duration? get delay => throw _privateConstructorUsedError;

  /// Timeout behavior
  TimeoutBehavior get timeoutBehavior => throw _privateConstructorUsedError;

  /// Turn order
  TurnOrder get turnOrder => throw _privateConstructorUsedError;

  /// Whether this is a built-in preset
  bool get isBuiltIn => throw _privateConstructorUsedError;

  /// Whether this is a favorite
  bool get isFavorite => throw _privateConstructorUsedError;

  /// Tags for search
  List<String> get tags => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PresetCopyWith<Preset> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PresetCopyWith<$Res> {
  factory $PresetCopyWith(Preset value, $Res Function(Preset) then) =
      _$PresetCopyWithImpl<$Res, Preset>;
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      PresetCategory category,
      int playerCount,
      TimerType timerType,
      Duration mainTime,
      Duration? moveTime,
      Duration? increment,
      Duration? delay,
      TimeoutBehavior timeoutBehavior,
      TurnOrder turnOrder,
      bool isBuiltIn,
      bool isFavorite,
      List<String> tags});
}

/// @nodoc
class _$PresetCopyWithImpl<$Res, $Val extends Preset>
    implements $PresetCopyWith<$Res> {
  _$PresetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? category = null,
    Object? playerCount = null,
    Object? timerType = null,
    Object? mainTime = null,
    Object? moveTime = freezed,
    Object? increment = freezed,
    Object? delay = freezed,
    Object? timeoutBehavior = null,
    Object? turnOrder = null,
    Object? isBuiltIn = null,
    Object? isFavorite = null,
    Object? tags = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as PresetCategory,
      playerCount: null == playerCount
          ? _value.playerCount
          : playerCount // ignore: cast_nullable_to_non_nullable
              as int,
      timerType: null == timerType
          ? _value.timerType
          : timerType // ignore: cast_nullable_to_non_nullable
              as TimerType,
      mainTime: null == mainTime
          ? _value.mainTime
          : mainTime // ignore: cast_nullable_to_non_nullable
              as Duration,
      moveTime: freezed == moveTime
          ? _value.moveTime
          : moveTime // ignore: cast_nullable_to_non_nullable
              as Duration?,
      increment: freezed == increment
          ? _value.increment
          : increment // ignore: cast_nullable_to_non_nullable
              as Duration?,
      delay: freezed == delay
          ? _value.delay
          : delay // ignore: cast_nullable_to_non_nullable
              as Duration?,
      timeoutBehavior: null == timeoutBehavior
          ? _value.timeoutBehavior
          : timeoutBehavior // ignore: cast_nullable_to_non_nullable
              as TimeoutBehavior,
      turnOrder: null == turnOrder
          ? _value.turnOrder
          : turnOrder // ignore: cast_nullable_to_non_nullable
              as TurnOrder,
      isBuiltIn: null == isBuiltIn
          ? _value.isBuiltIn
          : isBuiltIn // ignore: cast_nullable_to_non_nullable
              as bool,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PresetImplCopyWith<$Res> implements $PresetCopyWith<$Res> {
  factory _$$PresetImplCopyWith(
          _$PresetImpl value, $Res Function(_$PresetImpl) then) =
      __$$PresetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? description,
      PresetCategory category,
      int playerCount,
      TimerType timerType,
      Duration mainTime,
      Duration? moveTime,
      Duration? increment,
      Duration? delay,
      TimeoutBehavior timeoutBehavior,
      TurnOrder turnOrder,
      bool isBuiltIn,
      bool isFavorite,
      List<String> tags});
}

/// @nodoc
class __$$PresetImplCopyWithImpl<$Res>
    extends _$PresetCopyWithImpl<$Res, _$PresetImpl>
    implements _$$PresetImplCopyWith<$Res> {
  __$$PresetImplCopyWithImpl(
      _$PresetImpl _value, $Res Function(_$PresetImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? category = null,
    Object? playerCount = null,
    Object? timerType = null,
    Object? mainTime = null,
    Object? moveTime = freezed,
    Object? increment = freezed,
    Object? delay = freezed,
    Object? timeoutBehavior = null,
    Object? turnOrder = null,
    Object? isBuiltIn = null,
    Object? isFavorite = null,
    Object? tags = null,
  }) {
    return _then(_$PresetImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as PresetCategory,
      playerCount: null == playerCount
          ? _value.playerCount
          : playerCount // ignore: cast_nullable_to_non_nullable
              as int,
      timerType: null == timerType
          ? _value.timerType
          : timerType // ignore: cast_nullable_to_non_nullable
              as TimerType,
      mainTime: null == mainTime
          ? _value.mainTime
          : mainTime // ignore: cast_nullable_to_non_nullable
              as Duration,
      moveTime: freezed == moveTime
          ? _value.moveTime
          : moveTime // ignore: cast_nullable_to_non_nullable
              as Duration?,
      increment: freezed == increment
          ? _value.increment
          : increment // ignore: cast_nullable_to_non_nullable
              as Duration?,
      delay: freezed == delay
          ? _value.delay
          : delay // ignore: cast_nullable_to_non_nullable
              as Duration?,
      timeoutBehavior: null == timeoutBehavior
          ? _value.timeoutBehavior
          : timeoutBehavior // ignore: cast_nullable_to_non_nullable
              as TimeoutBehavior,
      turnOrder: null == turnOrder
          ? _value.turnOrder
          : turnOrder // ignore: cast_nullable_to_non_nullable
              as TurnOrder,
      isBuiltIn: null == isBuiltIn
          ? _value.isBuiltIn
          : isBuiltIn // ignore: cast_nullable_to_non_nullable
              as bool,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PresetImpl implements _Preset {
  const _$PresetImpl(
      {required this.id,
      required this.name,
      this.description,
      this.category = PresetCategory.custom,
      this.playerCount = 2,
      this.timerType = TimerType.countdown,
      required this.mainTime,
      this.moveTime,
      this.increment,
      this.delay,
      this.timeoutBehavior = TimeoutBehavior.lose,
      this.turnOrder = TurnOrder.alternating,
      this.isBuiltIn = false,
      this.isFavorite = false,
      final List<String> tags = const []})
      : _tags = tags;

  factory _$PresetImpl.fromJson(Map<String, dynamic> json) =>
      _$$PresetImplFromJson(json);

  /// Unique identifier
  @override
  final String id;

  /// Display name
  @override
  final String name;

  /// Optional description
  @override
  final String? description;

  /// Category for organization
  @override
  @JsonKey()
  final PresetCategory category;

  /// Number of players (2-6)
  @override
  @JsonKey()
  final int playerCount;

  /// Type of timer
  @override
  @JsonKey()
  final TimerType timerType;

  /// Main time per player
  @override
  final Duration mainTime;

  /// Move time for reset-per-move formats
  @override
  final Duration? moveTime;

  /// Increment added after each move
  @override
  final Duration? increment;

  /// Delay before time starts ticking
  @override
  final Duration? delay;

  /// Timeout behavior
  @override
  @JsonKey()
  final TimeoutBehavior timeoutBehavior;

  /// Turn order
  @override
  @JsonKey()
  final TurnOrder turnOrder;

  /// Whether this is a built-in preset
  @override
  @JsonKey()
  final bool isBuiltIn;

  /// Whether this is a favorite
  @override
  @JsonKey()
  final bool isFavorite;

  /// Tags for search
  final List<String> _tags;

  /// Tags for search
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  String toString() {
    return 'Preset(id: $id, name: $name, description: $description, category: $category, playerCount: $playerCount, timerType: $timerType, mainTime: $mainTime, moveTime: $moveTime, increment: $increment, delay: $delay, timeoutBehavior: $timeoutBehavior, turnOrder: $turnOrder, isBuiltIn: $isBuiltIn, isFavorite: $isFavorite, tags: $tags)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PresetImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.playerCount, playerCount) ||
                other.playerCount == playerCount) &&
            (identical(other.timerType, timerType) ||
                other.timerType == timerType) &&
            (identical(other.mainTime, mainTime) ||
                other.mainTime == mainTime) &&
            (identical(other.moveTime, moveTime) ||
                other.moveTime == moveTime) &&
            (identical(other.increment, increment) ||
                other.increment == increment) &&
            (identical(other.delay, delay) || other.delay == delay) &&
            (identical(other.timeoutBehavior, timeoutBehavior) ||
                other.timeoutBehavior == timeoutBehavior) &&
            (identical(other.turnOrder, turnOrder) ||
                other.turnOrder == turnOrder) &&
            (identical(other.isBuiltIn, isBuiltIn) ||
                other.isBuiltIn == isBuiltIn) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite) &&
            const DeepCollectionEquality().equals(other._tags, _tags));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      category,
      playerCount,
      timerType,
      mainTime,
      moveTime,
      increment,
      delay,
      timeoutBehavior,
      turnOrder,
      isBuiltIn,
      isFavorite,
      const DeepCollectionEquality().hash(_tags));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PresetImplCopyWith<_$PresetImpl> get copyWith =>
      __$$PresetImplCopyWithImpl<_$PresetImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PresetImplToJson(
      this,
    );
  }
}

abstract class _Preset implements Preset {
  const factory _Preset(
      {required final String id,
      required final String name,
      final String? description,
      final PresetCategory category,
      final int playerCount,
      final TimerType timerType,
      required final Duration mainTime,
      final Duration? moveTime,
      final Duration? increment,
      final Duration? delay,
      final TimeoutBehavior timeoutBehavior,
      final TurnOrder turnOrder,
      final bool isBuiltIn,
      final bool isFavorite,
      final List<String> tags}) = _$PresetImpl;

  factory _Preset.fromJson(Map<String, dynamic> json) = _$PresetImpl.fromJson;

  @override

  /// Unique identifier
  String get id;
  @override

  /// Display name
  String get name;
  @override

  /// Optional description
  String? get description;
  @override

  /// Category for organization
  PresetCategory get category;
  @override

  /// Number of players (2-6)
  int get playerCount;
  @override

  /// Type of timer
  TimerType get timerType;
  @override

  /// Main time per player
  Duration get mainTime;
  @override

  /// Move time for reset-per-move formats
  Duration? get moveTime;
  @override

  /// Increment added after each move
  Duration? get increment;
  @override

  /// Delay before time starts ticking
  Duration? get delay;
  @override

  /// Timeout behavior
  TimeoutBehavior get timeoutBehavior;
  @override

  /// Turn order
  TurnOrder get turnOrder;
  @override

  /// Whether this is a built-in preset
  bool get isBuiltIn;
  @override

  /// Whether this is a favorite
  bool get isFavorite;
  @override

  /// Tags for search
  List<String> get tags;
  @override
  @JsonKey(ignore: true)
  _$$PresetImplCopyWith<_$PresetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
