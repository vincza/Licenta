import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '/widgets/input_textfield.dart';
import '/widgets/buttons/main_button.dart';
import '/widgets/custom_suffix_icon.dart';

import '/UI/register/register_viewmodel.dart';

class FirstIntroductionPage extends ViewModelWidget<RegisterViewmodel> {
  const FirstIntroductionPage({Key? key}) : super(key: key, reactive: true);

  @override
  Widget build(BuildContext context, RegisterViewmodel viewModel) {
    final Size _screenSize = MediaQuery.of(context).size;
    final double _keyboard = MediaQuery.of(context).viewInsets.bottom;
    return Form(
      key: viewModel.getFormBasicInformation,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: _keyboard != 0 ? 0 : _screenSize.height * 0.05,
              ),
              Text(
                'First Step',
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              InputTextField(
                controller: viewModel.getEmailController,
                obscureText: false,
                additionalText: 'Email',
                hint: 'someone@gmail.com',
                initialValue: null,
                validator: (String? value) => viewModel.validateEmail(value),
                onChanged: null,
                formColor: Theme.of(context).colorScheme.primaryContainer,
                keyboardType: TextInputType.emailAddress,
                textColor: Theme.of(context).colorScheme.background,
                additionalTextColor: Theme.of(context).colorScheme.background,
              ),
              InputTextField(
                controller: viewModel.getPasswordController,
                obscureText: viewModel.getObscuredPassword,
                maxLines: 1,
                additionalText: 'Password',
                hint: '\$Asd12345678',
                initialValue: null,
                validator: (String? value) => viewModel.validatePassword(value),
                onChanged: null,
                formColor: Theme.of(context).colorScheme.primaryContainer,
                keyboardType: TextInputType.emailAddress,
                textColor: Theme.of(context).colorScheme.background,
                additionalTextColor: Theme.of(context).colorScheme.background,
                suffixIcon: CustomSuffixIcon(
                  onPressed: () => viewModel.setObscurePassword(),
                  icon: viewModel.getObscuredPassword
                      ? Icon(
                          Icons.remove_red_eye_rounded,
                          size: 24,
                          color: Theme.of(context).colorScheme.secondary,
                        )
                      : Icon(
                          Icons.remove_red_eye_outlined,
                          size: 24,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                ),
              ),
              InputTextField(
                controller: viewModel.getConfirmPasswordController,
                obscureText: viewModel.getObscuredConfirmPassword,
                maxLines: 1,
                additionalText: 'Confirm Password',
                hint: '\$Asd12345678',
                initialValue: null,
                validator: (String? value) => viewModel.validateConfirmPassword(
                  value,
                  viewModel.getPasswordController.text,
                ),
                onChanged: null,
                formColor: Theme.of(context).colorScheme.primaryContainer,
                keyboardType: TextInputType.emailAddress,
                textColor: Theme.of(context).colorScheme.background,
                additionalTextColor: Theme.of(context).colorScheme.background,
                suffixIcon: CustomSuffixIcon(
                  onPressed: () => viewModel.setObscureConfirmPassword(),
                  icon: viewModel.getObscuredConfirmPassword
                      ? Icon(
                          Icons.remove_red_eye_rounded,
                          size: 24,
                          color: Theme.of(context).colorScheme.secondary,
                        )
                      : Icon(
                          Icons.remove_red_eye_outlined,
                          size: 24,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17),
                child: MainButton(
                  text: 'Next',
                  onTap: () => viewModel.navigateToSecondStep(context),
                  busy: false,
                  color: Theme.of(context).colorScheme.secondary,
                  textColor: Theme.of(context).colorScheme.primary,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
