import 'package:get_it/get_it.dart';
import 'package:licenta/services/location_service.dart';
import 'package:licenta/services/places_service.dart';
import 'package:licenta/services/shared_workouts_service.dart';
import 'package:stacked_services/stacked_services.dart';

//Services
import '/services/session_service.dart';
import '/services/authentication_service.dart';
import '/services/firebase_service.dart';
import '/services/media_service.dart';
import '/services/storage_service.dart';
import '/services/workouts_service.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => FirebaseService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => MediaService());
  locator.registerLazySingleton(() => StorageService());
  locator.registerLazySingleton(() => WorkoutsService());
  locator.registerLazySingleton(() => SessionService());
  locator.registerLazySingleton(() => SharedWorkoutsService());
  locator.registerLazySingleton(() => LocationService());
  locator.registerLazySingleton(() => PlacesService());
}
