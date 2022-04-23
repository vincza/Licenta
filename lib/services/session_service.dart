import 'package:licenta/locator.dart';
import 'package:licenta/models/exercise_session_model.dart';
import 'package:licenta/models/session_model.dart';
import 'package:licenta/services/authentication_service.dart';
import 'package:licenta/services/firebase_service.dart';

class SessionService {
  final FirebaseService _firebaseService = locator<FirebaseService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final Map<int, ExerciseSessionModel> _exercises = {};
  Map<String, SessionModel> _sessions = {};

  Map<int, ExerciseSessionModel> get getExercises => _exercises;
  List<SessionModel> get getSessions => _sessions.values.toList();

  void addExercise(ExerciseSessionModel exercise, int index) {
    _exercises.update(index, (value) => exercise, ifAbsent: () => exercise);
  }

  Future<bool> createSession(String workoutId, SessionModel session) async {
    return await _firebaseService.createSession(
      _authenticationService.getCurrentUser!.uid,
      workoutId,
      session,
    );
  }

  Future<bool> deleteSession(String workoutId, String sessionId) async {
    bool result = await _firebaseService.deleteSession(
      _authenticationService.getCurrentUser!.uid,
      workoutId,
      sessionId,
    );
    if (result) {
      _sessions.remove(sessionId);
      return true;
    }
    return false;
  }

  Future<void> getSessionsFromDb(String workoutId) async {
    _sessions = await _firebaseService.getSessions(
            _authenticationService.getCurrentUser!.uid, workoutId) ??
        {};
  }

  Future<bool> deleteAllSessions(String workoutId) async {
    return await _firebaseService.deleteAllSessions(
        _authenticationService.getCurrentUser!.uid, workoutId);
  }

  void discardExercises() {
    _exercises.clear();
  }

  void discardSessions() {
    _sessions.clear();
  }
}
