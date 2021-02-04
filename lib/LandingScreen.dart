import 'dart:io';

import 'package:client/Services/PushService.dart';
import 'package:client/Services/UserService.dart';
import 'package:client/Views/Auth/loginScreen.dart';
import 'package:client/Views/Cart/CartScreen.dart';
import 'package:client/Views/DineIn/DineInScreen.dart';
import 'package:client/Views/HomeScreen/HomeScreen.dart';
import 'package:client/Views/Menu/MenuScreen.dart';
import 'package:client/Views/TakeAway/TakeAwayScreen.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int _selectedIndex = 0;
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
  List<String> notifications = [];
  List<String> time = [];

  final _fcm = FirebaseMessaging();
  @override
  void initState() {
    PushService.genTokenID();
    super.initState();
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("show");
        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // notifications = prefs.getStringList("notifications");
        // time = prefs.getStringList("time");
        // setState(() {
        //   time.add(DateTime.now().toString());
        //   notifications.add(message['notification']['body']);
        // });
        // prefs.setStringList("notifications", notifications);
        // prefs.setStringList("time", time);
        showDialog(
          context: context,
          builder: (context) => Platform.isAndroid
              ? AlertDialog(
                  title: Text(message['notification']['title']),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  content: Text(message['notification']['body']),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Ok'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                )
              : CupertinoAlertDialog(
                  title: Text(message['notification']['title']),
                  content: Text(message['notification']['body']),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Ok'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // TODO optional
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        // TODO optional
      },
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text('Tap back again to leave'),
        ),
        child: SafeArea(
          top: false,
          child: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: pageController,
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            children: [
              HomeScreen(),
              MenuScreen(),
              CartScreen(),
              TakeAwayScreen(),
              DineInScreen(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
            gap: 8,
            activeColor: Colors.white,
            iconSize: 24,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            duration: Duration(milliseconds: 500),
            tabBackgroundColor: Color.fromRGBO(252, 126, 47, 1),
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.fastfood,
                text: 'Menu',
              ),
              GButton(
                icon: Icons.shopping_cart,
                text: 'Cart',
              ),
              GButton(
                icon: Icons.directions_run,
                text: 'Takeaway',
              ),
              GButton(
                icon: Icons.phone_in_talk,
                text: 'Dine-In',
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(
                () {
                  _selectedIndex = index;
                },
              );
              pageController.animateToPage(index,
                  duration: Duration(milliseconds: 300), curve: Curves.ease);
            },
          ),
        ),
      ),
    );
  }
}
