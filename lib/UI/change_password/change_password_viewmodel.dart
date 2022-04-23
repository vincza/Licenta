import 'package:flutter/cupertino.dart';
import 'package:licenta/locator.dart';
import 'package:licenta/services/authentication_service.dart';
import 'package:licenta/utility/validation_mixin.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ChangePasswordViewmodel extends BaseViewModel with Validation {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _newPasswordConfirmationController =
      TextEditingController();
  final GlobalKey<FormState> _formChangePassword = GlobalKey<FormState>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  bool _obscureTextOldPassword = true;
  bool _obscureTextNewPassword = true;
  bool _obscureTextNewPasswordConfirmation = true;

  //Getters
  TextEditingController get getOldPassword => _oldPasswordController;
  TextEditingController get getNewPassword => _newPasswordController;
  TextEditingController get getConfirmationNewPassword =>
      _newPasswordConfirmationController;
  bool get getObscureTextOldPassword => _obscureTextOldPassword;
  bool get getObscureTextNewPassword => _obscureTextNewPassword;
  bool get getObscureTextNewPasswordConfirmation =>
      _obscureTextNewPasswordConfirmation;
  GlobalKey<FormState> get getFormKey => _formChangePassword;

  //Setters
  set setObscureTextOldPassword(_) {
    _obscureTextOldPassword = !_obscureTextOldPassword;
    notifyListeners();
  }

  set setObscureTextNewPassword(_) {
    _obscureTextNewPassword = !_obscureTextNewPassword;
    notifyListeners();
  }

  set setObscureTextNewPasswordConfirmation(_) {
    _obscureTextNewPasswordConfirmation = !_obscureTextNewPasswordConfirmation;
    notifyListeners();
  }

  //Methods
  Future<void> changePassword() async {
    if (!_formChangePassword.currentState!.validate()) {
      return;
    }
    setBusy(true);
    bool result = await _authenticationService.changePassword(
      _oldPasswordController.text,
      _newPasswordController.text,
    );
    if (!result) {
      //TODO: Add Dialog Error
      setBusy(false);
      return;
    }
    setBusy(false);
    _navigationService.popRepeated(1);
  }
}
