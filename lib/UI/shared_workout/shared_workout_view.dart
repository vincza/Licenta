import 'package:flutter/material.dart';
import 'package:licenta/UI/shared_workout/shared_workout_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/buttons/back_button.dart';
import '../../widgets/custom_circular_progress_indicator.dart';
import '../../widgets/fade_animation.dart';

class SharedWorkoutView extends StatelessWidget {
  final String workoutId;

  const SharedWorkoutView({
    Key? key,
    required this.workoutId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: SafeArea(
        child: ViewModelBuilder<SharedWorkoutViewmodel>.reactive(
          onModelReady: (model) => model.initializeWorkout(),
          viewModelBuilder: () => SharedWorkoutViewmodel(workoutId: workoutId),
          builder: (context, model, child) => NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  automaticallyImplyLeading: false,
                  collapsedHeight: 250,
                  floating: true,
                  flexibleSpace: SharedWorkoutHeader(workoutId: workoutId),
                ),
              ];
            },
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(50),
                ),
              ),
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
                        margin: const EdgeInsets.only(bottom: 20),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              child: Text(
                                '${index + 1}/${model.getSharedWorkout.exercises.length}',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    model.getSharedWorkout.exercises[index]
                                        .exerciseName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .copyWith(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                        ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    model.getSharedWorkout.exercises[index]
                                        .exerciseDescription,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      itemCount: model.getSharedWorkout.exercises.length,
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

class SharedWorkoutHeader extends ViewModelWidget<SharedWorkoutViewmodel> {
  final String workoutId;
  const SharedWorkoutHeader({Key? key, required this.workoutId})
      : super(key: key, reactive: true);

  @override
  Widget build(BuildContext context, SharedWorkoutViewmodel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            top: 20,
            bottom: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomBackButton(
                onTap: () => Navigator.of(context).pop(),
                color: Theme.of(context)
                    .colorScheme
                    .primaryContainer
                    .withOpacity(0.4),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: viewModel.isBusy
                    ? const CustomCircularProgressIndicator(
                        size: 25,
                        strokeWidth: 2,
                      )
                    : !viewModel.isWorkoutOwner()
                        ? viewModel.isAlreadyAdded()
                            ? const SizedBox()
                            : CustomBackButton(
                                onTap: () =>
                                    viewModel.addWorkoutToOwnCollection(),
                                icon: Icons.add,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer
                                    .withOpacity(0.4),
                              )
                        : const SizedBox(),
              ),
            ],
          ),
        ),
        FadeAnimation(
          delay: 0.3,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              viewModel.getSharedWorkout.workoutName,
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    fontSize: 40,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ),
        ),
        FadeAnimation(
          delay: 0.45,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              viewModel.getSharedWorkout.workoutDescription,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.primary,
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
