import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Uploads a profile image and returns its download URL
  Future<String> uploadProfileImage(File file, String uid) async {
    final ref = _storage.ref().child('profile_images/$uid.jpg');
    await ref.putFile(file);
    return await ref.getDownloadURL();
  }
}
