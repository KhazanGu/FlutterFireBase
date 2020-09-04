
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SignInWithPhonePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SignInWithPhonePageState();
  }
}

class _SignInWithPhonePageState extends State<SignInWithPhonePage> {

  String _phoneNumber;

  String _verificationId;

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

    print("verifyPhoneNumber");

    void verificationCompleted(PhoneAuthCredential credential) {

      print("verificationCompleted:" + credential.toString());

    }

    void verificationFailed(FirebaseAuthException exception) {

      print("verificationFailed:" + exception.toString());

    }

    void codeSent(String verificationId, int forceResendingToken) {

      print("codeSent:" + "id:" + verificationId + "token:" + forceResendingToken.toString());

      setState(() {
        
        _verificationId = verificationId;

      });

      _showAlertDialog(context, 'Please check your phone for the verification code.');

    }

    void codeAutoRetrievalTimeout(String verificationId) {

      print("codeAutoRetrievalTimeout:" + verificationId);

    }

    _auth.verifyPhoneNumber(phoneNumber: this._phoneNumber, verificationCompleted: verificationCompleted, verificationFailed: verificationFailed, codeSent: codeSent, codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);

  }

  void _signIn(BuildContext context) async {

    try {

      final AuthCredential authCredential = PhoneAuthProvider.credential(

        verificationId: _verificationId,

        smsCode: _code,

      );

      final UserCredential userCredential = await _auth.signInWithCredential(authCredential);

      final User user = userCredential.user;

      print("userInfo:" + user.toString());

      _showAlertDialog(context, user.toString());

    }  on FirebaseAuthException catch (exception) {

      print("exception:$exception");

      _showAlertDialog(context, exception.message);

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
            
              onPressed: () => _signIn(context), 
              
              child: Text("Sign Up"),
              
              color: Colors.blue,

            )

          )

        ],

      ),     
      
    );

  }

}