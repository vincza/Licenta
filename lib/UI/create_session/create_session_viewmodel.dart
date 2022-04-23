import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:licenta/locator.dart';
import 'package:licenta/models/exercise_session_model.dart';
import 'package:licenta/models/session_model.dart';
import 'package:licenta/models/workout_model.dart';
import 'package:licenta/services/session_service.dart';
import 'package:licenta/services/workouts_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:uuid/uuid.dart';

import '../../router/app.router.dart';

class CreateSessionViewmodel extends BaseViewModel {
  late PageController _pageController;
  final NavigationService _navigationService = locator<NavigationService>();
  final WorkoutsService _workoutsService = locator<WorkoutsService>();
  final SessionService _sessionService = locator<SessionService>();
  final TextEditingController _notesController = TextEditingController();
  late final WorkoutModel _workout;
  bool _isSecondPage = false;
  Timer? _timer;
  int _seconds = 0;
  int _minutes = 0;
  int _hours = 0;
  String _sessionFeel = '';

  //Getters
  PageController get getPageController => _pageController;
  String get getSeconds => _seconds < 10 ? '0$_seconds' : _seconds.toString();
  String get getMinutes => _minutes < 10 ? '0$_minutes' : _minutes.toString();
  String get getHours => _hours < 10 ? '0$_hours' : _hours.toString();
  TextEditingController get getNotesController => _notesController;
  WorkoutModel get getWorkout => _workout;
  String get getSessionFell => _sessionFeel;
  bool get getIsSecondPage => _isSecondPage;

  //Setters
  set setSessionFell(String value) {
    _sessionFeel = value;
    notifyListeners();
  }

  void initializeTimer(String workoutId) {
    _pageController = PageController();
    _workout = _workoutsService.getWorkouts[workoutId]!;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _addTime());
  }

  void _addTime() {
    if (_seconds < 59) {
      _seconds++;
    } else {
      _seconds = 0;
      _minutes = _minutes + 1;
      if (_minutes >= 59) {
        _minutes = 0;
        _hours = _hours + 1;
      }
    }
    notifyListeners();
  }

  Future<void> navigateBack() async {
    if (_pageController.page! < 1) {
      _navigationService.popRepeated(1);
      _sessionService.discardExercises();
    } else {
      _isSecondPage = false;
      notifyListeners();
      await _pageController.previousPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.decelerate,
      );
    }
  }

  Future<void> navigateForward() async {
    if (_pageController.page! != 0) {
      _completeSession();
    }
    if (_workout.exercises.length == _sessionService.getExercises.length) {
      _isSecondPage = true;
      notifyListeners();
      await _pageController.nextPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.decelerate,
      );
      return;
    }

    //TODO:Add validation dialog
  }

  Future<void> _completeSession() async {
    if (_sessionFeel.isEmpty) {
      return;
    }
    _timer!.cancel();
    String hours = _hours < 10 ? '0$_hours' : _hours.toString();
    String minutes = _minutes < 10 ? '0$_minutes' : _minutes.toString();
    String seconds = _seconds < 10 ? '0$_seconds' : _seconds.toString();
    String duration = '$hours:$minutes:$seconds';
    String date = DateTime.now().toIso8601String();
    String sessionId = const Uuid().v1();
    List<ExerciseSessionModel> _exercisesData = [];
    for (ExerciseSessionModel exercise
        in _sessionService.getExercises.values.toList()) {
      _exercisesData.add(exercise);
    }
    SessionModel session = SessionModel(
      sessionId: sessionId,
      date: date,
      duration: duration,
      workoutFeel: _sessionFeel,
      exercises: _exercisesData,
      notes: _notesController.text.isEmpty ? null : _notesController.text,
    );
    setBusy(true);
    bool queryResult =
        await _sessionService.createSession(_workout.workoutId, session);
    if (!queryResult) {
      print('Something went wrong');
      return;
    }
    _sessionService.discardExercises();
    _sessionService.discardSessions();
    _navigationService.navigateTo(Routes.homeView,
        arguments: HomeViewArguments(index: 2));
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
