import 'dart:io' show Platform;

import 'package:cloud_firestore/cloud_firestore.dart';

class FBCloudFirestore {

  FirebaseFirestore _firestore = FirebaseFirestore.instance;


  static FBCloudFirestore get instance {

    return FBCloudFirestore();

  }

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

  void datas(List<Map> datas) {

  }

  void getLaunchRecord({Function callback(List<Map> datas)}) async {

    CollectionReference launchs = _firestore.collection("launchs");

    QuerySnapshot snapshot = await launchs.get();

    List<QueryDocumentSnapshot> docs = snapshot.docs;

    List<Map> datas = docs.map((e) => e.data()).toList();

    callback(datas);

  }


  void removeLaunchRecord() {

  }



}
