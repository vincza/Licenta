import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String?> uploadProfileImage(String uid, File profileImage) async {
    final String storagePath = '/users/$uid/profileImage/profileImage.png';
    Reference _storageReference = _firebaseStorage.ref(storagePath);
    try {
      UploadTask task = _storageReference.putFile(profileImage);
      TaskSnapshot snapshot = await task.whenComplete(() {});
      if (snapshot.state == TaskState.success) {
        return await snapshot.ref.getDownloadURL();
      }
      return null;
    } on FirebaseException catch (e) {
      print(e.code);
      return null;
    } catch (e) {
      return null;
    }
  }
}
