import 'dart:io';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/cupertino.dart';

import '/models/workout_model.dart';
import '/models/exercise_model.dart';

import '/services/authentication_service.dart';
import '/services/firebase_service.dart';
import '/services/storage_service.dart';
import '/services/media_service.dart';
import '/services/workouts_service.dart';
import '/utility/validation_mixin.dart';

import '/router/app.router.dart';
import '/locator.dart';

class CreateWorkoutViewmodel extends BaseViewModel with Validation {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final MediaService _mediaService = locator<MediaService>();
  final WorkoutsService _workoutsService = locator<WorkoutsService>();
  final StorageService _storageService = locator<StorageService>();
  final FirebaseService _firebaseService = locator<FirebaseService>();
  late String _userId;

  final PageController _pageController = PageController();
  TextEditingController _workoutNameController = TextEditingController();
  TextEditingController _workoutDescriptionController = TextEditingController();
  final GlobalKey<FormState> _formBasicWorkoutInformation =
      GlobalKey<FormState>();

  //Getters
  PageController get getPageController => _pageController;
  TextEditingController get getWorkoutNameController => _workoutNameController;
  TextEditingController get getWorkoutDescriptionController =>
      _workoutDescriptionController;
  GlobalKey<FormState> get getFormKey => _formBasicWorkoutInformation;

  List<ExerciseModel?> get getExercises => _workoutsService.getExercises;

  void initializeWorkoutData(String? workoutId) {
    if (workoutId != null) {
      _workoutsService.editWorkout(workoutId);
      _userId = _workoutsService.getWorkouts[workoutId]!.userId;
      _workoutNameController = TextEditingController(
        text: _workoutsService.getWorkouts[workoutId]!.workoutName,
      );
      _workoutDescriptionController = TextEditingController(
        text: _workoutsService.getWorkouts[workoutId]!.workoutDescription,
      );
      return;
    }
    _userId = _authenticationService.getCurrentUser!.uid;
  }

  //Methods

  String getExerciseNumber(int index) {
    int exerciseNumber =
        int.parse(_workoutsService.getExercises[index]!.exerciseId) + 1;
    return exerciseNumber.toString();
  }

  Future<void> navigateToNextPage(BuildContext context) async {
    if (_formBasicWorkoutInformation.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      await Future.delayed(
        const Duration(milliseconds: 300),
      );

      await _pageController.nextPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.decelerate,
      );
    }
  }

  void removeExercise(int index) {
    _workoutsService.removeExercise(index);
    notifyListeners();
  }

  Future<void> submitWorkout(String? wid) async {
    setBusy(true);
    var workoutId = wid ?? const Uuid().v1();
    WorkoutModel workout = WorkoutModel(
      workoutId: workoutId,
      workoutName: _workoutNameController.text,
      userId: _userId,
      workoutDescription: _workoutDescriptionController.text,
      exercises: _workoutsService.getExercises
          .map(
            (e) => ExerciseModel(
              exerciseId: e!.exerciseId,
              exerciseName: e.exerciseName,
              exerciseDescription: e.exerciseDescription,
            ),
          )
          .toList(),
    );
    bool result = await _firebaseService.manipulateWorkout(
      workoutId,
      _authenticationService.getCurrentUser!.uid,
      workout,
    );
    if (result) {
      _workoutsService.manipulateWorkout(workout);
      _navigationService.navigateTo(
        Routes.homeView,
        arguments: HomeViewArguments(index: 2),
      );
      _workoutsService.discardExercises();
    }
  }

  Future<void> navigateToWorkoutsView() async {
    if (_pageController.page! < 1) {
      _navigationService.popRepeated(1);
      _workoutsService.discardExercises();
    } else {
      await _pageController.previousPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.decelerate,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _workoutDescriptionController.dispose();
    _workoutNameController.dispose();
    super.dispose();
  }
}
