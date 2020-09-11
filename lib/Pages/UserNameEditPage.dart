import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Models/UserProvider.dart';

class UserNameEditPage extends StatefulWidget {
  

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    
    return _UserNameEditPageState();
  }

}

class _UserNameEditPageState extends State<UserNameEditPage> {
  
  String _name;

  void _nameOnChanged(String text) {

    setState(() {
      _name = text;
    });

  }


  void _updateUserName(BuildContext context, UserProvider user, String userName) async {

    if (userName != null) {
      
      try {
        
        await user.updateUserName(userName);

        _pop();

      } catch (e) {

        _showAlertDialog(context, e.toString());

      }

    }

  }

  void _pop() {

    Navigator.of(context).pop();

  }

  void _showAlertDialog(BuildContext context, String message) {
    // set up the buttons
    Widget confirmButton = FlatButton(
      child: Text("Confirm"),
      onPressed:  () {
            Navigator.of(context).pop(); // dismiss dialog
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Tips"),
      content: Text(message),
      actions: [
        confirmButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    
    return Consumer(
      
      builder: (BuildContext context, UserProvider user, Widget child) {

        return Scaffold(

          appBar: AppBar(

            title: Text("Edit User Name"),

          ),

          body: Column(

            children: [

              Container(

                margin: EdgeInsets.only(left: 24, top: 24, right: 24),

                height: 48.0,

                child: TextFormField(

                  decoration: InputDecoration (
                    
                    hintText: "User Name"
                    
                  ),

                  onChanged: _nameOnChanged,

                ),

              ),

              Container(

                margin: EdgeInsets.only(left: 24, top: 52),

                width: MediaQuery.of(context).size.width - 24 * 2,

                height: 48.0,

                child: FlatButton(
                
                  onPressed: () => _updateUserName(context, user, this._name), 
                  
                  child: Text("Confirm"),
                  
                  color: Colors.blue,

                ),
                
              ),

            ],

          ),

        );

      }
      
    );

  }

}