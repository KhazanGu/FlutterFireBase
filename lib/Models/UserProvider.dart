import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {

  String photoURL = "";

  String displayName = "-----";

  String phoneNumber = "--- ---- ----";

  String email = "------";

  bool login = false;

  String uid;

  User user;

  FirebaseStorage storage;


  UserProvider(
    {
      this.storage,
    }
  );


  Map<String, dynamic> toJson() {

    return {

      "photoURL": photoURL,

      "displayName": displayName,

      "phoneNumber": phoneNumber,

      "email": email,

      "login": login,

      "uid": uid,
      
    };

  }


  void _fromJson(Map<String, dynamic> json) {
    
    photoURL = json["photoURL"];

    displayName = json["displayName"];

    phoneNumber = json["phoneNumber"];

    email = json["email"];
    
    login = json["login"];
    
    uid = json["uid"];

  }


  UserProvider.fromJson(Map<String, dynamic> json)

  :

  photoURL = json["photoURL"],

  displayName = json["displayName"],

  phoneNumber = json["phoneNumber"],

  email = json["email"],
  
  login = json["login"],
  
  uid = json["uid"];


  Future<Map<String, dynamic>> _read(String key) async {

    final prefs = await SharedPreferences.getInstance();

    return json.decode(prefs.getString(key));

  }

  void _save(String key, value) async {

    print("_save");

    try {
      
      final prefs = await SharedPreferences.getInstance();

      final bool status = await prefs.setString(key, json.encode(value));

      print("_save" + status.toString());

    } catch (e) {

      print("_save error" + e.toString());

    }    

  }

  void _remove(String key) async {

    final prefs = await SharedPreferences.getInstance();

    prefs.remove(key);

  }


  void loadUserData() async {

    Map<String, dynamic> info = await _read("USER_INFO");
    
    _fromJson(info);

  }


  void updateWithUser(User newUser) {

    print("updateWithUser");

    user = newUser;

    login = true;

    photoURL = newUser.photoURL != null ?  newUser.photoURL : "";

    displayName = newUser.displayName != null ?  newUser.displayName : "-----";

    phoneNumber = newUser.phoneNumber != null ? newUser.phoneNumber : "--- ---- ----";

    email = newUser.email != null ? newUser.email : "------";

    uid = newUser.uid;

    _save("USER_INFO", this.toJson());

    notifyListeners();

  }


  void updateStorage(File file) async {

    final StorageReference storageReference = storage.ref().child('user').child(user.uid);

    final StorageUploadTask uploadTask = storageReference.putFile(file);

    StorageTaskSnapshot snapshot = await uploadTask.onComplete;

    var url = await storageReference.getDownloadURL() as String;

    print("snapshot" + url);

    try {
      
      await updateProfile(displayName: this.displayName, photoURL:url);

    } catch (e) {

      print('updateProfile error' + e.toString());

    }

  }

  Future<void> updateProfile({String displayName, String photoURL}) async {

    try {
      
      await user.updateProfile(displayName: displayName, photoURL: photoURL);

      this.displayName = displayName;

      this.photoURL = photoURL;

      _save("USER_INFO", this.user);

      notifyListeners();

      return;

    } catch (e) {

      print("updateProfile failed:" + e.toString());

      throw e;

    }
    
  }

}