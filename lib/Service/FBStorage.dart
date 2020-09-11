
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FBStorage {
  
  FBStorage._privateConstructor();

  static final FBStorage _instance = FBStorage._privateConstructor();

  static FBStorage get instance => _instance;


  FirebaseStorage _storage;
  

  Future<String> uploadImage(File image, String path, String name) async {

    final StorageReference storageReference = _storage.ref().child(path).child(name);

    final StorageUploadTask uploadTask = storageReference.putFile(image);

    await uploadTask.onComplete;

    final String url = await storageReference.getDownloadURL() as String;

    print("url" + url);

    return url;

  }


}