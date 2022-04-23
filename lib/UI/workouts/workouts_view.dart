import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '/UI/workouts/workouts_viewmodel.dart';
import '/widgets/buttons/action_button.dart';
import '/widgets/buttons/back_button.dart';
import '/widgets/buttons/main_button.dart';
import '/widgets/custom_circular_progress_indicator.dart';

class WorkoutsView extends StatelessWidget {
  const WorkoutsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WorkoutsViewmodel>.reactive(
      viewModelBuilder: () => WorkoutsViewmodel(),
      builder: (context, model, child) => model.isBusy
          ? const Center(
              child: CustomCircularProgressIndicator(size: 60, strokeWidth: 4),
            )
          : model.getWorkouts.isEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/workouts_placeholder.png',
                          height: 300,
                          width: 300,
                        ),
                      ),
                      Text(
                        'No Workouts Created yet',
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: MainButton(
                          text: 'Create Workout',
                          onTap: () => model.navigateToCreateWorkout(),
                          busy: false,
                          color: Theme.of(context).colorScheme.secondary,
                          textColor: Theme.of(context).colorScheme.primary,
                        ),
                      )
                    ],
                  ),
                )
              : Stack(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: ListView.builder(
                            key: const PageStorageKey('My Workouts'),
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) => Container(
                              margin: EdgeInsets.only(
                                left: 20,
                                right: 20,
                                bottom: model.getWorkouts.length - 1 == index
                                    ? 100
                                    : 20,
                              ),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                ),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  stops: const [0.2, 0.7],
                                  colors: [
                                    Theme.of(context).colorScheme.secondary,
                                    Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.7),
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(0, 3),
                                    blurRadius: 5,
                                    spreadRadius: 2,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background
                                        .withOpacity(0.2),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    model.getWorkouts[index].workoutName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .copyWith(
                                          fontSize: 24,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  Text(
                                    'Number of Exercises: ${model.getWorkouts[index].exercises.length}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                            fontSize: 15,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    model.getWorkouts[index].workoutDescription,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          fontSize: 14,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () => model.deleteWorkout(
                                          model.getWorkouts[index].workoutId,
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            boxShadow: [
                                              BoxShadow(
                                                offset: const Offset(0, 0),
                                                blurRadius: 5,
                                                spreadRadius: 3,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary
                                                    .withOpacity(0.6),
                                              ),
                                            ],
                                          ),
                                          child: Icon(
                                            Icons.delete_outline,
                                            size: 25,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      GestureDetector(
                                        onTap: () =>
                                            model.navigateToWorkoutView(
                                          model.getWorkouts[index].workoutId,
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            boxShadow: [
                                              BoxShadow(
                                                offset: const Offset(0, 0),
                                                blurRadius: 5,
                                                spreadRadius: 3,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary
                                                    .withOpacity(0.6),
                                              ),
                                            ],
                                          ),
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            size: 25,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            itemCount: model.getWorkouts.length,
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 20,
                      child: Align(
                        alignment: Alignment.center,
                        child: ActionButton(
                          title: 'Create Workout',
                          onTap: () => model.navigateToCreateWorkout(),
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    )
                  ],
                ),
    );
  }
}
