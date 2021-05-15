import 'package:client/Services/UserService.dart';
import 'package:client/Services/offerSerivce.dart';
import 'package:client/Services/topService.dart';
import 'package:client/Views/Cart/CartScreen.dart';
import 'package:client/Views/HomeScreen/MenuScreen.dart';
import 'package:client/Views/Settings/ManageAddress.dart';
import 'package:client/Views/Settings/ProfileScreen.dart';
import 'package:client/models/User.dart';
import 'package:client/models/cartItem.dart';
import 'package:client/models/offers.dart';
import 'package:client/models/top.dart';
import 'package:flutter/material.dart';
import 'dart:math';

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

  Random random = new Random();

  bool loading = false;
  User client;
  List<Offer> offers = [];
  List<Top> top8 = [];

  List<String> menuName = [
    'Tandoor',
    'Main\nCourse',
    'Chinese\nMain\nCourse',
    'Rice\n&\nBiryani',
    'Noodles',
    'Rolls\n&\nMomos',
    'Breads',
    'Beverages'
  ];

  getData() async {
    setState(() {
      loading = true;
    });
    client = await UserService.getUserByPhone();
    offers = await OfferService.getUnBlockedOffers();
    top8 = await TopService.getTops();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage('assets/menu' +
                              random.nextInt(7).toString() +
                              '.png'),
                          colorFilter: ColorFilter.mode(
                              Colors.black54, BlendMode.darken),
                          fit: BoxFit.cover,
                        )),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                "Tandoor Hut",
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .headline4
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.location_on,
                                color: Colors.white,
                                size: 35,
                              ),
                              title: InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(
                                          builder: (context) =>
                                              EditProfileScreen()))
                                      .then((value) async {
                                    client = await UserService.getUserByPhone();
                                    setState(() {});
                                  });
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(
                                      'Home',
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .headline6
                                          .copyWith(fontSize: 18),
                                    ),
                                    Text(
                                      client.address,
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .headline6
                                          .copyWith(fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                              trailing: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      width: 16,
                                    ),
                                    InkWell(
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: Text(
                                          client.name.substring(0, 1),
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .headline5
                                              .copyWith(color: Colors.black),
                                        ),
                                      ),
                                      onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProfileScreen(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(16),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 8),
                              // Text(
                              //   'LockDown Craving',
                              //   style: Theme.of(context)
                              //       .primaryTextTheme
                              //       .headline5
                              //       .copyWith(
                              //           fontWeight: FontWeight.bold,
                              //           color: Colors.black),
                              // ),
                              // SizedBox(height: 3),
                              // Text(
                              //   'Most ordered in your city',
                              //   style: TextStyle(
                              //     color: Colors.black45,
                              //     fontSize: 14,
                              //   ),
                              // ),
                              // SizedBox(
                              //   height: 120,
                              //   child: ListView.builder(
                              //     itemCount: top8.length,
                              //     scrollDirection: Axis.horizontal,
                              //     itemBuilder: (context, index) {
                              //       print(top8[index].item.category);
                              //       return Padding(
                              //         padding:
                              //             const EdgeInsets.only(right: 16.0),
                              //         child: Stack(
                              //           alignment: Alignment.center,
                              //           children: <Widget>[
                              //             Container(
                              //               decoration: BoxDecoration(
                              //                 borderRadius:
                              //                     BorderRadius.circular(15),
                              //                 image: DecorationImage(
                              //                   image: AssetImage('assets/menu' +
                              //                       menuName.indexWhere((e)=>e.contains(top8[index].item.category)).toString()
                              //                        +
                              //                       '.png'),
                              //                   colorFilter: ColorFilter.mode(
                              //                       Colors.black45,
                              //                       BlendMode.darken),
                              //                   fit: BoxFit.cover,
                              //                 ),
                              //               ),
                              //               child: SizedBox(
                              //                 height: 108,
                              //                 width: 115,
                              //               ),
                              //             ),
                              //             Text(
                              //               top8[index]
                              //                   .item
                              //                   .name
                              //                   .replaceAll(" ", "\n"),
                              //               style: Theme.of(context)
                              //                   .primaryTextTheme
                              //                   .headline6
                              //                   .copyWith(
                              //                       fontWeight:
                              //                           FontWeight.bold),
                              //               textAlign: TextAlign.center,
                              //             ),
                              //             InkWell(
                              //               child: SizedBox(
                              //                 height: 108,
                              //                 width: 115,
                              //               ),
                              //               onTap: () async {
                              //                 showDialog(
                              //                   context: context,
                              //                   builder: (context) {
                              //                     return StatefulBuilder(
                              //                       builder:
                              //                           (context, setState) =>
                              //                               AlertDialog(
                              //                         shape:
                              //                             RoundedRectangleBorder(
                              //                                 borderRadius:
                              //                                     BorderRadius
                              //                                         .circular(
                              //                                             16)),
                              //                         title: Text(
                              //                           "Do you want to add ${top8[index].item.name} to your cart ?",
                              //                           style: Theme.of(context)
                              //                               .primaryTextTheme
                              //                               .headline6
                              //                               .copyWith(
                              //                                   fontWeight:
                              //                                       FontWeight
                              //                                           .bold,
                              //                                   color: Colors
                              //                                       .black,
                              //                                   fontSize: 18),
                              //                         ),
                              //                         content: Row(
                              //                           mainAxisAlignment:
                              //                               MainAxisAlignment
                              //                                   .center,
                              //                           children: [
                              //                             MaterialButton(
                              //                               shape:
                              //                                   RoundedRectangleBorder(
                              //                                 borderRadius:
                              //                                     BorderRadius
                              //                                         .circular(
                              //                                             18),
                              //                               ),
                              //                               color: Colors.white,
                              //                               onPressed:
                              //                                   () async {
                              //                                 Navigator.of(
                              //                                         context)
                              //                                     .pop();
                              //                               },
                              //                               child: Text(
                              //                                 "NO",
                              //                                 style: TextStyle(
                              //                                   fontSize: 18,
                              //                                   color: Colors
                              //                                       .black,
                              //                                 ),
                              //                               ),
                              //                             ),
                              //                             SizedBox(
                              //                               width: 16,
                              //                             ),
                              //                             MaterialButton(
                              //                               shape:
                              //                                   RoundedRectangleBorder(
                              //                                 borderRadius:
                              //                                     BorderRadius
                              //                                         .circular(
                              //                                             18),
                              //                               ),
                              //                               color:
                              //                                   Colors.orange,
                              //                               onPressed:
                              //                                   () async {
                              //                                 User user =
                              //                                     await UserService
                              //                                         .getUserByPhone();
                              //                                 user.cart.add(CartItem(
                              //                                     item: top8[
                              //                                             index]
                              //                                         .item,
                              //                                     count: "1"));
                              //                                 UserService
                              //                                     .updateUser(
                              //                                         user);
                              //                                 Navigator.of(
                              //                                         context)
                              //                                     .pop();
                              //                                 Navigator.of(
                              //                                         context)
                              //                                     .push(MaterialPageRoute(
                              //                                         builder:
                              //                                             (context) =>
                              //                                                 CartScreen()));
                              //                               },
                              //                               child: Text(
                              //                                 "Yes",
                              //                                 style: TextStyle(
                              //                                   fontSize: 18,
                              //                                   color: Colors
                              //                                       .white,
                              //                                 ),
                              //                               ),
                              //                             )
                              //                           ],
                              //                         ),
                              //                       ),
                              //                     );
                              //                   },
                              //                 );
                              //               },
                              //             ),
                              //           ],
                              //         ),
                              //       );
                              //     },
                              //   ),
                              // ),
                              // SizedBox(height: 8),
                              Text(
                                'Explore Menu',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .headline5
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Container(
                                height: 360,
                                child: GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3),
                                  itemCount: 8,
                                  physics: NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(right: 16.0),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/menu' +
                                                        index.toString() +
                                                        '.png'),
                                                colorFilter: ColorFilter.mode(
                                                    Colors.black45,
                                                    BlendMode.darken),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            child: SizedBox(
                                              height: 108,
                                              width: 115,
                                            ),
                                          ),
                                          Text(
                                            menuName[index],
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .bodyText1
                                                .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 20),
                                            textAlign: TextAlign.center,
                                          ),
                                          InkWell(
                                            child: SizedBox(
                                              height: 108,
                                              width: 115,
                                            ),
                                            onTap: () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MenuScreen(
                                                          index: index,
                                                        ))),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  top: 10,
                                ),
                                alignment: Alignment.topLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'OFFERS',
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .headline5
                                          .copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
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
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Color.fromRGBO(
                                                          255, 143, 54, 1),
                                                      Color.fromRGBO(
                                                          252, 81, 133, 1)
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
                                                style: Theme.of(context)
                                                    .primaryTextTheme
                                                    .headline5
                                                    .copyWith(fontWeight: FontWeight.bold),
                                                textAlign: TextAlign.center,
                                              ),
                                              InkWell(
                                                child: SizedBox(
                                                  height: 108,
                                                  width: 115,
                                                ),
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder:
                                                          (context) =>
                                                              AlertDialog(
                                                                title: Text(
                                                                  "All Offer",
                                                                  style: Theme.of(
                                                                          context)
                                                                      .primaryTextTheme
                                                                      .headline6
                                                                      .copyWith(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              18),
                                                                ),
                                                                content:
                                                                    Container(
                                                                  height: 200,
                                                                  width: 200,
                                                                  child: ListView
                                                                      .builder(
                                                                    itemCount:
                                                                        offers
                                                                            .length,
                                                                    itemBuilder:
                                                                        (context,
                                                                            index) {
                                                                      return ListTile(
                                                                        title: Text(
                                                                            offers[index].offerCode),
                                                                        subtitle:
                                                                            Text(offers[index].percentage +
                                                                                "% OFF"),
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                              ));
                                                },
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 16,
                                          ),
                                          offers.length > 0
                                              ? Stack(
                                                  alignment: Alignment.center,
                                                  children: <Widget>[
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        gradient:
                                                            LinearGradient(
                                                          begin: Alignment
                                                              .topCenter,
                                                          end: Alignment
                                                              .bottomCenter,
                                                          colors: [
                                                            Colors.cyan,
                                                            Color.fromRGBO(
                                                                21, 183, 185, 1)
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
                                                      'min\n${offers[0].percentage}%\nOFF',
                                                      style: Theme.of(context)
                                                          .primaryTextTheme
                                                          .headline5
                                                          .copyWith(fontWeight: FontWeight.bold),
                                                      textAlign:
                                                          TextAlign.center,
                                                    )
                                                  ],
                                                )
                                              : Container(),
                                          SizedBox(
                                            width: 16,
                                          ),
                                          offers.length > 1
                                              ? Stack(
                                                  alignment: Alignment.center,
                                                  children: <Widget>[
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        gradient:
                                                            LinearGradient(
                                                          begin: Alignment
                                                              .topCenter,
                                                          end: Alignment
                                                              .bottomCenter,
                                                          colors: [
                                                           Colors.cyan,
                                                            Color.fromRGBO(
                                                                21, 183, 185, 1)
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
                                                      'min\n${offers[1].percentage}%\nOFF',
                                                      style: Theme.of(context)
                                                          .primaryTextTheme
                                                          .headline5
                                                          .copyWith(fontWeight: FontWeight.bold),
                                                      textAlign:
                                                          TextAlign.center,
                                                    )
                                                  ],
                                                )
                                              : Container(),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      flex: 8,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
