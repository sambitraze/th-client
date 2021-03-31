// To parse this JSON data, do
//
//     final booking = bookingFromJson(jsonString);

import 'dart:convert';

List<Booking> bookingFromJson(String str) => List<Booking>.from(json.decode(str).map((x) => Booking.fromJson(x)));

String bookingToJson(List<Booking> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Booking {
  Booking({
    this.canceled,
    this.id,
    this.date,
    this.startTimeId,
    this.endTimeId,
    this.tableId,
    this.customer,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  bool canceled;
  String id;
  String date;
  String startTimeId;
  String endTimeId;
  String tableId;
  Customer customer;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
    canceled: json["canceled"] == null ? null : json["canceled"],
    id: json["_id"] == null ? null : json["_id"],
    date: json["date"] == null ? null : json["date"],
    startTimeId: json["startTimeID"] == null ? null : json["startTimeID"],
    endTimeId: json["endTimeID"] == null ? null : json["endTimeID"],
    tableId: json["tableId"] == null ? null : json["tableId"],
    customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"] == null ? null : json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "canceled": canceled == null ? null : canceled,
    "_id": id == null ? null : id,
    "date": date == null ? null : date,
    "startTimeID": startTimeId == null ? null : startTimeId,
    "endTimeID": endTimeId == null ? null : endTimeId,
    "tableId": tableId == null ? null : tableId,
    "customer": customer == null ? null : customer.toJson(),
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
    "__v": v == null ? null : v,
  };
}

class Customer {
  Customer({
    this.id,
    this.phone,
    this.email,
    this.name,
    this.city,
    this.address,
    this.latitude,
    this.longitude,
    this.cart,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.deviceToken,
  });

  String id;
  String phone;
  String email;
  String name;
  String city;
  String address;
  String latitude;
  String longitude;
  List<dynamic> cart;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String deviceToken;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["_id"] == null ? null : json["_id"],
    phone: json["phone"] == null ? null : json["phone"],
    email: json["email"] == null ? null : json["email"],
    name: json["name"] == null ? null : json["name"],
    city: json["city"] == null ? null : json["city"],
    address: json["address"] == null ? null : json["address"],
    latitude: json["latitude"] == null ? null : json["latitude"],
    longitude: json["longitude"] == null ? null : json["longitude"],
    cart: json["cart"] == null ? null : List<dynamic>.from(json["cart"].map((x) => x)),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"] == null ? null : json["__v"],
    deviceToken: json["deviceToken"] == null ? null : json["deviceToken"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "phone": phone == null ? null : phone,
    "email": email == null ? null : email,
    "name": name == null ? null : name,
    "city": city == null ? null : city,
    "address": address == null ? null : address,
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
    "cart": cart == null ? null : List<dynamic>.from(cart.map((x) => x)),
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
    "__v": v == null ? null : v,
    "deviceToken": deviceToken == null ? null : deviceToken,
  };
}
