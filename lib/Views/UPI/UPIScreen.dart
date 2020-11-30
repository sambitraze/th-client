import 'dart:convert';

import 'package:client/LandingScreen.dart';
import 'package:client/Services/PushService.dart';
import 'package:client/Services/UserService.dart';
import 'package:client/Services/orderService.dart';
import 'package:client/models/User.dart';
import 'package:client/models/order.dart';
import 'package:flutter/material.dart';
import 'package:client/ui_constants.dart';
import 'package:flutter_upi/flutter_upi.dart';

class UPIScreen extends StatefulWidget {
  UPIScreen({this.order, this.total});
  final String total;
  final Order order;
  @override
  _UPIScreenState createState() => _UPIScreenState();
}

class _UPIScreenState extends State<UPIScreen> {
  Future _initiateTransaction;
  GlobalKey<ScaffoldState> _key;
  SliverGridDelegate sliverGridDelegate;
  @override
  void initState() {
    super.initState();
    _key = GlobalKey<ScaffoldState>();
    //_initiateTransaction = initTransaction();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<String> initTransaction(String app) async {
    try {
      String response = await FlutterUpi.initiateTransaction(
          app: app,
          pa: "sayannath235@okicici", //replace
          pn: "Sayan Nath",
          tr: widget.order.orderId,
          tn: "Tandoor Hut payment",
          am: widget.total,
          cu: "INR",
          url: "http://www.tandoorhut.tk");
      print(response);

      return response;
    } catch (e) {
      _key.currentState.showSnackBar(new SnackBar(
        content: new Text("Payment Cancel"),
      ));
    }
  }

  placeOrder() async {
    OrderService.createOrder(json.encode(widget.order.toJson()));
    // DeliveryBoy boy =
    //     await DeliveryService.getDeliveryBoy(widget.order.deliveryBy.id);
    // await DeliveryService.updateDeliveryData(
    //     boy.id, (int.parse(boy.assignedOrder) + 1).toString());
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext context) => LandingScreen()),
      ModalRoute.withName('/'),
    );    
    await PushService.sendPushToSelf("Order Update !!!",
        "Your order no : ${widget.order.orderId} is placed succesfully");
    // await PushService.sendPushToVendor("New Update !!!",
    //     "New Order : ${widget.order.orderId} ", widget.vendor.deviceToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: FutureBuilder(
                future: _initiateTransaction,
                builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      snapshot.data == null) {
                    return Text(
                      "Payment Options",
                      style: TextStyle(
                          color: Color(0xff25354E),
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    );
                  } else {
                    switch (snapshot.data.toString()) {
                      case 'app_not_installed':
                        return Text("Application not installed.");
                        break;
                      case 'invalid_params':
                        return Text("Request parameters are wrong");
                        break;
                      case 'user_canceled':
                        return Text("User canceled the flow");
                        break;
                      case 'null_response':
                        return Text("No data received");
                        break;
                      default:
                        {
                          FlutterUpiResponse flutterUpiResponse =
                              FlutterUpiResponse(snapshot.data);
                          print(flutterUpiResponse.txnId);
                          if (flutterUpiResponse.Status != "SUCCESS") {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      LandingScreen()),
                              ModalRoute.withName('/'),
                            );
                          }
                          if (flutterUpiResponse.Status == "SUCCESS") {
                            setState(() {
                              widget.order.paid = true;
                              widget.order.txtId = flutterUpiResponse.txnId;
                            });
                          }
                          return Text('Status: ' + flutterUpiResponse.Status);
                        }
                    }
                  }
                },
              ),
            ),
            gridView(context)
          ],
        ),
      ),
    );
  }

  Widget gridView(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: UIConstants.fitToWidth(16, context),
          right: UIConstants.fitToWidth(16, context),
          top: UIConstants.fitToHeight(48, context)),
      child: GridView.count(
        shrinkWrap: true,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        crossAxisCount: 2,
        children: [
          metricCard('googlepay_upi.jpg', 'Google Pay', onTap: () {
            _initiateTransaction = initTransaction(FlutterUpiApps.GooglePay);
            // setState(() {});
          }),
          metricCard('phonepe_upi.png', 'PhonePe UPI', onTap: () {
            _initiateTransaction = initTransaction(FlutterUpiApps.PhonePe);
            // setState(() {});
          }),
          metricCard(
            'bhim.png',
            'BHIM UPI',
            onTap: () {
              _initiateTransaction = initTransaction(FlutterUpiApps.BHIMUPI);
              // setState(() {});
            },
          ),
          metricCard('amazon_pay.jpg', 'Amazon UPI', onTap: () {
            _initiateTransaction = initTransaction(FlutterUpiApps.AmazonPay);
            // setState(() {});
          }),
        ],
      ),
    );
  }

  Widget metricCard(String assets, String title, {VoidCallback onTap}) {
    onTap ??= () {};
    return Container(
      height: UIConstants.fitToHeight(150, context),
      width: UIConstants.fitToWidth(151, context),
      child: Ink(
        decoration: BoxDecoration(
            color: Color(0xff38414D),
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                offset: Offset(2, -2),
                blurRadius: 4,
                color: Color.fromRGBO(0, 0, 0, 0.25),
              ),
              BoxShadow(
                offset: Offset(-2, 2),
                blurRadius: 5,
                color: Color.fromRGBO(0, 0, 0, 0.25),
              ),
            ]),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8.0),
          splashColor: Color(0xff686C71),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                  padding:
                      const EdgeInsets.only(left: 9.5, right: 9.5, top: 16),
                  child: Image.asset(
                    'assets/$assets',
                    height: UIConstants.fitToHeight(85, context),
                    width: UIConstants.fitToWidth(85, context),
                  )),
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 16),
                child: Text('$title',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .subtitle2
                        .copyWith(fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
