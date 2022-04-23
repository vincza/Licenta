import 'package:licenta/models/exercise_model.dart';
import 'package:stacked/stacked.dart';
import '/services/workouts_service.dart';

import '/locator.dart';

class ExercisesDisplayViewmodel extends BaseViewModel {
  final WorkoutsService _workoutsService = locator<WorkoutsService>();
  List<ExerciseModel> getExercises(String workoutId) {
    return _workoutsService.getWorkouts[workoutId]!.exercises;
  }
}
