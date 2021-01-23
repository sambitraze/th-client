import 'package:client/Services/UserService.dart';
import 'package:client/Views/Auth/loginScreen.dart';
import 'package:client/Views/Settings/DevPage.dart';
import 'package:client/Views/Settings/EditProfileScreen.dart';
import 'package:client/Views/Settings/ManageAddress.dart';
import 'package:client/Views/Settings/OrderHistory.dart';
import 'package:client/Views/Settings/notfication.dart';
import 'package:client/models/User.dart' as u;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  u.User user;
  @override
  void initState() {
    getUser();
    super.initState();
  }

  bool load = false;
  getUser() async {
    setState(() {
      load = true;
    });
    user = await UserService.getUserByPhone();
    setState(() {
      load = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pop(context),
          ),
         ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: load
            ? CircularProgressIndicator()
            : Column(
                children: [                 
                  SizedBox(height: 20),
                  Container(
                    child: Column(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 40,
                          child: InkWell(
                            child: Text(
                              user.name.substring(0, 1),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 32,
                              ),
                            ),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditProfile(),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          user.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          user.email + '\n' + "+91 " + user.phone,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25),
                  Divider(
                    color: Colors.grey.withOpacity(0.48),
                    height: 1,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Settings',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        // FlatButton.icon(
                        //   onPressed: () => Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => SavedFoodPage(),
                        //     ),
                        //   ),
                        //   icon: Icon(
                        //     Icons.save,
                        //     color: Colors.grey,
                        //   ),
                        //   label: Text(
                        //     'Saved Foods',
                        //     style: TextStyle(
                        //       color: Colors.grey,
                        //       fontSize: 16,
                        //     ),
                        //   ),
                        // ),
                        FlatButton.icon(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderHistory(),
                            ),
                          ),
                          icon: Icon(
                            Icons.pages,
                            color: Colors.grey,
                          ),
                          label: Text(
                            'Your Orders',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        // FlatButton.icon(
                        //   onPressed: () => Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => NotificationPage(),
                        //     ),
                        //   ),
                        //   icon: Icon(
                        //     Icons.notification_important,
                        //     color: Colors.grey,
                        //   ),
                        //   label: Text(
                        //     'Notifications',
                        //     style: TextStyle(
                        //       color: Colors.grey,
                        //       fontSize: 16,
                        //     ),
                        //   ),
                        // ),
                        FlatButton.icon(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditProfileScreen(),
                            ),
                          ),
                          icon: Icon(
                            Icons.contacts,
                            color: Colors.grey,
                          ),
                          label: Text(
                            'Manage Address',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey.withOpacity(0.48),
                    height: 1,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'About',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        FlatButton.icon(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DevPage(),
                            ),
                          ),
                          icon: Icon(
                            Icons.developer_mode,
                            color: Colors.grey,
                          ),
                          label: Text(
                            'Our Developers',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        FlatButton.icon(
                          onPressed: ()async {
                              // Android and iOS
                              const uri =
                                  'mailto:tandoorhut@gmail.com?subject=Query&body=';
                              if (await canLaunch(uri)) {
                                await launch(uri);
                              } else {
                                throw 'Could not launch $uri';
                              }

                          },
                          icon: Icon(
                            Icons.message,
                            color: Colors.grey,
                          ),
                          label: Text(
                            'Reach us!',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        FlatButton.icon(
                          onPressed: () => print('asd'),
                          icon: Icon(
                            Icons.star,
                            color: Colors.grey,
                          ),
                          label: Text(
                            'Rate Us!',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        FlatButton.icon(
                          onPressed: () async{
                             await FirebaseAuth.instance.signOut();
                             SharedPreferences pref = await SharedPreferences.getInstance();
                             pref.clear();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
                          },
                          icon: Icon(
                            Icons.exit_to_app,
                            color: Colors.grey,
                          ),
                          label: Text(
                            'Logout',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
