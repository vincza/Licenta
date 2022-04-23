import 'package:flutter/material.dart';
import 'package:licenta/UI/create_session/session_steps/add_sets_view.dart';
import 'package:licenta/UI/create_session/session_steps/session_exercise_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SessionExerciseView extends StatelessWidget {
  final String exerciseTitle;
  final String exerciseDescription;
  final String exerciseId;
  final int index;
  const SessionExerciseView(
      {Key? key,
      required this.exerciseDescription,
      required this.exerciseTitle,
      required this.exerciseId,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SessionExerciseViewmodel>.reactive(
      viewModelBuilder: () => SessionExerciseViewmodel(index: index),
      builder: (context, model, child) => Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  exerciseTitle,
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                ),
                model.returnSets(index).isNotEmpty
                    ? GestureDetector(
                        onTap: () => showModalBottomSheet(
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          context: context,
                          builder: (_) => AddSetsView(
                            index: index,
                            exerciseDescription: exerciseDescription,
                            exerciseTitle: exerciseTitle,
                            exerciseId: exerciseId,
                          ),
                        ).whenComplete(
                          () => model.notifyListeners(),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          child: Icon(
                            Icons.edit,
                            size: 16,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            shape: BoxShape.circle,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              exerciseDescription,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 13,
                  ),
            ),
            const SizedBox(
              height: 15,
            ),
            model.returnSets(index).isEmpty
                ? GestureDetector(
                    onTap: () => showModalBottomSheet(
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      context: context,
                      builder: (_) => AddSetsView(
                        index: index,
                        exerciseDescription: exerciseDescription,
                        exerciseTitle: exerciseTitle,
                        exerciseId: exerciseId,
                      ),
                    ).whenComplete(
                      () => model.notifyListeners(),
                    ),
                    child: Container(
                      width: 110,
                      padding: const EdgeInsets.all(8),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Add sets',
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                  )
                : ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, setIndex) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Set ${model.returnSets(index)[setIndex].setId + 1}',
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(
                                fontSize: 16,
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              child: Text(
                                'Weight: ${model.returnSets(index)[setIndex].weight} kg',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
                                      fontSize: 12,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              child: Text(
                                'Reps: ${model.returnSets(index)[setIndex].reps}',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
                                      fontSize: 12,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    itemCount: model.returnSets(index).length,
                  ),
          ],
        ),
      ),
    );
  }
}
