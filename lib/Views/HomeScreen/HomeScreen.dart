import 'package:client/Services/ItemService.dart';
import 'package:client/Services/UserService.dart';
import 'package:client/Views/HomeScreen/search/ItemSearch.dart';
import 'package:client/Views/Menu/ItemListScreen.dart';
import 'package:client/Views/Settings/ManageAddress.dart';
import 'package:client/Views/Settings/ProfileScreen.dart';
import 'package:client/models/Item.dart';
import 'package:client/models/User.dart';
import 'package:flutter/material.dart';

import '../../ui_constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  bool loading = false;
  User client;
  List<Item> items = [];
  List<String> itemNames = [];
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
  // ignore: missing_return
  List<Item> getlist(int i) {
    if (i == 0)
      return menulist0;
    else if (i == 1)
      return menulist1;
    else if (i == 2)
      return menulist2;
    else if (i == 3)
      return menulist3;
    else if (i == 4)
      return menulist4;
    else if (i == 5)
      return menulist5;
    else if (i == 6)
      return menulist6;
    else if (i == 7) return menulist7;
  }

  List<Item> menulist0 = [];
  List<Item> menulist1 = [];
  List<Item> menulist2 = [];
  List<Item> menulist3 = [];
  List<Item> menulist4 = [];
  List<Item> menulist5 = [];
  List<Item> menulist6 = [];
  List<Item> menulist7 = [];


  @override
  void initState() {
    getData();
    _tabController =
        TabController(length: 8, vsync: this, initialIndex: _index);
    super.initState();
  }

  getData() async {
    setState(() {
      loading = true;
    });
    itemNames.clear();
    items = await ItemService.getItems();
    items.forEach((element) {
      itemNames.add(element.name);
      if (element.category == "Tandoor") {
        menulist0.add(element);
      } else if (element.category == "Main Course") {
        menulist1.add(element);
      } else if (element.category == "Chinese Main Course") {
        menulist2.add(element);
      } else if (element.category == "Rice/Biryani") {
        menulist3.add(element);
      } else if (element.category == "Noodles") {
        menulist4.add(element);
      } else if (element.category == "Rolls and Momos") {
        menulist5.add(element);
      } else if (element.category == "Breads") {
        menulist6.add(element);
      } else if (element.category == "Beverages") {
        menulist7.add(element);
      }
    });
    client = await UserService.getUserByPhone();
    setState(() {
      loading = false;
    });
  }

  TabController _tabController;
  int _index = 0;
  List searchResult = [];

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
                child: Center(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage(
                                'assets/menu' + _index.toString() + '.png'),
                            colorFilter: ColorFilter.mode(
                                Colors.black45, BlendMode.darken),
                            fit: BoxFit.cover,
                          )),
                          // height: MediaQuery.of(context).size.height * 0.23,
                          // width: MediaQuery.of(context).size.width,
                          // color: Colors.orange,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
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
                                      client =
                                          await UserService.getUserByPhone();
                                      setState(() {});
                                    });
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Home',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        client.address,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
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
                                      InkWell(
                                        child: Icon(
                                          Icons.search
                                              ,color: Colors.white,size: 28,
                                        ),
                                        onTap: () {
                                          showSearch(
                                              context: context,
                                              delegate: ItemSearch(
                                                  names: itemNames, items: items));
                                        }
                                      ),
                                      SizedBox(width: 16,),
                                      InkWell(
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: Text(
                                            client.name.substring(0, 1),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 22,
                                            ),
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
                              SizedBox(height: 70,),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                child: TabBar(
                                  isScrollable: true,
                                  controller: _tabController,
                                  indicator: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  labelStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                  unselectedLabelStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                  unselectedLabelColor: Colors.white,
                                  labelColor: Colors.black,
                                  tabs: [
                                    Tab(
                                      text: "Tandoor",
                                    ),
                                    Tab(
                                      text: "Main Course",
                                    ),
                                    Tab(
                                      text: "Chinese Main Course",
                                    ),
                                    Tab(
                                      text: "Rice/Biryani",
                                    ),
                                    Tab(
                                      text: "Noodles",
                                    ),
                                    Tab(
                                      text: "Rolls and Momos",
                                    ),
                                    Tab(
                                      text: "Breads",
                                    ),
                                    Tab(
                                      text: "Beverages",
                                    ),
                                  ],
                                  onTap: (value) {
                                    setState(() {
                                      _index = value;
                                    });
                                    _tabController.animateTo(value,
                                        curve: Curves.easeIn,
                                        duration: Duration(milliseconds: 500));
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 9,
                        child: TabBarView(
                          physics: NeverScrollableScrollPhysics(),
                          controller: _tabController,
                          children: <Widget>[
                            ItemListScreen(
                              title: menuName[0],
                              itemlist: getlist(0),
                            ),
                            ItemListScreen(
                              title: menuName[1],
                              itemlist: getlist(1),
                            ),
                            ItemListScreen(
                              title: menuName[2],
                              itemlist: getlist(2),
                            ),
                            ItemListScreen(
                              title: menuName[3],
                              itemlist: getlist(3),
                            ),
                            ItemListScreen(
                              title: menuName[4],
                              itemlist: getlist(4),
                            ),
                            ItemListScreen(
                              title: menuName[5],
                              itemlist: getlist(5),
                            ),
                            ItemListScreen(
                              title: menuName[6],
                              itemlist: getlist(6),
                            ),
                            ItemListScreen(
                              title: menuName[7],
                              itemlist: getlist(7),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

}
