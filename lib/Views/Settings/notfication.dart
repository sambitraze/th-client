import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<String> notifications = [];
  List<String> time = [];
  @override
  void initState() {
    getNotification();
    super.initState();
  }

  bool loading = false;
  int count = 0;

  getNotification() async {
    setState(() {
      loading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      notifications = prefs.getStringList("notifications");
      if (notifications != null) count = notifications.length;
      time = prefs.getStringList("time");
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title:  Text(
                            "Notifications",
                            style: TextStyle(
                              fontSize: 32,
                              color: Colors.white,
                            ),
                          ),
                          centerTitle: true,
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/svg/savedfood.svg',
                      height: 128.0,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  color: Colors.black12,
                  child: SizedBox(
                    height: 128,
                    width: 128,
                  ),
                ),
                Container(
                  color: Colors.black12,
                  child: Column(
                    children: <Widget>[
                     
                      SizedBox(
                        height: 10,
                      ),
                      count > 0
                          ? Expanded(
                              child: ListView.builder(
                                itemCount: count,
                                itemBuilder: (BuildContext ctxt, int index) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                    color: Colors.black38,
                                    child: new ListTile(
                                        leading: CircleAvatar(
                                            radius: 25,
                                            child: Image(
                                              image:
                                                  AssetImage('assets/logo.png'),
                                            )),
                                        title: Text(
                                          notifications[index],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                        trailing: Text(
                                          "${DateTime.parse(time[index]).day}-${DateTime.parse(time[index]).month}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        )),
                                  );
                                },
                              ),
                            )
                          : Center(
                              child: Text(
                              "No Notifications",
                              style: TextStyle(color: Colors.white),
                            )),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
