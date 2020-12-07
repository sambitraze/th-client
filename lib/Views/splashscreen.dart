import 'dart:async';

import 'package:client/LandingScreen.dart';
import 'package:client/Views/Auth/AddData.dart';
import 'package:client/Views/Auth/loginScreen.dart';
import 'package:client/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // getUser();
    super.initState();
    startTime();
  }

  // getUser() async {
  //   try {
  //     user = await UserService.getUser();
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  startTime() async {
    var duration = new Duration(seconds: 3);
    return new Timer(duration, navigate);
  }

  void navigate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool chk = prefs.getBool("login");
    if (chk != null) {
      if (chk) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
          return LandingScreen();
        }));
      } else {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
          return LoginScreen();
        }));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: 
      Center(
        child: Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height - 50,
              width: MediaQuery.of(context).size.width - 100,
              child: Image.asset(
                "assets/logo.png",
                fit: BoxFit.contain,
              ),
            ),
      ),
      // Column(
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   children: [
      //     Container(
      //       alignment: Alignment.center,
      //       height: MediaQuery.of(context).size.height - 50,
      //       width: MediaQuery.of(context).size.width - 100,
      //       child: Image.asset(
      //         "assets/logo.png",
      //         fit: BoxFit.contain,
      //       ),
      //     ),
      //     // Padding(
      //     //   padding: const EdgeInsets.only(bottom: 10.0),
      //     //   child: Align(
      //     //       alignment: Alignment.bottomCenter,
      //     //       child: Container(
      //     //         child: Text("Made with ❤ by Codebugged AI"),
      //     //       )),
      //     // )
      //   ],
      // ),
    );
  }
}
