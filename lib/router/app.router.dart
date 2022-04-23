// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../UI/create_session/create_session_view.dart';
import '../UI/create_workout/create_workout_view.dart';
import '../UI/forgot_password/forgot_password_view.dart';
import '../UI/home/home_view.dart';
import '../UI/register/register_view.dart';
import '../UI/shared_workout/shared_workout_view.dart';
import '../UI/sign_in/sign_in.dart';
import '../UI/single_session/single_session_view.dart';
import '../UI/single_workout/single_workout_view.dart';
import '../UI/start_up/start_up_view.dart';

class Routes {
  static const String startUpView = '/';
  static const String signInView = '/sign-in-view';
  static const String homeView = '/home-view';
  static const String forgotPasswordView = '/forgot-password-view';
  static const String registerView = '/register-view';
  static const String createWorkoutView = '/create-workout-view';
  static const String singleWorkoutView = '/single-workout-view';
  static const String createSessionView = '/create-session-view';
  static const String singleSessionView = '/single-session-view';
  static const String sharedWorkoutView = '/shared-workout-view';
  static const all = <String>{
    startUpView,
    signInView,
    homeView,
    forgotPasswordView,
    registerView,
    createWorkoutView,
    singleWorkoutView,
    createSessionView,
    singleSessionView,
    sharedWorkoutView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.startUpView, page: StartUpView),
    RouteDef(Routes.signInView, page: SignInView),
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.forgotPasswordView, page: ForgotPasswordView),
    RouteDef(Routes.registerView, page: RegisterView),
    RouteDef(Routes.createWorkoutView, page: CreateWorkoutView),
    RouteDef(Routes.singleWorkoutView, page: SingleWorkoutView),
    RouteDef(Routes.createSessionView, page: CreateSessionView),
    RouteDef(Routes.singleSessionView, page: SingleSessionView),
    RouteDef(Routes.sharedWorkoutView, page: SharedWorkoutView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    StartUpView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const StartUpView(),
        settings: data,
      );
    },
    SignInView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const SignInView(),
        settings: data,
      );
    },
    HomeView: (data) {
      var args = data.getArgs<HomeViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeView(
          key: args.key,
          index: args.index,
        ),
        settings: data,
      );
    },
    ForgotPasswordView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const ForgotPasswordView(),
        settings: data,
      );
    },
    RegisterView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const RegisterView(),
        settings: data,
      );
    },
    CreateWorkoutView: (data) {
      var args = data.getArgs<CreateWorkoutViewArguments>(
        orElse: () => CreateWorkoutViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => CreateWorkoutView(
          key: args.key,
          workoutId: args.workoutId,
        ),
        settings: data,
      );
    },
    SingleWorkoutView: (data) {
      var args = data.getArgs<SingleWorkoutViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => SingleWorkoutView(
          key: args.key,
          workoutId: args.workoutId,
        ),
        settings: data,
      );
    },
    CreateSessionView: (data) {
      var args = data.getArgs<CreateSessionViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => CreateSessionView(
          key: args.key,
          workoutId: args.workoutId,
        ),
        settings: data,
      );
    },
    SingleSessionView: (data) {
      var args = data.getArgs<SingleSessionViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => SingleSessionView(
          key: args.key,
          sessionId: args.sessionId,
          index: args.index,
        ),
        settings: data,
      );
    },
    SharedWorkoutView: (data) {
      var args = data.getArgs<SharedWorkoutViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => SharedWorkoutView(
          key: args.key,
          workoutId: args.workoutId,
        ),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// HomeView arguments holder class
class HomeViewArguments {
  final Key? key;
  final int index;
  HomeViewArguments({this.key, required this.index});
}

/// CreateWorkoutView arguments holder class
class CreateWorkoutViewArguments {
  final Key? key;
  final String? workoutId;
  CreateWorkoutViewArguments({this.key, this.workoutId});
}

/// SingleWorkoutView arguments holder class
class SingleWorkoutViewArguments {
  final Key? key;
  final String workoutId;
  SingleWorkoutViewArguments({this.key, required this.workoutId});
}

/// CreateSessionView arguments holder class
class CreateSessionViewArguments {
  final Key? key;
  final String workoutId;
  CreateSessionViewArguments({this.key, required this.workoutId});
}

/// SingleSessionView arguments holder class
class SingleSessionViewArguments {
  final Key? key;
  final String sessionId;
  final int index;
  SingleSessionViewArguments(
      {this.key, required this.sessionId, required this.index});
}

/// SharedWorkoutView arguments holder class
class SharedWorkoutViewArguments {
  final Key? key;
  final String workoutId;
  SharedWorkoutViewArguments({this.key, required this.workoutId});
}
