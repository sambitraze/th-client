import 'package:client/Services/ItemService.dart';
import 'package:client/Views/Menu/ItemListScreen.dart';
import 'package:client/models/Item.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  List<Item> items = [];
  List<String> menuname = [
    'Tandoor',
    'Main\nCourse',
    'Chinese\nMain\nCourse',
    'Rice\n&\nBiryani',
    'Noodles',
    'Rolls\n&\nDimsums',
    'Breads',
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
    else if (i == 6) return menulist6;
  }

  List<Item> menulist0 = [];
  List<Item> menulist1 = [];
  List<Item> menulist2 = [];
  List<Item> menulist3 = [];
  List<Item> menulist4 = [];
  List<Item> menulist5 = [];
  List<Item> menulist6 = [];
  @override
  void initState() {
    getItems();
    super.initState();
  }

  bool loading = false;

  getItems() async {
    setState(() {
      loading = true;
    });
    items = await ItemService.getItems();
    print(items.length);
    items.forEach((element) {
      setState(() {
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
        }
      });
    });
    print(items.length);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  child: Image(
                    image: AssetImage("assets/menubg.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 148,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 15),
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: InkWell(
                            child: Text(
                              "Menu",
                              style: TextStyle(
                                fontSize: 42,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: GridView.count(
                          crossAxisCount: 2,
                          children: List.generate(
                            7,
                            (index) {
                              return Container(
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                          image: AssetImage('assets/menu' +
                                              index.toString() +
                                              '.png'),
                                              colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: SizedBox(
                                        height: 163,
                                        width: 159,
                                      ),
                                    ),
                                    Text(
                                      menuname[index],
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 26,
                                      ),
                                    ),
                                    InkWell(
                                      child: SizedBox(
                                        height: 163,
                                        width: 159,
                                      ),
                                      onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ItemListScreen(
                                            // itemno: index.toString(),
                                            title: menuname[index],
                                            itemlist: getlist(index),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
