import 'package:client/Views/Auth/loginScreen.dart';
import 'package:client/Views/Cart/CartScreen.dart';
import 'package:client/Views/DineIn/DineInScreen.dart';
import 'package:client/Views/HomeScreen/HomeScreen.dart';
import 'package:client/Views/Menu/MenuScreen.dart';
import 'package:client/Views/TakeAway/TakeAwayScreen.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {

  int _selectedIndex = 0;
  PageController 
    pageController = PageController(
      initialPage: 0,
      keepPage: true,
    );
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
      onPressed: () async {
        await FirebaseAuth.instance.signOut();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      },
    ),
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text('Tap back again to leave'),
        ),
        child: SafeArea(
          child: PageView(
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
              print(index);
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
