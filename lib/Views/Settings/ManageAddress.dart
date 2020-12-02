import 'dart:convert';

import 'package:client/Services/UserService.dart';
import 'package:flutter/material.dart';
import 'package:client/ui_constants.dart';
import 'package:client/models/User.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart' as gc;
class ManageAddress extends StatefulWidget {
  @override
  _ManageAddressState createState() => _ManageAddressState();
}

class _ManageAddressState extends State<ManageAddress> {
   User user;
  bool isLoading = false;
  Geolocator geolocator;

  String clientCategory;
  @override
  void initState() {
    geolocator = Geolocator();
    getUserData();
    super.initState();
  }

  getUserData() async {
    setState(() {
      loading = true;
    });    
    user = await UserService.getUserByPhone();
    setState(() {
      loading = false;
    });
  }

  final scaffkey = new GlobalKey<ScaffoldState>();

  Widget saveButton(context) {
    return !isLoading
        ? Padding(
            padding: EdgeInsets.only(
                left: UIConstants.fitToWidth(34, context),
                right: UIConstants.fitToWidth(34, context),
                bottom: UIConstants.fitToHeight(20, context)),
            child: SizedBox(
              height: UIConstants.fitToHeight(40, context),
              width: UIConstants.fitToWidth(292, context),
              child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      side: BorderSide(color: Colors.transparent)),
                  color: Colors.orange,
                  elevation: 2.0,
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    List<gc.Location> locations = await gc.locationFromAddress(
                        user.address.toString());
                       setState(() {
                          user.latitude = locations[0].latitude.toString();
                        user.longitude = locations[0].longitude.toString();
                       });
                    bool updateStatus =
                        await UserService.updateUser(user);
                    if (updateStatus) {
                      scaffkey.currentState.showSnackBar(new SnackBar(
                        content: new Text("Updated"),
                      ));
                      Navigator.of(context).pop();
                    } else {
                      scaffkey.currentState.showSnackBar(new SnackBar(
                        content: new Text("Please Retry"),
                      ));
                    }
                    setState(() {
                      isLoading = false;
                    });
                  },
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  )),
            ),
          )
        : Center(
            child: CircularProgressIndicator(
                valueColor:
                    new AlwaysStoppedAnimation<Color>(Color(0xff25354E))));
  }

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffkey,
      backgroundColor: Colors.black,
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
              setState(() {});
            },
          ),
          iconTheme: IconThemeData(
            color: Color(0xff25354E), //change your color here
          ),
          elevation: 0.0,
          backgroundColor: Colors.black),
      body: loading
          ? Center(
              child: CircularProgressIndicator(valueColor:
                      new AlwaysStoppedAnimation<Color>(Color(0xff25354E))),
            )
          : SingleChildScrollView(
              child: Container(
                height: UIConstants.fitToHeight(640, context),
                width: UIConstants.fitToWidth(360, context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: UIConstants.fitToHeight(10, context),
                          bottom: UIConstants.fitToHeight(10, context)),
                      child: Text('Edit Address',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w500)),
                    ),
                     CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 40,
                          child: Text(
                            user.name.substring(0, 1),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 32,
                            ),
                          ),
                        ),
                    SizedBox(
                      height: UIConstants.fitToHeight(60, context),
                    ),
                    FlatButton.icon(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: Colors.orange,
                      onPressed: () async {
                        print(user.address);
                        scaffkey.currentState.showSnackBar(new SnackBar(
                          content: new Text("Turn on GPS and Wait / Retry"),
                        ));
                        Position position = await Geolocator.getCurrentPosition(
                            desiredAccuracy: LocationAccuracy.high);
                        if (position.latitude != null) {
                          scaffkey.currentState.showSnackBar(new SnackBar(
                            content: new Text("location found"),
                          ));
                          List<gc.Placemark> placemarks =
                              await gc.placemarkFromCoordinates(
                                  position.latitude, position.longitude);
                          placemarks.forEach((element) {
                            print(element.postalCode);
                          });                          
                          
                          setState(() {
                            user.address = (placemarks[0].name == "Unnamed Road"
                                  ? ""
                                  : placemarks[0].name) +
                              " " +
                              (placemarks[1].name == "Unnamed Road"
                                  ? ""
                                  : placemarks[1].name) +
                              " " +
                              (placemarks[2].name == "Unnamed Road"
                                  ? ""
                                  : placemarks[2].name) +
                              " " +
                              (placemarks[3].name == "Unnamed Road"
                                  ? ""
                                  : placemarks[3].name) +
                              " " +
                              (placemarks[4].street == "Unnamed Road"
                                  ? ""
                                  : placemarks[4].street);
                            isLoading = true;
                          });
                          bool updateStatus =
                              await UserService.updateUser(user);
                          if (updateStatus) {
                            scaffkey.currentState.showSnackBar(new SnackBar(
                              content: new Text("Updated"),
                            ));
                            Navigator.of(context).pop();
                          } else {
                            scaffkey.currentState.showSnackBar(new SnackBar(
                              content: new Text("Please Retry"),
                            ));
                          }
                          setState(() {
                            isLoading = false;
                          });
                        } else {
                          scaffkey.currentState.showSnackBar(new SnackBar(
                            content: new Text("location not found"),
                          ));
                        }
                      },
                      icon: Icon(
                        Icons.location_on,
                        color: Colors.white,
                      ),
                      label: Text(
                        "Get current location !",
                        style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                          '------------------------------------OR------------------------------------', style: TextStyle(color: Colors.white),),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _input(
                        'Please enter Address',
                        'Address',
                        '${user.address}',
                        'address',
                        Icons.home,
                        TextInputType.streetAddress, (value) {
                      setState(() {
                        user.address = value;
                      });
                    }),
                    SizedBox(height: 30),
                    saveButton(context)
                  ],
                ),
              ),
            ),
    );
  }

  Widget _input(String validation, String label, String init, String hint,
      IconData icon, TextInputType type, save) {
    return Padding(
      padding: EdgeInsets.only(
          top: UIConstants.fitToHeight(20, context),
          left: UIConstants.fitToWidth(34, context),
          right: UIConstants.fitToWidth(34, context)),
      child: TextFormField(
        keyboardType: type,
        onChanged: save,
        style: TextStyle(color: Colors.white),
        initialValue: init,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.transparent,
          hintText: hint,
          hintStyle: TextStyle(fontSize: 15.0, color: Colors.white),
          labelText: label,
          labelStyle: TextStyle(fontSize: 15.0, color: Colors.white),
          prefixIcon: Icon(icon,color: Colors.white,),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10.0)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Colors.white,
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}