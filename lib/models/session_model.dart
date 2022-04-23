import 'package:json_annotation/json_annotation.dart';
import 'package:licenta/models/exercise_session_model.dart';
part 'session_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SessionModel {
  String sessionId;
  String date;
  String duration;
  String workoutFeel;
  String? notes;
  List<ExerciseSessionModel> exercises;

  SessionModel({
    required this.sessionId,
    required this.date,
    required this.duration,
    required this.workoutFeel,
    required this.exercises,
    this.notes,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) =>
      _$SessionModelFromJson(json);

  Map<String, dynamic> toJson() => _$SessionModelToJson(this);
}
