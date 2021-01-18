
import 'package:client/Services/UserService.dart';
import 'package:client/models/User.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../../ui_constants.dart';

class EditProfileScreen extends StatefulWidget {
  final User user;
  EditProfileScreen({this.user});
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  User user;
  bool isLoading = false;
  Geolocator geoLocator;

  String clientCategory;
  @override
  void initState() {
    geoLocator = Geolocator();
    getUserData();
    super.initState();
  }

  getUserData() async {
    setState(() {
      loading = true;
    });
    user = await UserService.getUserByPhone();
    print(user.toJson());
    setState(() {
      loading = false;
    });
  }

  final scaffoldKey = new GlobalKey<ScaffoldState>();

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
            color: Color(0xff25354E),
            elevation: 2.0,
            onPressed: () async {
              setState(() {
                isLoading = true;
              });
              // List<gc.Location> locations = await gc.locationFromAddress(
              //     user.address.toString() +
              //         ' ' +
              //         user.pincode.toString());
              // bool updateStatus =
              //     await UserService.updateUser(jsonEncode({
              //   "address": user.address,
              //   "pincode": user.pincode,
              //   "longitude": locations[0].longitude,
              //   "latitude": locations[0].latitude
              // }));
              // if (updateStatus) {
              //   scaffkey.currentState.showSnackBar(new SnackBar(
              //     content: new Text("Updated"),
              //   ));
              //   Navigator.of(context).pop();
              // } else {
              //   scaffkey.currentState.showSnackBar(new SnackBar(
              //     content: new Text("Please Retry"),
              //   ));
              // }
              // setState(() {
              //   isLoading = false;
              // });
            },
            child: Text(
              'Update',
              style: TextStyle(color: Colors.white, fontSize: 16),
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
      key: scaffoldKey,
      backgroundColor: Colors.black,
      appBar: AppBar(
          brightness: Brightness.light,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
              setState(() {});
            },
          ),
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent),
      body: loading
          ? Center(
        child: CircularProgressIndicator(
            valueColor:
            new AlwaysStoppedAnimation<Color>(Colors.white)),
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
                child: Text('Edit Profile',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w500)),
              ),
              // CircleAvatar(
              //   backgroundColor:
              //   photoUrl == null ? Colors.black : Colors.white,
              //   radius: 86.5,
              //   backgroundImage: NetworkImage(photoUrl),
              //   child: photoUrl == null
              //       ? Text(
              //     '${user.name.substring(0, 1).toUpperCase()}',
              //     style: TextStyle(color: Colors.white),
              //   )
              //       : null,
              // ),
              SizedBox(
                height: UIConstants.fitToHeight(60, context),
              ),
              FlatButton.icon(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.grey[200],
                onPressed: () async {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => MapsDemo()));
                },
                icon: Icon(
                  Icons.location_on,
                  color: Colors.red,
                ),
                label: Text(
                  "Get current location !",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                    '------OR------'),
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


              SizedBox(
                height: UIConstants.fitToHeight(25, context),
              ),
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
        initialValue: init,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hint,
          hintStyle: TextStyle(fontSize: 15.0, color: Colors.grey[400]),
          // labelText: label,
          labelStyle: TextStyle(color: Colors.orange),
          prefixIcon: Icon(icon,color: Colors.orange,),
          focusColor: Colors.orange,
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange),
              borderRadius: BorderRadius.circular(10.0)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}
