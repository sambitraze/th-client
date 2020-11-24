import 'package:client/Services/ItemService.dart';
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
    'Salads\n&\nRaita',
  ];
  @override
  void initState() {
    // TODO: implement initState
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
                  padding: const EdgeInsets.symmetric(vertical:8.0, horizontal: 15),
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
                                // onTap: () => Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => MenuList(
                                //       itemno: index.toString(),
                                //       title: menuname[index],
                                //       itemlist: geblist(index),
                                //     ),
                                //   ),
                              //   ),
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
