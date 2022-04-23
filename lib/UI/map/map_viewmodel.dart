import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:licenta/models/place_model.dart';
import 'package:licenta/services/location_service.dart';
import 'package:licenta/services/places_service.dart';
import 'package:location/location.dart';
import 'package:stacked/stacked.dart';

import '../../locator.dart';

class MapViewmodel extends BaseViewModel {
  final LocationService _locationService = locator<LocationService>();
  final PlacesService _placesService = locator<PlacesService>();
  late GoogleMapController _googleMapController;
  late bool _locationStatus;
  late CameraPosition _cameraPosition;
  late Set<Marker> _gymLocations;
  late Set<PlaceModel> _places;
  bool _showInformationToolbar = false;
  double? _latitude;
  double? _longitude;
  String? _title;

  num? _rating;
  int? _numberOfReviews;

  //Getters
  bool get getLocationStatus => _locationStatus;
  CameraPosition get getCurrentPosition => _cameraPosition;
  Set<Marker> get getGymMarkers => _gymLocations;
  String get getTitle => _title!;
  GoogleMapController get getMapController => _googleMapController;

  num? get getGymRating => _rating;
  int? get getGymNumberOfReviews => _numberOfReviews;

  bool get showInformationToolbar => _showInformationToolbar;

  Future<void> initializeMap() async {
    setBusy(true);
    _locationStatus = await _locationService.getPermissionStatus();
    if (!_locationStatus) {
      setBusy(false);
      return;
    }
    LocationData myLocation = await _locationService.getLocation();
    _cameraPosition = CameraPosition(
      target: LatLng(myLocation.latitude!, myLocation.longitude!),
      zoom: 13,
    );
    _places = await _placesService.getNearbyGyms();
    _gymLocations = _places
        .map(
          (e) => Marker(
            markerId: MarkerId(e.name),
            position: e.coordinates,
            onTap: () async {
              _latitude = e.coordinates.latitude;
              _longitude = e.coordinates.longitude;
              _showInformationToolbar = true;
              _title = e.name;
              _numberOfReviews = e.numberOfReviews;
              _rating = e.rating;
              print(_rating);
              await _googleMapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target:
                        LatLng(e.coordinates.latitude, e.coordinates.longitude),
                    zoom: 16,
                  ),
                ),
              );
              notifyListeners();
            },
          ),
        )
        .toSet();

    setBusy(false);
  }

  void onMapCreated(GoogleMapController controller) async {
    _googleMapController = controller;
    notifyListeners();
  }

  Future<void> onMapTap(LatLng coordinates) async {
    await _googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: coordinates, zoom: 14),
      ),
    );
    _showInformationToolbar = false;
    _latitude = null;
    _longitude = null;
    _title = null;

    _numberOfReviews = null;
    _rating = null;
    notifyListeners();
  }

  Future<void> openGymInGoogleMaps() async {
    await _placesService.openGymInGoogleMaps(_latitude!, _longitude!, _title!);
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }
}
