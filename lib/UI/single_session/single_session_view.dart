import 'package:flutter/material.dart';
import 'package:licenta/UI/single_session/single_session_viewmodel.dart';
import 'package:licenta/widgets/buttons/main_button.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/buttons/back_button.dart';
import '../../widgets/fade_animation.dart';

class SingleSessionView extends StatelessWidget {
  final String sessionId;
  final int index;
  const SingleSessionView(
      {Key? key, required this.sessionId, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SingleSessionViewmodel>.reactive(
      onModelReady: (model) => model.initializeSession(),
      viewModelBuilder: () => SingleSessionViewmodel(sessionId: sessionId),
      builder: (context, model, child) => Scaffold(
        backgroundColor: model.returnStatusColor(),
        body: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  backgroundColor: model.returnStatusColor(),
                  automaticallyImplyLeading: false,
                  collapsedHeight: 230,
                  floating: true,
                  flexibleSpace: SessionHeader(index: index),
                ),
              ];
            },
            body: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(50),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Exercises',
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                            fontSize: 30,
                            color: Theme.of(context).colorScheme.background,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) => Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            ),
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                model.getSession.exercises[index].exerciseName,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontSize: 17,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, setIndex) => Container(
                                  margin: const EdgeInsets.only(bottom: 20),
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: const Offset(0, 3),
                                        blurRadius: 4,
                                        spreadRadius: 2,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background
                                            .withOpacity(0.1),
                                      ),
                                    ],
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 15,
                                          vertical: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                        child: Text(
                                          'Set ${model.getSession.exercises[index].sets[setIndex].setId + 1}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1!
                                              .copyWith(
                                                fontSize: 13,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 15,
                                          vertical: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                        child: Text(
                                          'Weight: ${model.getSession.exercises[index].sets[setIndex].weight} kg',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1!
                                              .copyWith(
                                                fontSize: 13,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 15,
                                          vertical: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                        child: Text(
                                          'Reps: ${model.getSession.exercises[index].sets[setIndex].reps}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1!
                                              .copyWith(
                                                fontSize: 13,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                itemCount: model
                                    .getSession.exercises[index].sets.length,
                              )
                            ],
                          ),
                        ),
                        itemCount: model.getSession.exercises.length,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SessionHeader extends ViewModelWidget<SingleSessionViewmodel> {
  final int index;
  const SessionHeader({Key? key, required this.index})
      : super(key: key, reactive: false);

  @override
  Widget build(BuildContext context, SingleSessionViewmodel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            top: 20,
            bottom: 20,
            right: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomBackButton(
                onTap: () => viewModel.navigateBack(),
                color: Theme.of(context)
                    .colorScheme
                    .primaryContainer
                    .withOpacity(0.4),
              ),
              viewModel.getSession.notes != null
                  ? CustomBackButton(
                      onTap: () => showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (context) => Container(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            top: 35,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Notes',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  viewModel.getSession.notes!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        fontSize: 14,
                                      ),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              MainButton(
                                text: 'Dismiss',
                                onTap: () => Navigator.of(context).pop(),
                                busy: false,
                                color: Theme.of(context).colorScheme.secondary,
                                textColor:
                                    Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                      icon: Icons.note,
                      color: Theme.of(context)
                          .colorScheme
                          .primaryContainer
                          .withOpacity(0.4),
                    )
                  : const SizedBox()
            ],
          ),
        ),
        FadeAnimation(
          delay: 0.3,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              'Session $index',
              style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontSize: 30,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        FadeAnimation(
          delay: 0.45,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              'Date: ${viewModel.returnDate()}',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ),
        FadeAnimation(
          delay: 0.60,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              'Duration: ${viewModel.getSession.duration}',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ),
        FadeAnimation(
          delay: 0.75,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: RichText(
              text: TextSpan(
                text: 'Session Status: ',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                children: [
                  TextSpan(
                    text: viewModel.getSession.workoutFeel,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 20,
                          color: viewModel.returnStatusColorTitle(),
                          fontWeight: FontWeight.bold,
                        ),
                  )
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
