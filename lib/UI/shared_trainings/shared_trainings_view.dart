import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:licenta/UI/shared_trainings/shared_trainings_viewmodel.dart';
import 'package:licenta/widgets/custom_circular_progress_indicator.dart';
import 'package:stacked/stacked.dart';

class SharedTrainingsView extends StatelessWidget {
  const SharedTrainingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SharedWorkoutsViewmodel>.reactive(
      viewModelBuilder: () => SharedWorkoutsViewmodel(),
      onModelReady: (model) => model.getWorkouts(),
      builder: (context, model, child) => model.getFetchingForFirstTime
          ? const Center(
              child: CustomCircularProgressIndicator(
                size: 40,
                strokeWidth: 4,
              ),
            )
          : SizedBox(
              height: double.infinity,
              child: NotificationListener<ScrollEndNotification>(
                onNotification: (notification) {
                  if (notification.metrics.atEdge && !model.isBusy) {
                    model.getWorkouts();
                  }
                  return true;
                },
                child: ListView.builder(
                  key: const PageStorageKey('sharedWorkouts'),
                  itemBuilder: (context, index) {
                    if (index == model.getSharedWorkouts.length) {
                      if (model.isBusy) {
                        return const Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child: CustomCircularProgressIndicator(
                              size: 30,
                              strokeWidth: 4,
                            ),
                          ),
                        );
                      }
                      return const SizedBox();
                    }
                    return Container(
                      margin: EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: index == 0 ? 20 : 0,
                        bottom: 20,
                      ),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: 50,
                                width: 50,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(35),
                                  child: model.getSharedWorkouts[index]
                                              .profileImageUrl ==
                                          null
                                      ? SvgPicture.asset(
                                          'assets/profile_placeholder.svg',
                                          fit: BoxFit.cover,
                                        )
                                      : CachedNetworkImage(
                                          imageUrl: model
                                              .getSharedWorkouts[index]
                                              .profileImageUrl!,
                                          fit: BoxFit.cover,
                                          placeholder: (context, _) =>
                                              const CustomCircularProgressIndicator(
                                            size: 20,
                                            strokeWidth: 2,
                                          ),
                                        ),
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Text(
                                model.getSharedWorkouts[index].username,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
                                      fontSize: 16,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.all(16),
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              ),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                stops: const [0.2, 0.7],
                                colors: [
                                  Theme.of(context).colorScheme.secondary,
                                  Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withOpacity(0.7),
                                ],
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  model.getSharedWorkouts[index].workoutName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .copyWith(
                                        fontSize: 24,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Text(
                                  'Number of Exercises: ${model.getSharedWorkouts[index].exercises.length}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        fontSize: 15,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                Text(
                                  model.getSharedWorkouts[index]
                                      .workoutDescription,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        fontSize: 14,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () =>
                                        model.navigateToSharedWorkoutView(
                                      model.getSharedWorkouts[index].workoutId,
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        boxShadow: [
                                          BoxShadow(
                                            offset: const Offset(0, 0),
                                            blurRadius: 5,
                                            spreadRadius: 3,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary
                                                .withOpacity(0.6),
                                          ),
                                        ],
                                      ),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 25,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: model.getSharedWorkouts.length + 1,
                ),
              ),
            ),
    );
  }
}
