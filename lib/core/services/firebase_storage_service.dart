import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:twitter/core/services/storage_base.dart';

class FirebaseStorageService implements StorageBase {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
 Reference? _storageReference;

  @override
  Future<String> uploadFile(
      String userID, String fileType, File yuklenecekDosya) async {
    _storageReference = _firebaseStorage.ref().child(userID).child(fileType).child('profile_picture.png');
    var uploadTask = _storageReference!.putFile(yuklenecekDosya);
    var snapshot = await uploadTask;
    var url = await (await uploadTask).ref.getDownloadURL();
    return url;
  }
}
