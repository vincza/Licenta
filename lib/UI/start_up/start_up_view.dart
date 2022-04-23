import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import './startup_viewmodel.dart';
import '/widgets/custom_circular_progress_indicator.dart';

class StartUpView extends StatelessWidget {
  const StartUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartUpViewmodel>.reactive(
      viewModelBuilder: () => StartUpViewmodel(),
      onModelReady: (model) => model.handleStartUpLogic(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RichText(
                text: TextSpan(
                  text: 'FIT',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 50,
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -2,
                      ),
                  children: [
                    TextSpan(
                      text: 'tracker',
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                            fontSize: 50,
                            color: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.7),
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const CustomCircularProgressIndicator(
                size: 60,
                strokeWidth: 4,
              )
            ],
          ),
        ),
      ),
    );
  }
}
