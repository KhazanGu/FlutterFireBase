
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Models/UserProvider.dart';
import '../Service/FBAuthentication.dart';
import '../Service/FBCloudFirestore.dart';

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


  void _signup(BuildContext context, UserProvider userProvider) async {

    try {

      final Map<String, dynamic> userInfo = await FBAuthentication.instance.creatUserWithEmail(this._email, this._password);

      await FBCloudFirestore.instance.addUser(userInfo);

      userProvider.signInWithUserInfo(userInfo);

      _popToRoot(context);

    } catch (error) {
      
      _showAlertDialog(context, error.toString());

    }

  }

  void _popToRoot(BuildContext context) {

    Navigator.of(context).popUntil((route) => route.isFirst);

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

    return Consumer<UserProvider>(
      
      builder: (context, user, child) {

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
                
                  onPressed: () => _signup(context, user), 
                  
                  child: Text("Sign Up"),
                  
                  color: Colors.blue,

                )

              )

            ],

          ),     
          
        );

      }
      
    );

  }

}