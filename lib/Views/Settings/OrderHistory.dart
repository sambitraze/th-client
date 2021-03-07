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
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Order History",
          style: TextStyle(
            fontSize: 32,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.black12,
      body: !loading
          ? Stack(
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
                orders.length > 0
                    ? Container(
                        color: Colors.black12,
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
                                          trailing: Container(
                                            width: 100,
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
                                              child: Text(
                                                'Details',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                ),
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
                                                    'Status',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    orders[index].status,
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey[400],
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Time",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    '${orders[index].createdAt.day}-${orders[index].createdAt.month}-${orders[index].createdAt.year}',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey[400],
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
                                                      color: Colors.white,
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
                      )
                    : Column(
                        children: [
                          SizedBox(
                            height: 100,
                          ),
                          Center(
                              child: Text(
                            "No Orders ",
                            style: TextStyle(color: Colors.white),
                          )),
                        ],
                      ),
              ],
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
