import 'package:json_annotation/json_annotation.dart';
import 'package:licenta/models/exercise_model.dart';
import 'package:licenta/models/workout_model.dart';
part 'shared_workout_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SharedWorkoutModel extends WorkoutModel {
  String username;
  String? profileImageUrl;

  SharedWorkoutModel({
    required this.username,
    required this.profileImageUrl,
    required String workoutId,
    required String workoutName,
    required String userId,
    required String workoutDescription,
    required List<ExerciseModel> exercises,
    required bool isShared,
  }) : super(
          exercises: exercises,
          userId: userId,
          workoutId: workoutId,
          workoutDescription: workoutDescription,
          workoutName: workoutName,
        );

  @override
  factory SharedWorkoutModel.fromJson(Map<String, dynamic> json) =>
      _$SharedWorkoutModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SharedWorkoutModelToJson(this);
}
