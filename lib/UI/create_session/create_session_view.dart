import 'dart:math';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stacked/stacked.dart';

import '/UI/create_session/create_session_viewmodel.dart';
import '/UI/create_session/session_steps/session_result_view.dart';
import '/UI/create_session/session_steps/session_view.dart';

import '/widgets/buttons/back_button.dart';
import '/widgets/custom_circular_progress_indicator.dart';

class CreateSessionView extends StatelessWidget {
  final String workoutId;
  const CreateSessionView({Key? key, required this.workoutId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ViewModelBuilder<CreateSessionViewmodel>.reactive(
        onModelReady: (model) => model.initializeTimer(workoutId),
        viewModelBuilder: () => CreateSessionViewmodel(),
        builder: (context, model, child) => SafeArea(
          child: model.isBusy
              ? const Center(
                  child: CustomCircularProgressIndicator(
                    size: 60,
                    strokeWidth: 4,
                  ),
                )
              : Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                          child: CustomBackButton(
                            onTap: () => model.navigateBack(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                          child: Text(
                            'Duration: ${model.getHours}:${model.getMinutes}:${model.getSeconds}',
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(
                                  fontSize: 16,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                          child: Transform.rotate(
                            angle: model.getIsSecondPage ? 0 : pi,
                            child: CustomBackButton(
                              onTap: () => model.navigateForward(),
                              icon: model.getIsSecondPage ? Icons.done : null,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: PageView(
                        onPageChanged: (value) => model.notifyListeners(),
                        controller: model.getPageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: const [
                          SessionView(),
                          SessionResultView(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: SmoothPageIndicator(
                        count: 2,
                        controller: model.getPageController,
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
    );
  }
}
