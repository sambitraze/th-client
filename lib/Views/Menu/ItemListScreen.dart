import 'package:client/Services/UserService.dart';
import 'package:client/Views/Cart/CartScreen.dart';
import 'package:client/models/Item.dart';
import 'package:client/models/User.dart';
import 'package:client/models/cartItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:stepper_counter_swipe/stepper_counter_swipe.dart';

class ItemListScreen extends StatefulWidget {
  ItemListScreen({this.title, this.itemlist});

  final String title;
  final List<Item> itemlist;
  @override
  _ItemListScreenState createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  List<CartItem> cartItems = [];
  final scaffkey = new GlobalKey<ScaffoldState>();
  User user;
  int prevCartLength = 0;
  @override
  void initState() {
    widget.itemlist.forEach((element) {
      cartItems.add(CartItem(
        item: element,
        count: "0",
      ));
    });
    getUserData();
    super.initState();
  }

  getUserData() async {
    user = await UserService.getUserByPhone();
    setState(() {
      prevCartLength = user.cart.length;
    });
  }

  add2cart() async {
    setState(() {
      user.name = "sam";
    });
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Processing'),
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.symmetric(horizontal: 130),
        content: CircularProgressIndicator(),
      ),
    );
    UserService.updateUser(user);
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CartScreen()));
  }

  bool chkoutbutton = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffkey,
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Choose your dish",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  MaterialButton(
                    color: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    onPressed: () {
                      cartItems.forEach((element) {
                        if (element.count != "0") {
                          setState(() {
                            user.cart.add(element);
                          });
                        }
                      });
                      if (prevCartLength < user.cart.length) {
                        add2cart();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                          content: new Text(
                            "Select an item first",
                            style: TextStyle(color: Colors.white),
                          ),
                        ));
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Add to cart',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
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
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return Container(
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: new ListTile(
                            leading: cartItems[index].item.isVeg
                                ? Image.asset(
                                    'assets/veg.png',
                                    height: 20,
                                  )
                                : Image.asset(
                                    'assets/nonveg.png',
                                    height: 20,
                                  ),
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  cartItems[index].item.name,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                RatingBar(
                                  ratingWidget: RatingWidget(
                                    full: Icon(
                                      Icons.star,
                                      color: Colors.amberAccent,
                                    ),
                                    half: Icon(
                                      Icons.star_half,
                                      color: Colors.amberAccent,
                                    ),
                                    empty: Icon(
                                      Icons.star_outline,
                                      color: Colors.amberAccent,
                                    ),
                                  ),
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  onRatingUpdate: (v) {},
                                  itemCount: 5,
                                  initialRating: double.parse(
                                      cartItems[index].item.rating.toString()),
                                  itemSize: 13.0,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 4.0),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Row(children: <Widget>[
                                  Image.asset(
                                    'assets/rupee.png',
                                    height: 16,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    cartItems[index].item.price,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ])
                              ],
                            ),
                            trailing: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                int.parse(cartItems[index].count) > 0
                                    ? Expanded(
                                        child: StepperSwipe(
                                          stepperValue:
                                              int.parse(cartItems[index].count),
                                          initialValue:
                                              int.parse(cartItems[index].count),
                                          speedTransitionLimitCount: 1,
                                          firstIncrementDuration:
                                              Duration(milliseconds: 250),
                                          secondIncrementDuration:
                                              Duration(milliseconds: 100),
                                          direction: Axis.horizontal,
                                          dragButtonColor: Colors.orange,
                                          iconsColor: Colors.orange,
                                          withSpring: true,
                                          minValue: 0,
                                          onChanged: (int val) {
                                            print('New value : $val');
                                            setState(() {
                                              cartItems[index].count =
                                                  val.toString();
                                            });
                                          },
                                        ),
                                      )
                                    : MaterialButton(
                                        color: Colors.orange,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        height: 32,
                                        onPressed: () {
                                          print('add');
                                          setState(() {
                                            chkoutbutton = true;
                                            cartItems[index].count = "1";
                                          });
                                        },
                                        child: Text(
                                          'Add +',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                // Text(
                                //   'customizable',
                                //   style: TextStyle(
                                //     color: Colors.black,
                                //     fontSize: 12,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
