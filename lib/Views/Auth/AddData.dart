import 'dart:convert';
import 'package:client/LandingScreen.dart';
import 'package:client/Services/UserService.dart';
import 'package:client/Views/components/txtfield.dart';
import 'package:client/models/User.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController name = TextEditingController();
  TextEditingController city = TextEditingController(text: "Ara, Bihar");
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();

  double latitude = 0.0, longitude = 0.0;
  String deviceToken = '';
  bool _loading = false;

  Future _determinePosition() async {
    setState(() {
      _loading = true;
    });
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }

    Position position = await Geolocator.getCurrentPosition();

    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(1),
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5), BlendMode.dstATop),
            image: AssetImage('assets/loginbg.png'),
          ),
        ),
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 56,
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
              height: 10,
            ),
            Text(
              "**We are available in Ara, Bihar only",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              // textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 50,
            ),
            Column(
              children: <Widget>[
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  decoration: TextFieldDec.inputDec("Name *"),
                  controller: name,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.white),
                  decoration: TextFieldDec.inputDec("Email *"),
                  controller: email,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  enabled: false,
                  style: TextStyle(color: Colors.white),
                  decoration: TextFieldDec.inputDec("City *").copyWith(
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                    ),
                  ),
                  controller: city,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Colors.grey[200],
              onPressed: () async {
                await _determinePosition();
              },
              child: Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.red,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      "Get current location !",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            _loading
                ? Center(child: CircularProgressIndicator())
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Latitude: $latitude      Longitude: $longitude",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              style: TextStyle(color: Colors.white),
              decoration: TextFieldDec.inputDec("Address *"),
              controller: address,
            ),
            SizedBox(
              height: 50,
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.all(8),
              color: Colors.amber,
              minWidth: 180,
              onPressed: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                if (name.text.length > 0 &&
                    email.text.length > 0 &&
                    city.text == "Ara, Bihar" &&
                    address.text.length > 0 &&
                    latitude != 0 &&
                    longitude != 0) {
                  User user = await UserService.createUser(
                   jsonEncode( {
                     "phone": pref.getString("phoneNo"),
                     "email": email.text,
                     "name": name.text,
                     "city": city.text,
                     'address': address.text,
                     'latitude': latitude.toString(),
                     'longitude': longitude.toString(),
                   }),
                  );
                  if (user.id != null) {
                    pref.setString("id", user.id);
                    pref.setBool("newUser", false);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LandingScreen()));
                  } else {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LandingScreen()));
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
