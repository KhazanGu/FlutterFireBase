import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:io';

import '../Service/FBAuthentication.dart';
import '../Service/FBStorage.dart';
import '../Service/KZSharedPreferences.dart';

class UserProvider with ChangeNotifier {

  String photoURL = "";

  String displayName = "-----";

  String phoneNumber = "--- ---- ----";

  String email = "------";

  bool isLogin = false;

  String uid;


  // Map<String, dynamic> toJson() {

  //   return {

  //     "photoURL": photoURL,

  //     "displayName": displayName,

  //     "phoneNumber": phoneNumber,

  //     "email": email,

  //     "login": isLogin,

  //     "uid": uid,
      
  //   };

  // }


  // void _fromJson(Map<String, dynamic> json) {
    
  //   photoURL = json["photoURL"];

  //   displayName = json["displayName"];

  //   phoneNumber = json["phoneNumber"];

  //   email = json["email"];
    
  //   isLogin = json["login"];
    
  //   uid = json["uid"];

  // }


  // UserProvider.fromJson(Map<String, dynamic> json)

  // :

  // photoURL = json["photoURL"],

  // displayName = json["displayName"],

  // phoneNumber = json["phoneNumber"],

  // email = json["email"],
  
  // isLogin = json["login"],
  
  // uid = json["uid"];


  // Future<Map<String, dynamic>> _read(String key) async {

  //   final prefs = await SharedPreferences.getInstance();

  //   return json.decode(prefs.getString(key));

  // }

  // void _save(String key, value) async {

  //   print("_save");

  //   try {
      
  //     final prefs = await SharedPreferences.getInstance();

  //     final bool status = await prefs.setString(key, json.encode(value));

  //     print("_save" + status.toString());

  //   } catch (e) {

  //     print("_save error" + e.toString());

  //   }    

  // }

  // void _remove(String key) async {

  //   final prefs = await SharedPreferences.getInstance();

  //   prefs.remove(key);

  // }


  void _updateWithUserInfo(Map<String, dynamic> userInfo) {

    print("updateWithUserInfo");

    photoURL = userInfo["photoURL"];

    displayName = userInfo["displayName"];

    phoneNumber = userInfo["phoneNumber"];

    email = userInfo["email"];

    uid = userInfo["uid"];

  }

  void _clearUserInfo() {

    isLogin = false;

    photoURL = "";
    
    displayName = "-----";

    phoneNumber = "--- ---- ----";

    email = "------";

    uid = null;

  }

  Future<bool> _sync() async {

    Map<String, dynamic> userInfo = {

      "photoURL": photoURL,

      "displayName": displayName,

      "phoneNumber": phoneNumber,

      "email": email,

      "login": isLogin,

      "uid": uid,
      
    };

    return KZSharedPreferences.instance.jsonSave("USER_INFO", userInfo);

  }

  void loadUserData() async {

    Map<String, dynamic> userInfo = await KZSharedPreferences.instance.jsonRead("USER_INFO");

    _updateWithUserInfo(userInfo);

  }

  
  Future<void> updateProfile({String displayName, String photoURL}) async {

    try {

      await FBAuthentication.instance.updateProfile(displayName: displayName, photoURL: photoURL);

      this.displayName = displayName;

      this.photoURL = photoURL;

      _sync();

      notifyListeners();

      return;

    } catch (e) {

      print("updateProfile failed:" + e.toString());

      throw e;

    }
    
  }

  void updateAvatar(File file) async {

    final String url = await FBStorage.instance.uploadImage(file, 'user', uid);

    if (url != null) {
      
      await updateProfile(displayName: this.displayName, photoURL:url);

    } else {

      print('updateProfile error');

    }

  }

  Future<void> signInWithUserInfo(Map<String, dynamic> userInfo) async {

    isLogin = true;

    _updateWithUserInfo(userInfo);

    await _sync();

    notifyListeners();

  }

  void signOut() async {

    KZSharedPreferences.instance.remove("USER_INFO");

    _clearUserInfo();

    notifyListeners();

  }

}