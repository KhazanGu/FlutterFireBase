import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import '../Models/UserProvider.dart';
import '../Components/TitleContentItem.dart';
import '../Pages/SignUpAndInPage.dart';
import '../Pages/UserNameEditPage.dart';

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


  void _login () {

    Navigator.of(context).push(
    
      CupertinoPageRoute(
        
        fullscreenDialog: true,

        builder: (context) => SignUpAndInPage()
        
      )

    );

  }

  void _displayPickImageDialog(BuildContext context, UserProvider user) async {

    CupertinoAlertDialog alertDialog = CupertinoAlertDialog(

      title: Text(
        
        'Upload a avatar',

        textAlign: TextAlign.center,
        
      ),

      content: Column(

        children: <Widget>[

          FlatButton(
            
            onPressed: () => this._pickerImage(context, ImageSource.camera, user), 
            
            child: Text("Take a Photo")
            
          ),

          FlatButton(
            
            onPressed: () => this._pickerImage(context, ImageSource.gallery, user), 
            
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

  void _pickerImage(BuildContext context, ImageSource source, UserProvider user) async {

    print("pickerImage");

    try {

      final pickedFile = await _picker.getImage(
        source: source,
        maxWidth: 100,
        maxHeight: 100,
        imageQuality: 1,
      );

      final imageFile = File(pickedFile.path);

      setState(() {
        this._imageFile = imageFile;
      });

      _uploadImage(context, user, imageFile);

    } catch (e) {

      setState(() {
        _pickImageError = e;
      });

    }

    Navigator.of(context).pop();

  }

  void _uploadImage(BuildContext context, UserProvider user, File imageFile) async {

    user.updateAvatar(imageFile);

  }



  void _updateUserAvatar(BuildContext context, UserProvider user) {

    if (!user.isLogin) {
      
      _login();

      return;

    }

    this._displayPickImageDialog(context, user);

  }

  void _updateUserName(UserProvider user){

    if (!user.isLogin) {
      
      _login();

      return;

    }

    Navigator.of(context).push(

      MaterialPageRoute<void>(builder: (_) => UserNameEditPage()),

    );    

  }

  void _updatePhoneNumber(UserProvider user){
    
    if (!user.isLogin) {
      
      _login();

      return;

    }

  }

  void _updateEmail (UserProvider user){
    
    if (!user.isLogin) {
      
      _login();

      return;

    }

  }


  void _signOut(UserProvider user) async {
  
    user.signOut();
    
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

              Container(

                margin: EdgeInsets.only(top: 0, left: 0, right: 0),

                height: 200,

                child: FlatButton(
                  
                  onPressed: () => this._updateUserAvatar(context, user), 
                  
                  child: this._imageFile != null ? Image.file(_imageFile, width: 100, height: 100, fit: BoxFit.fill,) : FadeInImage.assetNetwork(placeholder: 'images/Avatar.png', image: user.photoURL, width: 100, height: 100, fit: BoxFit.fill,)
                                    
                ),

              ),              

              TitleContentItem(title: "User Name", content: user.displayName, onTap: () => this._updateUserName(user),),

              TitleContentItem(title: "Phone Number", content: user.phoneNumber, onTap: () => this._updatePhoneNumber(user),),

              TitleContentItem(title: "Email", content: user.email, onTap: () => this._updateEmail(user),),


              user.isLogin
              
              ?

              Container(

                margin: EdgeInsets.only(top: 42, left: 24, right: 24),

                width: MediaQuery.of(context).size.width - 24 * 2,

                color: Colors.blue,

                child: FlatButton(onPressed: () => _signOut(user), child: Text("Sign Out")),

              )

              :

              Container(),

            ],

          ),
          
        );

      }
      
    );

  }

}