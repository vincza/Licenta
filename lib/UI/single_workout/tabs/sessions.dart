import 'package:flutter/material.dart';
import 'package:licenta/UI/single_workout/tabs/sessions_viewmodel.dart';
import 'package:licenta/widgets/custom_circular_progress_indicator.dart';
import 'package:stacked/stacked.dart';

class SessionsView extends StatelessWidget {
  final String workoutId;
  const SessionsView({Key? key, required this.workoutId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SessionsViewmodel>.reactive(
      onModelReady: (model) => model.initializeSessions(),
      viewModelBuilder: () => SessionsViewmodel(workoutId: workoutId),
      builder: (context, model, child) => model.isBusy
          ? const Center(
              child: CustomCircularProgressIndicator(size: 60, strokeWidth: 4),
            )
          : model.getSessions.isEmpty
              ? Center(
                  child: Text(
                    'No Sessions Created Yet',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                )
              : ListView.builder(
                  itemBuilder: (context, index) => Container(
                    margin: EdgeInsets.only(
                      right: 20,
                      left: 20,
                      bottom: model.getSessions.length - 1 == index ? 100 : 20,
                    ),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                      color: Theme.of(context).colorScheme.primaryContainer,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Session ${model.getSessions.length - index}',
                          style:
                              Theme.of(context).textTheme.headline1!.copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                        Text(
                          'Session Date: ${model.getDate(index)} ',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 14,
                                  ),
                        ),
                        Text(
                          'Duration: ${model.getSessions[index].duration}',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 14,
                                  ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Session Status: ',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontSize: 14,
                                    ),
                            children: [
                              TextSpan(
                                text: model.getSessions[index].workoutFeel,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontSize: 14,
                                      color: returnStatusColor(
                                        model.getSessions[index].workoutFeel,
                                      ),
                                      fontWeight: FontWeight.bold,
                                    ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () => model.deleteSession(
                                  model.getSessions[index].sessionId),
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  boxShadow: [
                                    BoxShadow(
                                      offset: const Offset(0, 2),
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
                                  Icons.delete_outline,
                                  size: 25,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            GestureDetector(
                              onTap: () => model.navigateToSingleSessionView(
                                model.getSessions[index].sessionId,
                                model.getSessions.length - index,
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  boxShadow: [
                                    BoxShadow(
                                      offset: const Offset(0, 2),
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
                                  Icons.arrow_forward_ios_sharp,
                                  size: 25,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  itemCount: model.getSessions.length,
                ),
    );
  }

  Color? returnStatusColor(String status) {
    switch (status) {
      case 'Good':
        return Colors.green;
      case 'Average':
        return Colors.yellow[700];
      case 'Bad':
        return Colors.red;
      default:
        return Colors.black;
    }
  }
}
