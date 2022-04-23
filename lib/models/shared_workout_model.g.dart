// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_workout_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SharedWorkoutModel _$SharedWorkoutModelFromJson(Map<String, dynamic> json) =>
    SharedWorkoutModel(
      username: json['username'] as String,
      profileImageUrl: json['profileImageUrl'] as String?,
      workoutId: json['workoutId'] as String,
      workoutName: json['workoutName'] as String,
      userId: json['userId'] as String,
      workoutDescription: json['workoutDescription'] as String,
      exercises: (json['exercises'] as List<dynamic>)
          .map((e) => ExerciseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      isShared: json['isShared'] as bool,
    );

Map<String, dynamic> _$SharedWorkoutModelToJson(SharedWorkoutModel instance) =>
    <String, dynamic>{
      'workoutId': instance.workoutId,
      'workoutName': instance.workoutName,
      'userId': instance.userId,
      'workoutDescription': instance.workoutDescription,
      'exercises': instance.exercises.map((e) => e.toJson()).toList(),
      'isShared': instance.isShared,
      'username': instance.username,
      'profileImageUrl': instance.profileImageUrl,
    };
