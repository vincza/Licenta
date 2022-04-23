import 'package:flutter/material.dart';
import 'package:licenta/widgets/buttons/main_button.dart';
import 'package:licenta/widgets/input_textfield.dart';
import 'package:stacked/stacked.dart';

import '../create_session_viewmodel.dart';

class SessionResultView extends ViewModelWidget<CreateSessionViewmodel> {
  const SessionResultView({Key? key}) : super(key: key, reactive: true);

  @override
  Widget build(BuildContext context, CreateSessionViewmodel viewModel) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            'Session Overview',
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
            'How was the session ?',
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => viewModel.setSessionFell = 'Bad',
                child: AnimatedContainer(
                  height: viewModel.getSessionFell == 'Bad' ? 150 : 100,
                  width: viewModel.getSessionFell == 'Bad' ? 150 : 100,
                  curve: Curves.decelerate,
                  alignment: Alignment.center,
                  duration: const Duration(milliseconds: 150),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: viewModel.getSessionFell == 'Bad'
                        ? Colors.red
                        : Colors.red.withOpacity(0.2),
                    boxShadow: viewModel.getSessionFell == 'Bad'
                        ? [
                            BoxShadow(
                              color: Colors.red.withOpacity(0.9),
                              blurRadius: 7,
                              spreadRadius: 8,
                            )
                          ]
                        : null,
                  ),
                  child: Text(
                    'Bad',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: 16,
                          color: viewModel.getSessionFell == 'Bad'
                              ? const Color.fromARGB(255, 204, 0, 0)
                              : Theme.of(context)
                                  .colorScheme
                                  .background
                                  .withOpacity(0.4),
                          fontWeight: viewModel.getSessionFell == 'Bad'
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                  ),
                ),
              ),
              const SizedBox(
                width: 40,
              ),
              GestureDetector(
                onTap: () => viewModel.setSessionFell = 'Average',
                child: AnimatedContainer(
                  curve: Curves.decelerate,
                  height: viewModel.getSessionFell == 'Average' ? 150 : 100,
                  width: viewModel.getSessionFell == 'Average' ? 150 : 100,
                  alignment: Alignment.center,
                  duration: const Duration(milliseconds: 150),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: viewModel.getSessionFell == 'Average'
                        ? Colors.yellow[600]
                        : Colors.yellow[600]!.withOpacity(0.2),
                    boxShadow: viewModel.getSessionFell == 'Average'
                        ? [
                            BoxShadow(
                              color: Colors.yellow[600]!.withOpacity(0.9),
                              blurRadius: 7,
                              spreadRadius: 8,
                            )
                          ]
                        : null,
                  ),
                  child: Text(
                    'Average',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: 16,
                          color: viewModel.getSessionFell == 'Average'
                              ? Colors.yellowAccent
                              : Theme.of(context)
                                  .colorScheme
                                  .background
                                  .withOpacity(0.4),
                          fontWeight: viewModel.getSessionFell == 'Average'
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () => viewModel.setSessionFell = 'Good',
            child: AnimatedContainer(
              curve: Curves.decelerate,
              height: viewModel.getSessionFell == 'Good' ? 150 : 100,
              width: viewModel.getSessionFell == 'Good' ? 150 : 100,
              alignment: Alignment.center,
              duration: const Duration(milliseconds: 150),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: viewModel.getSessionFell == 'Good'
                      ? Colors.green
                      : Colors.green.withOpacity(0.2),
                  boxShadow: viewModel.getSessionFell == 'Good'
                      ? [
                          BoxShadow(
                            color: Colors.green.withOpacity(0.9),
                            blurRadius: 7,
                            spreadRadius: 8,
                          )
                        ]
                      : null),
              child: Text(
                'Good',
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: 16,
                      color: viewModel.getSessionFell == 'Good'
                          ? Colors.greenAccent
                          : Theme.of(context).primaryColor.withOpacity(0.4),
                      fontWeight: viewModel.getSessionFell == 'Good'
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Add Notes',
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: 14,
                    ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () => showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (ctx) {
                  final double _keyboard = MediaQuery.of(ctx).viewInsets.bottom;
                  return SizedBox(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 20, left: 20, top: 35),
                          child: Text(
                            'Add notes',
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
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
                            controller: viewModel.getNotesController,
                            maxLength: 300,
                            obscureText: false,
                            maxLines: 5,
                            additionalText: 'Notes',
                            hint: 'Notes',
                            initialValue: null,
                            validator: null,
                            onChanged: null,
                            formColor:
                                Theme.of(context).colorScheme.primaryContainer,
                            keyboardType: TextInputType.multiline,
                            textColor: Theme.of(context).colorScheme.background,
                            additionalTextColor:
                                Theme.of(context).colorScheme.background,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: MainButton(
                            text: viewModel.getNotesController.text.isEmpty
                                ? 'Add notes'
                                : 'Edit notes',
                            onTap: () => Navigator.of(context).pop(),
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
                  );
                }).whenComplete(
              () => viewModel.notifyListeners(),
            ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                viewModel.getNotesController.text.isEmpty
                    ? 'Add notes (Optional)'
                    : viewModel.getNotesController.text,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 14,
                    ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
