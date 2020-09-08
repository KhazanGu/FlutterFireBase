import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class UserProvider with ChangeNotifier {

  String photoURL = "";

  String displayName = "-----";

  String phoneNumber = "--- ---- ----";

  String email = "------";

  bool login = false;

  User user;

  void updateWithUser(User newUser) {

    user = newUser;

    login = true;

    displayName = newUser.displayName != null ?  newUser.displayName : "-----";

    phoneNumber = newUser.phoneNumber != null ? newUser.phoneNumber : "--- ---- ----";

    email = newUser.email != null ? newUser.email : "------";

    notifyListeners();

  }

  Future<void> updateProfile({String displayName, String photoURL}) async {

    try {
      
      await user.updateProfile(displayName: displayName, photoURL: photoURL);

      this.displayName = displayName;

      this.photoURL = photoURL;

      return;

    } catch (e) {

      throw e;

    }
    
  }

}