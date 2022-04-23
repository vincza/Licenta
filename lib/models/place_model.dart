import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
  LatLng coordinates;
  String name;
  num? rating;
  int? numberOfReviews;

  PlaceModel(
      {required this.coordinates,
      required this.name,
      required this.numberOfReviews,
      required this.rating});
}
