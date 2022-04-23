import 'package:flutter/cupertino.dart';
import 'package:licenta/services/authentication_service.dart';
import 'package:licenta/utility/validation_mixin.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../router/app.router.dart';
import '/locator.dart';

class SignInViewmodel extends BaseViewModel with Validation {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formLogin = GlobalKey<FormState>();
  bool _obscureText = true;

  //Getters
  GlobalKey<FormState> get getFormKey => _formLogin;
  TextEditingController get getEmailController => _emailController;
  TextEditingController get getPasswordController => _passwordController;
  bool get getObscureTextForPassword => _obscureText;

  //Setters
  set setObscureText(_) {
    _obscureText = !_obscureText;
    notifyListeners();
  }

  //Methods
  Future<void> signIn() async {
    if (_formLogin.currentState!.validate()) {
      setBusy(true);
      bool result = await _authenticationService.signIn(
        _emailController.text,
        _passwordController.text,
      );
      setBusy(false);
      if (result) {
        _navigationService.navigateTo(
          Routes.homeView,
          arguments: HomeViewArguments(index: 0),
        );
      }
    }
  }

  void navigateToForgotPassword() {
    _navigationService.navigateTo(Routes.forgotPasswordView);
  }

  void navigateToRegister() {
    _navigationService.navigateTo(Routes.registerView);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
