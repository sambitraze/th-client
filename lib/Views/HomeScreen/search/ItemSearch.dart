import 'package:client/Services/UserService.dart';
import 'package:client/Views/Cart/CartScreen.dart';
import 'package:client/models/Item.dart';
import 'package:client/models/User.dart';
import 'package:client/models/cartItem.dart';
import 'package:flutter/material.dart';

class ItemSearch extends SearchDelegate<String> {
  final List<String> names;
  final List<Item> items;
  ItemSearch({this.names, this.items});

  List<Item> tempItemList = [];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow,
            progress: transitionAnimation,
            color: Color(0xff25354E)),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    List suggestionList = [];
    tempItemList.clear();
    for (int i = 0; i < names.length; i++) {
      if (names[i].toLowerCase().contains(query.toLowerCase())) {
        tempItemList.add(items[i]);
        suggestionList.add(names[i]);
      }
    }

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.builder(
        itemBuilder: (context, index) => ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 0),
            onTap: () {
              print(index);
              showDialog(
                context: context,
                builder: (context) {
                  return StatefulBuilder(
                    builder: (context, setState) => AlertDialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      title: Text(
                          "Do you want to add ${tempItemList[index].name} to your cart ?"),
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            color: Colors.white,
                            onPressed: () async {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "NO",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(width: 16,),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            color: Colors.orange,
                            onPressed: () async {
                              User user = await UserService.getUserByPhone();
                              user.cart.add(CartItem(
                                  item: tempItemList[index], count: "1"));
                              UserService.updateUser(user);
                              Navigator.of(context).pop();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => CartScreen()));
                            },
                            child: Text(
                              "Yes",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            trailing: Text(tempItemList[index].category,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
            leading: Icon(Icons.fastfood),
            title: Text(tempItemList[index].name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.normal))),
        itemCount: suggestionList.length,
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List suggestionList = [];
    tempItemList.clear();
    for (int i = 0; i < names.length; i++) {
      if (names[i].toLowerCase().contains(query.toLowerCase())) {
        tempItemList.add(items[i]);
        suggestionList.add(names[i]);
      }
    }

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.builder(
        itemBuilder: (context, index) => ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 0),
            onTap: () {
              print(index);
              showDialog(
                context: context,
                builder: (context) {
                  return StatefulBuilder(
                    builder: (context, setState) => AlertDialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      title: Text(
                          "Do you want to add ${tempItemList[index].name} to your cart ?"),
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            color: Colors.white,
                            onPressed: () async {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "NO",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(width: 16,),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            color: Colors.orange,
                            onPressed: () async {
                              User user = await UserService.getUserByPhone();
                              user.cart.add(CartItem(
                                  item: tempItemList[index], count: "1"));
                              UserService.updateUser(user);
                              Navigator.of(context).pop();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => CartScreen()));
                            },
                            child: Text(
                              "Yes",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            trailing: Text(tempItemList[index].category,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
            leading: Icon(Icons.fastfood),
            title: Text(tempItemList[index].name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.normal))),
        itemCount: suggestionList.length,
      ),
    );
  }
}
