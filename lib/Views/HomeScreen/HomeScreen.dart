import 'package:client/Services/UserService.dart';
import 'package:client/Views/Settings/ManageAddress.dart';
import 'package:client/Views/Settings/ProfileScreen.dart';
import 'package:client/models/User.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  bool loading = false;
  User client;

  getData() async {
    setState(() {
      loading = true;
    });
    client = await UserService.getUserByPhone();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              elevation: 0,
              brightness: Brightness.dark,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: InkWell(
                      child: Text(
                        client.name.substring(0, 1),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                        ),
                      ),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileScreen(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              leading: Icon(
                Icons.location_on,
                color: Color.fromRGBO(252, 126, 47, 1),
                size: 35,
              ),
              title: InkWell(
                onTap: (){
                  Navigator.of(context)
                              .push(MaterialPageRoute(
                                  builder: (context) => ManageAddress()))
                              .then((value) async {
                            client = await UserService.getUserByPhone();
                            setState(() {});
                          });
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Home',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      client.address ,
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            backgroundColor: Colors.black,
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.only(top: 10, left: 10),
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Order again',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Food you have tried before',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          height: 120,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/again1.png'),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                child: InkWell(
                                  child: SizedBox(
                                    height: 46,
                                    width: 170,
                                  ),
                                  onTap: () => print("tapped"),
                                ),
                              ),
                              SizedBox(width: 15),
                              Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/again2.png'),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                child: InkWell(
                                  child: SizedBox(
                                    height: 46,
                                    width: 170,
                                  ),
                                  onTap: () => print("tapped"),
                                ),
                              ),
                              SizedBox(width: 15),
                              Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/again1.png'),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                child: InkWell(
                                  child: SizedBox(
                                    height: 46,
                                    width: 170,
                                  ),
                                  onTap: () => print("tapped"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.only(top: 10, left: 10),
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Lockdown Craving',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                        //top 10 items
                        SizedBox(height: 5),
                        Text(
                          'Most ordered in your city',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.only(top: 10, left: 10),
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'OFFERS',
                          style: TextStyle(
                            color: Color.fromRGBO(136, 136, 136, 1),
                            fontSize: 19,
                          ),
                        ),
                        SizedBox(height: 18),
                        SizedBox(
                          height: 110,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color.fromRGBO(255, 143, 54, 1),
                                          Color.fromRGBO(252, 81, 133, 1)
                                        ],
                                      ),
                                    ),
                                    child: SizedBox(
                                      height: 108,
                                      width: 115,
                                    ),
                                  ),
                                  Text(
                                    'ALL\nOFFERS',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  InkWell(
                                    child: SizedBox(
                                      height: 108,
                                      width: 115,
                                    ),
                                    // onTap: () => Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) => AllOffers())),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color.fromRGBO(248, 255, 59, 1),
                                          Color.fromRGBO(110, 182, 255, 1)
                                        ],
                                      ),
                                    ),
                                    child: InkWell(
                                      child: SizedBox(
                                        height: 108,
                                        width: 115,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'min\n30%\nOFF',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                    ),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color.fromRGBO(248, 255, 59, 1),
                                          Color.fromRGBO(21, 183, 185, 1)
                                        ],
                                      ),
                                    ),
                                    child: InkWell(
                                      child: SizedBox(
                                        height: 108,
                                        width: 115,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'min\n40%\nOFF ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                    ),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10, left: 10),
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Quick Links',
                          style: TextStyle(
                            color: Color.fromRGBO(136, 136, 136, 1),
                            fontSize: 19,
                          ),
                        ),
                        SizedBox(height: 18),
                        SizedBox(
                          height: 110,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    image: AssetImage("assets/newarrival.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: InkWell(
                                  child: SizedBox(
                                    height: 108,
                                    width: 115,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    image: AssetImage("assets/express.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: InkWell(
                                  child: SizedBox(
                                    height: 108,
                                    width: 115,
                                  ),
                                  // onTap: () => Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => Express())),
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    image: AssetImage("assets/bestdeals.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: InkWell(
                                  child: SizedBox(
                                    height: 108,
                                    width: 115,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
