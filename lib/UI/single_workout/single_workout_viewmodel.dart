import 'package:licenta/locator.dart';
import 'package:licenta/models/shared_workout_model.dart';
import 'package:licenta/models/workout_model.dart';
import 'package:licenta/services/authentication_service.dart';
import 'package:licenta/services/session_service.dart';
import 'package:licenta/services/shared_workouts_service.dart';
import 'package:licenta/services/workouts_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../router/app.router.dart';

class SingleWorkoutViewmodel extends BaseViewModel {
  final String workoutId;
  SingleWorkoutViewmodel({required this.workoutId});
  final WorkoutsService _workoutsService = locator<WorkoutsService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final SessionService _sessionService = locator<SessionService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final SharedWorkoutsService _sharedWorkoutsService =
      locator<SharedWorkoutsService>();

  WorkoutModel getWorkout() {
    return _workoutsService.getWorkouts[workoutId]!;
  }

  Future<void> shareWorkout() async {
    setBusy(true);
    SharedWorkoutModel workout = SharedWorkoutModel(
      username: _authenticationService.getCurrentUser!.name,
      profileImageUrl: _authenticationService.getCurrentUser!.profileImageUrl!,
      workoutId: _workoutsService.getWorkouts[workoutId]!.workoutId,
      workoutName: _workoutsService.getWorkouts[workoutId]!.workoutName,
      userId: _authenticationService.getCurrentUser!.uid,
      workoutDescription:
          _workoutsService.getWorkouts[workoutId]!.workoutDescription,
      exercises: _workoutsService.getWorkouts[workoutId]!.exercises,
      isShared: false,
    );
    bool result = await _sharedWorkoutsService.createSharedWorkout(workout);
    if (result) {
      bool updateResult = await _workoutsService.updateIsShared(workoutId);
      if (!updateResult) {
        //TODO:Add error pop-up
      }
    }
    setBusy(false);
  }

  Future<void> deleteSharedWorkout() async {
    setBusy(true);
    bool result = await _sharedWorkoutsService.deleteSharedWorkout(workoutId);
    if (result) {
      bool updateResult = await _workoutsService.updateIsShared(workoutId);
      if (!updateResult) {
        //TODO: Add error pop-up
      }
    }
    setBusy(false);
  }

  bool isWorkoutOwner() {
    return _authenticationService.getCurrentUser!.uid == getWorkout().userId;
  }

  void navigateBack() {
    _sessionService.discardSessions();
    _navigationService.popRepeated(1);
  }

  void navigateToWorkoutView(String workoutId) {
    _navigationService.navigateTo(
      Routes.createWorkoutView,
      arguments: CreateWorkoutViewArguments(workoutId: workoutId),
    );
  }

  void navigateToCreateSessionView(String workoutId) {
    _navigationService.navigateTo(
      Routes.createSessionView,
      arguments: CreateSessionViewArguments(workoutId: workoutId),
    );
  }
}
