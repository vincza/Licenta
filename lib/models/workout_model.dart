import 'package:json_annotation/json_annotation.dart';

import './exercise_model.dart';
part 'workout_model.g.dart';

@JsonSerializable(explicitToJson: true)
class WorkoutModel {
  String workoutId;
  String workoutName;
  String userId;
  String workoutDescription;
  List<ExerciseModel> exercises;
  bool isShared = false;

  WorkoutModel({
    required this.workoutId,
    required this.workoutName,
    required this.userId,
    required this.workoutDescription,
    required this.exercises,
  });

  set setIsShared(value) => isShared = value;

  factory WorkoutModel.fromJson(Map<String, dynamic> json) =>
      _$WorkoutModelFromJson(json);

  Map<String, dynamic> toJson() => _$WorkoutModelToJson(this);
}
