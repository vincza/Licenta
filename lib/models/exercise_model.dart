import 'package:json_annotation/json_annotation.dart';
part 'exercise_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ExerciseModel {
  String exerciseId;
  String exerciseName;
  String exerciseDescription;

  ExerciseModel({
    required this.exerciseId,
    required this.exerciseName,
    required this.exerciseDescription,
  });

  factory ExerciseModel.fromJson(Map<String, dynamic> json) =>
      _$ExerciseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseModelToJson(this);
}
