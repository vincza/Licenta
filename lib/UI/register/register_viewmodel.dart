import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '/services/media_service.dart';
import '/services/authentication_service.dart';
import '/utility/validation_mixin.dart';
import '/router/app.router.dart';
import '/locator.dart';

class RegisterViewmodel extends BaseViewModel with Validation {
  final PageController _pageController = PageController(initialPage: 0);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _formBasicInformation = GlobalKey<FormState>();
  final GlobalKey<FormState> _formName = GlobalKey<FormState>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final MediaService _mediaService = locator<MediaService>();

  File? _profileImage;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  String _gender = 'Male';

  //Getters
  PageController get getPageController => _pageController;
  GlobalKey<FormState> get getFormBasicInformation => _formBasicInformation;
  GlobalKey<FormState> get getFormName => _formName;
  TextEditingController get getEmailController => _emailController;
  TextEditingController get getPasswordController => _passwordController;
  TextEditingController get getConfirmPasswordController =>
      _confirmPasswordController;
  TextEditingController get getNameController => _nameController;
  bool get getObscuredPassword => _obscurePassword;
  bool get getObscuredConfirmPassword => _obscureConfirmPassword;
  String get getGender => _gender;
  File? get getProfileImage => _profileImage;

  //Methods
  void setGender(String value) {
    _gender = value;
    notifyListeners();
  }

  void setObscurePassword() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void setObscureConfirmPassword() {
    _obscureConfirmPassword = !_obscureConfirmPassword;
    notifyListeners();
  }

  Future<void> navigateToSecondStep(BuildContext context) async {
    if (_formBasicInformation.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      await _pageController.nextPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.decelerate,
      );
    }
  }

  Future<void> navigateToThirdStep() async {
    await _pageController.nextPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.decelerate,
    );
  }

  Future<void> pickProfileImage() async {
    var image = await _mediaService.pickImage();
    if (image != null) {
      _profileImage = image;
    }
    notifyListeners();
  }

  Future<void> handleBackButton() async {
    if (_pageController.page != null &&
        _pageController.page! < 1 &&
        _pageController.page! >= 0) {
      _navigationService.popRepeated(1);
    } else {
      await _pageController.previousPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.decelerate,
      );
    }
  }

  Future<void> createUser(BuildContext context) async {
    if (_formName.currentState!.validate()) {
      setBusy(true);
      FocusScope.of(context).unfocus();
      bool result = await _authenticationService.createUser(
        _emailController.text,
        _passwordController.text,
        _profileImage,
        _nameController.text,
        _gender,
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

  @override
  void dispose() {
    _confirmPasswordController.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _pageController.dispose();
    super.dispose();
  }
}
