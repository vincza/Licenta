import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '/UI/register/register_viewmodel.dart';
import '/widgets/buttons/back_button.dart';

import 'introduction_pages/first_introduction_page.dart';
import 'introduction_pages/second_introduction_page.dart';
import 'introduction_pages/third_introduction_page.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _keyboard = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: ViewModelBuilder<RegisterViewmodel>.reactive(
        viewModelBuilder: () => RegisterViewmodel(),
        builder: (context, model, child) => GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SafeArea(
            child: Column(
              children: [
                _keyboard != 0
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                          right: 20,
                          left: 20,
                          bottom: 20,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: CustomBackButton(
                            onTap: () => model.handleBackButton(),
                          ),
                        ),
                      ),
                Expanded(
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: model.getPageController,
                    children: const [
                      FirstIntroductionPage(),
                      SecondIntroductionPage(),
                      ThirdIntroductionScreen(),
                    ],
                  ),
                ),
                _keyboard != 0
                    ? const SizedBox()
                    : SizedBox(
                        height: 50,
                        child: SmoothPageIndicator(
                          controller: model.getPageController,
                          count: 3,
                          effect: WormEffect(
                            dotHeight: 11,
                            dotWidth: 11,
                            dotColor: Theme.of(context)
                                .colorScheme
                                .onPrimary
                                .withOpacity(0.3),
                            activeDotColor:
                                Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
