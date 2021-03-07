import 'dart:convert';
import 'package:client/models/User.dart';
import 'package:client/models/order.dart';
import 'package:http/http.dart' as http;

import 'UserService.dart';

class OrderService {
  static Future createOrder(payload) async {
    http.Response response = await http.post(
      Uri.parse("http://64.225.85.5/order/create"),
      headers: {"Content-Type": "application/json"},
      body: payload,
    );
    if (response.statusCode == 200) {
      User user = await UserService.getUserByPhone();
      user.cart.clear();
      await UserService.updateUser(user);
      var responsedata = json.decode(response.body);
      print(responsedata);
      return true;
    } else {
      print(response.body);
      return false;
    }
  }

  static Future updateOrder(payload) async {
    http.Response response = await http.put(
      Uri.parse("http://64.225.85.5/order/update"),
      headers: {"Content-Type": "application/json"},
      body: payload,
    );
    if (response.statusCode == 200) {
      var responsedata = json.decode(response.body);
      print(responsedata);
      return true;
    } else {
      print(response.body);
      return false;
    }
  }
  //get

  // static Future getAllOrders() async {
  //   http.Response response = await http.get(
  //     "http://tandoorhut.tk/order/",
  //     headers: {"Content-Type": "application/json"},
  //   );
  //   if (response.statusCode == 200) {
  //     var responsedata = json.decode(response.body);
  //     List<Order> orderList = responsedata
  //         .map<Order>((itemMap) => Order.fromJson(itemMap))
  //         .toList();
  //     return orderList;
  //   } else {
  //     print(response.body);
  //     return false;
  //   }
  // }
  static Future getAllOrdersById(id) async {
    http.Response response = await http.post(
      Uri.parse("http://64.225.85.5/order/id"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"id":id})
    );
    if (response.statusCode == 200) {
      var responsedata = json.decode(response.body);
      List<Order> orderList = responsedata
          .map<Order>((itemMap) => Order.fromJson(itemMap))
          .toList();
      return orderList;
    } else {
      print(response.body);
      return false;
    }
  }
}
