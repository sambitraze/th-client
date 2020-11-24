import 'dart:convert';

import 'package:client/Services/UserService.dart';
import 'package:client/LandingScreen.dart';
import 'package:client/Views/components/txtfield.dart';
import 'package:client/models/User.dart';
import 'package:client/models/User.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController email = TextEditingController();
  double latitude, longitude = 0.0;
  String deviceToken = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          SharedPreferences pref = await SharedPreferences.getInstance();
          print(pref.setBool("newUser", false));
        },
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(1),
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.7), BlendMode.dstATop),
            image: AssetImage('assets/loginbg.png'),
          ),
        ),
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            Text(
              "Add Info",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
              // textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 60,
            ),
            Column(
              children: <Widget>[
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  decoration: TextFieldDec.inputDec("Name *"),
                  controller: name,
                ),
                SizedBox(
                  height: 40,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.white),
                  decoration: TextFieldDec.inputDec("Email *"),
                  controller: email,
                ),
                SizedBox(
                  height: 40,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  decoration: TextFieldDec.inputDec("Address *"),
                  controller: address,
                ),
              ],
            ),
            SizedBox(
              height: 60,
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.all(8),
              color: Colors.green,
              minWidth: 250,
              onPressed: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                if (name.text.length > 0 &&
                    email.text.length > 0 &&
                    address.text.length > 0) {
                  print(name.text);
                  print(email.text);
                  print(address.text);
                  print(pref.getString("phoneNo"));
                  User user = await UserService.createUser(
                    jsonEncode(
                      User(
                        phone: pref.getString("phoneNo"),
                        email: email.text,
                        name: name.text,
                        latitude: latitude.toString(),
                        longitude: longitude.toString(),
                        address: address.text,
                        deviceToken: deviceToken,
                      ).toJson(),
                    ),
                  );
                  if (user.id != null) {
                    pref.setBool("newUser", false);
                  } else {
                    print("sdasda");
                  }
                } else {
                  print('not entered');
                }
              },
              child: Text(
                "ADD",
                style: TextStyle(color: Colors.white, fontSize: 28),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
