// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExerciseSessionModel _$ExerciseSessionModelFromJson(
        Map<String, dynamic> json) =>
    ExerciseSessionModel(
      sets: (json['sets'] as List<dynamic>)
          .map((e) => SetModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      exerciseDescription: json['exerciseDescription'] as String,
      exerciseName: json['exerciseName'] as String,
      exerciseId: json['exerciseId'] as String,
    );

Map<String, dynamic> _$ExerciseSessionModelToJson(
        ExerciseSessionModel instance) =>
    <String, dynamic>{
      'exerciseId': instance.exerciseId,
      'exerciseName': instance.exerciseName,
      'exerciseDescription': instance.exerciseDescription,
      'sets': instance.sets.map((e) => e.toJson()).toList(),
    };
