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
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  ];
  List<Widget> itemName = [
    Text(
      'Item Name',
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  ];
  List<Widget> quantity = [
    Text(
      'Quantity',
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  ];
  List<Widget> price = [
    Text(
      'Price',
      style: TextStyle(
        color: Colors.white,
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
              color: Colors.white,
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
              color: Colors.white,
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
              color: Colors.white,
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
              color: Colors.white,
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
      backgroundColor: Colors.black,      
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.black,
        elevation: 0.0,
        title: Text(
          'Order Details',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30),
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
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                  subtitle: Text(
                    '${DateFormat("yy-MM-dd HH:mm:SSS").parse(order.createdAt.toString(), true).toLocal()}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                 SizedBox(height: UIConstants.fitToHeight(25, context)),
                ListTile(
                  title: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      "Deliver to",
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),),
                    ),
                  ),
                  subtitle: Text(
                    '${order.customer.name}, \n${order.customer.address}',
                    style:TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                  ),
                ),
                SizedBox(height: UIConstants.fitToHeight(15, context)),
                Divider(
                  height: 1,
                  thickness: 1,
                  endIndent: 10,
                  indent: 10,
                  color: Colors.white,
                ),
                SizedBox(height: UIConstants.fitToHeight(15, context)),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0,bottom: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 1.0, bottom: 1.0),
                        child: Text(
                          'ITEMS',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(children: srlNo),
                              Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
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
                  color: Colors.white,
                ),
                SizedBox(height: UIConstants.fitToHeight(15, context)),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Item total: ',
                         style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),),),
                      Text('Rs ${double.parse(order.amount)}',
                          textAlign: TextAlign.left,
                          style:GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),),),
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
                        style:GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),),
                      ),
                      Text('₹ ${order.gst}',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),)),
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
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          )),
                      Text(
                          '₹ ${(double.parse(order.amount) + double.parse(order.gst) + double.parse(order.packing)).toStringAsFixed(2)}',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.white,
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
                  color: Colors.white,
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
                            color: Colors.white,
                          ),)),
                      Text('${order.paymentType}',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),)),
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
                          style:GoogleFonts.lato(
                          textStyle: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),),
                          )),
                      Text('${order.status}',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),)),
                    ],
                  ),
                ),
                SizedBox(height: UIConstants.fitToHeight(15, context)),
                Divider(
                  height: 1,
                  thickness: 1,
                  endIndent: 10,
                  indent: 10,
                  color: Colors.white,
                ),
                SizedBox(height: UIConstants.fitToHeight(15, context)),
                // ListTile(
                //   trailing: Row(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     mainAxisSize: MainAxisSize.min,
                //     children: [
                //       isVisible
                //           ? IconButton(
                //               icon: Icon(
                //                 Icons.call,
                //                 color: Colors.green,
                //               ),
                //               onPressed: () {
                //                 callAction(order.deliveryBy.phone);
                //               })
                //           : Container(),
                //       trackButton(context),
                //       cancelOrder(context)
                //     ],
                //   ),
                //   title: Padding(
                //     padding: const EdgeInsets.symmetric(vertical: 4.0),
                //     child: Text(
                //       "Delivery By",
                //       style: TextStyle(
                //             fontSize: 16,
                //             fontWeight: FontWeight.normal,
                //             color: Colors.white,
                //           ),
                //     ),
                //   ),
                //   subtitle: Text(
                //     '${order.deliveryBy.name}\n${order.deliveryBy.phone}',
                //     style: TextStyle(
                //             fontSize: 17,
                //             fontWeight: FontWeight.bold,
                //             color: Colors.white,
                //           ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}