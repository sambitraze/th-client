import 'package:client/Views/Auth/AddData.dart';
import 'package:client/Views/Auth/loginScreen.dart';
import 'package:client/Views/HomeScreen/LandingScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static bool newUser = true;
  static handleAuth() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        getData();
        print(newUser);
        if (snapshot.hasData && newUser) {
          return AddData();
        } else if (snapshot.hasData && !newUser) {
          return LandingScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }

  static getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    newUser = pref.get("newUser") == null ? true : pref.get("newUser");
  }

  signOut() {
    FirebaseAuth.instance.signOut();
  }

  //SignIn
  signIn(AuthCredential authCreds, String phoneNo) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(authCreds);
    if (userCredential.additionalUserInfo.isNewUser) {
      pref.setBool("newUser", true);
      pref.setString("phoneNo", phoneNo);
      pref.setString("uid", userCredential.user.uid);
    }
  }

  signInWithOTP(smsCode, verId, phoneNo) {
    AuthCredential authCreds =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);
    signIn(authCreds, phoneNo);
  }
}
