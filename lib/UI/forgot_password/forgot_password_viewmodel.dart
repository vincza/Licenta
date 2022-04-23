import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '/services/authentication_service.dart';
import '/utility/validation_mixin.dart';
import '/router/app.router.dart';
import '/locator.dart';

class ForgotPasswordViewmodel extends BaseViewModel with Validation {
  final TextEditingController _forgotPasswordController =
      TextEditingController();
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> get getFormKey => _formKey;

  TextEditingController get getForgotPasswordController =>
      _forgotPasswordController;

  void navigateToSignIn(BuildContext context) {
    FocusScope.of(context).unfocus();
    _navigationService.popRepeated(1);
  }

  Future<void> sendForgotPasswordEmail(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      setBusy(true);
      bool response = await _authenticationService
          .forgotPassword(_forgotPasswordController.text);
      setBusy(false);
      if (response) {
        _navigationService.navigateTo(Routes.signInView);
      }
    }
  }
}
