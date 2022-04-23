import 'package:flutter/material.dart';
import 'package:licenta/UI/create_workout/workout_steps/exercise/exercise_viewmodel.dart';
import 'package:licenta/widgets/buttons/main_button.dart';
import 'package:licenta/widgets/input_textfield.dart';
import 'package:stacked/stacked.dart';

class ExerciseView extends StatelessWidget {
  final int index;
  const ExerciseView({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _keyboard = MediaQuery.of(context).viewInsets.bottom;

    return ViewModelBuilder<ExerciseViewmodel>.reactive(
      onModelReady: (model) => model.initializeExercise(index),
      viewModelBuilder: () => ExerciseViewmodel(),
      builder: (context, model, child) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(20),
          ),
          margin: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: Form(
            key: model.getExerciseFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InputTextField(
                  controller: model.getExerciseNameController,
                  obscureText: false,
                  additionalText: 'Exercise Name',
                  hint: 'E.g: Bench Press',
                  initialValue: null,
                  validator: (String? value) => model.validateName(value),
                  onChanged: null,
                  formColor: Theme.of(context).colorScheme.primaryContainer,
                  keyboardType: TextInputType.name,
                  textColor: Theme.of(context).colorScheme.background,
                  additionalTextColor: Theme.of(context).colorScheme.background,
                ),
                InputTextField(
                  controller: model.getExerciseDescriptionController,
                  obscureText: false,
                  additionalText: 'Exercise Description',
                  maxLines: 4,
                  hint: 'E.g: Bench Press',
                  initialValue: null,
                  validator: (String? value) => model.validateName(value),
                  onChanged: null,
                  formColor: Theme.of(context).colorScheme.primaryContainer,
                  keyboardType: TextInputType.name,
                  textColor: Theme.of(context).colorScheme.background,
                  additionalTextColor: Theme.of(context).colorScheme.background,
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 17),
                  child: MainButton(
                    text: 'Save Exercise',
                    onTap: () => model.addExercise(index),
                    busy: false,
                    color: Theme.of(context).colorScheme.secondary,
                    textColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
                _keyboard != 0
                    ? SizedBox(
                        height: _keyboard,
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
