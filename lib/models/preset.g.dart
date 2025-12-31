// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preset.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PresetImpl _$$PresetImplFromJson(Map<String, dynamic> json) => _$PresetImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      category:
          $enumDecodeNullable(_$PresetCategoryEnumMap, json['category']) ??
              PresetCategory.custom,
      playerCount: (json['playerCount'] as num?)?.toInt() ?? 2,
      timerType: $enumDecodeNullable(_$TimerTypeEnumMap, json['timerType']) ??
          TimerType.countdown,
      mainTime: Duration(microseconds: (json['mainTime'] as num).toInt()),
      moveTime: json['moveTime'] == null
          ? null
          : Duration(microseconds: (json['moveTime'] as num).toInt()),
      increment: json['increment'] == null
          ? null
          : Duration(microseconds: (json['increment'] as num).toInt()),
      delay: json['delay'] == null
          ? null
          : Duration(microseconds: (json['delay'] as num).toInt()),
      timeoutBehavior: $enumDecodeNullable(
              _$TimeoutBehaviorEnumMap, json['timeoutBehavior']) ??
          TimeoutBehavior.lose,
      turnOrder: $enumDecodeNullable(_$TurnOrderEnumMap, json['turnOrder']) ??
          TurnOrder.alternating,
      isBuiltIn: json['isBuiltIn'] as bool? ?? false,
      isFavorite: json['isFavorite'] as bool? ?? false,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
    );

Map<String, dynamic> _$$PresetImplToJson(_$PresetImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'category': _$PresetCategoryEnumMap[instance.category]!,
      'playerCount': instance.playerCount,
      'timerType': _$TimerTypeEnumMap[instance.timerType]!,
      'mainTime': instance.mainTime.inMicroseconds,
      'moveTime': instance.moveTime?.inMicroseconds,
      'increment': instance.increment?.inMicroseconds,
      'delay': instance.delay?.inMicroseconds,
      'timeoutBehavior': _$TimeoutBehaviorEnumMap[instance.timeoutBehavior]!,
      'turnOrder': _$TurnOrderEnumMap[instance.turnOrder]!,
      'isBuiltIn': instance.isBuiltIn,
      'isFavorite': instance.isFavorite,
      'tags': instance.tags,
    };

const _$PresetCategoryEnumMap = {
  PresetCategory.chess: 'chess',
  PresetCategory.board: 'board',
  PresetCategory.party: 'party',
  PresetCategory.sports: 'sports',
  PresetCategory.custom: 'custom',
};

const _$TimerTypeEnumMap = {
  TimerType.countdown: 'countdown',
  TimerType.resetPerMove: 'resetPerMove',
  TimerType.delay: 'delay',
  TimerType.byoyomi: 'byoyomi',
};

const _$TimeoutBehaviorEnumMap = {
  TimeoutBehavior.lose: 'lose',
  TimeoutBehavior.penalty: 'penalty',
  TimeoutBehavior.continuePlay: 'continuePlay',
};

const _$TurnOrderEnumMap = {
  TurnOrder.alternating: 'alternating',
  TurnOrder.sequential: 'sequential',
};
