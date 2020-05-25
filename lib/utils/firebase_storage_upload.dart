import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

Future<String> uploadProfilePicture(File file, String email) async {
  String name = email.substring(0, email.indexOf('@'));
  String filePath = 'profile_pictures/${name}_${DateTime.now()}.png';
  final StorageReference _storageReference =
      FirebaseStorage(storageBucket: 'gs://health-booklet.appspot.com')
          .ref()
          .child(filePath);

  StorageUploadTask uploadTask = _storageReference.putFile(file);
  await uploadTask.onComplete;

  final String url = await _storageReference.getDownloadURL();
  if (uploadTask.isComplete) {
    return url.toString();
  }
  return 'Upload Profile Picture Failed';
}
