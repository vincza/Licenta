import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:licenta/locator.dart';
import 'package:licenta/services/location_service.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:map_launcher/map_launcher.dart' as launcher;
import '../constants/keys.dart';

import '../models/place_model.dart';

class PlacesService {
  final LocationService _locationService = locator<LocationService>();
  final String apiKey = keys['API_KEY'].toString();

  Future<Set<PlaceModel>> getNearbyGyms() async {
    LocationData currentLocation = await _locationService.getLocation();
    String url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${currentLocation.latitude},${currentLocation.longitude}&type=gym&radius=6000&key=$apiKey';
    try {
      var response = await http.get(Uri.parse(url));
      var placesList = jsonDecode(response.body)['results'] as List<dynamic>;
      return placesList
          .map(
            (e) => PlaceModel(
              coordinates: LatLng(
                e['geometry']['location']['lat'],
                e['geometry']['location']['lng'],
              ),
              name: e['name'],
              numberOfReviews: e['user_ratings_total'],
              rating: e['rating'],
            ),
          )
          .toSet();
    } catch (e) {
      return {};
    }
  }

  Future<void> openGymInGoogleMaps(double latitude, double longitude, String title) async {
    bool? result = await launcher.MapLauncher.isMapAvailable(launcher.MapType.google);
    if (result != null && result) {
      await launcher.MapLauncher.showMarker(
        mapType: launcher.MapType.google,
        coords: launcher.Coords(latitude, longitude),
        title: title,
      );
    }
  }
}
