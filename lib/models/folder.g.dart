// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'folder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FolderImpl _$$FolderImplFromJson(Map<String, dynamic> json) => _$FolderImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      iconEmoji: json['iconEmoji'] as String? ?? '📁',
      color: json['color'] == null
          ? const Color(0xFF6366F1)
          : const FolderColorConverter()
              .fromJson((json['color'] as num).toInt()),
      sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
      isExpanded: json['isExpanded'] as bool? ?? true,
      createdAt: (json['createdAt'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$FolderImplToJson(_$FolderImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'iconEmoji': instance.iconEmoji,
      'color': const FolderColorConverter().toJson(instance.color),
      'sortOrder': instance.sortOrder,
      'isExpanded': instance.isExpanded,
      'createdAt': instance.createdAt,
    };
