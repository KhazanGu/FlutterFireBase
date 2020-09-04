
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SignUpWithEmailPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SignUpWithEmailPageState();
  }
}

class _SignUpWithEmailPageState extends State<SignUpWithEmailPage> {

  String _email;

  String _password;


  void _query() async {

      CollectionReference users = FirebaseFirestore.instance.collection("users");

      QuerySnapshot query = await users.get();

      List<QueryDocumentSnapshot> docs = query.docs;

      print("docs:$docs");

      docs.forEach((element) {
        
        print("element_id:" + element.id);

        print("element_data:" + element.data().toString());

      });
      
  }

  void _emailOnChanged(String text) {

    setState(() {
      this._email = text;
    });

  }

  void _passwordOnChanged(String text) {
    
    setState(() {
      this._password = text;
    });

  }

  void _popPage(BuildContext context) {

    Navigator.of(context).pop();

  }

  void _signup(BuildContext context) async {

    try {

      final UserCredential credential = await _auth.createUserWithEmailAndPassword(email: this._email, password: _password);

      final User user = credential.user;

      _addUserInDataBase(context, user);

    } on FirebaseAuthException catch (exception) {

      print("exception:$exception");

      _showAlertDialog(context, exception.message);

    } catch (error) {
      
      _showAlertDialog(context, error.toString());

    }

  }

  void _addUserInDataBase(BuildContext context, User user) async {

    if (user != null) {

      Map<String, dynamic> userInfo = {
        "email":user.email,
        "uid": user.uid,
      };

      print("user: $userInfo");

      CollectionReference users = FirebaseFirestore.instance.collection("users");

      users
      .add(userInfo)
      .then((value) => _popPage(context))
      .catchError((error) => print("error: $error"));

    } else {

      _showAlertDialog(context, "add to database failed");

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

        title: Text("Sign up with email"),

      ),

      body: Column(

        children: [

          Container(

            margin: EdgeInsets.only(left: 24, top: 24, right: 24),

            height: 48.0,

            child: TextFormField(

              decoration: InputDecoration (
                
                hintText: "email"
                
              ),

              onChanged: _emailOnChanged,

            ),

          ),

          Container(

            margin: EdgeInsets.only(left: 24, top: 12, right: 24),

            height: 48.0,

            child: TextFormField(

              decoration: InputDecoration (
                
                hintText: "password"
                
              ),

              onChanged: _passwordOnChanged,

            ),

          ),

          Container(

            margin: EdgeInsets.only(left: 24, top: 32, right: 24),

            width: MediaQuery.of(context).size.width - 24 * 2,

            height: 48.0,

            child: FlatButton(
            
              onPressed: () => _signup(context), 
              
              child: Text("Sign Up"),
              
              color: Colors.blue,

            )

          )

        ],

      ),     
      
    );

  }

}