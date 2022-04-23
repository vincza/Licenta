import 'package:flutter/material.dart';
import 'package:licenta/models/exercise_session_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '/models/set_model.dart';
import '/services/session_service.dart';
import '/utility/validation_mixin.dart';

import '../../../locator.dart';

class AddSetsViewmodel extends BaseViewModel with Validation {
  final SessionService _sessionService = locator<SessionService>();
  final GlobalKey<FormState> _formSets = GlobalKey<FormState>();
  final NavigationService _navigationService = locator<NavigationService>();

  final int index;
  late List<SetModel> _sets;
  final String exerciseDescription;
  final String exerciseTitle;
  final String exerciseId;

  AddSetsViewmodel({
    required this.index,
    required this.exerciseTitle,
    required this.exerciseDescription,
    required this.exerciseId,
  });

  //Getters
  List<SetModel> get getSets => _sets;
  GlobalKey<FormState> get getFormKey => _formSets;

  void initializeSets() {
    _sets = [];
    if (_sessionService.getExercises.containsKey(index)) {
      for (SetModel set in _sessionService.getExercises[index]!.sets) {
        _sets.add(set);
      }
    }
    notifyListeners();
  }

  void generateInputsForSets(int length) {
    if (_sets.length < length) {
      for (int index = _sets.length; index < length; index++) {
        _sets.add(SetModel(setId: index, weight: 0, reps: 0));
      }
    } else if (_sets.length > length) {
      _sets.removeRange(length, _sets.length);
    }
    notifyListeners();
  }

  void fillInWeight(String? value, int index) {
    if (value == null || value.isEmpty) {
      return;
    }
    _sets[index].weight = int.parse(value);
  }

  void fillInReps(String? value, int index) {
    if (value == null || value.isEmpty) {
      return;
    }
    _sets[index].setReps = int.parse(value);
  }

  void addSets() {
    if (_formSets.currentState!.validate()) {
      ExerciseSessionModel exercise = ExerciseSessionModel(
        sets: _sets,
        exerciseDescription: exerciseDescription,
        exerciseName: exerciseTitle,
        exerciseId: exerciseId,
      );
      _sessionService.addExercise(exercise, index);
      _navigationService.popRepeated(1);
    }
  }
}
