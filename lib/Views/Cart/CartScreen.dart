import 'dart:convert';

import 'package:client/LandingScreen.dart';
import 'package:client/Services/DeliveryBoyService.dart';
import 'package:client/Services/PushService.dart';
import 'package:client/Services/UserService.dart';
import 'package:client/Services/orderService.dart';
import 'package:client/Views/Settings/ManageAddress.dart';
import 'package:client/Views/UPI/UPIScreen.dart';
import 'package:client/models/User.dart';
import 'package:client/models/deliveryBoy.dart';
import 'package:client/models/order.dart';
import 'package:flutter/material.dart';
import 'package:stepper_counter_swipe/stepper_counter_swipe.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_rating_bar/src/rating_bar.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool istrue = true;
  bool showBill = true;
  User user;
  bool loading = false;
  bool chkcart = true;

  @override
  void initState() {
    // TODO: implement initState
    getUserData();
    assignDelivery();
    super.initState();
  }

  getUserData() async {
    setState(() {
      loading = true;
    });
    user = await UserService.getUserByPhone();
   if(user.cart!=null){
     setState(() {
       chkcart = false;
     });
      calcBill();
   }
   else{
 setState(() {
       chkcart = true;
     });
   }
    setState(() {
      loading = false;
    });
  }

  bool processing = false;
  bool loading1 = false;
  double itemsum = 0;
  double delivery = 0;
  double packing = 0;
  double gstper = 7; //TODO: update this
  double gstCharge = 0.0;
  double grandtot = 0.0;
  List<DeliveryBoy> tempDeliveryBoys = [];
  calcBill() {
    int count = 0;
    delivery = 0.0;
    // ((user.cart.length / 2) * 5).toDouble();
    itemsum = 0.0;
    gstCharge = 0.0;
    grandtot = 0.0;
    setState(() {
      user.cart.forEach((element) {
        itemsum +=
            double.parse(element.item.price) * double.parse(element.count);
        count += int.parse(element.count);
      });
      gstCharge = itemsum * gstper * 0.01;
      delivery = ((count / 2) * 2).toDouble();
      grandtot = gstCharge + itemsum + delivery;
    });
  }

  selectPic(String category) {
    if (category == "Tandoor")
      return "menu0.png";
    else if (category == "Main Course")
      return "menu1.png";
    else if (category == "Chinese Main Course")
      return "menu2.png";
    else if (category == "Rice/Biryani")
      return "menu3.png";
    else if (category == "Noodles")
      return "menu4.png";
    else if (category == "Rolls and Momos")
      return "menu5.png";
    else if (category == "Breads") return "menu6.png";
  }

  genOrderNo() {
    var orderId = DateTime.now().day.toString() +
        DateTime.now().month.toString() +
        DateTime.now().year.toString() +
        DateTime.now().hour.toString() +
        DateTime.now().minute.toString() +
        DateTime.now().second.toString() +
        DateTime.now().millisecond.toString();
    return orderId;
  }

  assignDelivery() async {
    setState(() {
      tempDeliveryBoys.clear();
      loading1 = true;
    });
    tempDeliveryBoys = await DeliveryBoyService.getAllDeliveryBoy();
    print(tempDeliveryBoys[0].name);
    setState(() {
      bubbleSort(tempDeliveryBoys);
    });
    tempDeliveryBoys.forEach((element) {
      print(element.assigned);
    });
    setState(() {
      loading1 = false;
    });
  }

  void bubbleSort(List<DeliveryBoy> list) {
    if (list == null || list.length == 0) return;

    int n = list.length;
    int i, step;
    for (step = 0; step < n; step++) {
      for (i = 0; i < n - step - 1; i++) {
        if (int.parse(list[i].assigned) > int.parse(list[i + 1].assigned)) {
          swap(list, i);
        }
      }
    }
  }

  void swap(List<DeliveryBoy> list, int i) {
    DeliveryBoy temp = list[i];
    list[i] = list[i + 1];
    list[i + 1] = temp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  child: Image(
                    image: AssetImage("assets/cartbg.png"),
                    fit: BoxFit.fill,
                    height: 185,
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        height: 12,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(
                                  builder: (context) => ManageAddress()))
                              .then((value) async {
                            user = await UserService.getUserByPhone();
                            setState(() {});
                          });
                        },
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 12),
                          leading: Icon(
                            Icons.edit,
                            color: Color.fromRGBO(252, 126, 47, 1),
                            size: 35,
                          ),
                          title: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Home',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                user.address,
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 28,
                      ),
                      chkcart
                          ? Expanded(
                              child: Center(
                                  child: SvgPicture.asset(
                                'assets/svg/cart.svg',
                                height: 128,
                              )),
                            )
                          : Expanded(
                              child: ListView.builder(
                                itemCount: user.cart.length,
                                itemBuilder: (BuildContext ctxt, int index) {
                                  final itemThumbnail = Container(
                                    height: 125,
                                    width: 125,
                                    decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: new DecorationImage(
                                            colorFilter: ColorFilter.mode(
                                                Colors.black,
                                                BlendMode.lighten),
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                                'assets/${selectPic(user.cart[index].item.category)}'))),
                                    alignment: Alignment.centerLeft,
                                  );

                                  final itemCardContent = Container(
                                    margin: EdgeInsets.fromLTRB(
                                        68.0, 10.0, 10.0, 1.0),
                                    constraints: BoxConstraints.expand(),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            user.cart[index].item.isVeg
                                                ? Image.asset(
                                                    'assets/veg.png',
                                                    height: 18,
                                                  )
                                                : Image.asset(
                                                    'assets/nonveg.png',
                                                    height: 18,
                                                  ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Expanded(
                                              child: Text(
                                                user.cart[index].item.name,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(height: 2.0),
                                        Row(
                                          children: <Widget>[
                                            RatingBar.builder(
                                              initialRating: double.parse(
                                                  user.cart[index].item.rating),
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemSize: 18,
                                              ignoreGestures: true,
                                              itemPadding: EdgeInsets.symmetric(
                                                  horizontal: 4.0),
                                              itemBuilder: (context, _) => Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              onRatingUpdate: (rating) {
                                                print(rating);
                                              },
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            FlatButton.icon(
                                              icon: Image.asset(
                                                'assets/rupee.png',
                                                height: 18,
                                              ),
                                              onPressed: null,
                                              label: Text(
                                                user.cart[index].item.price,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 50,
                                              child: StepperSwipe(
                                                withBackground: true,
                                                counterTextColor: Colors.black,
                                                iconsColor: Colors.orange,
                                                stepperValue: int.parse(
                                                    user.cart[index].count),
                                                initialValue: int.parse(
                                                    user.cart[index].count),
                                                speedTransitionLimitCount: 1,
                                                firstIncrementDuration:
                                                    Duration(milliseconds: 250),
                                                secondIncrementDuration:
                                                    Duration(milliseconds: 100),
                                                direction: Axis.horizontal,
                                                dragButtonColor:
                                                    Colors.grey[200],
                                                withSpring: true,
                                                onChanged: (int val) {
                                                  // setState(() {
                                                  //   user.cart[index].count =
                                                  //       val.toString();
                                                  // });
                                                  if (val == 0) {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          content: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Text(
                                                                "Remove Item",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              Text(
                                                                  "\nDo you want to remove item?"),
                                                            ],
                                                          ),
                                                          actionsPadding:
                                                              EdgeInsets.only(
                                                                  right: 15,
                                                                  bottom: 5),
                                                          actions: [
                                                            MaterialButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  user
                                                                      .cart[
                                                                          index]
                                                                      .count = "1";
                                                                });
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: Text(
                                                                "No",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 18,
                                                                  color: Color(
                                                                      0xff25354E),
                                                                ),
                                                              ),
                                                            ),
                                                            MaterialButton(
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            18),
                                                              ),
                                                              color: Color(
                                                                  0xff25354E),
                                                              onPressed:
                                                                  () async {
                                                                setState(() {
                                                                  user.cart
                                                                      .removeAt(
                                                                          index);
                                                                });
                                                                calcBill();
                                                                await UserService
                                                                    .updateUser(
                                                                        user);
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: Text(
                                                                "Yes",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 18,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  } else {
                                                    setState(() {
                                                      user.cart[index].count =
                                                          val.toString();

                                                      calcBill();
                                                    });
                                                  }
                                                },
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  );

                                  final itemCard = Container(
                                    child: itemCardContent,
                                    height: 145.0,
                                    margin: EdgeInsets.only(left: 60.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                  );
                                  return Container(
                                    padding: EdgeInsets.all(18),
                                    child: Stack(
                                      alignment: Alignment.centerLeft,
                                      children: <Widget>[
                                        itemCard,
                                        itemThumbnail,
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                      user.cart.length > 0
                          ? Container(
                              padding: EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Total Bill',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        'Item Total:',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Delivery Charges:',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'GST',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Total',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                      Text(
                                        '*including gst and packaging',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 10),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        height: 40,
                                        width: 100,
                                        child: SwitchListTile(
                                          value: true,
                                          onChanged: (value) => setState(() {}),
                                          title: Text(
                                            ' Apply Coupon',
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'Rs $itemsum',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Rs $delivery',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        ' Rs ${gstCharge.toStringAsFixed(2)}',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        ' Rs ${grandtot.toStringAsFixed(2)}',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                      Text(
                                        '',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 10),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      user.cart.length > 0
                          ? Container(
                              padding: EdgeInsets.all(12),
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                padding: EdgeInsets.all(8),
                                color: Colors.amber,
                                minWidth: 250,
                                onPressed: () {
                                  if (showBill == true) {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text(
                                          'Select Payment',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 28),
                                        ),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        backgroundColor: Colors.white,
                                        content: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ListTile(
                                              contentPadding: EdgeInsets.all(0),
                                              leading: Image.asset(
                                                "assets/upi.png",
                                                height: 15,
                                              ),
                                              title: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: Text(
                                                  'UPI',
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                              ),
                                              trailing: IconButton(
                                                icon: Icon(
                                                  Icons.keyboard_arrow_right,
                                                  color: Colors.black,
                                                ),
                                                onPressed: () {
                                                  Order order;
                                                  setState(() {
                                                    order = Order(
                                                      items: user.cart,
                                                      orderId: genOrderNo(),
                                                      customer: user,
                                                      custName: user.name,
                                                      deliveryby:
                                                          tempDeliveryBoys[0],
                                                      custNumber: user.phone,
                                                      paymentType: "UPI",
                                                      orderType: "Delivery",
                                                      amount:
                                                          itemsum.toString(),
                                                      packing:
                                                          delivery.toString(),
                                                      gst: gstCharge.toString(),
                                                      gstRate:
                                                          gstper.toString(),
                                                    );
                                                  });
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(builder:
                                                          (BuildContext
                                                              context) {
                                                    return UPIScreen(
                                                      order: order,
                                                      total:
                                                          grandtot.toString(),
                                                    );
                                                  }));
                                                },
                                              ),
                                            ),
                                            ListTile(
                                              contentPadding: EdgeInsets.all(0),
                                              leading: Icon(
                                                Icons.drive_eta_rounded,
                                                size: 30,
                                              ),
                                              title: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 12.0),
                                                child: Text(
                                                  'COD',
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                              ),
                                              trailing: IconButton(
                                                icon: Icon(
                                                  Icons.keyboard_arrow_right,
                                                  color: Colors.black,
                                                ),
                                                onPressed: () async {
                                                  Order order;
                                                  setState(() {
                                                    order = Order(
                                                        items: user.cart,
                                                        orderId: genOrderNo(),
                                                        customer: user,
                                                        custName: user.name,
                                                        custNumber: user.phone,
                                                        deliveryby:
                                                            tempDeliveryBoys[0],
                                                        paymentType: "COD",
                                                        status: "placed",
                                                        orderType: "Delivery",
                                                        paid: false,
                                                        amount:
                                                            itemsum.toString(),
                                                        packing:
                                                            delivery.toString(),
                                                        gst: gstCharge
                                                            .toString(),
                                                        gstRate:
                                                            gstper.toString(),
                                                        txtId: "COD");
                                                  });
                                                  await OrderService
                                                      .createOrder(jsonEncode(
                                                          order.toJson()));

                                                  setState(() {
                                                    tempDeliveryBoys[0]
                                                        .assigned = (int.parse(
                                                                tempDeliveryBoys[
                                                                        0]
                                                                    .assigned) +
                                                            1)
                                                        .toString();
                                                  });
                                                  await DeliveryBoyService
                                                      .updateDeliveryBoy(jsonEncode(tempDeliveryBoys[0].toJson()));
                                                  Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            LandingScreen()),
                                                    ModalRoute.withName('/'),
                                                  );
                                                  await PushService.sendPushToSelf(
                                                      "Order Update !!!",
                                                      "Your order no : ${order.orderId} is placed succesfully");
                                                  // await PushService.sendPushToVendor(
                                                  //     "New Update !!!",
                                                  //     "New Order : ${order.orderId} ",
                                                  //     vendor.deviceToken);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                                },
                                child: Text(
                                  "Checkout",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 28),
                                ),
                              ),
                            )
                          : Container()
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
