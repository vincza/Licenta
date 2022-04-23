import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';

import '/services/storage_service.dart';
import '/services/firebase_service.dart';
import '/models/user_model.dart';
import '/locator.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseService _firebaseService = locator<FirebaseService>();
  final StorageService _storageService = locator<StorageService>();
  UserModel? _currentUser;

  UserModel? get getCurrentUser => _currentUser;

  Future<bool> isUserLoggedIn() async {
    var user = _auth.currentUser;
    if (user != null) {
      _currentUser = await _firebaseService.getUserData(user.uid);
      if (_currentUser != null) {
        return true;
      }
      return false;
    }
    return false;
  }

  Future<bool> signIn(String email, String password) async {
    try {
      UserCredential user = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _currentUser = await _firebaseService.getUserData(user.user!.uid);
      return true;
    } on FirebaseAuthException catch (e) {
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> createUser(
    String email,
    String password,
    File? profileImage,
    String fullname,
    String gender,
  ) async {
    String? imageUrl;
    try {
      UserCredential credentials = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (profileImage != null) {
        imageUrl = await _storageService.uploadProfileImage(
          credentials.user!.uid,
          profileImage,
        );
        if (imageUrl == null) {
          return false;
        }
      }
      _currentUser = UserModel(
        email: email,
        name: fullname,
        uid: credentials.user!.uid,
        profileImageUrl: imageUrl,
        gender: gender,
      );
      bool result = await _firebaseService.createUser(_currentUser!);
      if (result) {
        return true;
      }
      return false;
    } on FirebaseAuthException catch (e) {
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> forgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    try {
      final userCredentials = EmailAuthProvider.credential(
        email: _auth.currentUser!.email!,
        password: currentPassword,
      );
      return await _auth.currentUser!
          .reauthenticateWithCredential(userCredentials)
          .then(
        (value) async {
          return await _auth.currentUser!
              .updatePassword(newPassword)
              .then((value) => true)
              .catchError(
            (e) {
              print(e);
              return false;
            },
          );
        },
      );
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      _currentUser = null;
    } catch (e) {
      print(e);
    }
  }
}
