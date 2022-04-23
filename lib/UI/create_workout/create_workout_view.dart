import 'package:flutter/material.dart';
import 'package:licenta/UI/create_workout/create_workout_viewmodel.dart';
import 'package:licenta/UI/create_workout/workout_steps/exercises_step.dart';
import 'package:licenta/UI/create_workout/workout_steps/workout_details_step.dart';
import 'package:licenta/widgets/buttons/back_button.dart';
import 'package:licenta/widgets/custom_circular_progress_indicator.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stacked/stacked.dart';

class CreateWorkoutView extends StatelessWidget {
  final String? workoutId;
  const CreateWorkoutView({Key? key, this.workoutId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _keyboard = MediaQuery.of(context).viewInsets.bottom;
    final Size _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: ViewModelBuilder<CreateWorkoutViewmodel>.reactive(
          onModelReady: (model) => model.initializeWorkoutData(workoutId),
          viewModelBuilder: () => CreateWorkoutViewmodel(),
          builder: (context, model, child) => GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: model.isBusy
                ? const Center(
                    child: CustomCircularProgressIndicator(
                      size: 60,
                      strokeWidth: 4,
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      _keyboard != 0 && model.getPageController.page! < 1
                          ? SizedBox(
                              height: _screenSize.height * 0.05,
                            )
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 20,
                              ),
                              child: CustomBackButton(
                                onTap: () => model.navigateToWorkoutsView(),
                              ),
                            ),
                      Expanded(
                        child: Stack(
                          children: [
                            PageView(
                              physics: const NeverScrollableScrollPhysics(),
                              controller: model.getPageController,
                              children: [
                                const WorkoutDetails(),
                                Stack(
                                  children: [
                                    const WorkoutExercises(),
                                    Positioned(
                                      right: 20,
                                      bottom: 20,
                                      child: GestureDetector(
                                        onTap: () =>
                                            model.submitWorkout(workoutId),
                                        child: AnimatedContainer(
                                          duration:
                                              const Duration(milliseconds: 500),
                                          curve: Curves.decelerate,
                                          height: 50,
                                          width: 50,
                                          transform: Matrix4.translationValues(
                                            model.getExercises.isEmpty
                                                ? 100
                                                : 0,
                                            model.getExercises.isEmpty
                                                ? 100
                                                : 0,
                                            0,
                                          ),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            boxShadow: [
                                              BoxShadow(
                                                offset: const Offset(0, 0),
                                                blurRadius: 5,
                                                spreadRadius: 1,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .background
                                                    .withOpacity(0.2),
                                              ),
                                            ],
                                          ),
                                          child: Icon(
                                            Icons.done,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      _keyboard != 0 && model.getPageController.page! < 1
                          ? const SizedBox()
                          : Align(
                              alignment: Alignment.center,
                              child: Padding(
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
                            )
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
