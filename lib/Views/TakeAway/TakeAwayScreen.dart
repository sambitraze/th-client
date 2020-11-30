import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TakeAwayScreen extends StatefulWidget {
  @override
  _TakeAwayScreenState createState() => _TakeAwayScreenState();
}

class _TakeAwayScreenState extends State<TakeAwayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
                color: Colors.white,
                fontSize: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}