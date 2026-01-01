// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'folder.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Folder _$FolderFromJson(Map<String, dynamic> json) {
  return _Folder.fromJson(json);
}

/// @nodoc
mixin _$Folder {
  /// Unique identifier
  String get id => throw _privateConstructorUsedError;

  /// Display name
  String get name => throw _privateConstructorUsedError;

  /// Emoji icon for the folder
  String get iconEmoji => throw _privateConstructorUsedError;

  /// Folder accent color
  @FolderColorConverter()
  Color get color => throw _privateConstructorUsedError;

  /// Sort order in the folder list
  int get sortOrder => throw _privateConstructorUsedError;

  /// Whether the folder is expanded in the UI
  bool get isExpanded => throw _privateConstructorUsedError;

  /// Creation timestamp (milliseconds since epoch)
  int? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FolderCopyWith<Folder> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FolderCopyWith<$Res> {
  factory $FolderCopyWith(Folder value, $Res Function(Folder) then) =
      _$FolderCopyWithImpl<$Res, Folder>;
  @useResult
  $Res call(
      {String id,
      String name,
      String iconEmoji,
      @FolderColorConverter() Color color,
      int sortOrder,
      bool isExpanded,
      int? createdAt});
}

/// @nodoc
class _$FolderCopyWithImpl<$Res, $Val extends Folder>
    implements $FolderCopyWith<$Res> {
  _$FolderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? iconEmoji = null,
    Object? color = null,
    Object? sortOrder = null,
    Object? isExpanded = null,
    Object? createdAt = freezed,
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
      iconEmoji: null == iconEmoji
          ? _value.iconEmoji
          : iconEmoji // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
      isExpanded: null == isExpanded
          ? _value.isExpanded
          : isExpanded // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FolderImplCopyWith<$Res> implements $FolderCopyWith<$Res> {
  factory _$$FolderImplCopyWith(
          _$FolderImpl value, $Res Function(_$FolderImpl) then) =
      __$$FolderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String iconEmoji,
      @FolderColorConverter() Color color,
      int sortOrder,
      bool isExpanded,
      int? createdAt});
}

/// @nodoc
class __$$FolderImplCopyWithImpl<$Res>
    extends _$FolderCopyWithImpl<$Res, _$FolderImpl>
    implements _$$FolderImplCopyWith<$Res> {
  __$$FolderImplCopyWithImpl(
      _$FolderImpl _value, $Res Function(_$FolderImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? iconEmoji = null,
    Object? color = null,
    Object? sortOrder = null,
    Object? isExpanded = null,
    Object? createdAt = freezed,
  }) {
    return _then(_$FolderImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      iconEmoji: null == iconEmoji
          ? _value.iconEmoji
          : iconEmoji // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
      isExpanded: null == isExpanded
          ? _value.isExpanded
          : isExpanded // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FolderImpl implements _Folder {
  const _$FolderImpl(
      {required this.id,
      required this.name,
      this.iconEmoji = '📁',
      @FolderColorConverter() this.color = const Color(0xFF6366F1),
      this.sortOrder = 0,
      this.isExpanded = true,
      this.createdAt});

  factory _$FolderImpl.fromJson(Map<String, dynamic> json) =>
      _$$FolderImplFromJson(json);

  /// Unique identifier
  @override
  final String id;

  /// Display name
  @override
  final String name;

  /// Emoji icon for the folder
  @override
  @JsonKey()
  final String iconEmoji;

  /// Folder accent color
  @override
  @JsonKey()
  @FolderColorConverter()
  final Color color;

  /// Sort order in the folder list
  @override
  @JsonKey()
  final int sortOrder;

  /// Whether the folder is expanded in the UI
  @override
  @JsonKey()
  final bool isExpanded;

  /// Creation timestamp (milliseconds since epoch)
  @override
  final int? createdAt;

  @override
  String toString() {
    return 'Folder(id: $id, name: $name, iconEmoji: $iconEmoji, color: $color, sortOrder: $sortOrder, isExpanded: $isExpanded, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FolderImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.iconEmoji, iconEmoji) ||
                other.iconEmoji == iconEmoji) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.isExpanded, isExpanded) ||
                other.isExpanded == isExpanded) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, iconEmoji, color,
      sortOrder, isExpanded, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FolderImplCopyWith<_$FolderImpl> get copyWith =>
      __$$FolderImplCopyWithImpl<_$FolderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FolderImplToJson(
      this,
    );
  }
}

abstract class _Folder implements Folder {
  const factory _Folder(
      {required final String id,
      required final String name,
      final String iconEmoji,
      @FolderColorConverter() final Color color,
      final int sortOrder,
      final bool isExpanded,
      final int? createdAt}) = _$FolderImpl;

  factory _Folder.fromJson(Map<String, dynamic> json) = _$FolderImpl.fromJson;

  @override

  /// Unique identifier
  String get id;
  @override

  /// Display name
  String get name;
  @override

  /// Emoji icon for the folder
  String get iconEmoji;
  @override

  /// Folder accent color
  @FolderColorConverter()
  Color get color;
  @override

  /// Sort order in the folder list
  int get sortOrder;
  @override

  /// Whether the folder is expanded in the UI
  bool get isExpanded;
  @override

  /// Creation timestamp (milliseconds since epoch)
  int? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$FolderImplCopyWith<_$FolderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
