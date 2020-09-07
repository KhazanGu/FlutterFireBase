import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MessagePageState();
  }
}


class _MessagePageState extends State<MessagePage> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      appBar: AppBar(),

      body: Text("Message"),

    );

  }

}