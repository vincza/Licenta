import 'package:flutter/material.dart';
import 'package:licenta/UI/single_workout/tabs/exercises_display_viewmodel.dart';
import 'package:stacked/stacked.dart';

class ExercisesView extends StatelessWidget {
  final String workoutId;
  const ExercisesView({Key? key, required this.workoutId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ExercisesDisplayViewmodel>.reactive(
      viewModelBuilder: () => ExercisesDisplayViewmodel(),
      builder: (context, model, child) => ListView.builder(
        itemBuilder: (context, index) => Container(
          margin: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom:
                model.getExercises(workoutId).length - 1 == index ? 100 : 30,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      Icons.fitness_center,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    '${int.parse(model.getExercises(workoutId)[index].exerciseId) + 1}/${model.getExercises(workoutId).length}',
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(fontSize: 16, fontWeight: FontWeight.w700),
                  )
                ],
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 1,
                    ),
                    Text(
                      model.getExercises(workoutId)[index].exerciseName,
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      model.getExercises(workoutId)[index].exerciseDescription,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 13.5),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        itemCount: model.getExercises(workoutId).length,
      ),
    );
  }
}
