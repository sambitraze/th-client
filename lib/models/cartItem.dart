// To parse this JSON data, do
//
//     final cartItem = cartItemFromJson(jsonString);

import 'dart:convert';

import 'package:client/models/Item.dart';


CartItem cartItemFromJson(String str) => CartItem.fromJson(json.decode(str));

String cartItemToJson(CartItem data) => json.encode(data.toJson());

class CartItem {
  CartItem({
    this.item,
    // this.name,
    this.count,
    // this.price,
    // this.amount,
  });

  Item item;
  String name;
  String count;
  double price;
  double amount;

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        item: json["item"] == null ? null : Item.fromJson(json["item"]),
        // name: json["name"] == null ? null : json["name"],
        count: json["count"] == null ? null : json["count"],
        // price: json["price"] == null ? null : json["price"],
      );

  Map<String, dynamic> toJson() => {
        "item": item == null ? null : item.toJson(),
        // "name": name == null ? null : name,
        "count": count == null ? null : count,
        // "price": price == null ? null : price,
      };
}
