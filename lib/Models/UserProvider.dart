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


  void _updateWithUserInfo(Map<String, dynamic> userInfo) {

    print("updateWithUserInfo");

    isLogin = true;

    photoURL = userInfo["photoURL"] != null ? userInfo["photoURL"] : "";

    displayName = userInfo["displayName"] != null ? userInfo["displayName"] : "-----";

    phoneNumber = userInfo["phoneNumber"] != null ? userInfo["phoneNumber"] : "--- ---- ----";

    email = userInfo["email"] != null ? userInfo["email"] : "------";

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

  
  Future<void> _updateProfile({String displayName, String photoURL}) async {

    print('updateProfile');

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
      
      await _updateProfile(displayName: this.displayName, photoURL:url);

    } else {

      print('updateProfile error');

    }

  }

  Future<void> updateUserName(String userName) async {

    return _updateProfile(displayName: userName, photoURL:this.photoURL);

  }

  void signInWithUserInfo(Map<String, dynamic> userInfo) async {

    _updateWithUserInfo(userInfo);

    await _sync();

    notifyListeners();

  }


  Future<void> signOut() async {

    await FBAuthentication.instance.signOut();

    await KZSharedPreferences.instance.remove("USER_INFO");

    _clearUserInfo();

    notifyListeners();

  }

}