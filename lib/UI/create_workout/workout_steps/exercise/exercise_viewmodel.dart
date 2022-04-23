import 'package:flutter/cupertino.dart';
import 'package:licenta/models/exercise_model.dart';
import 'package:licenta/utility/validation_mixin.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '/services/workouts_service.dart';

import '/locator.dart';

class ExerciseViewmodel extends BaseViewModel with Validation {
  final WorkoutsService _workoutsService = locator<WorkoutsService>();
  final NavigationService _navigationService = locator<NavigationService>();

  TextEditingController _exerciseNameController = TextEditingController();
  TextEditingController _exerciseDescriptionController =
      TextEditingController();
  final GlobalKey<FormState> _formExercise = GlobalKey<FormState>();

  //Getters
  TextEditingController get getExerciseNameController =>
      _exerciseNameController;
  TextEditingController get getExerciseDescriptionController =>
      _exerciseDescriptionController;

  GlobalKey<FormState> get getExerciseFormKey => _formExercise;

  //Methods
  void initializeExercise(int index) {
    if (_workoutsService.getExercises.length > index) {
      _exerciseNameController = TextEditingController(
        text: _workoutsService.getExercises[index]!.exerciseName,
      );

      _exerciseDescriptionController = TextEditingController(
        text: _workoutsService.getExercises[index]!.exerciseDescription,
      );
    }
  }

  void addExercise(int index) {
    if (_formExercise.currentState!.validate()) {
      ExerciseModel exercise = ExerciseModel(
        exerciseId: index.toString(),
        exerciseName: _exerciseNameController.text,
        exerciseDescription: _exerciseDescriptionController.text,
      );
      _workoutsService.manipulateExercise(index, exercise);
      _navigationService.popRepeated(1);
    }
  }
}
