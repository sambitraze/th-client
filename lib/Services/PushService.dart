import 'dart:convert';
import 'package:client/Services/UserService.dart';
import 'package:client/models/User.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PushService {
  static Future<String> genTokenID() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final FirebaseMessaging _fcm = FirebaseMessaging();
    await _fcm.subscribeToTopic("offers");
    String deviceToken = await _fcm.getToken();
    print(deviceToken);
    pref.setString("deviceToken", deviceToken);
    User user = await UserService.getUserByPhone();
    user.deviceToken = deviceToken;
    await UserService.updateUser(user);
    return deviceToken;
  }

  static Future<String> sendPushToSelf(String title, String message) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var deviceToken = pref.getString("deviceToken");
    final Map<String, String> headers = {"Content-Type": "application/json"};
    var body = jsonEncode(
      {"title": title, "message": message, "deviceToken": deviceToken},
    );
    http.Response response = await http.post(
        "http://64.225.85.5/notification/singleDevice",
        headers: headers,
        body: body);
    if (response.statusCode == 200) {
      print("posted");
      return response.body;
    } else {
      return response.body;
    }
  }

  static Future<String> sendPushToVendor(
      String title, String message, String id) async {
    final Map<String, String> headers = {"Content-Type": "application/json"};
    var body = jsonEncode(
      {"title": title, "message": message, "deviceToken": id},
    );
    http.Response response = await http.post(
        "http://64.225.85.5/notification/singleDevice",
        headers: headers,
        body: body);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return response.body;
    }
  }
}
