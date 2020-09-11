import 'package:flutter/material.dart';

import '../Service/FBCloudFirestore.dart';
import '../Components/TitleContentItem.dart';

class HomePage extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePageState();
  }
}


class _HomePageState extends State<HomePage> {

  List<Map> _records = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FBCloudFirestore.instance.getLaunchRecord(
      
      callback: (List<Map<String, dynamic>> data) {

        setState(() {

          _records = data;

        });

      }

    );

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      appBar: AppBar(

        title: Text("Launch records"),

      ),

      body: ListView(

        children: _records.map((e) => TitleContentItem(title: DateTime.fromMillisecondsSinceEpoch(e["time"]).toString(), content: e["platform"],)).toList()

      ),

    );

  }

}