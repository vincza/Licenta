import 'package:json_annotation/json_annotation.dart';
import '/models/exercise_model.dart';
import './set_model.dart';
part 'exercise_session_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ExerciseSessionModel extends ExerciseModel {
  List<SetModel> sets;
  ExerciseSessionModel({
    required this.sets,
    required String exerciseDescription,
    required String exerciseName,
    required String exerciseId,
  }) : super(
          exerciseDescription: exerciseDescription,
          exerciseId: exerciseId,
          exerciseName: exerciseName,
        );

  set setSets(List<SetModel> newSets) => sets = newSets;

  factory ExerciseSessionModel.fromJson(Map<String, dynamic> json) =>
      _$ExerciseSessionModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ExerciseSessionModelToJson(this);
}
