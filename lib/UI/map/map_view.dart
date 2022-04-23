import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:licenta/UI/map/map_viewmodel.dart';
import 'package:licenta/widgets/buttons/main_button.dart';
import 'package:licenta/widgets/custom_circular_progress_indicator.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MapView extends StatelessWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ViewModelBuilder<MapViewmodel>.reactive(
        onModelReady: (model) => model.initializeMap(),
        viewModelBuilder: () => MapViewmodel(),
        builder: (context, model, child) => model.isBusy
            ? const Center(
                child: CustomCircularProgressIndicator(
                  size: 50,
                  strokeWidth: 4,
                ),
              )
            : !model.getLocationStatus
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'You must have the location enabled, and allow the app to use it',
                          style:
                              Theme.of(context).textTheme.headline1!.copyWith(
                                    fontSize: 18,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        MainButton(
                          text: 'Request Access',
                          onTap: () => model.initializeMap(),
                          busy: model.isBusy,
                          color: Theme.of(context).colorScheme.secondary,
                          textColor: Theme.of(context).colorScheme.primary,
                        )
                      ],
                    ),
                  )
                : Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: GoogleMap(
                          onMapCreated: (controller) =>
                              model.onMapCreated(controller),
                          mapType: MapType.normal,
                          initialCameraPosition: model.getCurrentPosition,
                          myLocationEnabled: true,
                          markers: model.getGymMarkers,
                          mapToolbarEnabled: false,
                          onTap: (coordinates) => model.onMapTap(coordinates),
                        ),
                      ),
                      AnimatedContainer(
                        padding: model.showInformationToolbar
                            ? const EdgeInsets.all(20)
                            : null,
                        duration: const Duration(
                          milliseconds: 1000,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        child: model.showInformationToolbar
                            ? Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 65,
                                    width: 65,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer,
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: Icon(
                                      Icons.fitness_center,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          model.getTitle,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1!
                                              .copyWith(
                                                fontSize: 15,
                                              ),
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        model.getGymRating != null
                                            ? RatingBar(
                                                itemSize: 18,
                                                onRatingUpdate: (value) => {},
                                                ratingWidget: RatingWidget(
                                                  empty: Icon(
                                                    Icons.star_border,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .secondary,
                                                    size: 16,
                                                  ),
                                                  half: Icon(
                                                    Icons.star_half,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .secondary,
                                                    size: 16,
                                                  ),
                                                  full: Icon(
                                                    Icons.star,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .secondary,
                                                    size: 16,
                                                  ),
                                                ),
                                                initialRating: model
                                                    .getGymRating!
                                                    .toDouble(),
                                              )
                                            : Text(
                                                'Rating Not Available',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline1!
                                                    .copyWith(
                                                      fontSize: 13,
                                                    ),
                                              ),
                                        model.getGymNumberOfReviews != null
                                            ? Text(
                                                '(${model.getGymNumberOfReviews})',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline1!
                                                    .copyWith(
                                                      fontSize: 16,
                                                    ),
                                              )
                                            : const SizedBox()
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  GestureDetector(
                                    onTap: () => model.openGymInGoogleMaps(),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 5,
                                        horizontal: 14,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                      child: Text(
                                        'Directions',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1!
                                            .copyWith(
                                              fontSize: 16,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                            ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : const SizedBox(),
                      )
                    ],
                  ),
      ),
    );
  }
}
