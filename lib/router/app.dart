import 'package:licenta/UI/shared_workout/shared_workout_view.dart';
import 'package:licenta/UI/single_session/single_session_view.dart';
import 'package:stacked/stacked_annotations.dart';
import '/UI/create_session/create_session_view.dart';
import '/UI/single_workout/single_workout_view.dart';
import '/UI/create_workout/create_workout_view.dart';
import '/UI/forgot_password/forgot_password_view.dart';
import '/UI/home/home_view.dart';
import '/UI/register/register_view.dart';
import '/UI/sign_in/sign_in.dart';
import '/UI/start_up/start_up_view.dart';

@StackedApp(routes: [
  MaterialRoute(page: StartUpView, initial: true),
  MaterialRoute(page: SignInView),
  MaterialRoute(page: HomeView),
  MaterialRoute(page: ForgotPasswordView),
  MaterialRoute(page: RegisterView),
  MaterialRoute(page: CreateWorkoutView),
  MaterialRoute(page: SingleWorkoutView),
  MaterialRoute(page: CreateSessionView),
  MaterialRoute(page: SingleSessionView),
  MaterialRoute(page: SharedWorkoutView),
])
class AppSetup {}
