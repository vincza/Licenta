// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionModel _$SessionModelFromJson(Map<String, dynamic> json) => SessionModel(
      sessionId: json['sessionId'] as String,
      date: json['date'] as String,
      duration: json['duration'] as String,
      workoutFeel: json['workoutFeel'] as String,
      exercises: (json['exercises'] as List<dynamic>)
          .map((e) => ExerciseSessionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$SessionModelToJson(SessionModel instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
      'date': instance.date,
      'duration': instance.duration,
      'workoutFeel': instance.workoutFeel,
      'notes': instance.notes,
      'exercises': instance.exercises.map((e) => e.toJson()).toList(),
    };
