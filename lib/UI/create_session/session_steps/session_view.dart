import 'package:flutter/material.dart';
import 'package:licenta/UI/create_session/create_session_viewmodel.dart';
import 'package:licenta/UI/create_session/session_steps/session_exercise_view.dart';
import 'package:stacked/stacked.dart';

class SessionView extends ViewModelWidget<CreateSessionViewmodel> {
  const SessionView({Key? key}) : super(key: key, reactive: true);

  @override
  Widget build(BuildContext context, CreateSessionViewmodel viewModel) {
    return Column(
      children: [
        Text(
          'Session Information',
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
            padding: const EdgeInsets.only(
              top: 15,
            ),
            itemBuilder: (context, index) => SessionExerciseView(
              index: index,
              exerciseDescription:
                  viewModel.getWorkout.exercises[index].exerciseDescription,
              exerciseTitle: viewModel.getWorkout.exercises[index].exerciseName,
              exerciseId: viewModel.getWorkout.exercises[index].exerciseId,
            ),
            itemCount: viewModel.getWorkout.exercises.length,
          ),
        ),
      ],
    );
  }
}
