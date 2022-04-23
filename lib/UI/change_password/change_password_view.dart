import 'package:flutter/material.dart';
import 'package:licenta/UI/change_password/change_password_viewmodel.dart';
import 'package:licenta/widgets/buttons/main_button.dart';
import 'package:licenta/widgets/input_textfield.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/custom_suffix_icon.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _keyboard = MediaQuery.of(context).viewInsets.bottom;
    return ViewModelBuilder<ChangePasswordViewmodel>.reactive(
      viewModelBuilder: () => ChangePasswordViewmodel(),
      builder: (context, model, child) => Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
          color: Theme.of(context).colorScheme.primary,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: model.getFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Change Password',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InputTextField(
                    controller: model.getOldPassword,
                    obscureText: model.getObscureTextOldPassword,
                    additionalText: 'Old Password',
                    hint: 'Old Password',
                    initialValue: null,
                    maxLines: 1,
                    validator: (String? value) => model.validatePassword(value),
                    onChanged: null,
                    formColor: Theme.of(context).colorScheme.primaryContainer,
                    keyboardType: TextInputType.text,
                    textColor: Theme.of(context).colorScheme.background,
                    additionalTextColor:
                        Theme.of(context).colorScheme.background,
                    suffixIcon: CustomSuffixIcon(
                      onPressed: () => model.setObscureTextOldPassword = false,
                      icon: model.getObscureTextOldPassword
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
                    controller: model.getNewPassword,
                    obscureText: model.getObscureTextNewPassword,
                    additionalText: 'New Password',
                    hint: 'New Password',
                    initialValue: null,
                    maxLines: 1,
                    validator: (String? value) => model.validatePassword(value),
                    onChanged: null,
                    formColor: Theme.of(context).colorScheme.primaryContainer,
                    keyboardType: TextInputType.text,
                    textColor: Theme.of(context).colorScheme.background,
                    additionalTextColor:
                        Theme.of(context).colorScheme.background,
                    suffixIcon: CustomSuffixIcon(
                      onPressed: () => model.setObscureTextNewPassword = false,
                      icon: model.getObscureTextNewPassword
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
                    controller: model.getConfirmationNewPassword,
                    obscureText: model.getObscureTextNewPasswordConfirmation,
                    additionalText: 'Confirm New Password',
                    hint: 'Confirm New Password',
                    initialValue: null,
                    maxLines: 1,
                    validator: (String? value) => model.validateConfirmPassword(
                      value,
                      model.getNewPassword.text,
                    ),
                    onChanged: null,
                    formColor: Theme.of(context).colorScheme.primaryContainer,
                    keyboardType: TextInputType.text,
                    textColor: Theme.of(context).colorScheme.background,
                    additionalTextColor:
                        Theme.of(context).colorScheme.background,
                    suffixIcon: CustomSuffixIcon(
                      onPressed: () =>
                          model.setObscureTextNewPasswordConfirmation = false,
                      icon: model.getObscureTextNewPasswordConfirmation
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
                  const SizedBox(
                    height: 25,
                  ),
                  MainButton(
                    text: 'Change Password',
                    onTap: () => model.changePassword(),
                    busy: model.isBusy,
                    color: Theme.of(context).colorScheme.secondary,
                    textColor: Theme.of(context).colorScheme.primary,
                  ),
                  _keyboard != 0
                      ? SizedBox(
                          height: _keyboard + 30,
                        )
                      : const SizedBox(
                          height: 30,
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
