import 'package:licenta/locator.dart';
import 'package:licenta/models/shared_workout_model.dart';
import 'package:licenta/services/firebase_service.dart';

class SharedWorkoutsService {
  final FirebaseService _firebaseService = locator<FirebaseService>();
  final Map<String, SharedWorkoutModel> _sharedWorkouts = {};

  List<SharedWorkoutModel> get getSharedWorkouts =>
      _sharedWorkouts.values.toList();

  Future<void> getSharedWorkoutsFromDb() async {
    var workouts = await _firebaseService.fetchSharedWorkouts();
    if (workouts != null) {
      _sharedWorkouts.addAll(workouts);
    }
  }

  Future<bool> createSharedWorkout(SharedWorkoutModel workout) async {
    bool result = await _firebaseService.shareWorkout(workout);
    if (result) {
      _sharedWorkouts.update(
        workout.workoutId,
        (_) => workout,
        ifAbsent: () => workout,
      );
      return true;
    }
    return false;
  }

  Future<bool> deleteSharedWorkout(String workoutId) async {
    bool result = await _firebaseService.deleteSharedWorkout(workoutId);
    if (result) {
      _sharedWorkouts.remove(workoutId);
      return true;
    }
    return false;
  }

  void discardSharedWorkouts() {
    _sharedWorkouts.clear();
  }
}
