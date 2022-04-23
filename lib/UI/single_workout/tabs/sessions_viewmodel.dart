import 'package:licenta/services/session_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../router/app.router.dart';
import '/models/session_model.dart';
import 'package:intl/intl.dart';

import '/locator.dart';

class SessionsViewmodel extends BaseViewModel {
  SessionsViewmodel({required this.workoutId});
  final String workoutId;
  final SessionService _sessionService = locator<SessionService>();
  final NavigationService _navigationService = locator<NavigationService>();

  List<SessionModel> get getSessions => _sessionService.getSessions;

  Future<void> initializeSessions() async {
    if (_sessionService.getSessions.isEmpty) {
      setBusy(true);
      await _sessionService.getSessionsFromDb(workoutId);
      setBusy(false);
    }
  }

  String getDate(int index) {
    return DateFormat('yyyy-MM-dd').format(
      DateTime.parse(_sessionService.getSessions[index].date),
    );
  }

  Future<void> deleteSession(String sessionId) async {
    setBusy(true);
    bool result = await _sessionService.deleteSession(workoutId, sessionId);
    setBusy(false);
    if (!result) {
      //TODO: Add error pop-up
    }
  }

  void navigateToSingleSessionView(String sessionId, int index) {
    _navigationService.navigateTo(
      Routes.singleSessionView,
      arguments: SingleSessionViewArguments(sessionId: sessionId, index: index),
    );
  }
}
