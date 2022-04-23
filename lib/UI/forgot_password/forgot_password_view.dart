import 'package:flutter/material.dart';
import 'package:licenta/UI/forgot_password/forgot_password_viewmodel.dart';
import 'package:licenta/widgets/buttons/main_button.dart';
import 'package:licenta/widgets/input_textfield.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/buttons/back_button.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _keyboard = MediaQuery.of(context).viewInsets.bottom;
    final Size _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: ViewModelBuilder<ForgotPasswordViewmodel>.reactive(
        viewModelBuilder: () => ForgotPasswordViewmodel(),
        builder: (context, model, child) => SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      right: 20,
                      left: 20,
                      bottom: 20,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: CustomBackButton(
                        onTap: () => model.navigateToSignIn(context),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: _screenSize.height * 0.05,
                  ),
                  Text(
                    'Forgot Password ?',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Please fill in your email below, so we cand send you a reset password request',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 30,
                    ),
                    child: Form(
                      key: model.getFormKey,
                      child: InputTextField(
                        controller: model.getForgotPasswordController,
                        obscureText: false,
                        additionalText: 'Email',
                        hint: 'Email',
                        initialValue: null,
                        validator: (String? value) =>
                            model.validateEmail(value),
                        onChanged: null,
                        formColor:
                            Theme.of(context).colorScheme.primaryContainer,
                        keyboardType: TextInputType.emailAddress,
                        textColor: Theme.of(context).colorScheme.background,
                        additionalTextColor:
                            Theme.of(context).colorScheme.background,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 37),
                    child: MainButton(
                      text: 'Send Request',
                      onTap: () => model.sendForgotPasswordEmail(context),
                      busy: model.isBusy,
                      color: Theme.of(context).colorScheme.secondary,
                      textColor: Theme.of(context).colorScheme.primary,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
