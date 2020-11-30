// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

import 'package:client/models/User.dart';
import 'package:client/models/cartItem.dart';


Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
  Order({
    this.id,
    this.items,
    this.orderId,
    this.customer,
    this.custName,
    this.custNumber,
    this.deliveryby,
    this.orderType,
    this.date,
    this.paymentType,
    this.txtId,
    this.amount,
    this.packing,
    this.gst,
    this.status,
    this.gstRate,
    this.paid,
    this.createdAt,
    this.updatedAt,
  });

  String id;
  List<CartItem> items;
  String orderId;
  User customer;
  String custName;
  String custNumber;
  String deliveryby;
  String orderType;
  String paymentType;
  String txtId;
  String amount;
  String date;
  String status;
  String packing;
  String gst;
  String gstRate;
  bool paid;
  DateTime createdAt;
  DateTime updatedAt;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["_id"] == null ? null : json["_id"],
        items: json["items"] == null
            ? null
            : List<CartItem>.from(
                json["items"].map((x) => CartItem.fromJson(x))),
        orderId: json["orderId"] == null ? null : json["orderId"],
        customer: json["customer"] == null ? null : User.fromJson(json["customer"]),
        custName: json["custName"] == null ? null : json["custName"],
        custNumber: json["custNumber"] == null ? null : json["custNumber"],
        deliveryby: json["deliveryby"] == null ? null : json["deliveryby"],
        orderType: json["orderType"] == null ? null : json["orderType"],
        paymentType: json["paymentType"] == null ? null : json["paymentType"],
        txtId: json["txtId"] == null ? null : json["txtId"],
        amount: json["amount"] == null ? null : json["amount"],
        packing: json["packing"] == null ? null : json["packing"],
        gst: json["gst"] == null ? null : json["gst"],
        status: json["status"] == null ? null : json["status"],
        gstRate: json["gstRate"] == null ? null : json["gstRate"],
        paid: json["paid"] == null ? null : json["paid"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "items":
            items == null ? null : List<CartItem>.from(items.map((x) => x)),
        "orderId": orderId == null ? null : orderId,
        "customer": customer == null ? null : customer.toJson(),
        "custName": custName == null ? null : custName,
        "custNumber": custNumber == null ? null : custNumber,
        "deliveryby": deliveryby == null ? null : deliveryby,
        "orderType": orderType == null ? null : orderType,
        "paymentType": paymentType == null ? null : paymentType,
        "txtId": txtId == null ? null : txtId,
        "date": date,
        "status": status,
        "amount": amount == null ? null : amount,
        "packing": packing == null ? null : packing,
        "gst": gst == null ? null : gst,
        "gstRate": gstRate == null ? null : gstRate,
        "paid": paid == null ? null : paid,
      };
}
