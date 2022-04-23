import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '/UI/register/register_viewmodel.dart';
import '/widgets/buttons/main_button.dart';

class SecondIntroductionPage extends ViewModelWidget<RegisterViewmodel> {
  const SecondIntroductionPage({Key? key}) : super(key: key, reactive: true);

  @override
  Widget build(BuildContext context, RegisterViewmodel viewModel) {
    final Size _screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: _screenSize.height * 0.05,
            ),
            Text(
              'Choose Your Gender',
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(
              height: _screenSize.height * 0.45,
              child: Row(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Center(
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            height: viewModel.getGender == 'Male' ? 200 : 160,
                            width: viewModel.getGender == 'Male' ? 200 : 160,
                            decoration: BoxDecoration(
                              color: viewModel.getGender == 'Male'
                                  ? Theme.of(context).colorScheme.secondary
                                  : Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                              shape: BoxShape.circle,
                              gradient: viewModel.getGender == 'Male'
                                  ? LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Theme.of(context).colorScheme.secondary,
                                        Theme.of(context)
                                            .colorScheme
                                            .secondary
                                            .withOpacity(0.7),
                                      ],
                                    )
                                  : null,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => viewModel.setGender('Male'),
                          child: Center(
                            child: Image.asset(
                              'assets/fitness_man.png',
                              height: viewModel.getGender == 'Male'
                                  ? _screenSize.height
                                  : _screenSize.height * 0.40 - 120,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        Center(
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            height: viewModel.getGender == 'Female' ? 200 : 160,
                            width: viewModel.getGender == 'Female' ? 200 : 160,
                            decoration: BoxDecoration(
                              color: viewModel.getGender == 'Female'
                                  ? Theme.of(context).colorScheme.secondary
                                  : Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                              shape: BoxShape.circle,
                              gradient: viewModel.getGender == 'Female'
                                  ? LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Theme.of(context).colorScheme.secondary,
                                        Theme.of(context)
                                            .colorScheme
                                            .secondary
                                            .withOpacity(0.7),
                                      ],
                                    )
                                  : null,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => viewModel.setGender('Female'),
                          child: Center(
                            child: Image.asset(
                              'assets/fitness_woman.png',
                              height: viewModel.getGender == 'Female'
                                  ? _screenSize.height
                                  : _screenSize.height * 0.40 - 120,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: MainButton(
                text: 'Next',
                onTap: () => viewModel.navigateToThirdStep(),
                busy: false,
                color: Theme.of(context).colorScheme.secondary,
                textColor: Theme.of(context).colorScheme.primary,
              ),
            )
          ],
        ),
      ),
    );
  }
}
