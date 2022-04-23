import 'package:licenta/services/authentication_service.dart';
import 'package:licenta/services/session_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '/models/workout_model.dart';
import '/services/workouts_service.dart';
import '/router/app.router.dart';
import '/locator.dart';

class WorkoutsViewmodel extends BaseViewModel {
  final WorkoutsService _workoutsService = locator<WorkoutsService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final SessionService _sessionService = locator<SessionService>();

  List<WorkoutModel> get getWorkouts =>
      _workoutsService.getWorkouts.values.toList();

  Future<void> deleteWorkout(String workoutId) async {
    setBusy(true);

    bool response = await _sessionService.deleteAllSessions(workoutId);
    if (!response) {
      //TODO: Pop-up
      return;
    }
    response = await _workoutsService.deleteWorkout(workoutId);
    if (!response) {
      //TODO: Pop-up
      return;
    }

    setBusy(false);
  }

  void navigateToWorkoutView(String workoutId) {
    _navigationService.navigateTo(
      Routes.singleWorkoutView,
      arguments: SingleWorkoutViewArguments(workoutId: workoutId),
    );
  }

  void navigateToCreateWorkout() {
    _navigationService.navigateTo(Routes.createWorkoutView);
  }
}
