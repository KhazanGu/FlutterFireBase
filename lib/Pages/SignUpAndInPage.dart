import 'package:flutter/material.dart';

import 'SignUpWithEmailPage.dart';
import 'SignInWithEmailPage.dart';
import 'ForgotPasswordWithEmailPage.dart';
import 'SignInWithPhonePage.dart';

class SignUpAndInPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    
    return _SignUpAndInPageState();
  }

}

class _SignUpAndInPageState extends State<SignUpAndInPage> {

  void _pushPage(BuildContext context, Widget page) {

    Navigator.of(context).push(

      MaterialPageRoute<void>(builder: (_) => page),

    );

  }
  
    @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(

      body: Column(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: <Widget>[

          Container(

            margin: EdgeInsets.only(left: 24, top: 120),

            width: MediaQuery.of(context).size.width - 24 * 2,

            height: 48.0,

            child: FlatButton(
            
              onPressed: ()=> _pushPage(context, SignUpWithEmailPage()), 
              
              child: Text("Sign up with Email"),
              
              color: Colors.blue,

            ),

          ),

          Container(

            margin: EdgeInsets.only(left: 24, top: 12),

            width: MediaQuery.of(context).size.width - 24 * 2,

            height: 48.0,

            child: FlatButton(
            
              onPressed: ()=> _pushPage(context, SignInWithEmailPage()), 
              
              child: Text("Sign in with Email"),
              
              color: Colors.blue,

            ),
            
          ),

          Container(

            margin: EdgeInsets.only(left: 24, top: 12),

            width: MediaQuery.of(context).size.width - 24 * 2,

            height: 48.0,

            child: FlatButton(
            
              onPressed: ()=> _pushPage(context, ForgotPasswordWithEmailPage()), 
              
              child: Text("Forgot Password With Email"),
              
              color: Colors.blue,

            ),
            
          ),

          Container(

            margin: EdgeInsets.only(left: 24, top: 52),

            width: MediaQuery.of(context).size.width - 24 * 2,

            height: 48.0,

            child: FlatButton(
            
              onPressed: ()=> _pushPage(context, SignInWithPhonePage()), 
              
              child: Text("Sign in with Phone"),
              
              color: Colors.blue,

            ),
            
          ),

        ],

      ),

    );
    
  }

}