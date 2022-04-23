import 'package:licenta/services/shared_workouts_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../locator.dart';
import '../../models/shared_workout_model.dart';
import '../../router/app.router.dart';

class SharedWorkoutsViewmodel extends BaseViewModel {
  final SharedWorkoutsService _sharedWorkoutsService =
      locator<SharedWorkoutsService>();
  final NavigationService _navigationService = locator<NavigationService>();
  bool _fetchingFirstTime = false;

  List<SharedWorkoutModel> get getSharedWorkouts =>
      _sharedWorkoutsService.getSharedWorkouts;

  bool get getFetchingForFirstTime => _fetchingFirstTime;

  Future<void> getWorkouts() async {
    if (_sharedWorkoutsService.getSharedWorkouts.isEmpty) {
      _fetchingFirstTime = true;
      notifyListeners();
      await _sharedWorkoutsService.getSharedWorkoutsFromDb();
      _fetchingFirstTime = false;
      notifyListeners();
      return;
    }
    setBusy(true);
    await Future.delayed(const Duration(seconds: 1));
    await _sharedWorkoutsService.getSharedWorkoutsFromDb();
    setBusy(false);
  }

  void navigateToSharedWorkoutView(String workoutId) {
    _navigationService.navigateTo(
      Routes.sharedWorkoutView,
      arguments: SharedWorkoutViewArguments(workoutId: workoutId),
    );
  }
}
