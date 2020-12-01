import 'package:client/Services/UserService.dart';
import 'package:client/Services/orderService.dart';
import 'package:client/Views/Settings/orderDetialScreen.dart';
import 'package:client/models/User.dart';
import 'package:client/models/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderHistory extends StatefulWidget {
  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  String id;
  String billno;
  List billist = [];
  List<Order> orders = [];
  User user;
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    user = await UserService.getUserByPhone();
    orders = await OrderService.getAllOrdersById(user.id);
    // orders = orders.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              child: Center(
                child: SvgPicture.asset(
                  'assets/svg/orderhistory.svg',
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
                  ListTile(
                    contentPadding: EdgeInsets.all(1),
                    leading: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Order History",
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: orders.length,
                      itemBuilder: (context, int index) {
                        return Container(
                          color: Colors.black38,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Divider(
                                color: Colors.grey.withOpacity(0.88),
                                height: 1,
                              ),
                              ListTile(
                                leading: Text(
                                  'Order No: ' +
                                      orders[index].orderId,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                title: Icon(
                                  Icons.check,
                                  color: Colors.green,
                                ),
                                trailing: FlatButton.icon(
                                  onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => OrderDetailScreen(
                                                                         ),
                                    ),
                                  ),
                                  icon: Icon(
                                    Icons.location_searching,
                                    color: Colors.red,
                                  ),
                                  label: Text(
                                    'Track Order',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Divider(
                                color: Colors.grey.withOpacity(0.48),
                                height: 1,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Items',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          ' ' ,
                                          // +
                                          //     name
                                          //         .toString()
                                          //         .replaceAll('[', '')
                                          //         .replaceAll(']', '')
                                          //         .replaceAll(',', '\n'
                                                  // ),
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[400],
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "Time",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          " " ,
                                          // +
                                          //     formatter.format(DateTime.parse(
                                          //         snapshot.data
                                          //             .documents[index]['date']
                                          //             .toDate()
                                          //             .toString())),
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[400],
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Total: ',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: Colors.grey.withOpacity(0.48),
                                height: 0,
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
          ],
        ),
      ),
    );
  }
}
