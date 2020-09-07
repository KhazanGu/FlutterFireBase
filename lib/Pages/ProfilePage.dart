import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import '../Models/UserProvider.dart';
import '../Components/TitleContentItem.dart';
import '../Pages/SignUpAndInPage.dart';

typedef void OnPickImageCallback(double maxWidth, double maxHeight, int quality);

class ProfilePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProfilePageState();
  }

}

class _ProfilePageState extends State<ProfilePage> {

  final ImagePicker _picker = ImagePicker();

  File _imageFile;

  dynamic _pickImageError;

  // Widget image = Image(image: AssetImage('images/Avatar.png'));

  Widget _image = FadeInImage(width: 88, height: 88, image: AssetImage('images/Avatar.png'), placeholder: AssetImage('images/Avatar.png'));


  void _login () {

    Navigator.of(context).push(
    
      CupertinoPageRoute(
        
        fullscreenDialog: true,

        builder: (context) => SignUpAndInPage()
        
      )

    );

  }

  void _displayPickImageDialog(BuildContext context) async {

    AlertDialog alertDialog = AlertDialog(

      title: Text(
        
        'Upload a avatar',

        textAlign: TextAlign.center,
        
      ),

      content: Column(

        children: <Widget>[

          FlatButton(
            
            onPressed: () => this._pickerImage(context, ImageSource.camera), 
            
            child: Text("Take a Photo")
            
          ),

          FlatButton(
            
            onPressed: () => this._pickerImage(context, ImageSource.gallery), 
            
            child: Text("Pick Image from gallery")
            
          ),

          FlatButton(
            
            onPressed: () {

              Navigator.of(context).pop();

            }, 
            
            child: Text("Cancel")
            
          ),

        ],

      ),

    );

    showDialog(

      context: context,

      builder: (context) {

        return alertDialog;

      }

    );

  }

  void _pickerImage(BuildContext context, ImageSource source) async {

    print("pickerImage");

    try {

      final pickedFile = await _picker.getImage(
        source: source,
        maxWidth: 100,
        maxHeight: 100,
        imageQuality: 1,
      );

      setState(() {

        _image = Image.file(
          
          File(pickedFile.path),

          width: 100,

          height: 100,

          fit: BoxFit.cover,
          
        );

      });

    } catch (e) {

      setState(() {
        _pickImageError = e;
      });

    }

    Navigator.of(context).pop();

  }

  void _updateUserName (UserProvider user){

    if (!user.login) {
      
      _login();

    }

  }

  void _updatePhoneNumber (UserProvider user){
    
  }

  void _updateEmail (UserProvider user){
    
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Consumer<UserProvider>(
      
      builder: (context, user, child) {

        return Scaffold(

          appBar: AppBar(

            title: Text("Profile"),

          ),

          body: Column(

            children: [

              FlatButton(onPressed: () => this._displayPickImageDialog(context), child: this._image),              

              TitleContentItem(title: "User Name", content: user.displayName, onTap: () => this._updateUserName(user),),

              TitleContentItem(title: "Phone Number", content: user.phoneNumber, onTap: () => this._updatePhoneNumber(user),),

              TitleContentItem(title: "Email", content: user.email, onTap: () => this._updateEmail(user),),

            ],

          ),
          
        );

      }
      
    );

  }

}