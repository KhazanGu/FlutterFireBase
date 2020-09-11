import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Models/UserProvider.dart';
import '../Service/FBAuthentication.dart';

class SignInWithEmailPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SignInWithEmailPageState();
  }
}


class _SignInWithEmailPageState extends State<SignInWithEmailPage> {

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

  void _signIn(BuildContext context, UserProvider userProvider) async {

    try {

      Map<String, dynamic> userInfo = await FBAuthentication.instance.signInWithEmailAndPassword(this._email, this._password);

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

            title: Text("Sign In"),
            
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
                
                  onPressed: () => _signIn(context, user), 
                  
                  child: Text("Sign In"),
                  
                  color: Colors.blue,

                )
                
              ),

            ],

          ),  

        );

      }
      
    );
    
  }

}