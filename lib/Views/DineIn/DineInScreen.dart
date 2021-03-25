import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DineInScreen extends StatefulWidget {
  @override
  _DineInScreenState createState() => _DineInScreenState();
}

class _DineInScreenState extends State<DineInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              'assets/svg/construction.svg',
              height: 128.0,
            ),
            SizedBox(height: 30),
            Text(
              'Coming Soon',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}