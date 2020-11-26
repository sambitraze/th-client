import 'package:client/models/Item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
class ItemListScreen extends StatefulWidget {
  ItemListScreen({this.title, this.itemlist});

  final String title;
  // final String itemno;
  final List<Item> itemlist;
  @override
  _ItemListScreenState createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
              leading: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  Image.asset(
                    'assets/menulist.png',
                    height: 60,
                  )
                ],
              ),
              trailing: Padding(
                padding: const EdgeInsets.only(top: 10, right: 10),
                child: MaterialButton(
                  color: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  onPressed: () {
                    // add2cart();
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Processing'),
                        backgroundColor: Colors.transparent,
                        contentPadding: EdgeInsets.symmetric(horizontal: 130),
                        content: CircularProgressIndicator(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Add to\ncart',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title.replaceAll('\n', '\t'),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  //   IconButton(
                  //     icon: Icon(Icons.search, color: Colors.white, size: 30),
                  //     onPressed: () => print('fsd'),
                  //   )
                ],
              ),
            ),
            Divider(
              color: Colors.grey.withOpacity(0.48),
              height: 1,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.itemlist.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return Container(
                    color: Colors.black38,
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: new ListTile(
                            leading: widget.itemlist[index].isVeg
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
                                  widget.itemlist[index].name,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                RatingBar(
                                  ratingWidget: RatingWidget(full: Icon(Icons.star),half: Icon(Icons.star_half), empty: Icon(Icons.star_outline),),
                                  direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    onRatingUpdate: (v) {},
                                    itemCount: 5,
                                    initialRating: double.parse(widget
                                        .itemlist[index].rating
                                        .toString()),
                                    itemSize: 13.0,
                                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                    ),
                                Row(children: <Widget>[
                                  Image.asset(
                                    'assets/rupee.png',
                                    height: 16,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    widget.itemlist[index].price,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ])
                              ],
                            ),
                            trailing: Column(
                              children: <Widget>[
                                // quantity[index] > 0
                                //     ? Expanded(
                                //         child: StepperSwipe(
                                //           initialValue: quantity[index],
                                //           speedTransitionLimitCount: 1,
                                //           firstIncrementDuration:
                                //               Duration(milliseconds: 250),
                                //           secondIncrementDuration:
                                //               Duration(milliseconds: 100),
                                //           direction: Axis.horizontal,
                                //           dragButtonColor: Colors.orange,
                                //           withSpring: true,
                                //           withNaturalNumbers: true,
                                //           onChanged: (int val) {
                                //             print('New value : $val');
                                //             setState(() {
                                //               quantity[index] = val;
                                //             });
                                //           },
                                        // ),
                                    //   )
                                    // : 
                                    Expanded(
                                        child: MaterialButton(
                                          color: Colors.orange,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          height: 8,
                                          onPressed: () {
                                            print('add');
                                            // setState(() {
                                            //   quantity[index] = 1;
                                            // });
                                          },
                                          child: Text(
                                            'Add +',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                Text(
                                  'customizable',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
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