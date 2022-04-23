import 'dart:io';

import 'package:licenta/models/user_model.dart';
import 'package:licenta/services/firebase_service.dart';
import 'package:licenta/services/media_service.dart';
import 'package:licenta/services/shared_workouts_service.dart';
import 'package:licenta/services/storage_service.dart';
import 'package:licenta/services/workouts_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '/services/authentication_service.dart';
import '/router/app.router.dart';
import '/locator.dart';

class HomeViewmodel extends BaseViewModel {
  int _index = 0;
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final SharedWorkoutsService _sharedWorkoutsService =
      locator<SharedWorkoutsService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final MediaService _mediaService = locator<MediaService>();
  final StorageService _storageService = locator<StorageService>();
  final FirebaseService _firebaseService = locator<FirebaseService>();
  final WorkoutsService _workoutsService = locator<WorkoutsService>();
  File? _updatedImage;

  UserModel? get getUser => _authenticationService.getCurrentUser;
  File? get getUpdatedImage => _updatedImage;
  int get getBottomNavigationBarIndex => _index;

  Future<void> initializeData(int index) async {
    await _workoutsService.getWorkoutsFromDataBase();
    _index = index;
    notifyListeners();
  }

  void setBottomNavigationBarIndex(int value) {
    _index = value;
    notifyListeners();
  }

  Future<void> changeProfilePicture() async {
    File? image = await _mediaService.pickImage();
    setBusy(true);
    if (image != null) {
      _updatedImage = image;
      String? downloadUrl = await _storageService.uploadProfileImage(
        _authenticationService.getCurrentUser!.uid,
        image,
      );
      if (downloadUrl != null) {
        _authenticationService.getCurrentUser!.setProfileImageUrl = downloadUrl;
        bool result = await _firebaseService.updateProfileImageUrl(
          _authenticationService.getCurrentUser!.uid,
          downloadUrl,
        );
        if (!result) {
          //TODO:Pop-up with something went wrong
        }
      }
    }
    setBusy(false);
  }

  Future<void> updateName() async {}

  Future<void> signOut() async {
    await _authenticationService.signOut();
    _workoutsService.clearWorkouts();
    _sharedWorkoutsService.discardSharedWorkouts();
    _firebaseService.setLastDocument = null;
    _navigationService.clearStackAndShow(Routes.signInView);
  }
}
