mixin Validation {
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please fill in the email field';
    }
    bool emailIsValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    if (!emailIsValid) {
      return 'Please fill in a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please fill in the password field';
    }
    if (value.length <= 8) {
      return 'Please fill in a valid password';
    }
    return null;
  }

  String? validateConfirmPassword(String? value, String? equal) {
    if (value == null || value.isEmpty) {
      return 'Please fill in the confirm password field';
    }
    if (value.length <= 8) {
      return 'Please fill in a valid password';
    }
    if (value != equal) {
      return 'Please enter the same password';
    }
    return null;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please fill in a value';
    }
    return null;
  }

  String? validateSets(String? value) {
    if (value == null || value.isEmpty || value == '0') {
      return 'Please fill in a valid value';
    }

    final regex = RegExp(r'^[0-9]');
    if (!regex.hasMatch(value)) {
      return 'Please fill in a number';
    }
    return null;
  }
}
