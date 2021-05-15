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

  bool loading = false;

  getData() async {
    setState(() {
      loading = true;
    });
    user = await UserService.getUserByPhone();
    orders = await OrderService.getAllOrdersById(user.id);
    print(orders.length);
    // orders = orders.reversed.toList();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Order History",
          style:Theme.of(context).primaryTextTheme.headline4.copyWith(fontWeight: FontWeight.bold, color: Colors.black,fontSize: 28),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: !loading
          ? orders.length > 0
              ? Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: orders.length,
                          itemBuilder: (context, int index) {
                            return Container(
                              color: Colors.white,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Divider(
                                    color: Colors.black,
                                    height: 1,
                                  ),
                                  ListTile(
                                    leading: Text(
                                      'Order No: ' +
                                          orders[index].orderId,
                                      style:Theme.of(context).primaryTextTheme.bodyText1.copyWith(fontWeight: FontWeight.bold, color: Colors.black,fontSize: 17),
                                    ),
                                    trailing: Container(
                                      width: 120,
                                      child: MaterialButton(
                                        onPressed: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                OrderDetailScreen(
                                              order: orders[index],
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.menu),
                                            SizedBox(width: 6,),
                                            Text(
                                              'Details',
                                              style:Theme.of(context).primaryTextTheme.bodyText1.copyWith(fontWeight: FontWeight.bold, color: Colors.black,fontSize: 17),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.black,
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
                                              'Status',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight:
                                                    FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              orders[index].status,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black,
                                                fontWeight:
                                                    FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "Time",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight:
                                                    FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              '${orders[index].createdAt.day}-${orders[index].createdAt.month}-${orders[index].createdAt.year}',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black,
                                                fontWeight:
                                                    FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Total: Rs ${(double.parse(orders[index].amount) + double.parse(orders[index].gst) + double.parse(orders[index].packing)).toStringAsFixed(2)}',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight:
                                                    FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.black,
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
                )
              : Column(
                  children: [
                    SizedBox(
                      height: 100,
                    ),Center(
                      child: SvgPicture.asset(
                        'assets/svg/orderhistory.svg',
                        height: 128.0,
                      ),
                    ),
                    Center(
                        child: Text(
                      "No Orders ",
                      style: TextStyle(color: Colors.black),
                    )),
                    SizedBox(
                      height: 100,
                    ),
                  ],
                )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
