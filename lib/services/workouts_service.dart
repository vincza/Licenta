import 'package:licenta/locator.dart';
import 'package:licenta/models/exercise_model.dart';
import 'package:licenta/models/workout_model.dart';
import 'package:licenta/services/authentication_service.dart';
import 'package:licenta/services/firebase_service.dart';
import 'package:licenta/services/storage_service.dart';

class WorkoutsService {
  Map<String, WorkoutModel> _workouts = {};
  Map<int, ExerciseModel?> _exercises = {};

  final FirebaseService _firebaseService = locator<FirebaseService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  Map<String, WorkoutModel> get getWorkouts => _workouts;
  List<ExerciseModel?> get getExercises => _exercises.values.toList();

  Future<void> getWorkoutsFromDataBase() async {
    if (_workouts.isEmpty) {
      Map<String, WorkoutModel>? response = await _firebaseService
          .getWorkouts(_authenticationService.getCurrentUser!.uid);
      if (response != null) {
        _workouts = response;
      }
    }
  }

  Future<bool> deleteWorkout(String workoutId) async {
    bool firebaseResponse = await _firebaseService.deleteWorkout(
      workoutId,
      _authenticationService.getCurrentUser!.uid,
    );
    if (firebaseResponse) {
      _workouts.remove(workoutId);
      return true;
    }
    return false;
  }

  void editWorkout(String key) {
    if (_workouts.containsKey(key)) {
      for (ExerciseModel exercise in _workouts[key]!.exercises) {
        _exercises.putIfAbsent(int.parse(exercise.exerciseId), () => exercise);
      }
    }
  }

  Future<bool> updateIsShared(String workoutId) async {
    bool result = await _firebaseService.updateIsShared(
      _authenticationService.getCurrentUser!.uid,
      workoutId,
      !_workouts[workoutId]!.isShared,
    );
    if (result) {
      _workouts[workoutId]!.setIsShared = !_workouts[workoutId]!.isShared;
      return true;
    }
    return false;
  }

  void manipulateWorkout(WorkoutModel workout) {
    _workouts.update(
      workout.workoutId,
      (value) => workout,
      ifAbsent: () => workout,
    );
  }

  void manipulateExercise(int index, ExerciseModel exercise) {
    _exercises.update(
      index,
      (value) => exercise,
      ifAbsent: () => exercise,
    );
  }

  void removeExercise(int index) {
    _exercises.remove(index);
    Map<int, ExerciseModel?> _newExercises = {};
    for (int index = 0; index < _exercises.length; index++) {
      _newExercises.putIfAbsent(
        index,
        () => ExerciseModel(
          exerciseId: index.toString(),
          exerciseName: _exercises.values.toList()[index]!.exerciseName,
          exerciseDescription:
              _exercises.values.toList()[index]!.exerciseDescription,
        ),
      );
    }
    _exercises.clear();
    _exercises = _newExercises;
  }

  void discardExercises() {
    _exercises.clear();
  }

  void clearWorkouts() {
    _workouts.clear();
  }
}
