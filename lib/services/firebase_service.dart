import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:licenta/models/session_model.dart';
import 'package:licenta/models/shared_workout_model.dart';
import '/models/workout_model.dart';
import '/models/user_model.dart';

class FirebaseService {
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference _sharedWorkouts =
      FirebaseFirestore.instance.collection('sharedWorkouts');

  DocumentSnapshot? _lastDocument;

  set setLastDocument(value) => _lastDocument = value;

  Future<bool> createUser(UserModel user) async {
    try {
      await _usersCollection.doc(user.uid).set(user.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<UserModel?> getUserData(String uid) async {
    try {
      var user = await _usersCollection.doc(uid).get();
      Map<String, dynamic> _userData = user.data() as Map<String, dynamic>;
      return UserModel.fromJson(_userData);
    } catch (e) {
      return null;
    }
  }

  Future<bool> updateProfileImageUrl(String uid, String downloadUrl) async {
    try {
      await _usersCollection.doc(uid).update(
        {'profileImageUrl': downloadUrl},
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateName(String uid, String name) async {
    try {
      await _usersCollection.doc(uid).update({
        'name': name,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> manipulateWorkout(
      String workoutId, String uid, WorkoutModel workout) async {
    try {
      await _usersCollection
          .doc(uid)
          .collection('workouts')
          .doc(workoutId)
          .set(workout.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Map<String, WorkoutModel>?> getWorkouts(String uid) async {
    try {
      var json = await _usersCollection.doc(uid).collection('workouts').get();
      Map<String, WorkoutModel> workouts = {};
      for (var element in json.docs) {
        workouts.putIfAbsent(
          element.data()['workoutId'],
          () => WorkoutModel.fromJson(
            element.data(),
          ),
        );
      }
      return workouts;
    } catch (e) {
      return null;
    }
  }

  Future<bool> deleteWorkout(String workoutId, String uid) async {
    try {
      await _usersCollection
          .doc(uid)
          .collection('workouts')
          .doc(workoutId)
          .delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> createSession(
    String uid,
    String workoutId,
    SessionModel session,
  ) async {
    try {
      await _usersCollection
          .doc(uid)
          .collection('workouts')
          .doc(workoutId)
          .collection('sessions')
          .doc(session.sessionId)
          .set(
            session.toJson(),
          );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateIsShared(
    String uid,
    String workoutId,
    bool isShared,
  ) async {
    try {
      await _usersCollection
          .doc(uid)
          .collection('workouts')
          .doc(workoutId)
          .update({'isShared': isShared});
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Map<String, SessionModel>?> getSessions(
      String uid, String workoutId) async {
    try {
      var json = await _usersCollection
          .doc(uid)
          .collection('workouts')
          .doc(workoutId)
          .collection('sessions')
          .orderBy('date', descending: true)
          .get();
      Map<String, SessionModel> sessions = {};
      for (var element in json.docs) {
        sessions.putIfAbsent(
          element.data()['sessionId'],
          () => SessionModel.fromJson(
            element.data(),
          ),
        );
        print(element.data()['sessionId']);
      }
      return sessions;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> deleteAllSessions(String uid, String workoutId) async {
    try {
      await _usersCollection
          .doc(uid)
          .collection('workouts')
          .doc(workoutId)
          .collection('sessions')
          .get()
          .then((value) async {
        for (QueryDocumentSnapshot document in value.docs) {
          await document.reference.delete();
        }
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteSession(
      String uid, String workoutid, String sessionId) async {
    try {
      await _usersCollection
          .doc(uid)
          .collection('workouts')
          .doc(workoutid)
          .collection('sessions')
          .doc(sessionId)
          .delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> shareWorkout(SharedWorkoutModel workout) async {
    try {
      await _sharedWorkouts.doc(workout.workoutId).set(workout.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Map<String, SharedWorkoutModel>?> fetchSharedWorkouts() async {
    try {
      Map<String, SharedWorkoutModel> sharedWorkouts = {};
      var json = _lastDocument != null
          ? await _sharedWorkouts
              .limit(3)
              .startAfterDocument(_lastDocument!)
              .get()
          : await _sharedWorkouts.limit(3).get();
      if (json.size == 0) {
        return null;
      }
      for (var document in json.docs) {
        sharedWorkouts.putIfAbsent(
          document.id,
          () => SharedWorkoutModel.fromJson(
              document.data() as Map<String, dynamic>),
        );
        _lastDocument = json.docs.last;
      }
      return sharedWorkouts;
    } catch (e) {
      return null;
    }
  }

  Future<bool> deleteSharedWorkout(String workoutId) async {
    try {
      await _sharedWorkouts.doc(workoutId).delete();
      return true;
    } catch (e) {
      return false;
    }
  }
}
