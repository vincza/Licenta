import 'package:licenta/models/exercise_model.dart';
import 'package:licenta/models/shared_workout_model.dart';
import 'package:licenta/models/workout_model.dart';
import 'package:licenta/services/authentication_service.dart';
import 'package:licenta/services/firebase_service.dart';
import 'package:licenta/services/shared_workouts_service.dart';
import 'package:licenta/services/workouts_service.dart';
import 'package:stacked/stacked.dart';

import '../../locator.dart';

class SharedWorkoutViewmodel extends BaseViewModel {
  final String workoutId;
  final SharedWorkoutsService _sharedWorkoutsService =
      locator<SharedWorkoutsService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final WorkoutsService _workoutsService = locator<WorkoutsService>();
  final FirebaseService _firebaseService = locator<FirebaseService>();

  SharedWorkoutViewmodel({required this.workoutId});
  late SharedWorkoutModel _sharedWorkout;

  SharedWorkoutModel get getSharedWorkout => _sharedWorkout;

  void initializeWorkout() {
    _sharedWorkout = _sharedWorkoutsService.getSharedWorkouts
        .where((element) => element.workoutId == workoutId)
        .first;
  }

  Future<void> addWorkoutToOwnCollection() async {
    setBusy(true);
    List<ExerciseModel> exercises = [];
    for (ExerciseModel exercise in _sharedWorkout.exercises) {
      exercises.add(exercise);
    }
    WorkoutModel workout = WorkoutModel(
      workoutId: workoutId,
      workoutName: _sharedWorkout.workoutName,
      userId: _sharedWorkout.userId,
      workoutDescription: _sharedWorkout.workoutDescription,
      exercises: exercises,
    );
    bool result = await _firebaseService.manipulateWorkout(
      workoutId,
      _authenticationService.getCurrentUser!.uid,
      workout,
    );
    if (result) {
      _workoutsService.manipulateWorkout(workout);
    }
    setBusy(false);
  }

  bool isWorkoutOwner() {
    return _authenticationService.getCurrentUser!.uid == _sharedWorkout.userId;
  }

  bool isAlreadyAdded() {
    return _workoutsService.getWorkouts.containsKey(workoutId);
  }
}
