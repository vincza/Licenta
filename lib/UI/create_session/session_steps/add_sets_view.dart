import 'package:flutter/material.dart';
import 'package:licenta/UI/create_session/session_steps/add_sets_viewmodel.dart';
import 'package:licenta/widgets/buttons/main_button.dart';
import 'package:licenta/widgets/fade_animation.dart';
import 'package:licenta/widgets/input_textfield.dart';
import 'package:stacked/stacked.dart';

class AddSetsView extends StatelessWidget {
  final String exerciseDescription;
  final String exerciseTitle;
  final String exerciseId;

  final int index;
  const AddSetsView({
    Key? key,
    required this.index,
    required this.exerciseTitle,
    required this.exerciseDescription,
    required this.exerciseId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _keyboard = MediaQuery.of(context).viewInsets.bottom;
    return ViewModelBuilder<AddSetsViewmodel>.reactive(
      onModelReady: (model) => model.initializeSets(),
      viewModelBuilder: () => AddSetsViewmodel(
        index: index,
        exerciseDescription: exerciseDescription,
        exerciseId: exerciseId,
        exerciseTitle: exerciseTitle,
      ),
      builder: (context, model, child) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Form(
            key: model.getFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20, top: 35),
                  child: Text(
                    exerciseTitle,
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: InputTextField(
                    maxLength: 1,
                    obscureText: false,
                    additionalText: 'Number of Sets',
                    hint: 'Number of sets',
                    initialValue: model.getSets.isEmpty
                        ? null
                        : model.getSets.length.toString(),
                    validator: (String? value) => model.validateSets(value),
                    onChanged: (String? value) =>
                        (value == null || value.isEmpty)
                            ? model.initializeSets()
                            : model.generateInputsForSets(int.parse(value)),
                    formColor: Theme.of(context).colorScheme.primaryContainer,
                    keyboardType: TextInputType.number,
                    textColor: Theme.of(context).colorScheme.background,
                    additionalTextColor:
                        Theme.of(context).colorScheme.background,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => FadeAnimation(
                    delay: 0.2 * index,
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        bottom: 15,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Set: ${model.getSets[index].setId + 1}",
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(
                                    fontSize: 18,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8,
                                  ),
                                  child: Text(
                                    'Weight',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .background,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 10,
                                  ),
                                  child: Text(
                                    'Reps',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .background,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.only(
                                    left: 15,
                                    right: 15,
                                    top: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: TextFormField(
                                    initialValue: model.getSets[index].weight !=
                                            0
                                        ? model.getSets[index].weight.toString()
                                        : null,
                                    onChanged: (value) =>
                                        model.fillInWeight(value, index),
                                    validator: (value) =>
                                        model.validateSets(value),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .background,
                                        ),
                                    decoration: InputDecoration(
                                      suffixIconConstraints:
                                          const BoxConstraints(maxHeight: 20),
                                      counter: const Offstage(),
                                      isDense: true,
                                      border: InputBorder.none,
                                      hintText: 'Weight',
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .background
                                                .withOpacity(0.4),
                                          ),
                                      suffixIcon: Text(
                                        'kg',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .background),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.only(
                                    left: 15,
                                    right: 15,
                                    top: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        initialValue:
                                            model.getSets[index].reps != 0
                                                ? model.getSets[index].reps
                                                    .toString()
                                                : null,
                                        onChanged: (value) =>
                                            model.fillInReps(value, index),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .background,
                                            ),
                                        decoration: InputDecoration(
                                          suffixIconConstraints:
                                              const BoxConstraints(
                                                  maxHeight: 20),
                                          counter: const Offstage(),
                                          isDense: true,
                                          border: InputBorder.none,
                                          hintText: 'Reps',
                                          hintStyle: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .background
                                                    .withOpacity(0.4),
                                              ),
                                        ),
                                        validator: (String? value) =>
                                            model.validateSets(value),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  itemCount: model.getSets.length,
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: MainButton(
                    text: 'Submit Sets',
                    onTap: () => model.addSets(),
                    busy: false,
                    color: Theme.of(context).colorScheme.secondary,
                    textColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
                _keyboard != 0
                    ? SizedBox(
                        height: _keyboard + 20,
                      )
                    : const SizedBox(
                        height: 20,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
