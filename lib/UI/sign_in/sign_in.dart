import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '/widgets/custom_suffix_icon.dart';
import '/widgets/fade_animation.dart';
import '/widgets/input_textfield.dart';
import '/widgets/buttons/main_button.dart';

import '/UI/sign_in/sign_in_viewmodel.dart';

class SignInView extends StatelessWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _screenSize = MediaQuery.of(context).size;
    final double _keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: ViewModelBuilder<SignInViewmodel>.reactive(
          viewModelBuilder: () => SignInViewmodel(),
          disposeViewModel: true,
          builder: (context, model, child) => SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 80),
                transform: Matrix4.translationValues(
                    0,
                    _keyboardHeight != 0
                        ? _screenSize.height * 0.07
                        : _screenSize.height * 0.20,
                    0),
                child: Form(
                  key: model.getFormKey,
                  child: GestureDetector(
                    onTap: () => FocusScope.of(context).unfocus(),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Sign In',
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontSize: 60,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InputTextField(
                          controller: model.getEmailController,
                          obscureText: false,
                          additionalText: 'Email',
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
                          hint: 'Email',
                        ),
                        InputTextField(
                          controller: model.getPasswordController,
                          obscureText: model.getObscureTextForPassword,
                          maxLines: 1,
                          additionalText: 'Password',
                          initialValue: null,
                          validator: (String? value) =>
                              model.validatePassword(value),
                          suffixIcon: CustomSuffixIcon(
                            onPressed: () => model.setObscureText = false,
                            icon: model.getObscureTextForPassword
                                ? Icon(
                                    Icons.remove_red_eye_rounded,
                                    size: 24,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  )
                                : Icon(
                                    Icons.remove_red_eye_outlined,
                                    size: 24,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                          ),
                          onChanged: null,
                          formColor:
                              Theme.of(context).colorScheme.primaryContainer,
                          keyboardType: TextInputType.emailAddress,
                          textColor: Theme.of(context).colorScheme.background,
                          additionalTextColor:
                              Theme.of(context).colorScheme.background,
                          hint: 'Password',
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () => model.navigateToForgotPassword(),
                            child: Text(
                              'Forgot Password?',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 17),
                          child: MainButton(
                            text: 'Login',
                            onTap: () => model.signIn(),
                            busy: model.isBusy,
                            color: Theme.of(context).colorScheme.secondary,
                            textColor: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        _keyboardHeight != 0
                            ? const SizedBox()
                            : Expanded(
                                child: Container(
                                  transform: Matrix4.translationValues(
                                      0, -(_screenSize.height * 0.2 + 20), 0),
                                  alignment: Alignment.bottomCenter,
                                  child: GestureDetector(
                                    onTap: () => model.navigateToRegister(),
                                    child: FadeAnimation(
                                      delay: 0.1,
                                      child: RichText(
                                        text: TextSpan(
                                          text: 'You don\'t have an account? ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .background,
                                              ),
                                          children: [
                                            TextSpan(
                                              text: 'Sign Up',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .secondary,
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
