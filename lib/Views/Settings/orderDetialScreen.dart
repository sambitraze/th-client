import 'package:flutter/material.dart';
import 'package:client/models/order.dart';
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
            element.name,
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

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}