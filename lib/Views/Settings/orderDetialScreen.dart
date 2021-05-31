import 'dart:convert';

import 'package:client/Services/PushService.dart';
import 'package:client/Services/orderService.dart';
import 'package:client/Views/Maps/mapscreen.dart';
import 'package:client/Views/UPI/penanltyupi.dart';
import 'package:flutter/material.dart';
import 'package:client/models/order.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:client/ui_constants.dart';

class OrderDetailScreen extends StatefulWidget {
  final Order order;
  OrderDetailScreen({this.order});
  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  Order order;
  bool isVisible = false;
  bool isVisible1 = false;
  List<Widget> srlNo = [
    Text(
      'Sl No.',
      style: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  ];
  List<Widget> itemName = [
    Text(
      'Item Name',
      style: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  ];
  List<Widget> quantity = [
    Text(
      'Quantity',
      style: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  ];
  List<Widget> price = [
    Text(
      'Price',
      style: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  ];

  //Fields
  String status = '';

  @override
  void initState() {
    super.initState();
    order = widget.order;
    isVisible = getStatus();
    isVisible1 = getstatus1();
    genList();
  }

  genList() {
    int i = 0;
    order.items.forEach((element) {
      setState(() {
        srlNo.add(
          Text(
            (i + 1).toString() + ".",
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
        itemName.add(
          Text(
            element.item.name,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
        quantity.add(
          Text(
            'x' + element.count,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
        price.add(
          Text(
            '₹' + element.item.price,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
        i++;
      });
    });
  }

  getstatus1() {
    if (order.status == 'Placed' || order.status == "Received")
      return true;
    else
      return false;
  }

  getStatus() {
    if (order.status == 'Out for Delivery')
      return true;
    else
      return false;
  }

  callAction(String number) async {
    String url = 'tel:$number';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not call $number';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          'Order Details',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.blue, //change your color here
        ),
      ),
      body: Container(
        height: UIConstants.fitToHeight(640, context),
        width: UIConstants.fitToWidth(360, context),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListTile(
                  title: Text('#${order.orderId}',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                  subtitle: Text(
                    '${DateFormat("yy-MM-dd HH:mm:SSS").parse(order.createdAt.toString(), true).toLocal()}',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(height: UIConstants.fitToHeight(15, context)),
                Divider(
                  height: 1,
                  thickness: 1,
                  endIndent: 10,
                  indent: 10,
                  color: Colors.black,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Order Type: ',
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Text(
                        order.orderType,
                        textAlign: TextAlign.left,
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                  endIndent: 10,
                  indent: 10,
                  color: Colors.black,
                ),
                SizedBox(height: UIConstants.fitToHeight(15, context)),
                ListTile(
                  title: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      "Deliver to",
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      )),
                    ),
                  ),
                  subtitle: Text(
                    '${order.customer.name}, \n${order.customer.address}',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: UIConstants.fitToHeight(15, context)),
                Divider(
                  height: 1,
                  thickness: 1,
                  endIndent: 10,
                  indent: 10,
                  color: Colors.black,
                ),
                SizedBox(height: UIConstants.fitToHeight(15, context)),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 1.0, bottom: 1.0),
                        child: Text(
                          'ITEMS',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(children: srlNo),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: itemName),
                              Column(children: quantity),
                              Column(children: price),
                            ]),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: UIConstants.fitToHeight(15, context)),
                Divider(
                  height: 1,
                  thickness: 1,
                  endIndent: 10,
                  indent: 10,
                  color: Colors.black,
                ),
                SizedBox(height: UIConstants.fitToHeight(15, context)),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Item total: ',
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Text(
                        'Rs ${double.parse(order.amount)}',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Charges: ',
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Text('₹ ${order.gst}',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          )),
                    ],
                  ),
                ),
                // Padding(
                //   padding:
                //       const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text('Item deduction: ',
                //           style:GoogleFonts.lato(
                //           textStyle: TextStyle(
                //             fontSize: 17,
                //             fontWeight: FontWeight.w600,
                //             color: Colors.white,
                //           ),),),
                //       Text(
                //         '- ₹ ${double.parse(order.deduction.numberDecimal).toStringAsFixed(2)}',
                //         textAlign: TextAlign.left,
                //         style: GoogleFonts.lato(
                //           textStyle: TextStyle(
                //             fontSize: 17,
                //             fontWeight: FontWeight.w600,
                //             color: Colors.white,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Grand Total: ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          )),
                      Text(
                          '₹ ${(double.parse(order.amount) + double.parse(order.gst) + double.parse(order.packing)).toStringAsFixed(2)}',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                SizedBox(height: UIConstants.fitToHeight(15, context)),
                Divider(
                  height: 1,
                  thickness: 1,
                  endIndent: 10,
                  indent: 10,
                  color: Colors.black,
                ),
                SizedBox(height: UIConstants.fitToHeight(15, context)),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Payment Method: ',
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          )),
                      Text('${order.paymentType}',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Order Status: ',
                          style: GoogleFonts.lato(
                            textStyle: GoogleFonts.lato(
                              textStyle: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          )),
                      Text('${order.status}',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(height: UIConstants.fitToHeight(15, context)),
                Divider(
                  height: 1,
                  thickness: 1,
                  endIndent: 10,
                  indent: 10,
                  color: Colors.black,
                ),
                SizedBox(height: UIConstants.fitToHeight(15, context)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    order.status == "out for delivery"
                        ? MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            color: Colors.redAccent,
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      MapScreen(order: order)));
                            },
                            child: Text(
                              'Track',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          )
                        : Container(),
                    order.status == "placed" || order.status == "cooking"
                        ? SizedBox(
                            width: 28,
                          )
                        : Container(),
                    order.status == "placed" || order.status == "cooking"
                        ? MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            color: Colors.redAccent,
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: Text(
                                          "Alert",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        ),
                                        content: Text(
                                          "Do You want to cancel your order ?",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              .copyWith(fontSize: 16),
                                        ),
                                        actions: [
                                          MaterialButton(
                                            onPressed: () async {
                                              if (DateTime.now()
                                                      .difference(DateFormat(
                                                              "yy-MM-dd HH:mm:SSS")
                                                          .parse(
                                                              order.createdAt
                                                                  .toString(),
                                                              true)
                                                          .toLocal())
                                                      .inMinutes >
                                                  10) {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            PenaltyUPI(
                                                              order: order,
                                                            )));
                                              } else {
                                                setState(() {
                                                  order.status = "cancelled";
                                                });
                                                OrderService.updateOrder(
                                                    jsonEncode(order.toJson()));

                                                await PushService.sendToAdmin(
                                                    "Order Update !!!",
                                                    "An order no : ${order.orderId}  has been added to cancelled by user",
                                                    "test");
                                              }
                                            },
                                            child: Text(
                                              "Yes",
                                            ),
                                          ),
                                          MaterialButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              "No",
                                            ),
                                          ),
                                        ],
                                      ));
                            },
                            child: Text(
                              'Cancel',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
