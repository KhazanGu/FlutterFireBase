
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Service/FBAuthentication.dart';
import '../Models/UserProvider.dart';


class SignInWithPhonePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SignInWithPhonePageState();
  }
}

class _SignInWithPhonePageState extends State<SignInWithPhonePage> {

  String _phoneNumber;

  String _code;

  void _phoneNumberOnChanged(String text) {

    setState(() {
      this._phoneNumber = text;
    });

  }

  void _codeOnChanged(String text) {

    setState(() {
      this._code = text;
    });

  }

  void _getSMSCode(BuildContext context) {

    FBAuthentication.instance.getSMSCode(
      
      phoneNumber: this._phoneNumber,
      
      succeed: () => null,

      failed: (error) {

        _showAlertDialog(context, error);

      }

    );

  }

  void _signIn(BuildContext context, UserProvider user) async {

    try {

      Map<String, dynamic> userInfo = await FBAuthentication.instance.signInWithSMSCode(code: this._code);

      await user.signInWithUserInfo(userInfo);

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

    return Consumer<UserProvider> (

      builder: (BuildContext context, UserProvider user, Widget child) {

        return     Scaffold(

          appBar: AppBar(

            title: Text("Sign in with Phone"),

          ),

          body: Column(

            children: [

              Container(

                margin: EdgeInsets.only(left: 24, right: 24,top: 24),

                height: 48.0,

                child: TextFormField(

                  decoration: InputDecoration (
                    
                    hintText: "+1 650-555-1234"
                    
                  ),

                  onChanged: _phoneNumberOnChanged,

                ),

              ),

              Row(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [

                  Container(

                    margin: EdgeInsets.only(left: 24, top: 12),

                    width: (MediaQuery.of(context).size.width - 24 * 2) / 3 * 2,

                    height: 48.0,

                    child: TextFormField(

                      decoration: InputDecoration (
                        
                        hintText: "SMS Code"
                        
                      ),

                      onChanged: _codeOnChanged,

                    ),

                  ),

                  Container(
                    
                    margin: EdgeInsets.only(right: 24, top: 12),

                    width: 110,

                    height: 48.0,

                    child: FlatButton(
                
                      onPressed: () => _getSMSCode(context), 
                      
                      child: Text("SMS Code"),
                      
                      color: Colors.blue,

                    ),

                  ),

                ],

              ),

              Container(

                margin: EdgeInsets.only(left: 24, right: 24,top: 32),

                width: MediaQuery.of(context).size.width - 24 * 2,

                height: 48.0,

                child: FlatButton(
                
                  onPressed: () => _signIn(context, user), 
                  
                  child: Text("Sign Up"),
                  
                  color: Colors.blue,

                )

              )

            ],

          ),     
          
        );

      },

    );

  }

}