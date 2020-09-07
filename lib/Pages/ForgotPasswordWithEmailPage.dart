
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class ForgotPasswordWithEmailPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ForgotPasswordWithEmailPageState();
  }
}

class _ForgotPasswordWithEmailPageState extends State<ForgotPasswordWithEmailPage> {

  String _email;

  void _emailOnChanged(String text) {

    setState(() {
      this._email = text;
    });

  }

  void _sendEmail(BuildContext context) async {

    print("sendPasswordResetEmail");

    try {

      await _auth.sendPasswordResetEmail(email: this._email);

      _showAlertDialog(context, "Please check your email for the verification code.");

    } catch (error) {

      _showAlertDialog(context, error.toString());

    }

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

    return Scaffold(

      appBar: AppBar(

        title: Text("Forgot Password With Email"),

      ),

      body: Column(

        children: [

          Container(

            margin: EdgeInsets.only(left: 24, right: 24,top: 24),

            height: 48.0,

            child: TextFormField(

              decoration: InputDecoration (
                
                hintText: "email"
                
              ),

              onChanged: _emailOnChanged,

            ),

          ),

          Container(

            margin: EdgeInsets.only(left: 24, right: 24,top: 32),

            width: MediaQuery.of(context).size.width - 24 * 2,

            height: 48.0,

            child: FlatButton(
            
              onPressed: () => _sendEmail(context), 
              
              child: Text("Send Email"),
              
              color: Colors.blue,

            )

          )

        ],

      ),     
      
    );

  }

}