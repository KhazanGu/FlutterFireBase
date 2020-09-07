import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class UserProvider with ChangeNotifier {

  String avatar = "";

  String displayName = "----";

  String phoneNumber = "--- ---- ----";

  String email = "------";

  bool login = false;

  void updateWithUser(User user) {

    displayName = user.displayName;

    phoneNumber = user.phoneNumber;

    email = user.email;

  }

}