import 'package:licenta/models/exercise_session_model.dart';
import 'package:licenta/models/set_model.dart';
import 'package:licenta/services/session_service.dart';
import 'package:stacked/stacked.dart';

import '../../../locator.dart';

class SessionExerciseViewmodel extends BaseViewModel {
  final int index;
  SessionExerciseViewmodel({
    required this.index,
  });

  final SessionService _sessionService = locator<SessionService>();

  List<SetModel> returnSets(int index) {
    if (_sessionService.getExercises.containsKey(index)) {
      return _sessionService.getExercises[index]!.sets;
    }
    return [];
  }
}
