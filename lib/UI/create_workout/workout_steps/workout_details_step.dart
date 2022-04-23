import 'package:flutter/material.dart';
import 'package:licenta/widgets/buttons/main_button.dart';
import 'package:licenta/widgets/input_textfield.dart';
import 'package:stacked/stacked.dart';
import '/UI/create_workout/create_workout_viewmodel.dart';

class WorkoutDetails extends ViewModelWidget<CreateWorkoutViewmodel> {
  const WorkoutDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, CreateWorkoutViewmodel viewModel) {
    return Form(
      key: viewModel.getFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              Text(
                'Basic Workout Information',
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                height: 40,
              ),
              InputTextField(
                controller: viewModel.getWorkoutNameController,
                obscureText: false,
                additionalText: 'Workout Name',
                hint: 'E.g: Push',
                initialValue: null,
                validator: (String? value) => viewModel.validateName(value),
                onChanged: null,
                formColor: Theme.of(context).colorScheme.primaryContainer,
                keyboardType: TextInputType.name,
                textColor: Theme.of(context).colorScheme.background,
                additionalTextColor: Theme.of(context).colorScheme.background,
              ),
              const SizedBox(
                height: 5,
              ),
              InputTextField(
                controller: viewModel.getWorkoutDescriptionController,
                obscureText: false,
                additionalText: 'Workout Description',
                hint: 'E.g: The workout includes 6 exercises',
                maxLines: 4,
                maxLength: 200,
                initialValue: null,
                validator: (String? value) => viewModel.validateName(value),
                onChanged: null,
                formColor: Theme.of(context).colorScheme.primaryContainer,
                keyboardType: TextInputType.multiline,
                textColor: Theme.of(context).colorScheme.background,
                additionalTextColor: Theme.of(context).colorScheme.background,
              ),
              const SizedBox(
                height: 25,
              ),
              MainButton(
                text: 'Next',
                onTap: () => viewModel.navigateToNextPage(context),
                busy: false,
                color: Theme.of(context).colorScheme.secondary,
                textColor: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
