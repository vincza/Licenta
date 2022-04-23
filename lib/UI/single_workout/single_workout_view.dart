import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:licenta/UI/single_workout/single_workout_viewmodel.dart';
import 'package:licenta/UI/single_workout/tabs/exercises.dart';
import 'package:licenta/UI/single_workout/tabs/sessions.dart';
import 'package:licenta/widgets/buttons/action_button.dart';
import 'package:licenta/widgets/buttons/back_button.dart';
import 'package:licenta/widgets/custom_circular_progress_indicator.dart';
import 'package:licenta/widgets/fade_animation.dart';
import 'package:stacked/stacked.dart';

class SingleWorkoutView extends StatelessWidget {
  final String workoutId;
  const SingleWorkoutView({Key? key, required this.workoutId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        body: SafeArea(
          child: ViewModelBuilder<SingleWorkoutViewmodel>.reactive(
            viewModelBuilder: () =>
                SingleWorkoutViewmodel(workoutId: workoutId),
            builder: (context, model, child) => NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    automaticallyImplyLeading: false,
                    collapsedHeight: 250,
                    floating: true,
                    flexibleSpace: Header(workoutId: workoutId),
                  ),
                ];
              },
              body: Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(50),
                        ),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 40,
                              right: 40,
                              top: 20,
                            ),
                            child: TabBar(
                              unselectedLabelColor:
                                  Theme.of(context).colorScheme.secondary,
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(fontSize: 16),
                              indicatorSize: TabBarIndicatorSize.label,
                              indicator: ShapeDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                  ),
                                  side: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                              ),
                              tabs: const [
                                Tab(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text("Exercises"),
                                  ),
                                ),
                                Tab(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text("Sessions"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                Stack(
                                  children: [
                                    ExercisesView(workoutId: workoutId),
                                    Positioned(
                                      bottom: 25,
                                      left: 0,
                                      right: 0,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: ActionButton(
                                          title: 'Edit Workout',
                                          onTap: () => model
                                              .navigateToWorkoutView(workoutId),
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Stack(
                                  children: [
                                    SessionsView(workoutId: workoutId),
                                    Positioned(
                                      bottom: 25,
                                      left: 0,
                                      right: 0,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: ActionButton(
                                          onTap: () =>
                                              model.navigateToCreateSessionView(
                                                  workoutId),
                                          title: 'Create Session',
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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

class Header extends ViewModelWidget<SingleWorkoutViewmodel> {
  final String workoutId;
  const Header({Key? key, required this.workoutId})
      : super(key: key, reactive: true);

  @override
  Widget build(BuildContext context, SingleWorkoutViewmodel viewModel) {
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
                onTap: () => viewModel.navigateBack(),
                color: Theme.of(context)
                    .colorScheme
                    .primaryContainer
                    .withOpacity(0.4),
              ),
              viewModel.isWorkoutOwner()
                  ? Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: viewModel.isBusy
                          ? const CustomCircularProgressIndicator(
                              size: 25,
                              strokeWidth: 2,
                            )
                          : viewModel.getWorkout().isShared
                              ? CustomBackButton(
                                  onTap: () => viewModel.deleteSharedWorkout(),
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer
                                      .withOpacity(0.4),
                                  icon: Icons.undo,
                                )
                              : CustomBackButton(
                                  onTap: () => viewModel.shareWorkout(),
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer
                                      .withOpacity(0.4),
                                  icon: Icons.share,
                                ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
        FadeAnimation(
          delay: 0.3,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              viewModel.getWorkout().workoutName,
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
              viewModel.getWorkout().workoutDescription,
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
