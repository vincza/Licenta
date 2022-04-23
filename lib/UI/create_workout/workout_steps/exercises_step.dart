import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '/UI/create_workout/workout_steps/exercise/exercise_view.dart';
import '/UI/create_workout/create_workout_viewmodel.dart';
import '/widgets/buttons/action_button.dart';
import '/widgets/buttons/main_button.dart';

class WorkoutExercises extends ViewModelWidget<CreateWorkoutViewmodel> {
  const WorkoutExercises({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, CreateWorkoutViewmodel viewModel) {
    return viewModel.getExercises.isEmpty
        ? const EmptyExercises()
        : const ExerciseList();
  }
}

class EmptyExercises extends ViewModelWidget<CreateWorkoutViewmodel> {
  const EmptyExercises({Key? key}) : super(key: key, reactive: false);

  @override
  Widget build(BuildContext context, CreateWorkoutViewmodel viewModel) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
            'No Exercises Created yet',
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
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: MainButton(
              text: 'Add Exercise',
              onTap: () => showModalBottomSheet(
                backgroundColor: Theme.of(context).colorScheme.primary,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                context: context,
                builder: (context) => const ExerciseView(index: 0),
              ).whenComplete(
                () => viewModel.notifyListeners(),
              ),
              busy: false,
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.8),
              textColor: Theme.of(context).colorScheme.primary,
            ),
          )
        ],
      ),
    );
  }
}

class ExerciseList extends ViewModelWidget<CreateWorkoutViewmodel> {
  const ExerciseList({Key? key}) : super(key: key, reactive: true);

  @override
  Widget build(BuildContext context, CreateWorkoutViewmodel viewModel) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          'Add Exercises',
          style: Theme.of(context).textTheme.headline1!.copyWith(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              if (index == viewModel.getExercises.length) {
                return Align(
                  alignment: Alignment.center,
                  child: ActionButton(
                    title: 'Create Exercise',
                    color: Theme.of(context).colorScheme.secondary,
                    onTap: () => showModalBottomSheet(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      context: context,
                      builder: (context) => ExerciseView(index: index),
                    ).whenComplete(
                      () => viewModel.notifyListeners(),
                    ),
                  ),
                );
              }
              return Container(
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 25),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                height: 60,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 4),
                        blurRadius: 5,
                        spreadRadius: 1,
                        color: Theme.of(context)
                            .colorScheme
                            .background
                            .withOpacity(0.07),
                      ),
                    ]),
                child: Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.9),
                      ),
                      child: Text(
                        viewModel.getExerciseNumber(index),
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      viewModel.getExercises[index]!.exerciseName,
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => showModalBottomSheet(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        context: context,
                        builder: (context) => ExerciseView(index: index),
                      ).whenComplete(
                        () => viewModel.notifyListeners(),
                      ),
                      child: Container(
                        height: 27,
                        width: 27,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).colorScheme.primaryContainer,
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
                          Icons.edit,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 16,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                      onTap: () => viewModel.removeExercise(index),
                      child: Container(
                        height: 27,
                        width: 27,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).colorScheme.primaryContainer,
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
                          Icons.cancel,
                          color: Theme.of(context).colorScheme.error,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            itemCount: viewModel.getExercises.length + 1,
          ),
        ),
      ],
    );
  }
}
