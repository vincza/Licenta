import 'package:json_annotation/json_annotation.dart';

import './workout_model.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String name;
  String email;
  String uid;
  String? profileImageUrl;
  String gender;
  UserModel({
    required this.email,
    required this.name,
    required this.uid,
    required this.profileImageUrl,
    required this.gender,
  });

  set setProfileImageUrl(String? value) => profileImageUrl;

  set setName(String? value) => name;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
