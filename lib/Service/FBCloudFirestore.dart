import 'dart:io' show Platform;

import 'package:cloud_firestore/cloud_firestore.dart';

class FBCloudFirestore {

  FBCloudFirestore._privateConstructor();

  static final FBCloudFirestore _instance = FBCloudFirestore._privateConstructor();

  static FBCloudFirestore get instance => _instance;


  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ********************* lacunch ********************* //
  void addLaunchRecord() {

    CollectionReference launchs = _firestore.collection("launchs");

    int timestamp = DateTime.now().millisecondsSinceEpoch;

    String platform;

    if (Platform.isIOS) {

      platform = "iOS";

    } else{

      platform = "Android";

    }
    
    Map<String, dynamic> launchData = {"time": timestamp, "platform": platform};

    launchs.add(launchData);

  }

  void getLaunchRecord({Function callback(List<Map<String, dynamic>> datas)}) async {

    CollectionReference launchs = _firestore.collection("launchs");

    QuerySnapshot snapshot = await launchs.get();

    List<QueryDocumentSnapshot> docs = snapshot.docs;

    List<Map> datas = docs.map((e) => e.data()).toList();

    callback(datas);

  }


  void removeLaunchRecord() {

  }


  // ********************* user ********************* //

  Future<void> addUser(Map<String, dynamic> userInfo) async {

    CollectionReference users = _firestore.collection("users");

    return users.add(userInfo);

  }

}
