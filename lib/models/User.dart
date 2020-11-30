// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

import 'cartItem.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    User({
        this.id,
        this.name,
        this.cart,
        this.email,
        this.phone,
        this.latitude,
        this.longitude,
        this.address,
        this.deviceToken,
        this.createdAt,
        this.updatedAt,
        this.v,
    });
    List<CartItem> cart;
    String id;
    String name;
    String email;
    String phone;
    String latitude;
    String longitude;
    String address;
    String deviceToken;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"] == null ? null : json["_id"],
        cart: json["cart"] == null
            ? null
            : List<CartItem>.from(
                json["cart"].map((x) => CartItem.fromJson(x))),
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        phone: json["phone"] == null ? null : json["phone"],
        latitude: json["latitude"] == null ? null : json["latitude"],
        longitude: json["longitude"] == null ? null : json["longitude"],
        address: json["address"] == null ? null : json["address"],
        deviceToken: json["deviceToken"] == null ? null : json["deviceToken"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"] == null ? null : json["__v"],
    );

    Map<String, dynamic> toJson() => {
      "cart":
            cart == null ? null : List<CartItem>.from(cart.map((x) => x)),
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "phone": phone == null ? null : phone,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "address": address == null ? null : address,
        "deviceToken": deviceToken == null ? null : deviceToken,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "__v": v == null ? null : v,
    };
}
