import 'package:json_annotation/json_annotation.dart';
part 'set_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SetModel {
  int setId;
  int weight;
  int reps;

  SetModel({
    required this.setId,
    required this.weight,
    required this.reps,
  });

  set setWeight(int value) => weight = value;
  set setReps(int value) => reps = value;

  factory SetModel.fromJson(Map<String, dynamic> json) =>
      _$SetModelFromJson(json);

  Map<String, dynamic> toJson() => _$SetModelToJson(this);
}
