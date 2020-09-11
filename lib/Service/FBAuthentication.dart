import 'package:firebase_auth/firebase_auth.dart';

class FBAuthentication {

  FBAuthentication._privateConstructor();

  static final FBAuthentication _instance = FBAuthentication._privateConstructor();

  static FBAuthentication get instance => _instance;


  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  String _verificationId;


  Future<Map<String, dynamic>> creatUserWithEmail(String email, String password) async {

    try {

      final UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      final User user = credential.user;
      
      final Map<String, dynamic> userInfo = _jsonWithUser(user);

      return userInfo;

    } catch (error) {

      throw error;

    }

  }


  Future signInWithEmailAndPassword(String email, String password) async {

    try {
      
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);

      User user = credential.user;

      final Map<String, dynamic> userInfo = _jsonWithUser(user);

      return userInfo;

    } catch (error) {

      throw error;

    }

  }

  Future<void> signOut() {

    return _auth.signOut();

  }

  Future<void> sendPasswordResetEmail(String email) {

    return _auth.sendPasswordResetEmail(email: email);

  }

  Future<void> getSMSCode({String phoneNumber, Function succeed(), Function failed(String error)}) async {

    print("getSMSCode");

    void verificationCompleted(PhoneAuthCredential credential) {

      print("verificationCompleted:" + credential.toString());

    }

    void verificationFailed(FirebaseAuthException exception) {

      failed(exception.toString());

      print("verificationFailed:" + exception.toString());

    }

    void codeSent(String verificationId, int forceResendingToken) {

      print("codeSent:" + "id:" + verificationId + "token:" + forceResendingToken.toString());

      _verificationId = verificationId;

      succeed();

    }

    void codeAutoRetrievalTimeout(String verificationId) {

      print("codeAutoRetrievalTimeout:" + verificationId);

    }

    await _auth.verifyPhoneNumber(phoneNumber: phoneNumber, verificationCompleted: verificationCompleted, verificationFailed: verificationFailed, codeSent: codeSent, codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);

  }
  
  Future<Map<String, dynamic>> signInWithSMSCode({String code}) async {

    try {

      final AuthCredential authCredential = PhoneAuthProvider.credential(

        verificationId: this._verificationId,

        smsCode: code,

      );
      
      final UserCredential userCredential = await _auth.signInWithCredential(authCredential);

      final User user = userCredential.user;

      final Map<String, dynamic> userInfo = _jsonWithUser(user);

      return userInfo;

    } catch (e) {

      throw e;

    }

  }


  Future<void> updateProfile({String displayName, String photoURL}) {

    final User user = _auth.currentUser;

    return user.updateProfile(displayName: displayName, photoURL: photoURL);

  }


  Map<String, dynamic> _jsonWithUser(User user) {

    final Map<String, dynamic> userInfo = {

      "photoURL": user.photoURL != null ?  user.photoURL : "",

      "displayName": user.displayName != null ?  user.displayName : "",

      "phoneNumber": user.phoneNumber != null ?  user.phoneNumber : "",

      "email": user.email != null ?  user.email : "",

      "uid": user.uid,

    };

    print("userInfo: $userInfo");

    return userInfo;

  }



}
