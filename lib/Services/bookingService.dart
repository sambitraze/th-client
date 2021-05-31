import 'dart:convert';
import 'package:client/models/booking.dart';
import 'package:http/http.dart' as http;

class BookingService {
  static Future createBooking(payload) async {
    http.Response response = await http.post(
      Uri.parse("https://tandoorhut.co/booking/create"),
      headers: {"Content-Type": "application/json"},
      body: payload,
    );
    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      print(responseData);
      return true;
    } else {
      print(response.body);
      return false;
    }
  }

  static Future updateBooking(payload) async {
    http.Response response = await http.put(
      Uri.parse("https://tandoorhut.co/booking/update"),
      headers: {"Content-Type": "application/json"},
      body: payload,
    );
    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      print(responseData);
      return true;
    } else {
      print(response.body);
      return false;
    }
  }

  static Future getTodayBookingByUserId(customer, date) async {
    http.Response response = await http.post(
      Uri.parse("https://tandoorhut.co/booking/user/today"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"customer": customer, "date": date}),
    );
    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      List<Booking> orderList = responseData
          .map<Booking>((itemMap) => Booking.fromJson(itemMap))
          .toList();
      return orderList;
    } else {
      print(response.body);
      return false;
    }
  }

  static Future getPastBookingByUserIdCount(skip, limit, customer, date) async {
    http.Response response = await http.post(
      Uri.parse("https://tandoorhut.co/booking/user/past"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
          {"skip": skip, "limit": limit, "customer": customer, "date": date}),
    );
    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      List<Booking> orderList = responseData
          .map<Booking>((itemMap) => Booking.fromJson(itemMap))
          .toList();
      return orderList;
    } else {
      print(response.body);
      return false;
    }
  }
}
