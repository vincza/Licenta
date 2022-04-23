// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SetModel _$SetModelFromJson(Map<String, dynamic> json) => SetModel(
      setId: json['setId'] as int,
      weight: json['weight'] as int,
      reps: json['reps'] as int,
    );

Map<String, dynamic> _$SetModelToJson(SetModel instance) => <String, dynamic>{
      'setId': instance.setId,
      'weight': instance.weight,
      'reps': instance.reps,
    };
