import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked/stacked.dart';

import '/models/session_model.dart';
import '/services/session_service.dart';

import '../../locator.dart';

class SingleSessionViewmodel extends BaseViewModel {
  String sessionId;
  SingleSessionViewmodel({required this.sessionId});
  final SessionService _sessionService = locator<SessionService>();
  final NavigationService _navigationService = locator<NavigationService>();
  late SessionModel _sessionModel;

  //Getters
  SessionModel get getSession => _sessionModel;

  String returnDate() {
    return DateFormat('yyyy-MM-dd').format(
      DateTime.parse(_sessionModel.date),
    );
  }

  Color? returnStatusColor() {
    switch (_sessionModel.workoutFeel) {
      case 'Good':
        return Colors.green;
      case 'Average':
        return Colors.yellow[700];
      case 'Bad':
        return Colors.red;
      default:
        return Colors.black;
    }
  }

  Color? returnStatusColorTitle() {
    switch (_sessionModel.workoutFeel) {
      case 'Good':
        return Colors.greenAccent;
      case 'Average':
        return Colors.yellowAccent;
      case 'Bad':
        return const Color.fromARGB(255, 210, 0, 0);
      default:
        return Colors.black;
    }
  }

  void navigateBack() {
    _navigationService.popRepeated(1);
  }

  void initializeSession() {
    _sessionModel = _sessionService.getSessions
        .where((element) => element.sessionId == sessionId)
        .first;
  }
}
