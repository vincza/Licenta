import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:licenta/widgets/buttons/main_button.dart';
import 'package:licenta/widgets/input_textfield.dart';
import 'package:stacked/stacked.dart';
import '/UI/register/register_viewmodel.dart';

class ThirdIntroductionScreen extends ViewModelWidget<RegisterViewmodel> {
  const ThirdIntroductionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, RegisterViewmodel viewModel) {
    final Size _screenSize = MediaQuery.of(context).size;
    final double _keyboard = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
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
              'Almost Done',
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(
              height: 35,
            ),
            GestureDetector(
              onTap: () => viewModel.pickProfileImage(),
              child: Container(
                height: 220,
                width: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.primaryContainer,
                  image: viewModel.getProfileImage == null
                      ? null
                      : DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(
                            viewModel.getProfileImage!,
                          ),
                        ),
                ),
                child: viewModel.getProfileImage != null
                    ? const SizedBox()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.camera_alt_rounded,
                            size: 70,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            'Add a profile picture',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Text(
                            '(Optional)',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Form(
              key: viewModel.getFormName,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17),
                child: InputTextField(
                  controller: viewModel.getNameController,
                  obscureText: false,
                  additionalText: 'Fullname',
                  hint: 'Fullname',
                  initialValue: null,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                  onChanged: null,
                  formColor: Theme.of(context).colorScheme.primaryContainer,
                  keyboardType: TextInputType.name,
                  textColor: Theme.of(context).colorScheme.background,
                  additionalTextColor: Theme.of(context).colorScheme.background,
                ),
              ),
            ),
            const SizedBox(
              height: 45,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: MainButton(
                text: 'Create User',
                onTap: () => viewModel.createUser(context),
                busy: viewModel.isBusy,
                color: Theme.of(context).colorScheme.secondary,
                textColor: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
